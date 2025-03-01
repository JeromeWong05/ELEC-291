; ISR_example.asm: a) Increments/decrements a BCD variable every half second using
; an ISR for timer 2; b) Generates a 2kHz square wave at pin P1.7 using
; an ISR for timer 0; and c) in the 'main' loop it displays the variable
; incremented/decremented using the ISR for timer 2 on the LCD.  Also resets it to 
; zero if the 'CLEAR' push button connected to P1.5 is pressed.
$NOLIST
$MODN76E003
$LIST

;  N76E003 pinout:
;                               -------
;       PWM2/IC6/T0/AIN4/P0.5 -|1    20|- P0.4/AIN5/STADC/PWM3/IC3
;               TXD/AIN3/P0.6 -|2    19|- P0.3/PWM5/IC5/AIN6
;               RXD/AIN2/P0.7 -|3    18|- P0.2/ICPCK/OCDCK/RXD_1/[SCL]
;                    RST/P2.0 -|4    17|- P0.1/PWM4/IC4/MISO
;        INT0/OSCIN/AIN1/P3.0 -|5    16|- P0.0/PWM3/IC3/MOSI/T1
;              INT1/AIN0/P1.7 -|6    15|- P1.0/PWM2/IC2/SPCLK
;                         GND -|7    14|- P1.1/PWM1/IC1/AIN7/CLO
;[SDA]/TXD_1/ICPDA/OCDDA/P1.6 -|8    13|- P1.2/PWM0/IC0
;                         VDD -|9    12|- P1.3/SCL/[STADC]
;            PWM5/IC7/SS/P1.5 -|10   11|- P1.4/SDA/FB/PWM1
;                               -------
;

;---------------------------------;
;          Constants                
;---------------------------------;

CLK           EQU 16600000 ; Microcontroller system frequency in Hz
TIMER0_RATE   EQU 4096     ; 2048Hz squarewave (peak amplitude of CEM-1203 speaker)
TIMER0_RELOAD EQU ((65536-(CLK/TIMER0_RATE)))
TIMER2_RATE   EQU 1000     ; 1000Hz, for a timer tick of 1ms
TIMER2_RELOAD EQU ((65536-(CLK/TIMER2_RATE)))

;---------------------------------;
;        Pin Assignment                
;---------------------------------;

hour_button equ P0.5
minute_button equ P3.0
AMPM_button equ P1.7
alarm_button equ P1.6
alarm_clock_button equ P1.5
sound_out equ P1.2


;---------------------------------;
;        Interrupt memory            
;---------------------------------;

; Reset vector
org 0x0000
    ljmp main

; External interrupt 0 vector (not used in this code)
org 0x0003
	reti

; Timer/Counter 0 overflow interrupt vector
org 0x000B
	ljmp Timer0_ISR

; External interrupt 1 vector (not used in this code)
org 0x0013
	reti

; Timer/Counter 1 overflow interrupt vector (not used in this code)
org 0x001B
	reti

; Serial port receive/transmit interrupt vector (not used in this code)
org 0x0023 
	reti
	
; Timer/Counter 2 overflow interrupt vector
org 0x002B
	ljmp Timer2_ISR

;---------------------------------;
;     Direct Access Variables
;---------------------------------;

; In the 8051 we can define direct access variables starting at location 0x30 up to location 0x7F
dseg at 0x30
Count1ms: ds 2 ; ms Counter 
current_sec: ds 1
current_min: ds 1
current_hour: ds 1
current_ampm: ds 1

alarm_min: ds 1
alarm_hour: ds 1
alarm_ampm: ds 1

alarm_onoff: ds 1
alarm_ring: ds 1
mode: ds 1

; In the 8051 we have variables that are 1-bit in size.  We can use the setb, clr, jb, and jnb
; instructions with these variables.  This is how you define a 1-bit variable:
bseg
second_flag: dbit 1


cseg

; These 'equ' must match the hardware wiring
LCD_RS equ P1.3
;LCD_RW equ PX.X ; Not used in this code, connect the pin to GND
LCD_E  equ P1.4
LCD_D4 equ P0.0
LCD_D5 equ P0.1
LCD_D6 equ P0.2
LCD_D7 equ P0.3

$NOLIST
$include(LCD_4bit.inc) ; A library of LCD related functions and utility macros
$LIST

;---------------------------------;
;           Timer 0 Init
;---------------------------------;
Timer0_Init:
	orl CKCON, #0b00001000 ; Input for timer 0 is sysclk/1
	mov a, TMOD
	anl a, #0xf0 ; 11110000 Clear the bits for timer 0
	orl a, #0x01 ; 00000001 Configure timer 0 as 16-timer
	mov TMOD, a
	mov TH0, #high(TIMER0_RELOAD)
	mov TL0, #low(TIMER0_RELOAD)
	; Enable the timer and interrupts
    setb ET0  ; Enable timer 0 interrupt
    clr TR0
	ret

;---------------------------------;
;          Timer 0 ISR
;---------------------------------;
Timer0_ISR:
	;clr TF0  ; According to the data sheet this is done for us already.
	; Timer 0 doesn't have 16-bit auto-reload, so
	clr TR0
	mov TH0, #high(TIMER0_RELOAD)
	mov TL0, #low(TIMER0_RELOAD)
	setb TR0
	cpl sound_out ; Connect speaker the pin assigned to 'sound_out'!
	reti

;---------------------------------;
;          Timer 2 Init 
;---------------------------------;
Timer2_Init:
	mov T2CON, #0 ; Stop timer/counter.  Autoreload mode.
	mov TH2, #high(TIMER2_RELOAD)
	mov TL2, #low(TIMER2_RELOAD)
	; Set the reload value
	orl T2MOD, #0x80 ; Enable timer 2 autoreload
	mov RCMP2H, #high(TIMER2_RELOAD)
	mov RCMP2L, #low(TIMER2_RELOAD)

	; Init One millisecond interrupt counter.  It is a 16-bit variable made with two 8-bit parts
	clr a
	mov Count1ms+0, a
	mov Count1ms+1, a

	; Enable the timer and interrupts
	orl EIE, #0x80 ; Enable timer 2 interrupt ET2=1
    setb TR2  ; Enable timer 2
	ret

;---------------------------------;
;          Timer 2 ISR
;---------------------------------;
Timer2_ISR:
	clr TF2  ; Timer 2 doesn't clear TF2 automatically. Do it in the ISR.  It is bit addressable.
	
	; The two registers used in the ISR must be saved in the stack
	push acc
	push psw
	
	; Increment the 16-bit one mili second counter
	inc Count1ms+0    ; Increment the low 8-bits first
	mov a, Count1ms+0 ; If the low 8-bits overflow, then increment high 8-bits
	jnz Inc_Done
	inc Count1ms+1

Inc_Done:
	; Check if 1000ms is reached 
	mov a, Count1ms+0
	cjne a, #low(1000), Timer2_ISR_done 
	mov a, Count1ms+1
	cjne a, #high(1000), Timer2_ISR_done 
	
    ; let the main program know a second has passed 
    setb second_flag 
    ; when one second has passed
    cpl TR0 
    clr a 
    mov Count1ms+0, a 
    mov Count1ms+1, a 
    lcall increment_clock ; increment the clock

    ; check if the alarm time matches and alarm is on => if matched enable Timer0 if not already
    mov a, alarm_onoff 
    jz Timer2_ISR_done
    lcall check_alarm_match

Timer2_ISR_done:
	pop psw
	pop acc
	reti

;---------------------------------;
;        Increment Clock
;---------------------------------;
increment_clock: 
    push acc 
    push psw

    ; increment second
    mov a, current_sec
    add a, #1
    cjne a, #60, NoWrapSec
    clr a 
    da a 
    mov current_sec, a 

    ; increment minute
    mov a, current_min
    add a, #1
    cjne a, #60, NoWrapMin
    clr a 
    da a
    mov current_min, a 

    ; increment hour
    mov a, current_hour
    add a, #1
    cjne a, #13, NoAMPMToggle
    mov a, #1 
    lcall Toggle_AMPM_Clock
    sjmp HoursGood

NoAMPMToggle: 
    cjne a, #12, HoursGood
    clr a
    lcall Toggle_AMPM_Clock

HoursGood:
    da a 
    mov current_hour, a 
    sjmp clockdone

NoWrapSec: 
    da a 
    mov current_sec, a 

NoWrapMin: 
    da a
    mov current_min, a 
    sjmp clockdone 

clockdone: 
    pop psw 
    pop acc 
    ret 

;---------------------------------;
;        Toggle AMPM
;---------------------------------;
Toggle_AMPM_Clock:
    mov a, current_ampm
    cpl acc.0
    mov current_ampm, a 
    ret 

Toggle_AMPM_Alarm: 
    mov a, alarm_ampm 
    cpl acc.0
    mov alarm_ampm, A
    ret 

check_alarm_match: 
    push acc 
    push psw

    ; check hour
    mov a, current_hour
    cjne a, alarm_hour, alarm_check_done

    ; check minute
    mov a, current_min 
    cjne a, alarm_min, alarm_check_done

    ; compare am/pm
    mov a, current_ampm
    cjne a, alarm_ampm, alarm_check_done

    mov a, alarm_ring
    jnz alarm_check_done
    mov alarm_ring, #1
    setb TR0 

alarm_check_done: 
    pop psw 
    pop acc 
    ret 


;---------------------------------;
;          Main Program
;---------------------------------;
main:
	; Initialization
    mov SP, #0x7F
    mov P0M1, #0x00
    mov P0M2, #0x00
    mov P1M1, #0x00
    mov P1M2, #0x00
    mov P3M2, #0x00
    mov P3M2, #0x00

    lcall Timer0_Init
    lcall Timer2_Init
    setb EA   ; Enable Global interrupts
    lcall LCD_4BIT
    
    Set_Cursor(1, 1)
    Send_Constant_String(#TimeMessage)
    Set_Cursor(2, 1)
    Send_Constant_String(#AlarmMessage)

    ; initialize all the time values
    mov a, #0x00
    da a
    mov current_sec, a
    mov current_min, a
    mov current_hour, a ; set to 12:00:00 A
    mov current_ampm, #0x00 ; 0 = AM, 1 = PM

    mov alarm_min, #0x00
    mov alarm_hour, #0x06
    mov alarm_onoff, #0x00 ; 0 = off, 1 = on
    mov alarm_ampm, #0x00 ; 0 = AM, 1 = PM
    mov alarm_ring, #0x00
    mov mode, #0x00  ; 0 = adjust clock, 1 = adjust alarm


;---------------------------------;
;          Main Loop
;---------------------------------;
Mainloop: 

    jb second_flag, DoUpdateDisplay
    sjmp SkipUpdate

DoUpdateDisplay: 
    lcall UpdateDisplay
    clr second_flag
    sjmp LoopDone 

SkipUpdate: 

    ; check for alarm button
    jb alarm_clock_button, CheckHourButton
    Wait_Milli_Seconds(#50)
    jb alarm_clock_button, CheckHourButton
    ;jnb alarm_clock_button, $

LoopDone: 
    mov a, mode 
    cpl acc.0
    mov mode, a 
    ljmp Mainloop

;---------------------------------;
;      Checking Hour Button
;---------------------------------;
CheckHourButton: 
    jb hour_button, CheckMinuteButton
    Wait_Milli_Seconds(#50)
    jb hour_button, CheckMinuteButton
    jnb hour_button, $

    ; see if we are changing the alarm or clock hour
    mov a, mode
    jb acc.0, SetAlarmHour 

SetHourClock: 
    lcall Inc_Hour_Clock
    ljmp UpdateDisplay

SetAlarmHour: 
    lcall Inc_Hour_Alarm
    ljmp UpdateDisplay


;---------------------------------;
;     Checking Minute Button
;---------------------------------;
CheckMinuteButton: 
    jb minute_button, Check_AMPM_Button
    Wait_Milli_Seconds(#50)
    jb minute_button, Check_AMPM_Button
    jnb minute_button, $

    ; again we see if we are changing the alarm or clock minute
    mov a, mode 
    jb acc.0, SetMinuteAlarm

SetMinuteClock: 
    lcall Inc_Minute_Clock
    ljmp UpdateDisplay

SetMinuteAlarm: 
    lcall Inc_Minute_Alarm
    ljmp UpdateDisplay


;---------------------------------;
;     Checking AMPM Button
;---------------------------------;
Check_AMPM_Button: 
    jb AMPM_button, CheckAlarmOnOff
    Wait_Milli_Seconds(#50)
    jb AMPM_button, CheckAlarmOnOff
    jnb AMPM_button, $

    ; check if it is the alarm or clock AM/PM
    mov a, mode 
    jb acc.0, SetAMPMAlarm

SetAMPMClock: 
    lcall Toggle_AMPM_Clock
    ljmp UpdateDisplay

SetAMPMAlarm: 
    lcall Toggle_AMPM_Alarm
    ljmp UpdateDisplay 


;---------------------------------;
;     Checking Alarm OnOff
;---------------------------------;
CheckAlarmOnOff: 
    jb alarm_clock_button, JumpBooster 
    Wait_Milli_Seconds(#50)
    jb alarm_clock_button, JumpBooster
    jnb alarm_clock_button, $

    mov a, alarm_onoff
    cpl acc.0
    mov alarm_onoff, a 

    mov a, alarm_onoff
    jnz JumpBooster
    mov alarm_ring, #0
    clr TR0 

JumpBooster: 
    ljmp UpdateDisplay

Inc_Minute_Alarm: 
    push acc 
    push psw 

    mov a, alarm_min
    add a, #1
    cjne a, #60, AMNot60
    mov a, #0
    mov alarm_min, a 

    lcall Inc_Hour_Alarm 
    pop psw 
    pop acc 
    ret 

AMNot60: 
    mov alarm_min, a 
    pop psw 
    pop acc
    ret 

Inc_Hour_Alarm: 
    push acc
    push psw

    mov a, alarm_hour 
    add a, #1 
    cjne a, #13, AHNot13
    mov a, #0 
    mov alarm_hour, a 

    lcall Toggle_AMPM_Alarm
    pop psw 
    pop acc 
    ret 
AHNot13: 
    mov alarm_hour, a 
    pop psw 
    pop acc 
    ret 

Inc_Minute_Clock: 
    push acc 
    push psw 

    mov a, current_min
    add a, #1
    cjne a, #60, CMNot60 
    mov a, #0
    mov current_min, a 

    lcall Inc_Hour_Clock 
    pop psw 
    pop acc
    ret    

CMNot60: 
    mov current_min, a 
    pop psw 
    pop acc 
    ret 

Inc_Hour_Clock: 
    push acc 
    push psw 

    mov a, current_hour 
    add a, #1 
    cjne a, #13, CHNot13 
    mov a, #1 
    mov current_hour, a 

    lcall Toggle_AMPM_Clock
    pop psw 
    pop acc 
    ret 

CHNot13: 
    mov current_hour, a 
    pop psw 
    pop acc 
    ret 


;---------------------------------;
;        Update Display 
;---------------------------------;
UpdateDisplay: 
    push acc 
    push psw

    ; Display Clock Second
    Set_Cursor(1, 13)
    Display_BCD(current_sec)
UpdateDone:
    pop psw 
    pop acc
    ret 


TimeMessage: 
    db 'Time    :  :  ', 0
AlarmMessage: 
    db 'Alarm   :  ', 0
AM: 
    db 'A', 0
PM: 
    db 'P', 0
ON:
    db 'on', 0
OFF: 
    db 'off', 0
END
