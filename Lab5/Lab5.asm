;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1170 (Feb 16 2022) (MSVC)
; This file was generated Tue Mar 04 16:52:04 2025
;--------------------------------------------------------
$name Lab5
$optc51 --model-small
$printf_float
	R_DSEG    segment data
	R_CSEG    segment code
	R_BSEG    segment bit
	R_XSEG    segment xdata
	R_PSEG    segment xdata
	R_ISEG    segment idata
	R_OSEG    segment data overlay
	BIT_BANK  segment data overlay
	R_HOME    segment code
	R_GSINIT  segment code
	R_IXSEG   segment xdata
	R_CONST   segment code
	R_XINIT   segment code
	R_DINIT   segment code

;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	public _InitPinADC_PARM_2
	public _main
	public _DisplayMenu
	public _ReadDiff
	public _ReadPeak
	public _ReadPeriod
	public _Volts_at_Pin
	public _ADC_at_Pin
	public _InitPinADC
	public _InitADC
	public _Set_Pin_Input
	public _ReadButtonDebounced
	public _Read_Pin
	public _LCDprint
	public _LCD_4BIT
	public _WriteCommand
	public _WriteData
	public _LCD_byte
	public _LCD_pulse
	public _TIMER0_Init
	public _waitus
	public _waitms
	public _Timer3us
	public __c51_external_startup
	public _frequency
	public _phase_diff
	public _vpeak
	public _overflow_count
	public _LCDprint_PARM_4
	public _DisplayMenu_PARM_2
	public _ReadPeak_PARM_2
	public _LCDprint_PARM_3
	public _LCDprint_PARM_2
;--------------------------------------------------------
; Special Function Registers
;--------------------------------------------------------
_ACC            DATA 0xe0
_ADC0ASAH       DATA 0xb6
_ADC0ASAL       DATA 0xb5
_ADC0ASCF       DATA 0xa1
_ADC0ASCT       DATA 0xc7
_ADC0CF0        DATA 0xbc
_ADC0CF1        DATA 0xb9
_ADC0CF2        DATA 0xdf
_ADC0CN0        DATA 0xe8
_ADC0CN1        DATA 0xb2
_ADC0CN2        DATA 0xb3
_ADC0GTH        DATA 0xc4
_ADC0GTL        DATA 0xc3
_ADC0H          DATA 0xbe
_ADC0L          DATA 0xbd
_ADC0LTH        DATA 0xc6
_ADC0LTL        DATA 0xc5
_ADC0MX         DATA 0xbb
_B              DATA 0xf0
_CKCON0         DATA 0x8e
_CKCON1         DATA 0xa6
_CLEN0          DATA 0xc6
_CLIE0          DATA 0xc7
_CLIF0          DATA 0xe8
_CLKSEL         DATA 0xa9
_CLOUT0         DATA 0xd1
_CLU0CF         DATA 0xb1
_CLU0FN         DATA 0xaf
_CLU0MX         DATA 0x84
_CLU1CF         DATA 0xb3
_CLU1FN         DATA 0xb2
_CLU1MX         DATA 0x85
_CLU2CF         DATA 0xb6
_CLU2FN         DATA 0xb5
_CLU2MX         DATA 0x91
_CLU3CF         DATA 0xbf
_CLU3FN         DATA 0xbe
_CLU3MX         DATA 0xae
_CMP0CN0        DATA 0x9b
_CMP0CN1        DATA 0x99
_CMP0MD         DATA 0x9d
_CMP0MX         DATA 0x9f
_CMP1CN0        DATA 0xbf
_CMP1CN1        DATA 0xac
_CMP1MD         DATA 0xab
_CMP1MX         DATA 0xaa
_CRC0CN0        DATA 0xce
_CRC0CN1        DATA 0x86
_CRC0CNT        DATA 0xd3
_CRC0DAT        DATA 0xcb
_CRC0FLIP       DATA 0xcf
_CRC0IN         DATA 0xca
_CRC0ST         DATA 0xd2
_DAC0CF0        DATA 0x91
_DAC0CF1        DATA 0x92
_DAC0H          DATA 0x85
_DAC0L          DATA 0x84
_DAC1CF0        DATA 0x93
_DAC1CF1        DATA 0x94
_DAC1H          DATA 0x8a
_DAC1L          DATA 0x89
_DAC2CF0        DATA 0x95
_DAC2CF1        DATA 0x96
_DAC2H          DATA 0x8c
_DAC2L          DATA 0x8b
_DAC3CF0        DATA 0x9a
_DAC3CF1        DATA 0x9c
_DAC3H          DATA 0x8e
_DAC3L          DATA 0x8d
_DACGCF0        DATA 0x88
_DACGCF1        DATA 0x98
_DACGCF2        DATA 0xa2
_DERIVID        DATA 0xad
_DEVICEID       DATA 0xb5
_DPH            DATA 0x83
_DPL            DATA 0x82
_EIE1           DATA 0xe6
_EIE2           DATA 0xf3
_EIP1           DATA 0xbb
_EIP1H          DATA 0xee
_EIP2           DATA 0xed
_EIP2H          DATA 0xf6
_EMI0CN         DATA 0xe7
_FLKEY          DATA 0xb7
_HFO0CAL        DATA 0xc7
_HFO1CAL        DATA 0xd6
_HFOCN          DATA 0xef
_I2C0ADM        DATA 0xff
_I2C0CN0        DATA 0xba
_I2C0DIN        DATA 0xbc
_I2C0DOUT       DATA 0xbb
_I2C0FCN0       DATA 0xad
_I2C0FCN1       DATA 0xab
_I2C0FCT        DATA 0xf5
_I2C0SLAD       DATA 0xbd
_I2C0STAT       DATA 0xb9
_IE             DATA 0xa8
_IP             DATA 0xb8
_IPH            DATA 0xf2
_IT01CF         DATA 0xe4
_LFO0CN         DATA 0xb1
_P0             DATA 0x80
_P0MASK         DATA 0xfe
_P0MAT          DATA 0xfd
_P0MDIN         DATA 0xf1
_P0MDOUT        DATA 0xa4
_P0SKIP         DATA 0xd4
_P1             DATA 0x90
_P1MASK         DATA 0xee
_P1MAT          DATA 0xed
_P1MDIN         DATA 0xf2
_P1MDOUT        DATA 0xa5
_P1SKIP         DATA 0xd5
_P2             DATA 0xa0
_P2MASK         DATA 0xfc
_P2MAT          DATA 0xfb
_P2MDIN         DATA 0xf3
_P2MDOUT        DATA 0xa6
_P2SKIP         DATA 0xcc
_P3             DATA 0xb0
_P3MDIN         DATA 0xf4
_P3MDOUT        DATA 0x9c
_PCA0CENT       DATA 0x9e
_PCA0CLR        DATA 0x9c
_PCA0CN0        DATA 0xd8
_PCA0CPH0       DATA 0xfc
_PCA0CPH1       DATA 0xea
_PCA0CPH2       DATA 0xec
_PCA0CPH3       DATA 0xf5
_PCA0CPH4       DATA 0x85
_PCA0CPH5       DATA 0xde
_PCA0CPL0       DATA 0xfb
_PCA0CPL1       DATA 0xe9
_PCA0CPL2       DATA 0xeb
_PCA0CPL3       DATA 0xf4
_PCA0CPL4       DATA 0x84
_PCA0CPL5       DATA 0xdd
_PCA0CPM0       DATA 0xda
_PCA0CPM1       DATA 0xdb
_PCA0CPM2       DATA 0xdc
_PCA0CPM3       DATA 0xae
_PCA0CPM4       DATA 0xaf
_PCA0CPM5       DATA 0xcc
_PCA0H          DATA 0xfa
_PCA0L          DATA 0xf9
_PCA0MD         DATA 0xd9
_PCA0POL        DATA 0x96
_PCA0PWM        DATA 0xf7
_PCON0          DATA 0x87
_PCON1          DATA 0xcd
_PFE0CN         DATA 0xc1
_PRTDRV         DATA 0xf6
_PSCTL          DATA 0x8f
_PSTAT0         DATA 0xaa
_PSW            DATA 0xd0
_REF0CN         DATA 0xd1
_REG0CN         DATA 0xc9
_REVID          DATA 0xb6
_RSTSRC         DATA 0xef
_SBCON1         DATA 0x94
_SBRLH1         DATA 0x96
_SBRLL1         DATA 0x95
_SBUF           DATA 0x99
_SBUF0          DATA 0x99
_SBUF1          DATA 0x92
_SCON           DATA 0x98
_SCON0          DATA 0x98
_SCON1          DATA 0xc8
_SFRPAGE        DATA 0xa7
_SFRPGCN        DATA 0xbc
_SFRSTACK       DATA 0xd7
_SMB0ADM        DATA 0xd6
_SMB0ADR        DATA 0xd7
_SMB0CF         DATA 0xc1
_SMB0CN0        DATA 0xc0
_SMB0DAT        DATA 0xc2
_SMB0FCN0       DATA 0xc3
_SMB0FCN1       DATA 0xc4
_SMB0FCT        DATA 0xef
_SMB0RXLN       DATA 0xc5
_SMB0TC         DATA 0xac
_SMOD1          DATA 0x93
_SP             DATA 0x81
_SPI0CFG        DATA 0xa1
_SPI0CKR        DATA 0xa2
_SPI0CN0        DATA 0xf8
_SPI0DAT        DATA 0xa3
_SPI0FCN0       DATA 0x9a
_SPI0FCN1       DATA 0x9b
_SPI0FCT        DATA 0xf7
_SPI0PCF        DATA 0xdf
_TCON           DATA 0x88
_TH0            DATA 0x8c
_TH1            DATA 0x8d
_TL0            DATA 0x8a
_TL1            DATA 0x8b
_TMOD           DATA 0x89
_TMR2CN0        DATA 0xc8
_TMR2CN1        DATA 0xfd
_TMR2H          DATA 0xcf
_TMR2L          DATA 0xce
_TMR2RLH        DATA 0xcb
_TMR2RLL        DATA 0xca
_TMR3CN0        DATA 0x91
_TMR3CN1        DATA 0xfe
_TMR3H          DATA 0x95
_TMR3L          DATA 0x94
_TMR3RLH        DATA 0x93
_TMR3RLL        DATA 0x92
_TMR4CN0        DATA 0x98
_TMR4CN1        DATA 0xff
_TMR4H          DATA 0xa5
_TMR4L          DATA 0xa4
_TMR4RLH        DATA 0xa3
_TMR4RLL        DATA 0xa2
_TMR5CN0        DATA 0xc0
_TMR5CN1        DATA 0xf1
_TMR5H          DATA 0xd5
_TMR5L          DATA 0xd4
_TMR5RLH        DATA 0xd3
_TMR5RLL        DATA 0xd2
_UART0PCF       DATA 0xd9
_UART1FCN0      DATA 0x9d
_UART1FCN1      DATA 0xd8
_UART1FCT       DATA 0xfa
_UART1LIN       DATA 0x9e
_UART1PCF       DATA 0xda
_VDM0CN         DATA 0xff
_WDTCN          DATA 0x97
_XBR0           DATA 0xe1
_XBR1           DATA 0xe2
_XBR2           DATA 0xe3
_XOSC0CN        DATA 0x86
_DPTR           DATA 0x8382
_TMR2RL         DATA 0xcbca
_TMR3RL         DATA 0x9392
_TMR4RL         DATA 0xa3a2
_TMR5RL         DATA 0xd3d2
_TMR0           DATA 0x8c8a
_TMR1           DATA 0x8d8b
_TMR2           DATA 0xcfce
_TMR3           DATA 0x9594
_TMR4           DATA 0xa5a4
_TMR5           DATA 0xd5d4
_SBRL1          DATA 0x9695
_PCA0           DATA 0xfaf9
_PCA0CP0        DATA 0xfcfb
_PCA0CP1        DATA 0xeae9
_PCA0CP2        DATA 0xeceb
_PCA0CP3        DATA 0xf5f4
_PCA0CP4        DATA 0x8584
_PCA0CP5        DATA 0xdedd
_ADC0ASA        DATA 0xb6b5
_ADC0GT         DATA 0xc4c3
_ADC0           DATA 0xbebd
_ADC0LT         DATA 0xc6c5
_DAC0           DATA 0x8584
_DAC1           DATA 0x8a89
_DAC2           DATA 0x8c8b
_DAC3           DATA 0x8e8d
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
_ACC_0          BIT 0xe0
_ACC_1          BIT 0xe1
_ACC_2          BIT 0xe2
_ACC_3          BIT 0xe3
_ACC_4          BIT 0xe4
_ACC_5          BIT 0xe5
_ACC_6          BIT 0xe6
_ACC_7          BIT 0xe7
_TEMPE          BIT 0xe8
_ADGN0          BIT 0xe9
_ADGN1          BIT 0xea
_ADWINT         BIT 0xeb
_ADBUSY         BIT 0xec
_ADINT          BIT 0xed
_IPOEN          BIT 0xee
_ADEN           BIT 0xef
_B_0            BIT 0xf0
_B_1            BIT 0xf1
_B_2            BIT 0xf2
_B_3            BIT 0xf3
_B_4            BIT 0xf4
_B_5            BIT 0xf5
_B_6            BIT 0xf6
_B_7            BIT 0xf7
_C0FIF          BIT 0xe8
_C0RIF          BIT 0xe9
_C1FIF          BIT 0xea
_C1RIF          BIT 0xeb
_C2FIF          BIT 0xec
_C2RIF          BIT 0xed
_C3FIF          BIT 0xee
_C3RIF          BIT 0xef
_D1SRC0         BIT 0x88
_D1SRC1         BIT 0x89
_D1AMEN         BIT 0x8a
_D01REFSL       BIT 0x8b
_D3SRC0         BIT 0x8c
_D3SRC1         BIT 0x8d
_D3AMEN         BIT 0x8e
_D23REFSL       BIT 0x8f
_D0UDIS         BIT 0x98
_D1UDIS         BIT 0x99
_D2UDIS         BIT 0x9a
_D3UDIS         BIT 0x9b
_EX0            BIT 0xa8
_ET0            BIT 0xa9
_EX1            BIT 0xaa
_ET1            BIT 0xab
_ES0            BIT 0xac
_ET2            BIT 0xad
_ESPI0          BIT 0xae
_EA             BIT 0xaf
_PX0            BIT 0xb8
_PT0            BIT 0xb9
_PX1            BIT 0xba
_PT1            BIT 0xbb
_PS0            BIT 0xbc
_PT2            BIT 0xbd
_PSPI0          BIT 0xbe
_P0_0           BIT 0x80
_P0_1           BIT 0x81
_P0_2           BIT 0x82
_P0_3           BIT 0x83
_P0_4           BIT 0x84
_P0_5           BIT 0x85
_P0_6           BIT 0x86
_P0_7           BIT 0x87
_P1_0           BIT 0x90
_P1_1           BIT 0x91
_P1_2           BIT 0x92
_P1_3           BIT 0x93
_P1_4           BIT 0x94
_P1_5           BIT 0x95
_P1_6           BIT 0x96
_P1_7           BIT 0x97
_P2_0           BIT 0xa0
_P2_1           BIT 0xa1
_P2_2           BIT 0xa2
_P2_3           BIT 0xa3
_P2_4           BIT 0xa4
_P2_5           BIT 0xa5
_P2_6           BIT 0xa6
_P3_0           BIT 0xb0
_P3_1           BIT 0xb1
_P3_2           BIT 0xb2
_P3_3           BIT 0xb3
_P3_4           BIT 0xb4
_P3_7           BIT 0xb7
_CCF0           BIT 0xd8
_CCF1           BIT 0xd9
_CCF2           BIT 0xda
_CCF3           BIT 0xdb
_CCF4           BIT 0xdc
_CCF5           BIT 0xdd
_CR             BIT 0xde
_CF             BIT 0xdf
_PARITY         BIT 0xd0
_F1             BIT 0xd1
_OV             BIT 0xd2
_RS0            BIT 0xd3
_RS1            BIT 0xd4
_F0             BIT 0xd5
_AC             BIT 0xd6
_CY             BIT 0xd7
_RI             BIT 0x98
_TI             BIT 0x99
_RB8            BIT 0x9a
_TB8            BIT 0x9b
_REN            BIT 0x9c
_CE             BIT 0x9d
_SMODE          BIT 0x9e
_RI1            BIT 0xc8
_TI1            BIT 0xc9
_RBX1           BIT 0xca
_TBX1           BIT 0xcb
_REN1           BIT 0xcc
_PERR1          BIT 0xcd
_OVR1           BIT 0xce
_SI             BIT 0xc0
_ACK            BIT 0xc1
_ARBLOST        BIT 0xc2
_ACKRQ          BIT 0xc3
_STO            BIT 0xc4
_STA            BIT 0xc5
_TXMODE         BIT 0xc6
_MASTER         BIT 0xc7
_SPIEN          BIT 0xf8
_TXNF           BIT 0xf9
_NSSMD0         BIT 0xfa
_NSSMD1         BIT 0xfb
_RXOVRN         BIT 0xfc
_MODF           BIT 0xfd
_WCOL           BIT 0xfe
_SPIF           BIT 0xff
_IT0            BIT 0x88
_IE0            BIT 0x89
_IT1            BIT 0x8a
_IE1            BIT 0x8b
_TR0            BIT 0x8c
_TF0            BIT 0x8d
_TR1            BIT 0x8e
_TF1            BIT 0x8f
_T2XCLK0        BIT 0xc8
_T2XCLK1        BIT 0xc9
_TR2            BIT 0xca
_T2SPLIT        BIT 0xcb
_TF2CEN         BIT 0xcc
_TF2LEN         BIT 0xcd
_TF2L           BIT 0xce
_TF2H           BIT 0xcf
_T4XCLK0        BIT 0x98
_T4XCLK1        BIT 0x99
_TR4            BIT 0x9a
_T4SPLIT        BIT 0x9b
_TF4CEN         BIT 0x9c
_TF4LEN         BIT 0x9d
_TF4L           BIT 0x9e
_TF4H           BIT 0x9f
_T5XCLK0        BIT 0xc0
_T5XCLK1        BIT 0xc1
_TR5            BIT 0xc2
_T5SPLIT        BIT 0xc3
_TF5CEN         BIT 0xc4
_TF5LEN         BIT 0xc5
_TF5L           BIT 0xc6
_TF5H           BIT 0xc7
_RIE            BIT 0xd8
_RXTO0          BIT 0xd9
_RXTO1          BIT 0xda
_RFRQ           BIT 0xdb
_TIE            BIT 0xdc
_TXHOLD         BIT 0xdd
_TXNF1          BIT 0xde
_TFRQ           BIT 0xdf
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	rbank0 segment data overlay
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	rseg R_DSEG
_LCDprint_PARM_2:
	ds 1
_LCDprint_PARM_3:
	ds 1
_ReadPeak_PARM_2:
	ds 3
_ReadPeak_delay_us_1_118:
	ds 2
_DisplayMenu_PARM_2:
	ds 2
_main_sloc0_1_0:
	ds 4
_main_sloc1_1_0:
	ds 4
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
_InitPinADC_PARM_2:
	ds 1
	rseg	R_OSEG
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	rseg R_ISEG
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	DSEG
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	rseg R_BSEG
_LCDprint_PARM_4:
	DBIT	1
_Read_Pin_sloc0_1_0:
	DBIT	1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	rseg R_PSEG
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	rseg R_XSEG
_overflow_count:
	ds 1
_vpeak:
	ds 8
_phase_diff:
	ds 4
_frequency:
	ds 4
_LCDprint_address_1_88:
	ds 1
_Read_Pin_result_1_92:
	ds 1
_DisplayMenu_buff_1_126:
	ds 17
_main_v_rms_1_131:
	ds 8
_main_units_1_131:
	ds 2
_main_time_diff_1_131:
	ds 4
_main_menu_1_131:
	ds 2
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	XSEG
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	rseg R_IXSEG
	rseg R_HOME
	rseg R_GSINIT
	rseg R_CSEG
;--------------------------------------------------------
; Reset entry point and interrupt vectors
;--------------------------------------------------------
	CSEG at 0x0000
	ljmp	_crt0
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	rseg R_HOME
	rseg R_GSINIT
	rseg R_GSINIT
;--------------------------------------------------------
; data variables initialization
;--------------------------------------------------------
	rseg R_DINIT
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:41: char _c51_external_startup (void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
	using	0
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:44: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:45: WDTCN = 0xDE; //First key
	mov	_WDTCN,#0xDE
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:46: WDTCN = 0xAD; //Second key
	mov	_WDTCN,#0xAD
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:48: VDM0CN=0x80;       // enable VDD monitor
	mov	_VDM0CN,#0x80
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:49: RSTSRC=0x02|0x04;  // Enable reset on missing clock detector and VDD
	mov	_RSTSRC,#0x06
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:56: SFRPAGE = 0x10;
	mov	_SFRPAGE,#0x10
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:57: PFE0CN  = 0x20; // SYSCLK < 75 MHz.
	mov	_PFE0CN,#0x20
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:58: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:79: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:80: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:81: while ((CLKSEL & 0x80) == 0);
L002001?:
	mov	a,_CLKSEL
	jnb	acc.7,L002001?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:82: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:83: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:84: while ((CLKSEL & 0x80) == 0);
L002004?:
	mov	a,_CLKSEL
	jnb	acc.7,L002004?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:89: P0MDOUT |= 0x10; // Enable UART0 TX as push-pull output
	orl	_P0MDOUT,#0x10
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:90: XBR0     = 0x01; // Enable UART0 on P0.4(TX) and P0.5(RX)                     
	mov	_XBR0,#0x01
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:91: XBR1     = 0X00;
	mov	_XBR1,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:92: XBR2     = 0x40; // Enable crossbar and weak pull-ups
	mov	_XBR2,#0x40
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:98: SCON0 = 0x10;
	mov	_SCON0,#0x10
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:99: TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L));
	mov	_TH1,#0xE6
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:100: TL1 = TH1;      // Init Timer1
	mov	_TL1,_TH1
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:101: TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	anl	_TMOD,#0x0F
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:102: TMOD |=  0x20;                       
	orl	_TMOD,#0x20
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:103: TR1 = 1; // START Timer1
	setb	_TR1
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:104: TI = 1;  // Indicate TX0 ready
	setb	_TI
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:106: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer3us'
;------------------------------------------------------------
;i                         Allocated with name '_Timer3us_i_1_67'
;us                        Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:110: void Timer3us(unsigned char us)
;	-----------------------------------------
;	 function Timer3us
;	-----------------------------------------
_Timer3us:
	mov	r2,dpl
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:115: CKCON0|=0b_0100_0000;
	orl	_CKCON0,#0x40
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:117: TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	mov	_TMR3RL,#0xB8
	mov	(_TMR3RL >> 8),#0xFF
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:118: TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	mov	_TMR3,_TMR3RL
	mov	(_TMR3 >> 8),(_TMR3RL >> 8)
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:120: TMR3CN0 = 0x04;                 // Sart Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x04
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:121: for (i = 0; i < us; i++)       // Count <us> overflows
	mov	r3,#0x00
L003004?:
	clr	c
	mov	a,r3
	subb	a,r2
	jnc	L003007?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:123: while (!(TMR3CN0 & 0x80));  // Wait for overflow
L003001?:
	mov	a,_TMR3CN0
	jnb	acc.7,L003001?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:124: TMR3CN0 &= ~(0x80);         // Clear overflow indicator
	anl	_TMR3CN0,#0x7F
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:121: for (i = 0; i < us; i++)       // Count <us> overflows
	inc	r3
	sjmp	L003004?
L003007?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:126: TMR3CN0 = 0 ;                   // Stop Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'waitms'
;------------------------------------------------------------
;ms                        Allocated to registers r2 r3 
;j                         Allocated with name '_waitms_j_1_70'
;k                         Allocated with name '_waitms_k_1_70'
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:129: void waitms (unsigned int ms)
;	-----------------------------------------
;	 function waitms
;	-----------------------------------------
_waitms:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:133: for(j=0; j<ms; j++)
	mov	r4,#0x00
	mov	r5,#0x00
L004005?:
	clr	c
	mov	a,r4
	subb	a,r2
	mov	a,r5
	subb	a,r3
	jnc	L004009?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:134: for (k=0; k<4; k++) Timer3us(250);
	mov	r6,#0x00
L004001?:
	cjne	r6,#0x04,L004018?
L004018?:
	jnc	L004007?
	mov	dpl,#0xFA
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_Timer3us
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	inc	r6
	sjmp	L004001?
L004007?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:133: for(j=0; j<ms; j++)
	inc	r4
	cjne	r4,#0x00,L004005?
	inc	r5
	sjmp	L004005?
L004009?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'waitus'
;------------------------------------------------------------
;us                        Allocated to registers r2 r3 
;temp                      Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:137: void waitus(unsigned int us) {
;	-----------------------------------------
;	 function waitus
;	-----------------------------------------
_waitus:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:139: while (temp > 255) {
L005001?:
	clr	c
	mov	a,#0xFF
	subb	a,r2
	clr	a
	subb	a,r3
	jnc	L005003?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:140: Timer3us(255);
	mov	dpl,#0xFF
	push	ar2
	push	ar3
	lcall	_Timer3us
	pop	ar3
	pop	ar2
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:141: temp -= 255;
	mov	a,r2
	add	a,#0x01
	mov	r2,a
	mov	a,r3
	addc	a,#0xff
	mov	r3,a
	sjmp	L005001?
L005003?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:143: if (temp > 0) {
	mov	a,r2
	orl	a,r3
	jz	L005006?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:144: Timer3us((unsigned char)temp);
	mov	dpl,r2
	ljmp	_Timer3us
L005006?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'TIMER0_Init'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:149: void TIMER0_Init(void)
;	-----------------------------------------
;	 function TIMER0_Init
;	-----------------------------------------
_TIMER0_Init:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:151: TMOD&=0b_1111_0000; // Set the bits of Timer/Counter 0 to zero
	anl	_TMOD,#0xF0
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:152: TMOD|=0b_0000_0001; // Timer/Counter 0 used as a 16-bit timer
	orl	_TMOD,#0x01
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:153: TR0=0; // Stop Timer/Counter 0
	clr	_TR0
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_pulse'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:157: void LCD_pulse (void)
;	-----------------------------------------
;	 function LCD_pulse
;	-----------------------------------------
_LCD_pulse:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:159: LCD_E=1;
	setb	_P2_0
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:160: Timer3us(40);
	mov	dpl,#0x28
	lcall	_Timer3us
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:161: LCD_E=0;
	clr	_P2_0
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_byte'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:164: void LCD_byte (unsigned char x)
;	-----------------------------------------
;	 function LCD_byte
;	-----------------------------------------
_LCD_byte:
	mov	r2,dpl
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:167: ACC=x; //Send high nible
	mov	_ACC,r2
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:168: LCD_D7=ACC_7;
	mov	c,_ACC_7
	mov	_P1_0,c
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:169: LCD_D6=ACC_6;
	mov	c,_ACC_6
	mov	_P1_1,c
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:170: LCD_D5=ACC_5;
	mov	c,_ACC_5
	mov	_P1_2,c
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:171: LCD_D4=ACC_4;
	mov	c,_ACC_4
	mov	_P1_3,c
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:172: LCD_pulse();
	push	ar2
	lcall	_LCD_pulse
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:173: Timer3us(40);
	mov	dpl,#0x28
	lcall	_Timer3us
	pop	ar2
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:174: ACC=x; //Send low nible
	mov	_ACC,r2
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:175: LCD_D7=ACC_3;
	mov	c,_ACC_3
	mov	_P1_0,c
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:176: LCD_D6=ACC_2;
	mov	c,_ACC_2
	mov	_P1_1,c
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:177: LCD_D5=ACC_1;
	mov	c,_ACC_1
	mov	_P1_2,c
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:178: LCD_D4=ACC_0;
	mov	c,_ACC_0
	mov	_P1_3,c
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:179: LCD_pulse();
	ljmp	_LCD_pulse
;------------------------------------------------------------
;Allocation info for local variables in function 'WriteData'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:182: void WriteData (unsigned char x)
;	-----------------------------------------
;	 function WriteData
;	-----------------------------------------
_WriteData:
	mov	r2,dpl
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:184: LCD_RS=1;
	setb	_P1_7
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:185: LCD_byte(x);
	mov	dpl,r2
	lcall	_LCD_byte
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:186: waitms(2);
	mov	dptr,#0x0002
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'WriteCommand'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:189: void WriteCommand (unsigned char x)
;	-----------------------------------------
;	 function WriteCommand
;	-----------------------------------------
_WriteCommand:
	mov	r2,dpl
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:191: LCD_RS=0;
	clr	_P1_7
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:192: LCD_byte(x);
	mov	dpl,r2
	lcall	_LCD_byte
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:193: waitms(5);
	mov	dptr,#0x0005
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_4BIT'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:196: void LCD_4BIT (void)
;	-----------------------------------------
;	 function LCD_4BIT
;	-----------------------------------------
_LCD_4BIT:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:198: LCD_E=0; // Resting state of LCD's enable is zero
	clr	_P2_0
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:200: waitms(20);
	mov	dptr,#0x0014
	lcall	_waitms
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:202: WriteCommand(0x33);
	mov	dpl,#0x33
	lcall	_WriteCommand
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:203: WriteCommand(0x33);
	mov	dpl,#0x33
	lcall	_WriteCommand
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:204: WriteCommand(0x32); // Change to 4-bit mode
	mov	dpl,#0x32
	lcall	_WriteCommand
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:207: WriteCommand(0x28);
	mov	dpl,#0x28
	lcall	_WriteCommand
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:208: WriteCommand(0x0c);
	mov	dpl,#0x0C
	lcall	_WriteCommand
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:209: WriteCommand(0x01); // Clear screen command (takes some time)
	mov	dpl,#0x01
	lcall	_WriteCommand
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:210: waitms(20); // Wait for clear screen command to finsih.
	mov	dptr,#0x0014
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'LCDprint'
;------------------------------------------------------------
;line                      Allocated with name '_LCDprint_PARM_2'
;position                  Allocated with name '_LCDprint_PARM_3'
;string                    Allocated to registers r2 r3 r4 
;j                         Allocated to registers r5 r6 
;address                   Allocated with name '_LCDprint_address_1_88'
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:213: void LCDprint(char * string, unsigned char line, unsigned char position, bit clear)
;	-----------------------------------------
;	 function LCDprint
;	-----------------------------------------
_LCDprint:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:218: if (line == 1){
	mov	a,#0x01
	cjne	a,_LCDprint_PARM_2,L012002?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:219: address = 0x80 + position; 
	mov	dptr,#_LCDprint_address_1_88
	mov	a,#0x80
	add	a,_LCDprint_PARM_3
	movx	@dptr,a
	sjmp	L012003?
L012002?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:222: address = 0xC0 + position; 
	mov	dptr,#_LCDprint_address_1_88
	mov	a,#0xC0
	add	a,_LCDprint_PARM_3
	movx	@dptr,a
L012003?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:224: WriteCommand(address);
	mov	dptr,#_LCDprint_address_1_88
	movx	a,@dptr
	mov	dpl,a
	push	ar2
	push	ar3
	push	ar4
	lcall	_WriteCommand
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:225: waitms(5);
	mov	dptr,#0x0005
	lcall	_waitms
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:226: for(j=0; string[j]!=0; j++)	WriteData(string[j]);// Write the message
	mov	r5,#0x00
	mov	r6,#0x00
L012006?:
	mov	a,r5
	add	a,r2
	mov	r7,a
	mov	a,r6
	addc	a,r3
	mov	r0,a
	mov	ar1,r4
	mov	dpl,r7
	mov	dph,r0
	mov	b,r1
	lcall	__gptrget
	mov	r7,a
	jz	L012009?
	mov	dpl,r7
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_WriteData
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	inc	r5
	cjne	r5,#0x00,L012006?
	inc	r6
	sjmp	L012006?
L012009?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:227: if(clear) for(; j<CHARS_PER_LINE; j++) WriteData(' '); // Clear the rest of the line
	jnb	_LCDprint_PARM_4,L012014?
	mov	ar2,r5
	mov	ar3,r6
L012010?:
	clr	c
	mov	a,r2
	subb	a,#0x10
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L012014?
	mov	dpl,#0x20
	push	ar2
	push	ar3
	lcall	_WriteData
	pop	ar3
	pop	ar2
	inc	r2
	cjne	r2,#0x00,L012010?
	inc	r3
	sjmp	L012010?
L012014?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Read_Pin'
;------------------------------------------------------------
;mask                      Allocated with name '_Read_Pin_mask_1_92'
;result                    Allocated with name '_Read_Pin_result_1_92'
;pin                       Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:230: bit Read_Pin (unsigned char pin)
;	-----------------------------------------
;	 function Read_Pin
;	-----------------------------------------
_Read_Pin:
	mov	r2,dpl
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:234: mask=(1<<(pin&0x7));
	mov	a,#0x07
	anl	a,r2
	mov	b,a
	inc	b
	mov	a,#0x01
	sjmp	L013012?
L013010?:
	add	a,acc
L013012?:
	djnz	b,L013010?
	mov	r3,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:235: switch(pin/0x10)
	mov	a,r2
	swap	a
	anl	a,#0x0f
	mov  r2,a
	add	a,#0xff - 0x03
	jc	L013002?
	mov	a,r2
	add	a,r2
	add	a,r2
	mov	dptr,#L013014?
	jmp	@a+dptr
L013014?:
	ljmp	L013002?
	ljmp	L013003?
	ljmp	L013004?
	ljmp	L013005?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:238: case 0: result = P0 & mask; break;
L013002?:
	mov	dptr,#_Read_Pin_result_1_92
	mov	a,r3
	anl	a,_P0
	movx	@dptr,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:239: case 1: result = P1 & mask; break;
	sjmp	L013006?
L013003?:
	mov	dptr,#_Read_Pin_result_1_92
	mov	a,r3
	anl	a,_P1
	movx	@dptr,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:240: case 2: result = P2 & mask; break; 
	sjmp	L013006?
L013004?:
	mov	dptr,#_Read_Pin_result_1_92
	mov	a,r3
	anl	a,_P2
	movx	@dptr,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:241: case 3: result = P3 & mask; break; 
	sjmp	L013006?
L013005?:
	mov	dptr,#_Read_Pin_result_1_92
	mov	a,r3
	anl	a,_P3
	movx	@dptr,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:242: }
L013006?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:243: return (result?1:0);
	mov	dptr,#_Read_Pin_result_1_92
	movx	a,@dptr
	add	a,#0xff
	mov  _Read_Pin_sloc0_1_0,c
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ReadButtonDebounced'
;------------------------------------------------------------
;pin                       Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:246: bit ReadButtonDebounced(unsigned char pin)
;	-----------------------------------------
;	 function ReadButtonDebounced
;	-----------------------------------------
_ReadButtonDebounced:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:248: if (Read_Pin(pin) == 0) 
	mov  r2,dpl
	push	ar2
	lcall	_Read_Pin
	pop	ar2
	jc	L014007?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:250: waitms(10);
	mov	dptr,#0x000A
	push	ar2
	lcall	_waitms
	pop	ar2
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:251: while (Read_Pin(pin) == 0) // check again
L014001?:
	mov	dpl,r2
	push	ar2
	lcall	_Read_Pin
	clr	a
	rlc	a
	pop	ar2
	jz	L014001?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:255: waitms(10); 
	mov	dptr,#0x000A
	push	ar2
	lcall	_waitms
	pop	ar2
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:256: if (Read_Pin(pin) == 1){
	mov	dpl,r2
	lcall	_Read_Pin
	clr	a
	rlc	a
	mov	r2,a
	cjne	r2,#0x01,L014007?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:257: return 1;
	setb	c
	ret
L014007?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:261: return 0; 
	clr	c
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Set_Pin_Input'
;------------------------------------------------------------
;mask                      Allocated with name '_Set_Pin_Input_mask_1_100'
;pin                       Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:264: void Set_Pin_Input (unsigned char pin)
;	-----------------------------------------
;	 function Set_Pin_Input
;	-----------------------------------------
_Set_Pin_Input:
	mov	r2,dpl
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:268: mask=(1<<(pin&0x7));
	mov	a,#0x07
	anl	a,r2
	mov	b,a
	inc	b
	mov	a,#0x01
	sjmp	L015011?
L015009?:
	add	a,acc
L015011?:
	djnz	b,L015009?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:269: mask=~mask;
	cpl	a
	mov	r3,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:270: switch(pin/0x10)
	mov	a,r2
	swap	a
	anl	a,#0x0f
	mov  r2,a
	add	a,#0xff - 0x03
	jc	L015006?
	mov	a,r2
	add	a,r2
	add	a,r2
	mov	dptr,#L015013?
	jmp	@a+dptr
L015013?:
	ljmp	L015001?
	ljmp	L015002?
	ljmp	L015003?
	ljmp	L015004?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:272: case 0: P0MDOUT &= mask; break;
L015001?:
	mov	a,r3
	anl	_P0MDOUT,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:273: case 1: P1MDOUT &= mask; break;
	ret
L015002?:
	mov	a,r3
	anl	_P1MDOUT,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:274: case 2: P2MDOUT &= mask; break; 
	ret
L015003?:
	mov	a,r3
	anl	_P2MDOUT,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:275: case 3: P3MDOUT &= mask; break; 
	ret
L015004?:
	mov	a,r3
	anl	_P3MDOUT,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:276: }	
L015006?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'InitADC'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:281: void InitADC (void)
;	-----------------------------------------
;	 function InitADC
;	-----------------------------------------
_InitADC:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:283: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:284: ADEN=0; // Disable ADC
	clr	_ADEN
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:289: (0x0 << 0) ; // Accumulate n conversions: 0x0: 1, 0x1:4, 0x2:8, 0x3:16, 0x4:32
	mov	_ADC0CN1,#0x80
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:293: (0x0 << 2); // 0:SYSCLK ADCCLK = SYSCLK. 1:HFOSC0 ADCCLK = HFOSC0.
	mov	_ADC0CF0,#0x20
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:297: (0x1E << 0); // Conversion Tracking Time. Tadtk = ADTK / (Fsarclk)
	mov	_ADC0CF1,#0x1E
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:306: (0x0 << 0) ; // TEMPE. 0: Disable the Temperature Sensor. 1: Enable the Temperature Sensor.
	mov	_ADC0CN0,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:311: (0x1F << 0); // ADPWR. Power Up Delay Time. Tpwrtime = ((4 * (ADPWR + 1)) + 2) / (Fadcclk)
	mov	_ADC0CF2,#0x3F
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:315: (0x0 << 0) ; // ADCM. 0x0: ADBUSY, 0x1: TIMER0, 0x2: TIMER2, 0x3: TIMER3, 0x4: CNVSTR, 0x5: CEX5, 0x6: TIMER4, 0x7: TIMER5, 0x8: CLU0, 0x9: CLU1, 0xA: CLU2, 0xB: CLU3
	mov	_ADC0CN2,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:317: ADEN=1; // Enable ADC
	setb	_ADEN
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'InitPinADC'
;------------------------------------------------------------
;mask                      Allocated with name '_InitPinADC_mask_1_105'
;pinno                     Allocated with name '_InitPinADC_PARM_2'
;portno                    Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:320: void InitPinADC (unsigned char portno, unsigned char pinno)
;	-----------------------------------------
;	 function InitPinADC
;	-----------------------------------------
_InitPinADC:
	mov	r2,dpl
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:324: mask=1<<pinno;
	mov	b,_InitPinADC_PARM_2
	inc	b
	mov	a,#0x01
	sjmp	L017013?
L017011?:
	add	a,acc
L017013?:
	djnz	b,L017011?
	mov	r3,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:326: SFRPAGE = 0x20;
	mov	_SFRPAGE,#0x20
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:327: switch (portno)
	cjne	r2,#0x00,L017014?
	sjmp	L017001?
L017014?:
	cjne	r2,#0x01,L017015?
	sjmp	L017002?
L017015?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:329: case 0:
	cjne	r2,#0x02,L017005?
	sjmp	L017003?
L017001?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:330: P0MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P0MDIN,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:331: P0SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P0SKIP,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:332: break;
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:333: case 1:
	sjmp	L017005?
L017002?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:334: P1MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P1MDIN,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:335: P1SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P1SKIP,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:336: break;
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:337: case 2:
	sjmp	L017005?
L017003?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:338: P2MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P2MDIN,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:339: P2SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P2SKIP,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:343: }
L017005?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:344: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ADC_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:347: xdata unsigned int ADC_at_Pin(unsigned char pin)
;	-----------------------------------------
;	 function ADC_at_Pin
;	-----------------------------------------
_ADC_at_Pin:
	mov	_ADC0MX,dpl
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:350: ADINT = 0;
	clr	_ADINT
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:351: ADBUSY = 1;     // Convert voltage at the pin
	setb	_ADBUSY
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:352: while (!ADINT); // Wait for conversion to complete
L018001?:
	jnb	_ADINT,L018001?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:353: return (ADC0);
	mov	dpl,_ADC0
	mov	dph,(_ADC0 >> 8)
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Volts_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:356: float Volts_at_Pin(unsigned char pin) 
;	-----------------------------------------
;	 function Volts_at_Pin
;	-----------------------------------------
_Volts_at_Pin:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:358: return ((ADC_at_Pin(pin)*VDD)/0b_0011_1111_1111_1111);
	lcall	_ADC_at_Pin
	lcall	___uint2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x53F8
	mov	b,#0x53
	mov	a,#0x40
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	clr	a
	push	acc
	mov	a,#0xFC
	push	acc
	mov	a,#0x7F
	push	acc
	mov	a,#0x46
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ReadPeriod'
;------------------------------------------------------------
;period                    Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:361: float ReadPeriod(void)
;	-----------------------------------------
;	 function ReadPeriod
;	-----------------------------------------
_ReadPeriod:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:364: overflow_count = 0; 
	mov	dptr,#_overflow_count
	clr	a
	movx	@dptr,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:366: TR0 = 0; // make sure timer0 is stopped
	clr	_TR0
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:367: TH0 = 0; TL0 = 0; TF0 = 0;
	mov	_TH0,#0x00
	mov	_TL0,#0x00
	clr	_TF0
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:370: while(Phasor_ref == 1); // wait for the signal to be zero
L020001?:
	jb	_P2_6,L020001?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:371: while(Phasor_ref == 0); // wait for the signal to be one
L020004?:
	jnb	_P2_6,L020004?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:372: TR0 = 1; // start timing 
	setb	_TR0
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:373: while(Phasor_ref == 1) // Wait for the signal to be zero
L020009?:
	jnb	_P2_6,L020014?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:375: if(TF0==1) // Did the 16-bit timer overflow?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:377: TF0=0;
	jbc	_TF0,L020031?
	sjmp	L020009?
L020031?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:378: overflow_count++;
	mov	dptr,#_overflow_count
	movx	a,@dptr
	add	a,#0x01
	movx	@dptr,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:381: while(Phasor_ref == 0) // Wait for the signal to be one
	sjmp	L020009?
L020014?:
	jb	_P2_6,L020016?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:383: if(TF0==1) // Did the 16-bit timer overflow?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:385: TF0=0;
	jbc	_TF0,L020033?
	sjmp	L020014?
L020033?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:386: overflow_count++;
	mov	dptr,#_overflow_count
	movx	a,@dptr
	add	a,#0x01
	movx	@dptr,a
	sjmp	L020014?
L020016?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:389: TR0=0;
	clr	_TR0
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:391: period=(overflow_count * 65536.0 + TH0 * 256.0 + TL0) * (12.0 / SYSCLK);
	mov	dptr,#_overflow_count
	movx	a,@dptr
	mov	dpl,a
	lcall	___uchar2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x0000
	mov	b,#0x80
	mov	a,#0x47
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,_TH0
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	___uchar2fs
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dptr,#0x0000
	mov	b,#0x80
	mov	a,#0x43
	lcall	___fsmul
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	r6,_TL0
	mov	r7,#0x00
	mov	dpl,r6
	mov	dph,r7
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	___sint2fs
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0xF4FC
	mov	b,#0x32
	mov	a,#0x34
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:392: return period; 
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ReadPeak'
;------------------------------------------------------------
;vpeak                     Allocated with name '_ReadPeak_PARM_2'
;period                    Allocated to registers r2 r3 r4 r5 
;temp                      Allocated to registers r2 r3 r4 r5 
;delay_us                  Allocated with name '_ReadPeak_delay_us_1_118'
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:396: void ReadPeak(float period, float *vpeak)
;	-----------------------------------------
;	 function ReadPeak
;	-----------------------------------------
_ReadPeak:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:398: float temp = period * 1e6 / 4; // Period/4 in us
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x2400
	mov	b,#0x74
	mov	a,#0x49
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	clr	a
	push	acc
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#0x40
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:399: int delay_us = (int) temp; 
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fs2sint
	mov	_ReadPeak_delay_us_1_118,dpl
	mov	(_ReadPeak_delay_us_1_118 + 1),dph
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:403: while(Phasor_ref == 1);
L021001?:
	jb	_P2_6,L021001?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:404: while(Phasor_ref == 0); 
L021004?:
	jnb	_P2_6,L021004?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:407: waitus(delay_us);
	mov	dpl,_ReadPeak_delay_us_1_118
	mov	dph,(_ReadPeak_delay_us_1_118 + 1)
	lcall	_waitus
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:408: vpeak[0] = Volts_at_Pin(QFP32_MUX_P2_3);
	mov	r4,_ReadPeak_PARM_2
	mov	r5,(_ReadPeak_PARM_2 + 1)
	mov	r6,(_ReadPeak_PARM_2 + 2)
	mov	dpl,#0x10
	push	ar4
	push	ar5
	push	ar6
	lcall	_Volts_at_Pin
	mov	r7,dpl
	mov	r0,dph
	mov	r1,b
	mov	r2,a
	pop	ar6
	pop	ar5
	pop	ar4
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	mov	a,r7
	lcall	__gptrput
	inc	dptr
	mov	a,r0
	lcall	__gptrput
	inc	dptr
	mov	a,r1
	lcall	__gptrput
	inc	dptr
	mov	a,r2
	lcall	__gptrput
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:410: while(Phasor_sig == 1);
L021007?:
	jb	_P1_4,L021007?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:411: while(Phasor_sig == 0);
L021010?:
	jnb	_P1_4,L021010?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:413: waitus(delay_us);
	mov	dpl,_ReadPeak_delay_us_1_118
	mov	dph,(_ReadPeak_delay_us_1_118 + 1)
	push	ar4
	push	ar5
	push	ar6
	lcall	_waitus
	pop	ar6
	pop	ar5
	pop	ar4
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:414: vpeak[1] = Volts_at_Pin(QFP32_MUX_P1_5); 
	mov	a,#0x04
	add	a,r4
	mov	r4,a
	clr	a
	addc	a,r5
	mov	r5,a
	mov	dpl,#0x0B
	push	ar4
	push	ar5
	push	ar6
	lcall	_Volts_at_Pin
	mov	r2,dpl
	mov	r3,dph
	mov	r7,b
	mov	r0,a
	pop	ar6
	pop	ar5
	pop	ar4
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	mov	a,r2
	lcall	__gptrput
	inc	dptr
	mov	a,r3
	lcall	__gptrput
	inc	dptr
	mov	a,r7
	lcall	__gptrput
	inc	dptr
	mov	a,r0
	ljmp	__gptrput
;------------------------------------------------------------
;Allocation info for local variables in function 'ReadDiff'
;------------------------------------------------------------
;time_diff                 Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:419: float ReadDiff(void){
;	-----------------------------------------
;	 function ReadDiff
;	-----------------------------------------
_ReadDiff:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:422: TH0 = 0; 
	mov	_TH0,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:423: TL0 = 0;
	mov	_TL0,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:424: TR0 = 0; 
	clr	_TR0
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:425: TF0 = 0;
	clr	_TF0
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:426: overflow_count = 0;
	mov	dptr,#_overflow_count
	clr	a
	movx	@dptr,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:428: while(Phasor_ref == 1);
L022001?:
	jb	_P2_6,L022001?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:429: while(Phasor_ref == 0);
L022004?:
	jnb	_P2_6,L022004?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:430: TR0 = 1; 
	setb	_TR0
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:431: while(Phasor_sig == 1) // Wait for the signal to be zero
L022009?:
	jnb	_P1_4,L022014?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:433: if(TF0==1) // Did the 16-bit timer overflow?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:435: TF0=0;
	jbc	_TF0,L022031?
	sjmp	L022009?
L022031?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:436: overflow_count++;
	mov	dptr,#_overflow_count
	movx	a,@dptr
	add	a,#0x01
	movx	@dptr,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:439: while(Phasor_sig == 0) // Wait for the signal to be one
	sjmp	L022009?
L022014?:
	jb	_P1_4,L022016?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:441: if(TF0==1) // Did the 16-bit timer overflow?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:443: TF0=0;
	jbc	_TF0,L022033?
	sjmp	L022014?
L022033?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:444: overflow_count++;
	mov	dptr,#_overflow_count
	movx	a,@dptr
	add	a,#0x01
	movx	@dptr,a
	sjmp	L022014?
L022016?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:447: TR0=0;
	clr	_TR0
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:448: time_diff=(overflow_count * 65536.0 + TH0 * 256.0 + TL0) * (12.0 / SYSCLK);
	mov	dptr,#_overflow_count
	movx	a,@dptr
	mov	dpl,a
	lcall	___uchar2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x0000
	mov	b,#0x80
	mov	a,#0x47
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,_TH0
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	___uchar2fs
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dptr,#0x0000
	mov	b,#0x80
	mov	a,#0x43
	lcall	___fsmul
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	r6,_TL0
	mov	r7,#0x00
	mov	dpl,r6
	mov	dph,r7
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	___sint2fs
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0xF4FC
	mov	b,#0x32
	mov	a,#0x34
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:449: return time_diff; 
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'DisplayMenu'
;------------------------------------------------------------
;units                     Allocated with name '_DisplayMenu_PARM_2'
;menu                      Allocated to registers r2 r3 
;buff                      Allocated with name '_DisplayMenu_buff_1_126'
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:453: void DisplayMenu(int menu, int units)
;	-----------------------------------------
;	 function DisplayMenu
;	-----------------------------------------
_DisplayMenu:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:457: switch(menu)
	cjne	r2,#0x00,L023014?
	cjne	r3,#0x00,L023014?
	sjmp	L023001?
L023014?:
	cjne	r2,#0x01,L023015?
	cjne	r3,#0x00,L023015?
	ljmp	L023005?
L023015?:
	cjne	r2,#0x02,L023016?
	cjne	r3,#0x00,L023016?
	ljmp	L023006?
L023016?:
	ret
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:459: case 0:
L023001?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:460: if (units) // display peak
	mov	a,_DisplayMenu_PARM_2
	orl	a,(_DisplayMenu_PARM_2 + 1)
	jnz	L023017?
	ljmp	L023003?
L023017?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:462: sprintf(buff, "Vr=%.1fV", vpeak[0]);
	mov	dptr,#_vpeak
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	a,#__str_0
	push	acc
	mov	a,#(__str_0 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_DisplayMenu_buff_1_126
	push	acc
	mov	a,#(_DisplayMenu_buff_1_126 >> 8)
	push	acc
	clr	a
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf6
	mov	sp,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:463: LCDprint(buff, 1, 0, 1);
	mov	_LCDprint_PARM_2,#0x01
	mov	_LCDprint_PARM_3,#0x00
	setb	_LCDprint_PARM_4
	mov	dptr,#_DisplayMenu_buff_1_126
	mov	b,#0x00
	lcall	_LCDprint
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:464: sprintf(buff, "Vs=%.1fV", vpeak[1]);
	mov	dptr,#(_vpeak + 0x0004)
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_DisplayMenu_buff_1_126
	push	acc
	mov	a,#(_DisplayMenu_buff_1_126 >> 8)
	push	acc
	clr	a
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf6
	mov	sp,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:465: LCDprint(buff, 2, 0, 1);
	mov	_LCDprint_PARM_2,#0x02
	mov	_LCDprint_PARM_3,#0x00
	setb	_LCDprint_PARM_4
	mov	dptr,#_DisplayMenu_buff_1_126
	mov	b,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:467: break; 
	ljmp	_LCDprint
L023003?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:472: sprintf(buff, "%.1f",phase_diff);
	mov	dptr,#_phase_diff
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	mov	a,#__str_2
	push	acc
	mov	a,#(__str_2 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_DisplayMenu_buff_1_126
	push	acc
	mov	a,#(_DisplayMenu_buff_1_126 >> 8)
	push	acc
	clr	a
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf6
	mov	sp,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:473: LCDprint(buff, 2, 0, 1);
	mov	_LCDprint_PARM_2,#0x02
	mov	_LCDprint_PARM_3,#0x00
	setb	_LCDprint_PARM_4
	mov	dptr,#_DisplayMenu_buff_1_126
	mov	b,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:477: break; 
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:480: case 1: // main menu 
	ljmp	_LCDprint
L023005?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:481: LCDprint("Phasor", 1, 4, 1);
	mov	_LCDprint_PARM_2,#0x01
	mov	_LCDprint_PARM_3,#0x04
	setb	_LCDprint_PARM_4
	mov	dptr,#__str_3
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:482: LCDprint("<    Meter     >", 2, 0, 1);
	mov	_LCDprint_PARM_2,#0x02
	mov	_LCDprint_PARM_3,#0x00
	setb	_LCDprint_PARM_4
	mov	dptr,#__str_4
	mov	b,#0x80
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:483: break;
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:484: case 2: 
	ljmp	_LCDprint
L023006?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:485: LCDprint("2", 1, 0, 1);
	mov	_LCDprint_PARM_2,#0x01
	mov	_LCDprint_PARM_3,#0x00
	setb	_LCDprint_PARM_4
	mov	dptr,#__str_5
	mov	b,#0x80
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:490: }
	ljmp	_LCDprint
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;sloc0                     Allocated with name '_main_sloc0_1_0'
;sloc1                     Allocated with name '_main_sloc1_1_0'
;v_rms                     Allocated with name '_main_v_rms_1_131'
;units                     Allocated with name '_main_units_1_131'
;period                    Allocated with name '_main_period_1_131'
;time_diff                 Allocated with name '_main_time_diff_1_131'
;menu                      Allocated with name '_main_menu_1_131'
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:493: void main (void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:497: xdata int units = 0; 
	mov	dptr,#_main_units_1_131
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:502: xdata int menu = 1; 
	mov	dptr,#_main_menu_1_131
	mov	a,#0x01
	movx	@dptr,a
	clr	a
	inc	dptr
	movx	@dptr,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:504: TIMER0_Init();
	lcall	_TIMER0_Init
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:505: LCD_4BIT(); 
	lcall	_LCD_4BIT
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:508: InitPinADC(2,1);
	mov	_InitPinADC_PARM_2,#0x01
	mov	dpl,#0x02
	lcall	_InitPinADC
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:509: InitPinADC(2,2);
	mov	_InitPinADC_PARM_2,#0x02
	mov	dpl,#0x02
	lcall	_InitPinADC
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:510: InitADC();
	lcall	_InitADC
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:511: Set_Pin_Input(0x31);
	mov	dpl,#0x31
	lcall	_Set_Pin_Input
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:512: Set_Pin_Input(0X25);
	mov	dpl,#0x25
	lcall	_Set_Pin_Input
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:513: waitms(500); // Give PuTTy a chance to start before sending
	mov	dptr,#0x01F4
	lcall	_waitms
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:514: printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
	mov	a,#__str_6
	push	acc
	mov	a,#(__str_6 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:520: __FILE__, __DATE__, __TIME__);
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:519: "Compiled: %s, %s\n\n",
	mov	a,#__str_10
	push	acc
	mov	a,#(__str_10 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#__str_9
	push	acc
	mov	a,#(__str_9 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#__str_8
	push	acc
	mov	a,#(__str_8 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#__str_7
	push	acc
	mov	a,#(__str_7 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xf4
	mov	sp,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:521: while(1)
L024022?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:523: period = ReadPeriod();
	lcall	_ReadPeriod
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:525: ReadPeak(period, vpeak);
	mov	_ReadPeak_PARM_2,#_vpeak
	mov	(_ReadPeak_PARM_2 + 1),#(_vpeak >> 8)
	mov	(_ReadPeak_PARM_2 + 2),#0x00
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_ReadPeak
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:526: time_diff = ReadDiff();
	lcall	_ReadDiff
	mov	_main_sloc0_1_0,dpl
	mov	(_main_sloc0_1_0 + 1),dph
	mov	(_main_sloc0_1_0 + 2),b
	mov	(_main_sloc0_1_0 + 3),a
	mov	dptr,#_main_time_diff_1_131
	mov	a,_main_sloc0_1_0
	movx	@dptr,a
	inc	dptr
	mov	a,(_main_sloc0_1_0 + 1)
	movx	@dptr,a
	inc	dptr
	mov	a,(_main_sloc0_1_0 + 2)
	movx	@dptr,a
	inc	dptr
	mov	a,(_main_sloc0_1_0 + 3)
	movx	@dptr,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:528: v_rms[0] = vpeak[0] / sqrtf(2); 
	mov	dptr,#_vpeak
	movx	a,@dptr
	mov	_main_sloc1_1_0,a
	inc	dptr
	movx	a,@dptr
	mov	(_main_sloc1_1_0 + 1),a
	inc	dptr
	movx	a,@dptr
	mov	(_main_sloc1_1_0 + 2),a
	inc	dptr
	movx	a,@dptr
	mov	(_main_sloc1_1_0 + 3),a
	mov	dptr,#(0x00&0x00ff)
	clr	a
	mov	b,a
	mov	a,#0x40
	lcall	_sqrtf
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,_main_sloc1_1_0
	mov	dph,(_main_sloc1_1_0 + 1)
	mov	b,(_main_sloc1_1_0 + 2)
	mov	a,(_main_sloc1_1_0 + 3)
	lcall	___fsdiv
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dptr,#_main_v_rms_1_131
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:529: v_rms[1] = vpeak[1] / sqrtf(2); 
	mov	dptr,#(_vpeak + 0x0004)
	movx	a,@dptr
	mov	_main_sloc1_1_0,a
	inc	dptr
	movx	a,@dptr
	mov	(_main_sloc1_1_0 + 1),a
	inc	dptr
	movx	a,@dptr
	mov	(_main_sloc1_1_0 + 2),a
	inc	dptr
	movx	a,@dptr
	mov	(_main_sloc1_1_0 + 3),a
	mov	dptr,#(0x00&0x00ff)
	clr	a
	mov	b,a
	mov	a,#0x40
	lcall	_sqrtf
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,_main_sloc1_1_0
	mov	dph,(_main_sloc1_1_0 + 1)
	mov	b,(_main_sloc1_1_0 + 2)
	mov	a,(_main_sloc1_1_0 + 3)
	lcall	___fsdiv
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	dptr,#(_main_v_rms_1_131 + 0x0004)
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:530: if (time_diff > (period / 2.0))
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	clr	a
	push	acc
	push	acc
	push	acc
	mov	a,#0x40
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,_main_sloc0_1_0
	mov	dph,(_main_sloc0_1_0 + 1)
	mov	b,(_main_sloc0_1_0 + 2)
	mov	a,(_main_sloc0_1_0 + 3)
	lcall	___fsgt
	mov	r6,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r6
	jz	L024002?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:532: time_diff -= period; 
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,_main_sloc0_1_0
	mov	dph,(_main_sloc0_1_0 + 1)
	mov	b,(_main_sloc0_1_0 + 2)
	mov	a,(_main_sloc0_1_0 + 3)
	lcall	___fssub
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	dptr,#_main_time_diff_1_131
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
L024002?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:534: phase_diff = time_diff * -360.0 / period; 
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#_main_time_diff_1_131
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	mov	dptr,#0x0000
	mov	b,#0xB4
	mov	a,#0xC3
	lcall	___fsmul
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsdiv
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	dptr,#_phase_diff
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:535: frequency = 1.0/ period;
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x0000
	mov	b,#0x80
	mov	a,#0x3F
	lcall	___fsdiv
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dptr,#_frequency
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:537: if (ReadButtonDebounced(Buttonleft)){
	mov	dpl,#0x31
	lcall	_ReadButtonDebounced
	clr	a
	rlc	a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	jz	L024019?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:538: if (menu == 1) menu = 0; 
	mov	dptr,#_main_menu_1_131
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	cjne	r6,#0x01,L024009?
	cjne	r7,#0x00,L024009?
	mov	dptr,#_main_menu_1_131
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	sjmp	L024010?
L024009?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:539: else if (menu == 2) menu = 1; 
	cjne	r6,#0x02,L024006?
	cjne	r7,#0x00,L024006?
	mov	dptr,#_main_menu_1_131
	mov	a,#0x01
	movx	@dptr,a
	clr	a
	inc	dptr
	movx	@dptr,a
	sjmp	L024010?
L024006?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:540: else if (menu == 0) units = ~units; 
	mov	a,r6
	orl	a,r7
	jnz	L024010?
	mov	dptr,#_main_units_1_131
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	mov	dptr,#_main_units_1_131
	mov	a,r6
	cpl	a
	movx	@dptr,a
	mov	a,r7
	cpl	a
	inc	dptr
	movx	@dptr,a
L024010?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:541: WriteCommand(0x01);
	mov	dpl,#0x01
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_WriteCommand
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:542: waitms(5);
	mov	dptr,#0x0005
	lcall	_waitms
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	sjmp	L024020?
L024019?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:545: else if (ReadButtonDebounced(Buttonright)){
	mov	dpl,#0x25
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_ReadButtonDebounced
	clr	a
	rlc	a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	jz	L024020?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:546: if (menu == 0) menu = 1; 
	mov	dptr,#_main_menu_1_131
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	orl	a,r6
	jnz	L024014?
	mov	dptr,#_main_menu_1_131
	mov	a,#0x01
	movx	@dptr,a
	clr	a
	inc	dptr
	movx	@dptr,a
	sjmp	L024015?
L024014?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:547: else if (menu == 1) menu = 2; 
	cjne	r6,#0x01,L024015?
	cjne	r7,#0x00,L024015?
	mov	dptr,#_main_menu_1_131
	mov	a,#0x02
	movx	@dptr,a
	clr	a
	inc	dptr
	movx	@dptr,a
L024015?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:548: WriteCommand(0x01);
	mov	dpl,#0x01
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_WriteCommand
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:549: waitms(5);
	mov	dptr,#0x0005
	lcall	_waitms
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
L024020?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:551: DisplayMenu(menu, units);
	mov	dptr,#_main_menu_1_131
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	mov	dptr,#_main_units_1_131
	movx	a,@dptr
	mov	_DisplayMenu_PARM_2,a
	inc	dptr
	movx	a,@dptr
	mov	(_DisplayMenu_PARM_2 + 1),a
	mov	dpl,r6
	mov	dph,r7
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_DisplayMenu
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:553: printf("Vp_ref = %.3fV, Vp_sig = %.3fV, Phase Diff = %.3fdeg, f = %.3fHz, T = %.3fs\r", vpeak[0], vpeak[1], phase_diff, frequency, period);        
	mov	dptr,#(_vpeak + 0x0004)
	movx	a,@dptr
	mov	_main_sloc1_1_0,a
	inc	dptr
	movx	a,@dptr
	mov	(_main_sloc1_1_0 + 1),a
	inc	dptr
	movx	a,@dptr
	mov	(_main_sloc1_1_0 + 2),a
	inc	dptr
	movx	a,@dptr
	mov	(_main_sloc1_1_0 + 3),a
	mov	dptr,#_vpeak
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	mov	r1,a
	mov	dptr,#_frequency
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	mov	dptr,#_phase_diff
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	push	_main_sloc1_1_0
	push	(_main_sloc1_1_0 + 1)
	push	(_main_sloc1_1_0 + 2)
	push	(_main_sloc1_1_0 + 3)
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	a,#__str_11
	push	acc
	mov	a,#(__str_11 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xe9
	mov	sp,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c:554: waitms(500);
	mov	dptr,#0x01F4
	lcall	_waitms
	ljmp	L024022?
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
__str_0:
	db 'Vr=%.1fV'
	db 0x00
__str_1:
	db 'Vs=%.1fV'
	db 0x00
__str_2:
	db '%.1f'
	db 0x00
__str_3:
	db 'Phasor'
	db 0x00
__str_4:
	db '<    Meter     >'
	db 0x00
__str_5:
	db '2'
	db 0x00
__str_6:
	db 0x1B
	db '[2J'
	db 0x00
__str_7:
	db 'Phasor Meausrement'
	db 0x0A
	db 'Test signal: P1.5 and Reference signal: P'
	db '2.3'
	db 0x0A
	db 'File: %s'
	db 0x0A
	db 'Compiled: %s, %s'
	db 0x0A
	db 0x0A
	db 0x00
__str_8:
	db 'C:'
	db 0x5C
	db 'Users'
	db 0x5C
	db 'wongh'
	db 0x5C
	db 'OneDrive - UBC'
	db 0x5C
	db 'UBC'
	db 0x5C
	db 'Year 2'
	db 0x5C
	db 'ELEC 291'
	db 0x5C
	db 'ELEC-291'
	db 0x5C
	db 'L'
	db 'ab5'
	db 0x5C
	db 'Lab5.c'
	db 0x00
__str_9:
	db 'Mar  4 2025'
	db 0x00
__str_10:
	db '16:52:04'
	db 0x00
__str_11:
	db 'Vp_ref = %.3fV, Vp_sig = %.3fV, Phase Diff = %.3fdeg, f = %.'
	db '3fHz, T = %.3fs'
	db 0x0D
	db 0x00

	CSEG

end
