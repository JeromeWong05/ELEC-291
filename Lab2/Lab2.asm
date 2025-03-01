
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

CLK           EQU 16600000 ; Microcontroller system frequency in Hz
TIMER0_RATE   EQU 4096     ; 2048Hz squarewave (peak amplitude of CEM-1203 speaker)
TIMER0_RELOAD EQU ((65536-(CLK/TIMER0_RATE)))
TIMER2_RATE   EQU 1000     ; 1000Hz, for a timer tick of 1ms
TIMER2_RELOAD EQU ((65536-(CLK/TIMER2_RATE)))

hour_button equ P0.5
minute_button equ P3.0
AMPM_button equ P1.7
alarm_button equ P1.6
alarm_clock_button equ P1.5
sound_out equ P1.2

;---------------------------------;
;        Interrupt Memory
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
;          Variables 
;---------------------------------;

; In the 8051 we can define direct access variables starting at location 0x30 up to location 0x7F
dseg at 0x30
Count1ms: ds 2 ; Used to determine when half second has passed
csecond: ds 1 ; The BCD counter incrememted in the ISR and displayed in the main loop
cmin: ds 1
chour: ds 1
amin: ds 1
ahour: ds 1
button_counter: ds 1


; In the 8051 we have variables that are 1-bit in size.  We can use the setb, clr, jb, and jnb
; instructions with these variables.  This is how you define a 1-bit variable:
bseg
second_flag: dbit 1 
button_flag: dbit 1
c_ampm_flag: dbit 1
a_ampm_flag: dbit 1
a_ring_flag: dbit 1
a_onoff: dbit 1
mode_flag: dbit 1

hour_button_flag: dbit 1
minute_button_flag: dbit 1
ampm_button_flag: dbit 1
alarm_button_flag: dbit 1
clock_alarm_button_flag: dbit 1


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
; Routine to initialize the ISR   ;
; for timer 0                     ;
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
	ret

;---------------------------------;
; ISR for timer 0.  Set to execute;
; every 1/4096Hz to generate a    ;
; 2048 Hz wave at pin SOUND_OUT   ;
;---------------------------------;
Timer0_ISR:
	;clr TF0  ; According to the data sheet this is done for us already.
	; Timer 0 doesn't have 16-bit auto-reload, so
	clr TR0
	mov TH0, #high(TIMER0_RELOAD)
	mov TL0, #low(TIMER0_RELOAD)

    setb TR0 
    cpl sound_out 

    reti 

;---------------------------------;
; Routine to initialize the ISR   ;
; for timer 2                     ;
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
; ISR for timer 2                 ;
;---------------------------------;
Timer2_ISR:
    clr TF2  
    push acc
    push psw

    ;=============================================
    ; 1ms Counter & Button Checks (every 100ms)
    ;=============================================
    ; Increment main millisecond counter
    inc Count1ms+0    
    mov a, Count1ms+0 
    jnz Check_Buttons
    inc Count1ms+1

Check_Buttons:
    ; Set button_flag every 100ms using separate counter
    inc button_counter       ; New 8-bit variable
    mov a, button_counter
    cjne a, #50, Check_Clock
    setb button_flag
    mov button_counter, #0

    ;================================
    ; Clock Update (every 1000ms)
    ;================================
Check_Clock:
    ; Check if 1000ms (1 second) passed
    mov a, Count1ms+1
    cjne a, #high(1000), ISR_Done  ; 1000 = 0x03E8
    mov a, Count1ms+0
    cjne a, #low(1000), ISR_Done

    ; 1 second elapsed - update clock
    setb second_flag
    clr a
    mov Count1ms+0, a      ; Reset main counter
    mov Count1ms+1, a

    ; Increment seconds
    mov a, csecond
    add a, #0x01
    da a
    cjne a, #0x60, NoWrapSec 
    mov csecond, #0x00

    ; Increment minutes
    mov a, cmin
    add a, #0x01
    da a
    cjne a, #0x60, NoWrapMin
    mov cmin, #0x00

    ; Increment hours
    mov a, chour
    add a, #0x01
    da a
    cjne a, #0x12, CheckWrap
    cpl c_ampm_flag
    sjmp NoWrapHour

CheckWrap: 
    cjne a, #0x13, NoWrapHour
    mov chour, #0x01
    sjmp ISR_Done 

NoWrapHour:
    mov chour, a
    sjmp ISR_Done

NoWrapMin:
    mov cmin, a
    sjmp ISR_Done 

NoWrapSec:
    mov csecond, a

    jnb a_onoff, ISR_Done 
    mov a, chour 
    cjne a, ahour, ISR_Done 
    mov a, cmin
    cjne a, amin, ISR_Done 

    jb c_ampm_flag, Check_ampm_flag ; if Clock AMPM = 1, check alarm AMPM

    jnb a_ampm_flag, Flags_Match ; otherwise clock ampm = 0 , so if alarm ampm also 0 => matches

    sjmp ISR_Done ; does not match 

Check_ampm_flag: 
    jb a_ampm_flag, Flags_Match
    sjmp ISR_Done 

Flags_Match: 

    jb sound_out, resetalarm
    setb a_ring_flag
    sjmp ISR_Done 

resetalarm: 
    clr a_ring_flag 

ISR_Done:
    pop psw
    pop acc
    reti
;---------------------------------;
; Main program. Includes hardware ;
; initialization and 'forever'    ;
; loop.                           ;
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
    ; For convenience a few handy macros are included in 'LCD_4bit.inc':
	Set_Cursor(1, 1)
    Send_Constant_String(#TimeMessage)
    Set_Cursor(2, 1)
    Send_Constant_String(#AlarmMessage)
    setb second_flag

    ; clock time
	mov csecond, #0x55
    mov cmin, #0x59
    mov chour, #0x5
    clr c_ampm_flag

    ; alarm time
    mov amin, #0x00
    mov ahour, #0x06
    clr a_ampm_flag 
    setb a_onoff
    clr a_ring_flag
    clr mode_flag
	

mainloop: 
    jnb button_flag, check_clock_update  
    clr button_flag
    lcall Check_Button_presses

    jnb a_ring_flag, check_clock_update
    lcall alarm_beep

checkalarmstopbutton: 
    jb alarm_button, check_clock_update
    Wait_Milli_Seconds(#50) ; Debounce delay
    jb alarm_button, check_clock_update 
    jnb alarm_button, $

    clr a_ring_flag
    clr TR0 
    


check_clock_update: 
	jnb second_flag, mainloop  
    clr second_flag 

    Set_Cursor(1,7)
    Display_BCD(chour)

    Set_Cursor(1,10)
    Display_BCD(cmin) 

    Set_Cursor(1,13)
    Display_BCD(csecond)

    Set_Cursor(1,15)
    jb c_ampm_flag, Display_PM
    Send_Constant_String(#AM)
    sjmp Display_clock_Done

Display_PM: 
    Send_Constant_String(#PM)
Display_clock_Done: 
    
    Set_Cursor(2,7)
    Display_BCD(ahour)

    Set_Cursor(2,10)
    Display_BCD(amin) 

    Set_Cursor(2,12)
    jb a_ampm_flag, Display_alarm_PM
    Send_Constant_String(#AM)
    sjmp Display_alarm_Done

Display_alarm_PM: 
    Send_Constant_String(#PM) 

Display_alarm_Done: 
    Set_Cursor(2,14)
    jb a_onoff, Display_alarm_on
    Send_Constant_String(#OFF)
    sjmp Alarm_Done 

Display_alarm_on: 
    Send_Constant_String(#ON)

Alarm_Done:
    ljmp mainloop



Check_Button_presses: 

    jb alarm_clock_button, Check_Hour_Button
    Wait_Milli_Seconds(#50) 
    jb alarm_clock_button, Check_Hour_Button
    jnb alarm_clock_button, $ 
    cpl mode_flag

Check_Hour_Button:
    jb hour_button, Check_Minute_Button
    Wait_Milli_Seconds(#50) ; Debounce delay
    jb hour_button, Check_Minute_Button
    jnb hour_button, $ ; Wait for button release
    ; Increment hour (clock or alarm)
    jb mode_flag, Increment_Alarm_Hour

    ; Increment clock hour
    mov a, chour
    add a, #0x01
    da a
    cjne a, #0x12, CheckClockHourWrap
    cpl c_ampm_flag
    sjmp NoWrapClockHour

CheckClockHourWrap:
    cjne a, #0x13, NoWrapClockHour
    mov chour, #0x01
    sjmp Check_Minute_Button
NoWrapClockHour:
    mov chour, a
    sjmp Check_Minute_Button

Increment_Alarm_Hour:
    ; Increment alarm hour
    mov a, ahour
    add a, #0x01
    da a
    cjne a, #0x12, CheckAlarmHourWrap 
    cpl c_ampm_flag 
    sjmp NoWrapAlarmHour

CheckAlarmHourWrap:
    cjne a, #0x13, NoWrapAlarmHour
    mov ahour, #0x01
    sjmp Check_Minute_Button
NoWrapAlarmHour:
    mov ahour, a
    sjmp Check_Minute_Button



Check_Minute_Button:
    jb minute_button, Check_AMPM_Button
    Wait_Milli_Seconds(#50) ; Debounce delay
    jb minute_button, Check_AMPM_Button
    jnb minute_button, $ ; Wait for button release
    ; Increment minute (clock or alarm)
    jb mode_flag, Increment_Alarm_Minute
    ; Increment clock minute
    mov a, cmin
    add a, #0x01
    da a 
    cjne a, #0x60, NoWrapClockMin
    mov cmin, #0x00

    mov a, chour 
    add a, #0x01
    da a 
    cjne a, #0x12, Minute_CheckWrapHour
    cpl c_ampm_flag 
    sjmp NoClockWrapHour 

Minute_CheckWrapHour: 
    cjne a, #0x13, NoClockWrapHour
    mov chour, #0x01
    sjmp Check_AMPM_Button

NoClockWrapHour: 
    mov chour, a 
    sjmp Check_AMPM_Button

NoWrapClockMin:
    mov cmin, a 
    sjmp Check_AMPM_Button

Increment_Alarm_Minute:
    ; Increment alarm minute
    mov a, amin
    add a, #0x01
    da a
    cjne a, #0x60, NoWrapAlarmMin
    mov amin, #0x00
    sjmp Check_AMPM_Button
NoWrapAlarmMin:
    mov amin, a
    sjmp Check_AMPM_Button

Check_AMPM_Button:
    jb AMPM_button, Check_Alarm_Button
    Wait_Milli_Seconds(#50) ; Debounce delay
    jb AMPM_button, Check_Alarm_Button
    jnb AMPM_button, $ ; Wait for button release
    ; Toggle AM/PM (clock or alarm)
    jb mode_flag, Toggle_Alarm_AMPM
    ; Toggle clock AM/PM
    cpl c_ampm_flag
    sjmp Check_Alarm_Button

Toggle_Alarm_AMPM:
    ; Toggle alarm AM/PM
    cpl a_ampm_flag

Check_Alarm_Button:
    
    jb alarm_button, button_done
    Wait_Milli_Seconds(#50) ; Debounce delay
    jb alarm_button, button_done
    jnb alarm_button, $ ; Wait for button release
    cpl a_onoff 
button_done: 
    ret 

alarm_beep: 
    setb TR0 
    Wait_Milli_Seconds(#70) 
    clr TR0 
    Wait_Milli_Seconds(#70) 

    setb TR0 
    Wait_Milli_Seconds(#70) 
    clr TR0 
    Wait_Milli_Seconds(#70) 

    setb TR0 
    Wait_Milli_Seconds(#70) 
    clr TR0 
    Wait_Milli_Seconds(#70) 

    setb TR0 
    Wait_Milli_Seconds(#70) 
    clr TR0 
    Wait_Milli_Seconds(#70) 

    setb TR0 
    Wait_Milli_Seconds(#70) 
    clr TR0 
    Wait_Milli_Seconds(#70) 

    setb TR0 
    Wait_Milli_Seconds(#70) 
    clr TR0 
    Wait_Milli_Seconds(#70) 
    
    clr TR0 

 

TimeMessage: 
    db 'Time    :  :  ', 0
AlarmMessage: 
    db 'Alarm   :  ', 0
AM: 
    db 'A', 0
PM: 
    db 'P', 0
ON:
    db 'on ', 0
OFF: 
    db 'off', 0

END