; 76E003 ADC test program: Reads channel 7 on P1.1, pin 14
; This version uses an LED as voltage reference connected to pin 6 (P1.7/AIN0)

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
;      Clock Configurations
;---------------------------------;
CLK               EQU 16600000 ; Microcontroller system frequency in Hz
BAUD              EQU 115200 ; Baud rate of UART in bps
TIMER1_RELOAD     EQU (0x100-(CLK/(16*BAUD)))
TIMER0_RELOAD_1MS EQU (0x10000-(CLK/1000))
TIMER0_RATE   EQU 4096     ; 2048Hz squarewave (peak amplitude of CEM-1203 speaker)
TIMER0_RELOAD EQU ((65536-(CLK/TIMER0_RATE)))
TIMER2_RATE   EQU 1000     ; 1000Hz, for a timer tick of 1ms
TIMER2_RELOAD EQU ((65536-(CLK/TIMER2_RATE)))

sound_out equ P1.2 
LED_out equ P1.7
button_left equ P1.5
button_right equ P1.6
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
	reti 

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




cseg
; These 'equ' must match the hardware wiring
LCD_RS equ P1.3
LCD_E  equ P1.4
LCD_D4 equ P0.0
LCD_D5 equ P0.1
LCD_D6 equ P0.2
LCD_D7 equ P0.3

$NOLIST
$include(LCD_4bit.inc) ; A library of LCD related functions and utility macros
$LIST

; These register definitions needed by 'math32.inc'
DSEG at 30H
x:   ds 4
y:   ds 4
bcd: ds 5
Count1ms: ds 2 
;VLED_ADC: ds 2
; average the reading variable 
adc_sum: ds 4
adc_avg: ds 2 
adc_max: ds 2
adc_min: ds 2


BSEG
mf: dbit 1
leftmenu_flag: dbit 1
rightmenu_flag: dbit 1 

$NOLIST
$include(math32.inc)
$LIST

Init_All:
	; Configure all the pins for biderectional I/O
	mov	P3M1, #0x00
	mov	P3M2, #0x00
	mov	P1M1, #0x00
	mov	P1M2, #0x00
	mov	P0M1, #0x00
	mov	P0M2, #0x00

	mov R1, #200
	mov R0, #104
	djnz R0, $
	djnz R1, $-4
	
	orl	CKCON, #0x10 ; CLK is the input for timer 1
	orl	PCON, #0x80 ; Bit SMOD=1, double baud rate
	mov	SCON, #0x52
	anl	T3CON, #0b11011111
	anl	TMOD, #0x0F ; Clear the configuration bits for timer 1
	orl	TMOD, #0x20 ; Timer 1 Mode 2
	mov	TH1, #TIMER1_RELOAD ; TH1=TIMER1_RELOAD;
	setb TR1
	
	; Using timer 0 for delay functions.  Initialize here:
	clr	TR0 ; Stop timer 0
	orl	CKCON,#0x08 ; CLK is the input for timer 0
	anl	TMOD,#0xF0 ; Clear the configuration bits for timer 0
	orl	TMOD,#0x01 ; Timer 0 in Mode 1: 16-bit timer
	
	; Initialize the pins used by the ADC (P1.1, P1.7) as input.
	orl	P1M1, #0b10000010
	anl	P1M2, #0b01111101
	
	; Initialize and start the ADC:
	anl ADCCON0, #0xF0
	orl ADCCON0, #0x07 ; Select channel 7
	; AINDIDS select if some pins are analog inputs or digital I/O:
	mov AINDIDS, #0x00 ; Disable all analog inputs
	orl AINDIDS, #0b10000000 ; Activate AIN0 and AIN7 analog inputs
	orl ADCCON1, #0x01 ; Enable ADC
	
	; set LED to push pull mode 
	anl P1M1, #0b01111111 
	orl P1M2, #0b10000000 
	clr LED_out 

	ret

;---------------------------------;
; Routine to initialize the ISR   ;
; for timer 2                     ;
;---------------------------------;
Timer2_Init:
	orl CKCON, #0b00001000 ; Input for timer 0 is sysclk/1
	mov a, T2CON 
	clr a 
	orl a, #0x00 
	;anl a, #0xf0 ; 11110000 Clear the bits for timer 0
	;orl a, #0x01 ; 00000001 Configure timer 0 as 16-timer
	mov T2CON, a
	mov TH2, #high(TIMER0_RELOAD)
	mov TL2, #low(TIMER0_RELOAD)
	; Enable the timer and interrupts

    orl EIE, #0x80
	ret

;---------------------------------;
; ISR for timer 2.  Set to execute;
; every 1/4096Hz to generate a    ;
; 2048 Hz wave at pin SOUND_OUT   ;
;---------------------------------;
Timer2_ISR:
	;clr TF0  ; According to the data sheet this is done for us already.
	; Timer 0 doesn't have 16-bit auto-reload, so
	clr TR2
	mov TH2, #high(TIMER0_RELOAD)
	mov TL2, #low(TIMER0_RELOAD)

    setb TR2 
    cpl sound_out 

    reti 

wait_1ms:
	clr TR0 ; Stop timer 0
	clr TF0 ; Clear overflow flag
	mov TH0, #high(TIMER0_RELOAD_1MS)
	mov TL0,#low(TIMER0_RELOAD_1MS)
	setb TR0
	jnb TF0, $ ; Wait for overflow
	ret

; Wait the number of miliseconds in R2
waitms:
	lcall wait_1ms
	djnz R2, waitms
	ret

; We can display a number any way we want.  In this case with
; four decimal places.
Display_formated_BCD_temperature:
	Display_BCD(bcd+2)
	Display_char(#'.')
	Display_BCD(bcd+1)
	ret

putchar:
    jnb TI, putchar
    clr TI
    mov SBUF, a
    ret

; Send a constant-zero-terminated string using the serial port
SendString:
    clr A
    movc A, @A+DPTR
    jz SendStringDone
    lcall putchar
    inc DPTR
    sjmp SendString
SendStringDone:
    ret


Read_ADC:
	clr ADCF
	setb ADCS ;  ADC start trigger signal
    jnb ADCF, $ ; Wait for conversion complete
    
    ; Read the ADC result and store in [R1, R0]
    mov a, ADCRL
    anl a, #0x0f
    mov R0, a
    mov a, ADCRH   
    swap a
    push acc
    anl a, #0x0f
    mov R1, a
    pop acc
    anl a, #0xf0
    orl a, R0
    mov R0, A
	ret

main:
	mov sp, #0x7f
	lcall Init_All
	lcall Timer2_Init
    lcall LCD_4BIT

	; initialize variables 
	mov bcd+4, #0
	mov bcd+3, #0
	mov bcd+2, #0
	mov bcd+1, #0
	mov bcd+0, #0

	mov adc_max+0, #0x00
	mov adc_max+1, #0x00

	mov adc_min+0, #0x99
	mov adc_min+1, #0x99

	; clear all the flags
	clr leftmenu_flag
	clr rightmenu_flag 
	

Initial_Menu: 
	Set_Cursor(1,1)
	Send_Constant_String(#HomePage1) 
	Set_Cursor(2,5)
	Send_Constant_String(#HomePage2) 
	Set_Cursor(2,1)
	Send_Constant_String(#leftarrow)
	Set_Cursor(2,15)
	Send_Constant_String(#rightarrow)
	ljmp Main_loop

LeftMenu: 
	Set_Cursor(1,1)
	Send_Constant_String(#Temperature)
	Set_Cursor(2,1)
	Send_Constant_String(#Empty)

	ret 


RightMenu: 
	Set_Cursor(1,1)
	Send_Constant_String(#Empty)
	Set_Cursor(2,1)
	Send_Constant_String(#Empty)
	Set_Cursor(1,1)
	Send_Constant_String(#Min)
	Set_Cursor(2,1)
	Send_Constant_String(#Max)

	ret 

Main_loop: 
	mov r3, #50 ; takes 50 samples

	mov adc_sum+0, #0
	mov adc_sum+1, #0
	mov adc_sum+2, #0
	mov adc_sum+3, #0
	mov adc_avg+1, #0
	mov adc_avg+0, #0

adc_loop:

	; Read the signal connected to AIN7
	anl ADCCON0, #0xF0
	orl ADCCON0, #0x07 ; Select channel 7
	lcall Read_ADC

CheckLeftButton: 
	jb button_left, CheckRightButton
	mov R2, #50
	lcall waitms
	jb button_left, CheckRightButton
	jnb button_left, $

	clr rightmenu_flag
	setb leftmenu_flag
	lcall LeftMenu 

CheckRightButton: 
	jb button_right, Voltage_Convert
	mov R2, #50
	lcall waitms 
	jb button_right, Voltage_Convert
	jnb button_right, $ 

	mov adc_max+0, #0x00
	mov adc_max+1, #0x00

	mov adc_min+0, #0x99
	mov adc_min+1, #0x99

	clr leftmenu_flag
	setb rightmenu_flag 
	lcall RightMenu

Voltage_Convert:

    ; Convert to voltage
	mov x+0, R0
	mov x+1, R1
	; Pad other bits with zero
	mov x+2, #0
	mov x+3, #0

	Load_y(52000)
	lcall mul32 

	Load_y(4095)
	lcall div32 

	; now we add it to the average Vmeasured + Vsum = Vnewsum 
	mov y+0, adc_sum+0
	mov y+1, adc_sum+1
	mov y+2, adc_sum+2
	mov y+3, adc_sum+3 

	lcall add32 

	; move the new sum back into adc_sum 
	mov adc_sum+0, x+0 
	mov adc_sum+1, x+1
	mov adc_sum+2, x+2
	mov adc_sum+3, x+3 

	; wait for 2ms 
	mov r2, #2
	lcall waitms

	; continue the loop 100 times
	djnz r3, jumpboost
	sjmp Calculate_average

jumpboost: 
	ljmp adc_loop 

Calculate_average: 
	; calculate the average 
	mov x+0, adc_sum+0
	mov x+1, adc_sum+1
	mov x+2, adc_sum+2
	mov x+3, adc_sum+3

	; x = adc_sum / 50
	Load_y(50)
	lcall div32 

	; convert to temperature 
	Load_y(27300)
	lcall sub32 

	Load_y(100)
	lcall mul32 

	lcall hex2bcd 

MinLogic: 
	; do the min logic 
	clr cy 
	mov a, adc_min+1 
	mov r0, bcd+2
	subb a, r0 
	jb cy, MaxLogic ; if adc_min+1 > x+1 

	mov a, adc_min+0
	mov r0, bcd+1
	subb a, r0 
	jb cy, MaxLogic

SaveMin: 
	mov adc_min+0, bcd+1
	mov adc_min+1, bcd+2 

	jnb rightmenu_flag, LeftMenuTemp   
	Set_Cursor(1,6)
	lcall Display_formated_BCD_temperature
	
MaxLogic: 
	clr cy 
	mov a, adc_max+1 
	mov r0, bcd+2
	subb a, r0 
	jnb cy, LeftMenuTemp ; if adc_min+1 > x+1 
	sjmp SaveMax

	mov a, adc_max+0
	mov r0, bcd+1
	subb a, r0 
	jnb cy, LeftMenuTemp 

SaveMax: 
	mov adc_max+0, bcd+1
	mov adc_max+1, bcd+2 

	jnb rightmenu_flag, LeftMenuTemp   
	Set_Cursor(2,6)
	lcall Display_formated_BCD_temperature

LeftMenuTemp: 
	jnb leftmenu_flag, SerialSend   
	Set_Cursor(2,1)
	lcall Display_formated_BCD_temperature

SerialSend: 
    mov a, bcd+2
	swap a 
    anl a, #0x0F
	orl a, #0x30
    lcall putchar
	
	mov a, bcd+2
    anl a, #0x0F
	orl a, #0x30
    lcall putchar

	mov a, #'.'  
    lcall putchar

	mov a, bcd+1
	swap a 
    anl a, #0x0F
	orl a, #0x30
    lcall putchar

    mov a, bcd+1
    anl a, #0x0F
	orl a, #0x30
    lcall putchar

	mov DPTR, #newline
	lcall SendString 
	
Alarm_LED: 

	clr cy
	mov a, bcd+2 
	subb a, #0x30
	jc noLED 

	lcall LEDflash
	sjmp return  

noLED: 
	clr LED_out 

return: 
	ljmp Main_loop

alarm_beep: 
	mov r2, #70

    setb TR2 
	lcall waitms 
    clr TR2 
	lcall waitms 

    setb TR2
    lcall waitms 
    clr TR2 
    Wait_Milli_Seconds(#70) 
	lcall waitms 

    clr TR2 
	ret 

LEDflash: 
	setb LED_out 
	ret 



;                     1234567890123456    <- This helps determine the location of the counter
HomePage1:        db '      Home      ', 0
HomePage2:        db '01-28-25', 0 
Temperature:      db 'Temp in Celsius ', 0
newline:          db '\r', '\n', 0
leftarrow:        db '<-', 0
rightarrow:       db '->', 0
Empty:            db '                ',0
Min:              db 'Min: ',0
Max:              db 'Max: ',0

END
	