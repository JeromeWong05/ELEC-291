;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1170 (Feb 16 2022) (MSVC)
; This file was generated Tue Feb 25 18:04:05 2025
;--------------------------------------------------------
$name PeriodEFM8
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
	public _main
	public _DisplayMenu
	public _MeasureCap
	public _ReadButtonDebounced
	public _Read_Pin
	public _Set_Pin_Zero
	public _Set_Pin_One
	public _Set_Pin_Input
	public _Set_Pin_Output
	public _getsn
	public _LCDprint
	public _LCD_4BIT
	public _WriteCommand
	public _WriteData
	public _LCD_byte
	public _LCD_pulse
	public _TIMER0_Init
	public _waitms
	public _Timer3us
	public __c51_external_startup
	public _LCDprint_PARM_4
	public _DisplayMenu_PARM_3
	public _DisplayMenu_PARM_2
	public _getsn_PARM_2
	public _LCDprint_PARM_3
	public _LCDprint_PARM_2
	public _overflow_count
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
_overflow_count:
	ds 1
_LCDprint_PARM_2:
	ds 1
_LCDprint_PARM_3:
	ds 1
_getsn_PARM_2:
	ds 2
_getsn_buff_1_47:
	ds 3
_getsn_sloc0_1_0:
	ds 2
_DisplayMenu_StoredAvg_1_79:
	ds 4
_DisplayMenu_PARM_2:
	ds 2
_DisplayMenu_PARM_3:
	ds 2
_DisplayMenu_capacitance_1_79:
	ds 4
_DisplayMenu_i_1_79:
	ds 2
_DisplayMenu_buff_1_79:
	ds 17
_DisplayMenu_sloc0_1_0:
	ds 4
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
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
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	rseg R_PSEG
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	rseg R_XSEG
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
;------------------------------------------------------------
;Allocation info for local variables in function 'DisplayMenu'
;------------------------------------------------------------
;StoredAvg                 Allocated with name '_DisplayMenu_StoredAvg_1_79'
;units                     Allocated with name '_DisplayMenu_PARM_2'
;animation                 Allocated with name '_DisplayMenu_PARM_3'
;menu                      Allocated to registers r2 r3 
;capacitance               Allocated with name '_DisplayMenu_capacitance_1_79'
;i                         Allocated with name '_DisplayMenu_i_1_79'
;count                     Allocated to registers r4 r5 
;avg_C                     Allocated to registers r6 r7 r0 r1 
;buff                      Allocated with name '_DisplayMenu_buff_1_79'
;sloc0                     Allocated with name '_DisplayMenu_sloc0_1_0'
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:386: static double StoredAvg = 0.0; 
	mov	_DisplayMenu_StoredAvg_1_79,#0x00
	mov	(_DisplayMenu_StoredAvg_1_79 + 1),#0x00
	mov	(_DisplayMenu_StoredAvg_1_79 + 2),#0x00
	mov	(_DisplayMenu_StoredAvg_1_79 + 3),#0x00
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:35: char _c51_external_startup (void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
	using	0
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:38: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:39: WDTCN = 0xDE; //First key
	mov	_WDTCN,#0xDE
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:40: WDTCN = 0xAD; //Second key
	mov	_WDTCN,#0xAD
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:42: VDM0CN |= 0x80;
	orl	_VDM0CN,#0x80
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:43: RSTSRC = 0x02;
	mov	_RSTSRC,#0x02
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:50: SFRPAGE = 0x10;
	mov	_SFRPAGE,#0x10
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:51: PFE0CN  = 0x20; // SYSCLK < 75 MHz.
	mov	_PFE0CN,#0x20
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:52: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:73: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:74: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:75: while ((CLKSEL & 0x80) == 0);
L002001?:
	mov	a,_CLKSEL
	jnb	acc.7,L002001?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:76: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:77: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:78: while ((CLKSEL & 0x80) == 0);
L002004?:
	mov	a,_CLKSEL
	jnb	acc.7,L002004?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:83: P0MDOUT |= 0x10; // Enable UART0 TX as push-pull output
	orl	_P0MDOUT,#0x10
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:84: XBR0     = 0x01; // Enable UART0 on P0.4(TX) and P0.5(RX)                     
	mov	_XBR0,#0x01
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:85: XBR1     = 0X00;
	mov	_XBR1,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:86: XBR2     = 0x40; // Enable crossbar and weak pull-ups
	mov	_XBR2,#0x40
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:92: SCON0 = 0x10;
	mov	_SCON0,#0x10
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:93: CKCON0 |= 0b_0000_0000 ; // Timer 1 uses the system clock divided by 12.
	mov	_CKCON0,_CKCON0
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:94: TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L));
	mov	_TH1,#0xE6
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:95: TL1 = TH1;      // Init Timer1
	mov	_TL1,_TH1
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:96: TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	anl	_TMOD,#0x0F
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:97: TMOD |=  0x20;                       
	orl	_TMOD,#0x20
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:98: TR1 = 1; // START Timer1
	setb	_TR1
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:99: TI = 1;  // Indicate TX0 ready
	setb	_TI
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:101: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer3us'
;------------------------------------------------------------
;us                        Allocated to registers r2 
;i                         Allocated to registers r3 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:105: void Timer3us(unsigned char us)
;	-----------------------------------------
;	 function Timer3us
;	-----------------------------------------
_Timer3us:
	mov	r2,dpl
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:110: CKCON0|=0b_0100_0000;
	orl	_CKCON0,#0x40
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:112: TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	mov	_TMR3RL,#0xB8
	mov	(_TMR3RL >> 8),#0xFF
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:113: TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	mov	_TMR3,_TMR3RL
	mov	(_TMR3 >> 8),(_TMR3RL >> 8)
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:115: TMR3CN0 = 0x04;                 // Sart Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x04
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:116: for (i = 0; i < us; i++)       // Count <us> overflows
	mov	r3,#0x00
L003004?:
	clr	c
	mov	a,r3
	subb	a,r2
	jnc	L003007?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:118: while (!(TMR3CN0 & 0x80));  // Wait for overflow
L003001?:
	mov	a,_TMR3CN0
	jnb	acc.7,L003001?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:119: TMR3CN0 &= ~(0x80);         // Clear overflow indicator
	anl	_TMR3CN0,#0x7F
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:116: for (i = 0; i < us; i++)       // Count <us> overflows
	inc	r3
	sjmp	L003004?
L003007?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:121: TMR3CN0 = 0 ;                   // Stop Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'waitms'
;------------------------------------------------------------
;ms                        Allocated to registers r2 r3 
;j                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:124: void waitms (unsigned int ms)
;	-----------------------------------------
;	 function waitms
;	-----------------------------------------
_waitms:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:127: for(j=ms; j!=0; j--)
L004001?:
	cjne	r2,#0x00,L004010?
	cjne	r3,#0x00,L004010?
	ret
L004010?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:129: Timer3us(249);
	mov	dpl,#0xF9
	push	ar2
	push	ar3
	lcall	_Timer3us
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:130: Timer3us(249);
	mov	dpl,#0xF9
	lcall	_Timer3us
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:131: Timer3us(249);
	mov	dpl,#0xF9
	lcall	_Timer3us
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:132: Timer3us(250);
	mov	dpl,#0xFA
	lcall	_Timer3us
	pop	ar3
	pop	ar2
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:127: for(j=ms; j!=0; j--)
	dec	r2
	cjne	r2,#0xff,L004011?
	dec	r3
L004011?:
	sjmp	L004001?
;------------------------------------------------------------
;Allocation info for local variables in function 'TIMER0_Init'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:136: void TIMER0_Init(void)
;	-----------------------------------------
;	 function TIMER0_Init
;	-----------------------------------------
_TIMER0_Init:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:138: TMOD&=0b_1111_0000; // Set the bits of Timer/Counter 0 to zero
	anl	_TMOD,#0xF0
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:139: TMOD|=0b_0000_0001; // Timer/Counter 0 used as a 16-bit timer
	orl	_TMOD,#0x01
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:140: TR0=0; // Stop Timer/Counter 0
	clr	_TR0
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_pulse'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:143: void LCD_pulse (void)
;	-----------------------------------------
;	 function LCD_pulse
;	-----------------------------------------
_LCD_pulse:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:145: LCD_E=1;
	setb	_P2_0
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:146: Timer3us(40);
	mov	dpl,#0x28
	lcall	_Timer3us
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:147: LCD_E=0;
	clr	_P2_0
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_byte'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:150: void LCD_byte (unsigned char x)
;	-----------------------------------------
;	 function LCD_byte
;	-----------------------------------------
_LCD_byte:
	mov	r2,dpl
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:153: ACC=x; //Send high nible
	mov	_ACC,r2
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:154: LCD_D7=ACC_7;
	mov	c,_ACC_7
	mov	_P1_0,c
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:155: LCD_D6=ACC_6;
	mov	c,_ACC_6
	mov	_P1_1,c
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:156: LCD_D5=ACC_5;
	mov	c,_ACC_5
	mov	_P1_2,c
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:157: LCD_D4=ACC_4;
	mov	c,_ACC_4
	mov	_P1_3,c
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:158: LCD_pulse();
	push	ar2
	lcall	_LCD_pulse
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:159: Timer3us(40);
	mov	dpl,#0x28
	lcall	_Timer3us
	pop	ar2
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:160: ACC=x; //Send low nible
	mov	_ACC,r2
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:161: LCD_D7=ACC_3;
	mov	c,_ACC_3
	mov	_P1_0,c
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:162: LCD_D6=ACC_2;
	mov	c,_ACC_2
	mov	_P1_1,c
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:163: LCD_D5=ACC_1;
	mov	c,_ACC_1
	mov	_P1_2,c
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:164: LCD_D4=ACC_0;
	mov	c,_ACC_0
	mov	_P1_3,c
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:165: LCD_pulse();
	ljmp	_LCD_pulse
;------------------------------------------------------------
;Allocation info for local variables in function 'WriteData'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:168: void WriteData (unsigned char x)
;	-----------------------------------------
;	 function WriteData
;	-----------------------------------------
_WriteData:
	mov	r2,dpl
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:170: LCD_RS=1;
	setb	_P1_7
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:171: LCD_byte(x);
	mov	dpl,r2
	lcall	_LCD_byte
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:172: waitms(2);
	mov	dptr,#0x0002
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'WriteCommand'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:175: void WriteCommand (unsigned char x)
;	-----------------------------------------
;	 function WriteCommand
;	-----------------------------------------
_WriteCommand:
	mov	r2,dpl
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:177: LCD_RS=0;
	clr	_P1_7
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:178: LCD_byte(x);
	mov	dpl,r2
	lcall	_LCD_byte
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:179: waitms(5);
	mov	dptr,#0x0005
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_4BIT'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:182: void LCD_4BIT (void)
;	-----------------------------------------
;	 function LCD_4BIT
;	-----------------------------------------
_LCD_4BIT:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:184: LCD_E=0; // Resting state of LCD's enable is zero
	clr	_P2_0
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:186: waitms(20);
	mov	dptr,#0x0014
	lcall	_waitms
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:188: WriteCommand(0x33);
	mov	dpl,#0x33
	lcall	_WriteCommand
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:189: WriteCommand(0x33);
	mov	dpl,#0x33
	lcall	_WriteCommand
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:190: WriteCommand(0x32); // Change to 4-bit mode
	mov	dpl,#0x32
	lcall	_WriteCommand
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:193: WriteCommand(0x28);
	mov	dpl,#0x28
	lcall	_WriteCommand
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:194: WriteCommand(0x0c);
	mov	dpl,#0x0C
	lcall	_WriteCommand
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:195: WriteCommand(0x01); // Clear screen command (takes some time)
	mov	dpl,#0x01
	lcall	_WriteCommand
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:196: waitms(20); // Wait for clear screen command to finsih.
	mov	dptr,#0x0014
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'LCDprint'
;------------------------------------------------------------
;line                      Allocated with name '_LCDprint_PARM_2'
;position                  Allocated with name '_LCDprint_PARM_3'
;string                    Allocated to registers r2 r3 r4 
;j                         Allocated to registers r5 r6 
;address                   Allocated to registers r5 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:199: void LCDprint(char * string, unsigned char line, unsigned char position, bit clear)
;	-----------------------------------------
;	 function LCDprint
;	-----------------------------------------
_LCDprint:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:204: if (line == 1){
	mov	a,#0x01
	cjne	a,_LCDprint_PARM_2,L011002?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:205: address = 0x80 + position; 
	mov	a,#0x80
	add	a,_LCDprint_PARM_3
	mov	r5,a
	sjmp	L011003?
L011002?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:208: address = 0xC0 + position; 
	mov	a,#0xC0
	add	a,_LCDprint_PARM_3
	mov	r5,a
L011003?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:210: WriteCommand(address);
	mov	dpl,r5
	push	ar2
	push	ar3
	push	ar4
	lcall	_WriteCommand
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:211: waitms(5);
	mov	dptr,#0x0005
	lcall	_waitms
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:212: for(j=0; string[j]!=0; j++)	WriteData(string[j]);// Write the message
	mov	r5,#0x00
	mov	r6,#0x00
L011006?:
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
	jz	L011009?
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
	cjne	r5,#0x00,L011006?
	inc	r6
	sjmp	L011006?
L011009?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:213: if(clear) for(; j<CHARS_PER_LINE; j++) WriteData(' '); // Clear the rest of the line
	jnb	_LCDprint_PARM_4,L011014?
	mov	ar2,r5
	mov	ar3,r6
L011010?:
	clr	c
	mov	a,r2
	subb	a,#0x10
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L011014?
	mov	dpl,#0x20
	push	ar2
	push	ar3
	lcall	_WriteData
	pop	ar3
	pop	ar2
	inc	r2
	cjne	r2,#0x00,L011010?
	inc	r3
	sjmp	L011010?
L011014?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getsn'
;------------------------------------------------------------
;len                       Allocated with name '_getsn_PARM_2'
;buff                      Allocated with name '_getsn_buff_1_47'
;j                         Allocated with name '_getsn_sloc0_1_0'
;c                         Allocated to registers r3 
;sloc0                     Allocated with name '_getsn_sloc0_1_0'
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:216: int getsn (char * buff, int len)
;	-----------------------------------------
;	 function getsn
;	-----------------------------------------
_getsn:
	mov	_getsn_buff_1_47,dpl
	mov	(_getsn_buff_1_47 + 1),dph
	mov	(_getsn_buff_1_47 + 2),b
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:221: for(j=0; j<(len-1); j++)
	clr	a
	mov	_getsn_sloc0_1_0,a
	mov	(_getsn_sloc0_1_0 + 1),a
	mov	a,_getsn_PARM_2
	add	a,#0xff
	mov	r7,a
	mov	a,(_getsn_PARM_2 + 1)
	addc	a,#0xff
	mov	r0,a
	mov	r1,#0x00
	mov	r2,#0x00
L012005?:
	clr	c
	mov	a,r1
	subb	a,r7
	mov	a,r2
	xrl	a,#0x80
	mov	b,r0
	xrl	b,#0x80
	subb	a,b
	jnc	L012008?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:223: c=getchar();
	push	ar2
	push	ar7
	push	ar0
	push	ar1
	lcall	_getchar
	mov	r3,dpl
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar2
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:224: if ( (c=='\n') || (c=='\r') )
	cjne	r3,#0x0A,L012015?
	sjmp	L012001?
L012015?:
	cjne	r3,#0x0D,L012002?
L012001?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:226: buff[j]=0;
	mov	a,_getsn_sloc0_1_0
	add	a,_getsn_buff_1_47
	mov	r4,a
	mov	a,(_getsn_sloc0_1_0 + 1)
	addc	a,(_getsn_buff_1_47 + 1)
	mov	r5,a
	mov	r6,(_getsn_buff_1_47 + 2)
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	clr	a
	lcall	__gptrput
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:227: return j;
	mov	dpl,_getsn_sloc0_1_0
	mov	dph,(_getsn_sloc0_1_0 + 1)
	ret
L012002?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:231: buff[j]=c;
	mov	a,r1
	add	a,_getsn_buff_1_47
	mov	r4,a
	mov	a,r2
	addc	a,(_getsn_buff_1_47 + 1)
	mov	r5,a
	mov	r6,(_getsn_buff_1_47 + 2)
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	mov	a,r3
	lcall	__gptrput
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:221: for(j=0; j<(len-1); j++)
	inc	r1
	cjne	r1,#0x00,L012018?
	inc	r2
L012018?:
	mov	_getsn_sloc0_1_0,r1
	mov	(_getsn_sloc0_1_0 + 1),r2
	sjmp	L012005?
L012008?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:234: buff[j]=0;
	mov	a,_getsn_sloc0_1_0
	add	a,_getsn_buff_1_47
	mov	r2,a
	mov	a,(_getsn_sloc0_1_0 + 1)
	addc	a,(_getsn_buff_1_47 + 1)
	mov	r3,a
	mov	r4,(_getsn_buff_1_47 + 2)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	clr	a
	lcall	__gptrput
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:235: return len;
	mov	dpl,_getsn_PARM_2
	mov	dph,(_getsn_PARM_2 + 1)
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Set_Pin_Output'
;------------------------------------------------------------
;pin                       Allocated to registers r2 
;mask                      Allocated to registers r3 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:238: void Set_Pin_Output (unsigned char pin)
;	-----------------------------------------
;	 function Set_Pin_Output
;	-----------------------------------------
_Set_Pin_Output:
	mov	r2,dpl
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:242: mask=(1<<(pin&0x7));
	mov	a,#0x07
	anl	a,r2
	mov	b,a
	inc	b
	mov	a,#0x01
	sjmp	L013011?
L013009?:
	add	a,acc
L013011?:
	djnz	b,L013009?
	mov	r3,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:243: switch(pin/0x10)
	mov	a,r2
	swap	a
	anl	a,#0x0f
	mov  r2,a
	add	a,#0xff - 0x03
	jc	L013006?
	mov	a,r2
	add	a,r2
	add	a,r2
	mov	dptr,#L013013?
	jmp	@a+dptr
L013013?:
	ljmp	L013001?
	ljmp	L013002?
	ljmp	L013003?
	ljmp	L013004?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:245: case 0: P0MDOUT |= mask; break;
L013001?:
	mov	a,r3
	orl	_P0MDOUT,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:246: case 1: P1MDOUT |= mask; break;
	ret
L013002?:
	mov	a,r3
	orl	_P1MDOUT,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:247: case 2: P2MDOUT |= mask; break; 
	ret
L013003?:
	mov	a,r3
	orl	_P2MDOUT,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:248: case 3: P3MDOUT |= mask; break; 
	ret
L013004?:
	mov	a,r3
	orl	_P3MDOUT,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:249: }	
L013006?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Set_Pin_Input'
;------------------------------------------------------------
;pin                       Allocated to registers r2 
;mask                      Allocated to registers r3 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:252: void Set_Pin_Input (unsigned char pin)
;	-----------------------------------------
;	 function Set_Pin_Input
;	-----------------------------------------
_Set_Pin_Input:
	mov	r2,dpl
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:256: mask=(1<<(pin&0x7));
	mov	a,#0x07
	anl	a,r2
	mov	b,a
	inc	b
	mov	a,#0x01
	sjmp	L014011?
L014009?:
	add	a,acc
L014011?:
	djnz	b,L014009?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:257: mask=~mask;
	cpl	a
	mov	r3,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:258: switch(pin/0x10)
	mov	a,r2
	swap	a
	anl	a,#0x0f
	mov  r2,a
	add	a,#0xff - 0x03
	jc	L014006?
	mov	a,r2
	add	a,r2
	add	a,r2
	mov	dptr,#L014013?
	jmp	@a+dptr
L014013?:
	ljmp	L014001?
	ljmp	L014002?
	ljmp	L014003?
	ljmp	L014004?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:260: case 0: P0MDOUT &= mask; break;
L014001?:
	mov	a,r3
	anl	_P0MDOUT,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:261: case 1: P1MDOUT &= mask; break;
	ret
L014002?:
	mov	a,r3
	anl	_P1MDOUT,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:262: case 2: P2MDOUT &= mask; break; 
	ret
L014003?:
	mov	a,r3
	anl	_P2MDOUT,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:263: case 3: P3MDOUT &= mask; break; 
	ret
L014004?:
	mov	a,r3
	anl	_P3MDOUT,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:264: }	
L014006?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Set_Pin_One'
;------------------------------------------------------------
;pin                       Allocated to registers r2 
;mask                      Allocated to registers r3 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:267: void Set_Pin_One (unsigned char pin)
;	-----------------------------------------
;	 function Set_Pin_One
;	-----------------------------------------
_Set_Pin_One:
	mov	r2,dpl
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:271: mask=(1<<(pin&0x7));
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
	mov	r3,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:272: switch(pin/0x10)
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
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:274: case 0: P0 |= mask; break;
L015001?:
	mov	a,r3
	orl	_P0,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:275: case 1: P1 |= mask; break;
	ret
L015002?:
	mov	a,r3
	orl	_P1,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:276: case 2: P2 |= mask; break; 
	ret
L015003?:
	mov	a,r3
	orl	_P2,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:277: case 3: P3 |= mask; break; 
	ret
L015004?:
	mov	a,r3
	orl	_P3,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:278: }	
L015006?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Set_Pin_Zero'
;------------------------------------------------------------
;pin                       Allocated to registers r2 
;mask                      Allocated to registers r3 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:281: void Set_Pin_Zero (unsigned char pin)
;	-----------------------------------------
;	 function Set_Pin_Zero
;	-----------------------------------------
_Set_Pin_Zero:
	mov	r2,dpl
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:285: mask=(1<<(pin&0x7));
	mov	a,#0x07
	anl	a,r2
	mov	b,a
	inc	b
	mov	a,#0x01
	sjmp	L016011?
L016009?:
	add	a,acc
L016011?:
	djnz	b,L016009?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:286: mask=~mask;
	cpl	a
	mov	r3,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:287: switch(pin/0x10)
	mov	a,r2
	swap	a
	anl	a,#0x0f
	mov  r2,a
	add	a,#0xff - 0x03
	jc	L016006?
	mov	a,r2
	add	a,r2
	add	a,r2
	mov	dptr,#L016013?
	jmp	@a+dptr
L016013?:
	ljmp	L016001?
	ljmp	L016002?
	ljmp	L016003?
	ljmp	L016004?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:289: case 0: P0 &= mask; break;
L016001?:
	mov	a,r3
	anl	_P0,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:290: case 1: P1 &= mask; break;
	ret
L016002?:
	mov	a,r3
	anl	_P1,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:291: case 2: P2 &= mask; break; 
	ret
L016003?:
	mov	a,r3
	anl	_P2,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:292: case 3: P3 &= mask; break; 
	ret
L016004?:
	mov	a,r3
	anl	_P3,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:293: }	
L016006?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Read_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers r2 
;mask                      Allocated to registers r3 
;result                    Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:296: bit Read_Pin (unsigned char pin)
;	-----------------------------------------
;	 function Read_Pin
;	-----------------------------------------
_Read_Pin:
	mov	r2,dpl
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:300: mask=(1<<(pin&0x7));
	mov	a,#0x07
	anl	a,r2
	mov	b,a
	inc	b
	mov	a,#0x01
	sjmp	L017012?
L017010?:
	add	a,acc
L017012?:
	djnz	b,L017010?
	mov	r3,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:301: switch(pin/0x10)
	mov	a,r2
	swap	a
	anl	a,#0x0f
	mov  r2,a
	add	a,#0xff - 0x03
	jc	L017002?
	mov	a,r2
	add	a,r2
	add	a,r2
	mov	dptr,#L017014?
	jmp	@a+dptr
L017014?:
	ljmp	L017002?
	ljmp	L017003?
	ljmp	L017004?
	ljmp	L017005?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:304: case 0: result = P0 & mask; break;
L017002?:
	mov	a,r3
	anl	a,_P0
	mov	r2,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:305: case 1: result = P1 & mask; break;
	sjmp	L017006?
L017003?:
	mov	a,r3
	anl	a,_P1
	mov	r2,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:306: case 2: result = P2 & mask; break; 
	sjmp	L017006?
L017004?:
	mov	a,r3
	anl	a,_P2
	mov	r2,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:307: case 3: result = P3 & mask; break; 
	sjmp	L017006?
L017005?:
	mov	a,r3
	anl	a,_P3
	mov	r2,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:308: }
L017006?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:309: return (result?1:0);
	mov	a,r2
	add	a,#0xff
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ReadButtonDebounced'
;------------------------------------------------------------
;pin                       Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:312: bit ReadButtonDebounced(unsigned char pin)
;	-----------------------------------------
;	 function ReadButtonDebounced
;	-----------------------------------------
_ReadButtonDebounced:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:314: if (Read_Pin(pin) == 0) 
	mov  r2,dpl
	push	ar2
	lcall	_Read_Pin
	pop	ar2
	jc	L018007?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:316: waitms(10);
	mov	dptr,#0x000A
	push	ar2
	lcall	_waitms
	pop	ar2
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:317: while (Read_Pin(pin) == 0) // check again
L018001?:
	mov	dpl,r2
	push	ar2
	lcall	_Read_Pin
	clr	a
	rlc	a
	pop	ar2
	jz	L018001?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:321: waitms(10); 
	mov	dptr,#0x000A
	push	ar2
	lcall	_waitms
	pop	ar2
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:322: if (Read_Pin(pin) == 1){
	mov	dpl,r2
	lcall	_Read_Pin
	clr	a
	rlc	a
	mov	r2,a
	cjne	r2,#0x01,L018007?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:323: return 1;
	setb	c
	ret
L018007?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:327: return 0; 
	clr	c
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'MeasureCap'
;------------------------------------------------------------
;period                    Allocated to registers r2 r3 r4 r5 
;capacitance               Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:330: double MeasureCap(void)
;	-----------------------------------------
;	 function MeasureCap
;	-----------------------------------------
_MeasureCap:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:335: TL0=0; 
	mov	_TL0,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:336: TH0=0;
	mov	_TH0,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:337: TF0=0;
	clr	_TF0
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:338: overflow_count=0;
	mov	_overflow_count,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:341: while(P2_1!=0); // Wait for the signal to be zero 
L019001?:
	jb	_P2_1,L019001?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:342: while(P2_1!=1); // Wait for the signal to be one
L019004?:
	jnb	_P2_1,L019004?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:343: TR0=1; // Start the timer
	setb	_TR0
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:345: while(P2_1!=0) // Wait for the signal to be zero
L019009?:
	jnb	_P2_1,L019014?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:347: if(TF0==1) // Did the 16-bit timer overflow?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:349: TF0=0;
	jbc	_TF0,L019031?
	sjmp	L019009?
L019031?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:350: overflow_count++;
	inc	_overflow_count
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:353: while(P2_1!=1) // Wait for the signal to be one
	sjmp	L019009?
L019014?:
	jb	_P2_1,L019016?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:355: if(TF0==1) // Did the 16-bit timer overflow?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:357: TF0=0;
	jbc	_TF0,L019033?
	sjmp	L019014?
L019033?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:358: overflow_count++;
	inc	_overflow_count
	sjmp	L019014?
L019016?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:361: TR0=0; // Stop timer 0, the 24-bit number [overflow_count-TH0-TL0] has the period!
	clr	_TR0
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:362: period=(overflow_count * 65536.0 + TH0 * 256.0 + TL0) * (12.0 / SYSCLK);
	mov	dpl,_overflow_count
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
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:363: capacitance = (1.44 * period) / (RA + 2*RB);
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x51EC
	mov	b,#0xB8
	mov	a,#0x3F
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
	mov	a,#0x50
	push	acc
	mov	a,#0x36
	push	acc
	mov	a,#0x45
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
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:365: return capacitance; 
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'DisplayMenu'
;------------------------------------------------------------
;StoredAvg                 Allocated with name '_DisplayMenu_StoredAvg_1_79'
;units                     Allocated with name '_DisplayMenu_PARM_2'
;animation                 Allocated with name '_DisplayMenu_PARM_3'
;menu                      Allocated to registers r2 r3 
;capacitance               Allocated with name '_DisplayMenu_capacitance_1_79'
;i                         Allocated with name '_DisplayMenu_i_1_79'
;count                     Allocated to registers r4 r5 
;avg_C                     Allocated to registers r6 r7 r0 r1 
;buff                      Allocated with name '_DisplayMenu_buff_1_79'
;sloc0                     Allocated with name '_DisplayMenu_sloc0_1_0'
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:382: void DisplayMenu(int menu, int units, int animation)
;	-----------------------------------------
;	 function DisplayMenu
;	-----------------------------------------
_DisplayMenu:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:385: int i, count = 0; 
	mov	r4,#0x00
	mov	r5,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:387: double avg_C = 0.0; 
	mov	r6,#0x00
	mov	r7,#0x00
	mov	r0,#0x00
	mov	r1,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:390: switch(menu)
	cjne	r2,#0x00,L020049?
	cjne	r3,#0x00,L020049?
	sjmp	L020001?
L020049?:
	cjne	r2,#0x01,L020050?
	cjne	r3,#0x00,L020050?
	ljmp	L020005?
L020050?:
	cjne	r2,#0x02,L020051?
	cjne	r3,#0x00,L020051?
	ljmp	L020006?
L020051?:
	cjne	r2,#0x03,L020052?
	cjne	r3,#0x00,L020052?
	ljmp	L020007?
L020052?:
	ret
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:392: case 0: // left menu
L020001?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:393: waitms(1000);
	mov	dptr,#0x03E8
	lcall	_waitms
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:394: capacitance = MeasureCap(); 
	lcall	_MeasureCap
	mov	_DisplayMenu_capacitance_1_79,dpl
	mov	(_DisplayMenu_capacitance_1_79 + 1),dph
	mov	(_DisplayMenu_capacitance_1_79 + 2),b
	mov	(_DisplayMenu_capacitance_1_79 + 3),a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:395: if (!units){
	mov	a,_DisplayMenu_PARM_2
	orl	a,(_DisplayMenu_PARM_2 + 1)
	jnz	L020003?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:396: sprintf(buff, "%.3f uF", capacitance * 1e6); 
	push	_DisplayMenu_capacitance_1_79
	push	(_DisplayMenu_capacitance_1_79 + 1)
	push	(_DisplayMenu_capacitance_1_79 + 2)
	push	(_DisplayMenu_capacitance_1_79 + 3)
	mov	dptr,#0x2400
	mov	b,#0x74
	mov	a,#0x49
	lcall	___fsmul
	mov	_DisplayMenu_sloc0_1_0,dpl
	mov	(_DisplayMenu_sloc0_1_0 + 1),dph
	mov	(_DisplayMenu_sloc0_1_0 + 2),b
	mov	(_DisplayMenu_sloc0_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	_DisplayMenu_sloc0_1_0
	push	(_DisplayMenu_sloc0_1_0 + 1)
	push	(_DisplayMenu_sloc0_1_0 + 2)
	push	(_DisplayMenu_sloc0_1_0 + 3)
	mov	a,#__str_0
	push	acc
	mov	a,#(__str_0 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_DisplayMenu_buff_1_79
	push	acc
	mov	a,#(_DisplayMenu_buff_1_79 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf6
	mov	sp,a
	sjmp	L020004?
L020003?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:399: sprintf(buff, "%.3f nF", capacitance * 1e9);
	push	_DisplayMenu_capacitance_1_79
	push	(_DisplayMenu_capacitance_1_79 + 1)
	push	(_DisplayMenu_capacitance_1_79 + 2)
	push	(_DisplayMenu_capacitance_1_79 + 3)
	mov	dptr,#0x6B28
	mov	b,#0x6E
	mov	a,#0x4E
	lcall	___fsmul
	mov	_DisplayMenu_sloc0_1_0,dpl
	mov	(_DisplayMenu_sloc0_1_0 + 1),dph
	mov	(_DisplayMenu_sloc0_1_0 + 2),b
	mov	(_DisplayMenu_sloc0_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	_DisplayMenu_sloc0_1_0
	push	(_DisplayMenu_sloc0_1_0 + 1)
	push	(_DisplayMenu_sloc0_1_0 + 2)
	push	(_DisplayMenu_sloc0_1_0 + 3)
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_DisplayMenu_buff_1_79
	push	acc
	mov	a,#(_DisplayMenu_buff_1_79 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf6
	mov	sp,a
L020004?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:401: LCDprint("RT Meter uF<->nF", 1, 0, 1); 
	mov	_LCDprint_PARM_2,#0x01
	mov	_LCDprint_PARM_3,#0x00
	setb	_LCDprint_PARM_4
	mov	dptr,#__str_2
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:402: LCDprint(buff, 2, 0, 1);
	mov	_LCDprint_PARM_2,#0x02
	mov	_LCDprint_PARM_3,#0x00
	setb	_LCDprint_PARM_4
	mov	dptr,#_DisplayMenu_buff_1_79
	mov	b,#0x40
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:403: break; 
	ljmp	_LCDprint
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:404: case 1: // main menu
L020005?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:405: LCDprint("Capacitance", 1, 2, 1); 
	mov	_LCDprint_PARM_2,#0x01
	mov	_LCDprint_PARM_3,#0x02
	setb	_LCDprint_PARM_4
	mov	dptr,#__str_3
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:406: LCDprint("<    Meter     >", 2, 0, 1);
	mov	_LCDprint_PARM_2,#0x02
	mov	_LCDprint_PARM_3,#0x00
	setb	_LCDprint_PARM_4
	mov	dptr,#__str_4
	mov	b,#0x80
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:407: break; 
	ljmp	_LCDprint
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:408: case 2: // right menu
L020006?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:409: LCDprint("Accurate Meter", 1, 1, 1);
	mov	_LCDprint_PARM_2,#0x01
	mov	_LCDprint_PARM_3,#0x01
	setb	_LCDprint_PARM_4
	mov	dptr,#__str_5
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:410: LCDprint("  Click Start  >", 2, 0, 1); 
	mov	_LCDprint_PARM_2,#0x02
	mov	_LCDprint_PARM_3,#0x00
	setb	_LCDprint_PARM_4
	mov	dptr,#__str_6
	mov	b,#0x80
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:411: break;  
	ljmp	_LCDprint
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:412: case 3: //accurate meter 
L020007?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:413: if(animation){
	mov	a,_DisplayMenu_PARM_3
	orl	a,(_DisplayMenu_PARM_3 + 1)
	jnz	L020054?
	ljmp	L020019?
L020054?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:414: for (i = 0; i < 5; i++){
	clr	a
	mov	_DisplayMenu_i_1_79,a
	mov	(_DisplayMenu_i_1_79 + 1),a
L020027?:
	clr	c
	mov	a,_DisplayMenu_i_1_79
	subb	a,#0x05
	mov	a,(_DisplayMenu_i_1_79 + 1)
	xrl	a,#0x80
	subb	a,#0x80
	jc	L020055?
	ljmp	L020030?
L020055?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:415: LCDprint("Measuring", 1, 0, 1); 
	mov	_LCDprint_PARM_2,#0x01
	mov	_LCDprint_PARM_3,#0x00
	setb	_LCDprint_PARM_4
	mov	dptr,#__str_7
	mov	b,#0x80
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	lcall	_LCDprint
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:416: capacitance = MeasureCap();
	lcall	_MeasureCap
	mov	_DisplayMenu_capacitance_1_79,dpl
	mov	(_DisplayMenu_capacitance_1_79 + 1),dph
	mov	(_DisplayMenu_capacitance_1_79 + 2),b
	mov	(_DisplayMenu_capacitance_1_79 + 3),a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:417: if(capacitance > 1e-9){
	mov	a,#0x5F
	push	acc
	mov	a,#0x70
	push	acc
	mov	a,#0x89
	push	acc
	mov	a,#0x30
	push	acc
	mov	dpl,_DisplayMenu_capacitance_1_79
	mov	dph,(_DisplayMenu_capacitance_1_79 + 1)
	mov	b,(_DisplayMenu_capacitance_1_79 + 2)
	mov	a,(_DisplayMenu_capacitance_1_79 + 3)
	lcall	___fsgt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	mov	a,r2
	jz	L020009?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:418: avg_C += capacitance; 
	push	ar4
	push	ar5
	push	_DisplayMenu_capacitance_1_79
	push	(_DisplayMenu_capacitance_1_79 + 1)
	push	(_DisplayMenu_capacitance_1_79 + 2)
	push	(_DisplayMenu_capacitance_1_79 + 3)
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsadd
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:419: count++; 
	inc	r4
	cjne	r4,#0x00,L020057?
	inc	r5
L020057?:
L020009?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:421: waitms(200);
	mov	dptr,#0x00C8
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	lcall	_waitms
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:423: LCDprint("Measuring.", 1, 0, 1); 
	mov	_LCDprint_PARM_2,#0x01
	mov	_LCDprint_PARM_3,#0x00
	setb	_LCDprint_PARM_4
	mov	dptr,#__str_8
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:424: capacitance = MeasureCap();
	lcall	_MeasureCap
	mov	_DisplayMenu_capacitance_1_79,dpl
	mov	(_DisplayMenu_capacitance_1_79 + 1),dph
	mov	(_DisplayMenu_capacitance_1_79 + 2),b
	mov	(_DisplayMenu_capacitance_1_79 + 3),a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:425: if(capacitance > 1e-9){
	mov	a,#0x5F
	push	acc
	mov	a,#0x70
	push	acc
	mov	a,#0x89
	push	acc
	mov	a,#0x30
	push	acc
	mov	dpl,_DisplayMenu_capacitance_1_79
	mov	dph,(_DisplayMenu_capacitance_1_79 + 1)
	mov	b,(_DisplayMenu_capacitance_1_79 + 2)
	mov	a,(_DisplayMenu_capacitance_1_79 + 3)
	lcall	___fsgt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	mov	a,r2
	jz	L020011?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:426: avg_C += capacitance; 
	push	ar4
	push	ar5
	push	_DisplayMenu_capacitance_1_79
	push	(_DisplayMenu_capacitance_1_79 + 1)
	push	(_DisplayMenu_capacitance_1_79 + 2)
	push	(_DisplayMenu_capacitance_1_79 + 3)
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsadd
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:427: count++; 
	inc	r4
	cjne	r4,#0x00,L020059?
	inc	r5
L020059?:
L020011?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:429: waitms(200);
	mov	dptr,#0x00C8
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	lcall	_waitms
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:431: LCDprint("Measuring..", 1, 0, 1); 
	mov	_LCDprint_PARM_2,#0x01
	mov	_LCDprint_PARM_3,#0x00
	setb	_LCDprint_PARM_4
	mov	dptr,#__str_9
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:432: capacitance = MeasureCap();
	lcall	_MeasureCap
	mov	_DisplayMenu_capacitance_1_79,dpl
	mov	(_DisplayMenu_capacitance_1_79 + 1),dph
	mov	(_DisplayMenu_capacitance_1_79 + 2),b
	mov	(_DisplayMenu_capacitance_1_79 + 3),a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:433: if(capacitance > 1e-9){
	mov	a,#0x5F
	push	acc
	mov	a,#0x70
	push	acc
	mov	a,#0x89
	push	acc
	mov	a,#0x30
	push	acc
	mov	dpl,_DisplayMenu_capacitance_1_79
	mov	dph,(_DisplayMenu_capacitance_1_79 + 1)
	mov	b,(_DisplayMenu_capacitance_1_79 + 2)
	mov	a,(_DisplayMenu_capacitance_1_79 + 3)
	lcall	___fsgt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	mov	a,r2
	jz	L020013?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:434: avg_C += capacitance; 
	push	ar4
	push	ar5
	push	_DisplayMenu_capacitance_1_79
	push	(_DisplayMenu_capacitance_1_79 + 1)
	push	(_DisplayMenu_capacitance_1_79 + 2)
	push	(_DisplayMenu_capacitance_1_79 + 3)
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsadd
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:435: count++; 
	inc	r4
	cjne	r4,#0x00,L020061?
	inc	r5
L020061?:
L020013?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:437: waitms(200);
	mov	dptr,#0x00C8
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	lcall	_waitms
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:439: LCDprint("Measuring...", 1, 0, 1); 
	mov	_LCDprint_PARM_2,#0x01
	mov	_LCDprint_PARM_3,#0x00
	setb	_LCDprint_PARM_4
	mov	dptr,#__str_10
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:440: capacitance = MeasureCap();
	lcall	_MeasureCap
	mov	_DisplayMenu_capacitance_1_79,dpl
	mov	(_DisplayMenu_capacitance_1_79 + 1),dph
	mov	(_DisplayMenu_capacitance_1_79 + 2),b
	mov	(_DisplayMenu_capacitance_1_79 + 3),a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:441: if(capacitance > 1e-9){
	mov	a,#0x5F
	push	acc
	mov	a,#0x70
	push	acc
	mov	a,#0x89
	push	acc
	mov	a,#0x30
	push	acc
	mov	dpl,_DisplayMenu_capacitance_1_79
	mov	dph,(_DisplayMenu_capacitance_1_79 + 1)
	mov	b,(_DisplayMenu_capacitance_1_79 + 2)
	mov	a,(_DisplayMenu_capacitance_1_79 + 3)
	lcall	___fsgt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	mov	a,r2
	jz	L020015?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:442: avg_C += capacitance; 
	push	ar4
	push	ar5
	push	_DisplayMenu_capacitance_1_79
	push	(_DisplayMenu_capacitance_1_79 + 1)
	push	(_DisplayMenu_capacitance_1_79 + 2)
	push	(_DisplayMenu_capacitance_1_79 + 3)
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsadd
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:443: count++; 
	inc	r4
	cjne	r4,#0x00,L020063?
	inc	r5
L020063?:
L020015?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:445: waitms(200);
	mov	dptr,#0x00C8
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	lcall	_waitms
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:414: for (i = 0; i < 5; i++){
	inc	_DisplayMenu_i_1_79
	clr	a
	cjne	a,_DisplayMenu_i_1_79,L020064?
	inc	(_DisplayMenu_i_1_79 + 1)
L020064?:
	ljmp	L020027?
L020030?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:447: if (count!=0) {
	mov	a,r4
	orl	a,r5
	jz	L020017?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:448: avg_C = avg_C / (double)count; 
	mov	dpl,r4
	mov	dph,r5
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	lcall	___sint2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
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
L020017?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:450: StoredAvg = avg_C; 
	mov	_DisplayMenu_StoredAvg_1_79,r6
	mov	(_DisplayMenu_StoredAvg_1_79 + 1),r7
	mov	(_DisplayMenu_StoredAvg_1_79 + 2),r0
	mov	(_DisplayMenu_StoredAvg_1_79 + 3),r1
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:451: WriteCommand(0x01);
	mov	dpl,#0x01
	lcall	_WriteCommand
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:452: waitms(20);
	mov	dptr,#0x0014
	lcall	_waitms
L020019?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:455: if (StoredAvg < 1e-9)
	mov	a,#0x5F
	push	acc
	mov	a,#0x70
	push	acc
	mov	a,#0x89
	push	acc
	mov	a,#0x30
	push	acc
	mov	dpl,_DisplayMenu_StoredAvg_1_79
	mov	dph,(_DisplayMenu_StoredAvg_1_79 + 1)
	mov	b,(_DisplayMenu_StoredAvg_1_79 + 2)
	mov	a,(_DisplayMenu_StoredAvg_1_79 + 3)
	lcall	___fslt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,r2
	jz	L020024?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:457: LCDprint("Capacitance OOR", 1, 0, 1);
	mov	_LCDprint_PARM_2,#0x01
	mov	_LCDprint_PARM_3,#0x00
	setb	_LCDprint_PARM_4
	mov	dptr,#__str_11
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:458: LCDprint("TOO SMALL", 2, 0, 1);
	mov	_LCDprint_PARM_2,#0x02
	mov	_LCDprint_PARM_3,#0x00
	setb	_LCDprint_PARM_4
	mov	dptr,#__str_12
	mov	b,#0x80
	ljmp	_LCDprint
L020024?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:461: if (!units){
	mov	a,_DisplayMenu_PARM_2
	orl	a,(_DisplayMenu_PARM_2 + 1)
	jnz	L020021?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:462: sprintf(buff, "%.5f uF", StoredAvg * 1e6); 
	push	_DisplayMenu_StoredAvg_1_79
	push	(_DisplayMenu_StoredAvg_1_79 + 1)
	push	(_DisplayMenu_StoredAvg_1_79 + 2)
	push	(_DisplayMenu_StoredAvg_1_79 + 3)
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
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	a,#__str_13
	push	acc
	mov	a,#(__str_13 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_DisplayMenu_buff_1_79
	push	acc
	mov	a,#(_DisplayMenu_buff_1_79 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf6
	mov	sp,a
	sjmp	L020022?
L020021?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:465: sprintf(buff, "%.5f nF", StoredAvg * 1e9);
	push	_DisplayMenu_StoredAvg_1_79
	push	(_DisplayMenu_StoredAvg_1_79 + 1)
	push	(_DisplayMenu_StoredAvg_1_79 + 2)
	push	(_DisplayMenu_StoredAvg_1_79 + 3)
	mov	dptr,#0x6B28
	mov	b,#0x6E
	mov	a,#0x4E
	lcall	___fsmul
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
	mov	a,#__str_14
	push	acc
	mov	a,#(__str_14 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_DisplayMenu_buff_1_79
	push	acc
	mov	a,#(_DisplayMenu_buff_1_79 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf6
	mov	sp,a
L020022?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:467: LCDprint("Capacitance:", 1, 0, 1); 
	mov	_LCDprint_PARM_2,#0x01
	mov	_LCDprint_PARM_3,#0x00
	setb	_LCDprint_PARM_4
	mov	dptr,#__str_15
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:468: LCDprint(buff, 2, 0, 1);
	mov	_LCDprint_PARM_2,#0x02
	mov	_LCDprint_PARM_3,#0x00
	setb	_LCDprint_PARM_4
	mov	dptr,#_DisplayMenu_buff_1_79
	mov	b,#0x40
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:473: }
	ljmp	_LCDprint
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;menu                      Allocated to registers r2 r3 
;units                     Allocated to registers r4 r5 
;runanimation              Allocated to registers r6 r7 
;------------------------------------------------------------
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:476: void main (void) 
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:479: int menu = 1; // 0 is left, 1 is main, 2 is right
	mov	r2,#0x01
	mov	r3,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:480: int units = 0; 
	mov	r4,#0x00
	mov	r5,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:483: TIMER0_Init();
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_TIMER0_Init
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:484: LCD_4BIT(); 
	lcall	_LCD_4BIT
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:485: DisplayMenu(menu, units, runanimation); 	
	clr	a
	mov	_DisplayMenu_PARM_2,a
	mov	(_DisplayMenu_PARM_2 + 1),a
	mov	_DisplayMenu_PARM_3,a
	mov	(_DisplayMenu_PARM_3 + 1),a
	mov	dptr,#0x0001
	lcall	_DisplayMenu
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:487: waitms(500); // Give PuTTY a chance to start.
	mov	dptr,#0x01F4
	lcall	_waitms
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:488: printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
	mov	a,#__str_16
	push	acc
	mov	a,#(__str_16 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:493: __FILE__, __DATE__, __TIME__);
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:492: "Compiled: %s, %s\n\n",
	mov	a,#__str_20
	push	acc
	mov	a,#(__str_20 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#__str_19
	push	acc
	mov	a,#(__str_19 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#__str_18
	push	acc
	mov	a,#(__str_18 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#__str_17
	push	acc
	mov	a,#(__str_17 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xf4
	mov	sp,a
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:495: Set_Pin_Output(0x01); 
	mov	dpl,#0x01
	lcall	_Set_Pin_Output
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:496: Set_Pin_Input(0x21); 
	mov	dpl,#0x21
	lcall	_Set_Pin_Input
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:497: Set_Pin_Input(0x26); 
	mov	dpl,#0x26
	lcall	_Set_Pin_Input
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:498: Set_Pin_Input(0x23); 
	mov	dpl,#0x23
	lcall	_Set_Pin_Input
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:500: while (1)
L021025?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:502: runanimation = 0; 
	mov	r6,#0x00
	mov	r7,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:503: if (ReadButtonDebounced(ButtonLeft)){
	mov	dpl,#0x26
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	_ReadButtonDebounced
	clr	a
	rlc	a
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	jz	L021022?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:504: if (menu == 1) menu = 0; 
	cjne	r2,#0x01,L021008?
	cjne	r3,#0x00,L021008?
	mov	r2,#0x00
	mov	r3,#0x00
	sjmp	L021009?
L021008?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:505: else if (menu == 2) menu = 1;
	cjne	r2,#0x02,L021005?
	cjne	r3,#0x00,L021005?
	mov	r2,#0x01
	mov	r3,#0x00
	sjmp	L021009?
L021005?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:506: else if (menu == 3) menu = 2; 
	cjne	r2,#0x03,L021002?
	cjne	r3,#0x00,L021002?
	mov	r2,#0x02
	mov	r3,#0x00
	sjmp	L021009?
L021002?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:507: else units = ~units; 
	mov	a,r4
	cpl	a
	mov	r4,a
	mov	a,r5
	cpl	a
	mov	r5,a
L021009?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:508: WriteCommand(0x01); 
	mov	dpl,#0x01
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	_WriteCommand
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:509: waitms(5); 
	mov	dptr,#0x0005
	lcall	_waitms
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	sjmp	L021023?
L021022?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:511: else if (ReadButtonDebounced(ButtonRight)){
	mov	dpl,#0x23
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	_ReadButtonDebounced
	clr	a
	rlc	a
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	jz	L021023?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:512: if (menu == 1) menu = 2; 
	cjne	r2,#0x01,L021017?
	cjne	r3,#0x00,L021017?
	mov	r2,#0x02
	mov	r3,#0x00
	sjmp	L021018?
L021017?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:513: else if (menu == 0) menu = 1; 
	mov	a,r2
	orl	a,r3
	jnz	L021014?
	mov	r2,#0x01
	mov	r3,a
	sjmp	L021018?
L021014?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:514: else if (menu == 2){
	cjne	r2,#0x02,L021011?
	cjne	r3,#0x00,L021011?
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:515: menu = 3; 
	mov	r2,#0x03
	mov	r3,#0x00
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:516: runanimation = 1; 
	mov	r6,#0x01
	mov	r7,#0x00
	sjmp	L021018?
L021011?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:518: else units = ~units; 
	mov	a,r4
	cpl	a
	mov	r4,a
	mov	a,r5
	cpl	a
	mov	r5,a
L021018?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:519: WriteCommand(0x01); 
	mov	dpl,#0x01
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	_WriteCommand
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:520: waitms(5); 
	mov	dptr,#0x0005
	lcall	_waitms
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
L021023?:
;	C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c:522: DisplayMenu(menu, units, runanimation); 
	mov	_DisplayMenu_PARM_2,r4
	mov	(_DisplayMenu_PARM_2 + 1),r5
	mov	_DisplayMenu_PARM_3,r6
	mov	(_DisplayMenu_PARM_3 + 1),r7
	mov	dpl,r2
	mov	dph,r3
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_DisplayMenu
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	ljmp	L021025?
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
__str_0:
	db '%.3f uF'
	db 0x00
__str_1:
	db '%.3f nF'
	db 0x00
__str_2:
	db 'RT Meter uF<->nF'
	db 0x00
__str_3:
	db 'Capacitance'
	db 0x00
__str_4:
	db '<    Meter     >'
	db 0x00
__str_5:
	db 'Accurate Meter'
	db 0x00
__str_6:
	db '  Click Start  >'
	db 0x00
__str_7:
	db 'Measuring'
	db 0x00
__str_8:
	db 'Measuring.'
	db 0x00
__str_9:
	db 'Measuring..'
	db 0x00
__str_10:
	db 'Measuring...'
	db 0x00
__str_11:
	db 'Capacitance OOR'
	db 0x00
__str_12:
	db 'TOO SMALL'
	db 0x00
__str_13:
	db '%.5f uF'
	db 0x00
__str_14:
	db '%.5f nF'
	db 0x00
__str_15:
	db 'Capacitance:'
	db 0x00
__str_16:
	db 0x1B
	db '[2J'
	db 0x00
__str_17:
	db 'EFM8 Period measurement at pin P0.1 using Timer 0.'
	db 0x0A
	db 'File: %s'
	db 0x0A
	db 'Compiled: %s, %s'
	db 0x0A
	db 0x0A
	db 0x00
__str_18:
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
	db 'Lab4'
	db 0x5C
	db 'Perio'
	db 'dEFM8.c'
	db 0x00
__str_19:
	db 'Feb 25 2025'
	db 0x00
__str_20:
	db '18:04:05'
	db 0x00

	CSEG

end
