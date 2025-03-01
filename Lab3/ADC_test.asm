; 76E003 ADC_Pushbuttons.asm: Reads push buttons using the ADC, AIN0 in P1.7

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

CLK               EQU 16600000 ; Microcontroller system frequency in Hz
BAUD              EQU 115200 ; Baud rate of UART in bps
TIMER1_RELOAD     EQU (0x100-(CLK/(16*BAUD)))
TIMER0_RELOAD_1MS EQU (0x10000-(CLK/1000))

ORG 0x0000
	ljmp main

;              1234567890123456    <- This helps determine the location of the counter
title:     db 'temp = xxx.xxx', 0
blank:     db '                ', 0

cseg
; These 'equ' must match the hardware wiring
LCD_RS equ P1.3
LCD_E  equ P1.4
LCD_D4 equ P0.0
LCD_D5 equ P0.1
LCD_D6 equ P0.2
LCD_D7 equ P0.3
Buzzer equ p1.5

$NOLIST
$include(LCD_4bit.inc) ; A library of LCD related functions and utility macros
$include(math32.inc)
$LIST

DSEG at 30H
; for the states
STATE:			ds 1
count: 			ds 1

hex_temp_soak: ds 2
hex_time_soak: ds 1

hex_temp_reflow: ds 2
hex_time_reflow: ds 1

x:   			ds 4
y:   			ds 4
voltage_sum:	ds 4 
temp_avg_tc:	ds 4
hex_temp_335:	ds 4
hex_temp_tc:	ds 4
hex_temp:		ds 4 

bcd:			ds 5
;BCD_temp_335:	ds 5 ;debug use
BCD_temp_tc: 	ds 5
BCD_temp:	 	ds 5
v4040:			ds 2


BSEG
; These eight bit variables store the value of the pushbuttons after calling 'ADC_to_PB' below
PB0: dbit 1
PB1: dbit 1
PB2: dbit 1
PB3: dbit 1
PB4: dbit 1
PB5: dbit 1
PB6: dbit 1
PB7: dbit 1
setflag: 	dbit 1
startflag:  dbit 1
mf:	 		dbit 1

CSEG
Check_Button MAC ; %0 button, %1 not pressed, %2 jump to 
    jb %0, %1        ; Jump if button is pressed (fixed the logic)
	mov r2, #10
	lcall waitms 
    lcall ADC_to_PB                   ; Call ADC function
    jnb %0, %1 
    ljmp %2                ; Jump to next_label after release
ENDMAC



;inc_button MAC button, not_pressed, go_to, variable
;     jb button, not_pressed      ; Jump if button is not pressed
; check_release_inc:
;     lcall ADC_to_PB            ; Call ADC function
;     jnb button, check_release_inc ; Wait until button is released
; 	inc variable
;     ljmp go_to
; ENDMAC

; dec_button MAC button, not_pressed, go_to, variable
;     jb button, not_pressed     ; Jump if button is not pressed
; check_release_dec:
;     lcall ADC_to_PB            ; Call ADC function
;     jnb button, check_release_dec ; Wait until button is released
; 	dec variable
;     ljmp go_to
; ENDMAC

Init_All:
	; Configure all the pins for biderectional I/O
	mov	P3M1, #0x00
	mov	P3M2, #0x00
	mov	P1M1, #0x00
	mov	P1M2, #0x00
	mov	P0M1, #0x00
	mov	P0M2, #0x00
	
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
	
	; Initialize and start the ADC:
	
	; AIN0 is connected to P1.7.  Configure P1.7 as input.
	orl	P1M1, #0b10000000
	anl	P1M2, #0b01111111

	orl	P0M1, #0b00110000
	anl	P0M2, #0b11001111
	
	; AINDIDS select if some pins are analog inputs or digital I/O:
	mov AINDIDS, #0x00 ; Disable all analog inputs
	orl AINDIDS, #0b00000001 ; Using AIN0
	orl ADCCON1, #0x01 ; Enable ADC

	mov a, #0x00
	;mov 
	
	ret
	
wait_1ms:
	clr	TR0 ; Stop timer 0
	clr	TF0 ; Clear overflow flag
	mov	TH0, #high(TIMER0_RELOAD_1MS)
	mov	TL0, #low(TIMER0_RELOAD_1MS)
	setb TR0
	jnb	TF0, $ ; Wait for overflow
	ret

; Wait the number of miliseconds in R2
waitms:
	lcall wait_1ms
	djnz R2, waitms
	ret

ADC_to_PB:
	anl ADCCON0, #0xF0
	orl ADCCON0, #0x05 ; Select AIN4
	
	clr ADCF
	setb ADCS   ; ADC start trigger signal
    jnb ADCF, $ ; Wait for conversion complete

	setb PB7
	setb PB6
	setb PB5
	setb PB4
	setb PB3
	setb PB2
	setb PB1
	setb PB0
	
	; Check PB7
ADC_to_PB_L7:
	clr c
	mov a, ADCRH
	subb a, #0xf0
	jc ADC_to_PB_L6
	clr PB7
	ret

	; Check PB6
ADC_to_PB_L6:
	clr c
	mov a, ADCRH
	subb a, #0xd0
	jc ADC_to_PB_L5
	clr PB6
	ret

	; Check PB5
ADC_to_PB_L5:
	clr c
	mov a, ADCRH
	subb a, #0xb0
	jc ADC_to_PB_L4
	clr PB5
	ret

	; Check PB4
ADC_to_PB_L4:
	clr c
	mov a, ADCRH
	subb a, #0x90
	jc ADC_to_PB_L3
	clr PB4
	ret

	; Check PB3
ADC_to_PB_L3:
	clr c
	mov a, ADCRH
	subb a, #0x70
	jc ADC_to_PB_L2
	clr PB3
	ret

	; Check PB2
ADC_to_PB_L2:
	clr c
	mov a, ADCRH
	subb a, #0x50
	jc ADC_to_PB_L1
	clr PB2
	ret

	; Check PB1
ADC_to_PB_L1:
	clr c
	mov a, ADCRH
	subb a, #0x30
	jc ADC_to_PB_L0
	clr PB1
	ret

	; Check PB0
ADC_to_PB_L0:
	clr c
	mov a, ADCRH
	subb a, #0x10
	jc ADC_to_PB_Done
	clr PB0
	ret
	
ADC_to_PB_Done:
	; No pusbutton pressed	
	ret

Display_PushButtons_ADC:
	Set_Cursor(1, 1)
	mov a, #'0'
	mov c, PB7
	addc a, #0
    lcall ?WriteData	
	mov a, #'0'
	mov c, PB6
	addc a, #0
    lcall ?WriteData	
	mov a, #'0'
	mov c, PB5
	addc a, #0
    lcall ?WriteData	
	mov a, #'0'
	mov c, PB4
	addc a, #0
    lcall ?WriteData	
	mov a, #'0'
	mov c, PB3
	addc a, #0
    lcall ?WriteData	
	mov a, #'0'
	mov c, PB2
	addc a, #0
    lcall ?WriteData	
	mov a, #'0'
	mov c, PB1
	addc a, #0
    lcall ?WriteData	
	mov a, #'0'
	mov c, PB0
	addc a, #0
    lcall ?WriteData	
	ret
	
main:
	mov sp, #0x7f
	lcall Init_All
    lcall LCD_4BIT

	mov count, #0x00
	mov a, #0x00
	mov temp_avg_tc+0, a
	mov temp_avg_tc+1, a 
	mov temp_avg_tc+2, a
	mov temp_avg_tc+3, a
	mov temp_avg_tc+4, a
	mov voltage_sum+0, a
	mov voltage_sum+1, a
	mov voltage_sum+2, a
	mov voltage_sum+3, a
	mov voltage_sum+4, a

	mov a, #0x00
	mov STATE, a
    
main_loop:

	lcall ADC_to_lm4040
	lcall ADC_to_PB
	lcall ADC_to_voltage_sum
	lcall ADC_to_temp_335
	lcall Display_PushButtons_ADC

	; clear flags 
	clr startflag 
	clr setflag 
	
	; Wait 20 ms between readings
	mov R2, #20
	lcall waitms
	mov a, count 

	cjne a, #0d24, add_count
	mov a, #0x00
	mov count, a 
	cpl p1.6
	;cpl Buzzer
	lcall voltage_avg2bcd_temp_tc
;	lcall Display_temp_tc
	lcall Temp_addtion
;	lcall Display_temp_335
	lcall Display_temp 
	lcall BCD_temp2ASCII
	ljmp exit 
	
add_count: 
	mov a, count
	add a, #0x01
	mov count, a
	ljmp FSM1

FSM1:
FSM1_state0:
    mov a, STATE
    cjne a, #0, FSM1_state1
    ;mov pwm, #0

	Check_Button(PB0, testing, Done_state0)
Done_state0: 
	mov STATE, #0x01
	ljmp FSM1_state0

testing: 
	ljmp FSM1_state0

; 	 PB0 is for start
;     jb PB0, PB0_not_pressed 
; PB0_chk_release:
; 	lcall ADC_to_PB
; 	jnb PB0, PB0_chk_release
; 	mov a, STATE
; 	add a, #0x01
; 	mov STATE, a 
; 	ljmp FSM1_state0 
	
; PB0_not_pressed:
; But7:
;     Check_Button(PB7,But6,set_tempsoak)
; But6:
;     Check_Button(PB6, But5, set_timesoak)
; But5:
;     Check_Button(PB5, But4, set_tempreflow)
; But4:
;     Check_Button(PB4, FSM1_state0, set_timereflow)





FSM1_state1:
	mov a, STATE
    cjne a, #1, FSM1_state2
	Set_Cursor(1,1) 
	Send_Constant_String(#state1_debug)

exit:
	ljmp main_loop


; below are some functions
set_tempsoak:
    lcall ADC_to_PB 
    lcall CheckSETButton
    ;cjne setflag, #0, FSM1_state0

;     inc_button PB3, tempsoak_dec, set_tempsoak, temp_soak
; tempsoak_dec:
;     dec_button PB2, set_tempsoak, set_tempsoak, temp_soak



;soak time button
set_timesoak:
    lcall ADC_to_PB 
    lcall CheckSETButton
    ;cjne setflag, #0, FSM1_state0

;     inc_button PB3, timesoak_dec, set_timesoak, time_soak
; timesoak_dec:
;     dec_button PB2, set_timesoak, set_timesoak, time_soak


    
;reflow temp button
set_tempreflow:
    lcall ADC_to_PB 
    lcall CheckSETButton
    ;cjne setflag, #0, FSM1_state0

;     inc_button PB3, tempreflow_dec, set_tempreflow, temp_reflow
; tempreflow_dec:
;     dec_button PB2, set_tempreflow, set_tempreflow, temp_reflow
    


;reflow time button
set_timereflow:
    lcall ADC_to_PB 
    lcall CheckSETButton
    ;cjne setflag, #0, FSM1_state0

;     inc_button PB3, timereflow_dec, set_timereflow, time_reflow
; timereflow_dec:
;     dec_button PB2, set_timereflow, set_timereflow, time_reflow



Temp_addtion:

	mov x+0, temp_avg_tc+0
	mov x+1, temp_avg_tc+1
	mov x+2, temp_avg_tc+2
	mov x+3, temp_avg_tc+3

	mov y+0, hex_temp_335+0
	mov y+1, hex_temp_335+1
	mov y+2, hex_temp_335+2
	mov y+3, hex_temp_335+3

	lcall add32
	
	mov hex_temp+0, x+0
	mov hex_temp+0, x+0
	mov hex_temp+0, x+0
	mov hex_temp+0, x+0

	lcall hex2bcd
	; bcd holds the real temp in bcd
	mov BCD_temp+0, bcd+0
	mov BCD_temp+1, bcd+1
	mov BCD_temp+2, bcd+2
	mov BCD_temp+3, bcd+3
	mov BCD_temp+4, bcd+4
	ret

ADC_to_temp_335:

	push aR0 
	push aR1
	push acc
	push x+0 
	push x+1 
	push x+2 
	push x+3 

	anl ADCCON0, #0xF0
	orl ADCCON0, #0x04 ; Select AIN4
	
	clr ADCF
	setb ADCS   ; ADC start trigger signal
    jnb ADCF, $ ; Wait for conversion complete
	; now the temp is in ADCRH and ADCRL

	mov a, ADCRH   
    swap a
    push acc
    anl a, #0x0f
    mov R1, a
    pop acc
    anl a, #0xf0
    orl a, ADCRL
    mov R0, a 
	; now R0 has the low 8 bits and R1 has the high 4 bits

	mov x+0, R0
	mov x+1, R1
	mov x+2, #0
	mov x+3, #0
	
	Load_y(51640) ; VCC voltage measured
	lcall mul32
	Load_y(4095) ; 2^12-1
	lcall div32
	;now x holds the voltage in hex

	lcall voltage2temp

	;now x holds the temp in hex
	mov hex_temp_335+0, x+0
	mov hex_temp_335+1, x+1
	mov hex_temp_335+2, x+2
	mov hex_temp_335+3, x+3

	lcall hex2bcd

;	mov BCD_temp_335+0, bcd+0
;	mov BCD_temp_335+1, bcd+1
;	mov BCD_temp_335+2, bcd+2
;	mov BCD_temp_335+3, bcd+3
;	mov BCD_temp_335+4, bcd+4

	pop x+3 
	pop x+2 
	pop x+1 
	pop x+0
	pop acc 
	pop aR0 
	pop aR1
	ret 


ADC_to_lm4040:

	push aR0 
	push aR1
	push acc

	anl ADCCON0, #0xF0
	orl ADCCON0, #0x00 ; Select AIN0
	
	clr ADCF
	setb ADCS   ; ADC start trigger signal
    jnb ADCF, $ ; Wait for conversion complete
	; now the lm4040 is in ADCRH and ADCRL

	mov a, ADCRH   
    swap a
    push acc
    anl a, #0x0f
    mov R1, a
    pop acc
    anl a, #0xf0
    orl a, ADCRL
    mov R0, a 

	mov v4040+0, R0 
	mov v4040+1, R1

	pop acc 
	pop aR0 
	pop aR1
	ret


ADC_to_voltage_sum:

	push aR0 
	push aR1
	push acc

	anl ADCCON0, #0xF0
	orl ADCCON0, #0x01 ; Select AIN1
	
	clr ADCF
	setb ADCS   ; ADC start trigger signal
    jnb ADCF, $ ; Wait for conversion complete
	; now the temp is in ADCRH and ADCRL

	mov a, ADCRH   
    swap a
    push acc
    anl a, #0x0f
    mov R1, a
    pop acc
    anl a, #0xf0
    orl a, ADCRL
    mov R0, a 
	; now R0 has the low 8 bits and R1 has the high 4 bits

	; Convert to voltage
	mov x+0, R0
	mov x+1, R1
	mov x+2, #0
	mov x+3, #0
	Load_y(41010) ; VCC voltage measured
	lcall mul32
	mov y+0, v4040+0
	mov y+1, v4040+1
	mov y+2, #0x00
	mov y+3, #0x00
	lcall div32
	; now x holds the voltage in hex
	mov y+0, voltage_sum+0
	mov y+1, voltage_sum+1
	mov y+2, voltage_sum+2
	mov y+3, voltage_sum+3
	lcall add32
	; now x holds the new voltage in hex
	mov voltage_sum+0, x+0
	mov voltage_sum+1, x+1
	mov voltage_sum+2, x+2
	mov voltage_sum+3, x+3

	pop acc 
	pop aR0 
	pop aR1
	ret 

voltage_avg2bcd_temp_tc:
	mov x, voltage_sum+0
	mov x, voltage_sum+1
	mov x, voltage_sum+2
	mov x, voltage_sum+3
	Load_y(25)
	lcall div32
	; now x holds avg of 25 voltages
	Load_y(166)
	lcall mul32
	; get temp_avg_tc
	mov temp_avg_tc+0, x+0
	mov temp_avg_tc+1, x+1
	mov temp_avg_tc+2, x+2
	mov temp_avg_tc+3, x+3
	lcall hex2bcd
	lcall bcd2bcd_temp_tc
	mov voltage_sum+0, #0x00
	mov voltage_sum+1, #0x00
	mov voltage_sum+2, #0x00
	mov voltage_sum+3, #0x00
	ret	

bcd2bcd_temp_tc:
	mov BCD_temp_tc+0, bcd+0
	mov BCD_temp_tc+1, bcd+1
	mov BCD_temp_tc+2, bcd+2
	mov BCD_temp_tc+3, bcd+3
	ret 

Display_temp_tc:
	Set_Cursor(1, 1)
	Display_BCD(BCD_temp_tc+3)
	Display_BCD(BCD_temp_tc+2)
	Display_char(#'.')
	Display_BCD(BCD_temp_tc+1)
	Display_BCD(BCD_temp_tc+0)
	ret	

;Display_temp_335:
;	Set_Cursor(2, 11)
;	Display_BCD(BCD_temp_335+2)
;	Display_char(#'.')
;	Display_BCD(BCD_temp_335+1)
;	Display_BCD(BCD_temp_335+0)
;	ret	

Display_temp:
	Set_Cursor(2, 1)
	Display_BCD(BCD_temp+3)
	Display_BCD(BCD_temp+2)
	Display_char(#'.')
	Display_BCD(BCD_temp+1)
	Display_BCD(BCD_temp+0)
	ret	

Display_voltage_bcd:
	Set_Cursor(2, 1)
	Display_BCD(bcd+3)
	Display_BCD(bcd+2)
	Display_BCD(bcd+1)
	Display_BCD(bcd+0)
	ret	

voltage2temp:
	Load_y(27300)
	lcall sub32
	Load_y(100)
	lcall mul32
	ret	

BCD_temp2ASCII:
	mov a, BCD_temp+3
	anl a, #0b1111_0000
	swap a
	add a, #0d48
	lcall putchar

	mov a, BCD_temp+3
	anl a, #0b0000_1111
	add a, #0d48
	lcall putchar

	mov a, BCD_temp+2
	anl a, #0b1111_0000
	swap a
	add a, #0d48
	lcall putchar

	mov a, BCD_temp+2
	anl a, #0b0000_1111
	add a, #0d48
	lcall putchar

	mov a, BCD_temp+1
	anl a, #0b1111_0000
	swap a
	add a, #0d48
	lcall putchar

	mov a, BCD_temp+1
	anl a, #0b0000_1111
	add a, #0d48
	lcall putchar

	mov a, BCD_temp+0
	anl a, #0b1111_0000
	swap a
	add a, #0d48
	lcall putchar

	mov a, BCD_temp+0
	anl a, #0b0000_1111
	add a, #0d48
	lcall putchar
	mov a, #'\n'
	lcall putchar
	ret

; state1_debug:
; 	db "this is state 1"

END
	
	