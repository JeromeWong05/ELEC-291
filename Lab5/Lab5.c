// ADC.c:  Shows how to use the 14-bit ADC.  This program
// measures the voltage from some pins of the EFM8LB1 using the ADC.
//
// (c) 2008-2023, Jesus Calvino-Fraga
//

#include <stdio.h>
#include <stdlib.h>
#include <EFM8LB1.h>
#include <math.h>

// ~C51~  

#define SYSCLK 72000000L
#define BAUDRATE 115200L
#define SARCLK 18000000L
#define ADC_sig         P1_5
#define ADC_ref         P2_3
#define Phasor_sig      P1_4
#define Phasor_ref      P2_6
#define Buttonleft      0x31
#define Buttonright     0x25
#define DebugLED        P0_1

// Pins for the LCD
#define LCD_RS          P1_7
#define LCD_E           P2_0
#define LCD_D4          P1_3
#define LCD_D5          P1_2
#define LCD_D6          P1_1
#define LCD_D7          P1_0
#define CHARS_PER_LINE  16

// The measured value of VDD in volts
#define VDD 3.302
xdata unsigned char overflow_count;
xdata float vpeak[2];
xdata float phase_diff; 
xdata float frequency; 

char _c51_external_startup (void)
{
	// Disable Watchdog with key sequence
	SFRPAGE = 0x00;
	WDTCN = 0xDE; //First key
	WDTCN = 0xAD; //Second key
  
	VDM0CN=0x80;       // enable VDD monitor
	RSTSRC=0x02|0x04;  // Enable reset on missing clock detector and VDD

	#if (SYSCLK == 48000000L)	
		SFRPAGE = 0x10;
		PFE0CN  = 0x10; // SYSCLK < 50 MHz.
		SFRPAGE = 0x00;
	#elif (SYSCLK == 72000000L)
		SFRPAGE = 0x10;
		PFE0CN  = 0x20; // SYSCLK < 75 MHz.
		SFRPAGE = 0x00;
	#endif
	
	#if (SYSCLK == 12250000L)
		CLKSEL = 0x10;
		CLKSEL = 0x10;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 24500000L)
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 48000000L)	
		// Before setting clock to 48 MHz, must transition to 24.5 MHz first
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
		CLKSEL = 0x07;
		CLKSEL = 0x07;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 72000000L)
		// Before setting clock to 72 MHz, must transition to 24.5 MHz first
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
		CLKSEL = 0x03;
		CLKSEL = 0x03;
		while ((CLKSEL & 0x80) == 0);
	#else
		#error SYSCLK must be either 12250000L, 24500000L, 48000000L, or 72000000L
	#endif
	
	P0MDOUT |= 0x10; // Enable UART0 TX as push-pull output
	XBR0     = 0x01; // Enable UART0 on P0.4(TX) and P0.5(RX)                     
	XBR1     = 0X00;
	XBR2     = 0x40; // Enable crossbar and weak pull-ups

	// Configure Uart 0
	#if (((SYSCLK/BAUDRATE)/(2L*12L))>0xFFL)
		#error Timer 0 reload value is incorrect because (SYSCLK/BAUDRATE)/(2L*12L) > 0xFF
	#endif
	SCON0 = 0x10;
	TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L));
	TL1 = TH1;      // Init Timer1
	TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	TMOD |=  0x20;                       
	TR1 = 1; // START Timer1
	TI = 1;  // Indicate TX0 ready
  	
	return 0;
}

// Uses Timer3 to delay <us> micro-seconds. 
void Timer3us(unsigned char us)
{
	xdata unsigned char i;               // usec counter
	
	// The input for Timer 3 is selected as SYSCLK by setting T3ML (bit 6) of CKCON0:
	CKCON0|=0b_0100_0000;
	
	TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	
	TMR3CN0 = 0x04;                 // Sart Timer3 and clear overflow flag
	for (i = 0; i < us; i++)       // Count <us> overflows
	{
		while (!(TMR3CN0 & 0x80));  // Wait for overflow
		TMR3CN0 &= ~(0x80);         // Clear overflow indicator
	}
	TMR3CN0 = 0 ;                   // Stop Timer3 and clear overflow flag
}

void waitms (unsigned int ms)
{
	xdata unsigned int j;
	xdata unsigned char k;
	for(j=0; j<ms; j++)
		for (k=0; k<4; k++) Timer3us(250);
}

void waitus(unsigned int us) {
    unsigned int temp = us; // Preserve the original delay
    while (temp > 255) {
        Timer3us(255);
        temp -= 255;
    }
    if (temp > 0) {
        Timer3us((unsigned char)temp);
    }
}


void TIMER0_Init(void)
{
	TMOD&=0b_1111_0000; // Set the bits of Timer/Counter 0 to zero
	TMOD|=0b_0000_0001; // Timer/Counter 0 used as a 16-bit timer
	TR0=0; // Stop Timer/Counter 0
}

// copied from previous lab - start 
void LCD_pulse (void)
{
	LCD_E=1;
	Timer3us(40);
	LCD_E=0;
}

void LCD_byte (unsigned char x)
{
	// The accumulator in the C8051Fxxx is bit addressable!
	ACC=x; //Send high nible
	LCD_D7=ACC_7;
	LCD_D6=ACC_6;
	LCD_D5=ACC_5;
	LCD_D4=ACC_4;
	LCD_pulse();
	Timer3us(40);
	ACC=x; //Send low nible
	LCD_D7=ACC_3;
	LCD_D6=ACC_2;
	LCD_D5=ACC_1;
	LCD_D4=ACC_0;
	LCD_pulse();
}

void WriteData (unsigned char x)
{
	LCD_RS=1;
	LCD_byte(x);
	waitms(2);
}

void WriteCommand (unsigned char x)
{
	LCD_RS=0;
	LCD_byte(x);
	waitms(5);
}

void LCD_4BIT (void)
{
	LCD_E=0; // Resting state of LCD's enable is zero
	// LCD_RW=0; // We are only writing to the LCD in this program
	waitms(20);
	// First make sure the LCD is in 8-bit mode and then change to 4-bit mode
	WriteCommand(0x33);
	WriteCommand(0x33);
	WriteCommand(0x32); // Change to 4-bit mode

	// Configure the LCD
	WriteCommand(0x28);
	WriteCommand(0x0c);
	WriteCommand(0x01); // Clear screen command (takes some time)
	waitms(20); // Wait for clear screen command to finsih.
}

void LCDprint(char * string, unsigned char line, unsigned char position, bit clear)
{
	int j;
	xdata unsigned char address; 
	
	if (line == 1){
		address = 0x80 + position; 
	}
	else {
		address = 0xC0 + position; 
	}
	WriteCommand(address);
	waitms(5);
	for(j=0; string[j]!=0; j++)	WriteData(string[j]);// Write the message
	if(clear) for(; j<CHARS_PER_LINE; j++) WriteData(' '); // Clear the rest of the line
}

bit Read_Pin (unsigned char pin)
{
	xdata unsigned char mask, result;
	
	mask=(1<<(pin&0x7));
	switch(pin/0x10)
	{
		default:
		case 0: result = P0 & mask; break;
		case 1: result = P1 & mask; break;
		case 2: result = P2 & mask; break; 
		case 3: result = P3 & mask; break; 
	}
	return (result?1:0);
}

bit ReadButtonDebounced(unsigned char pin)
{
    if (Read_Pin(pin) == 0) 
    {
        waitms(10);
        while (Read_Pin(pin) == 0) // check again
        {

		}
		waitms(10); 
		if (Read_Pin(pin) == 1){
			return 1;
		}

    }
    return 0; 
}

void Set_Pin_Input (unsigned char pin)
{
	xdata unsigned char mask;
	
	mask=(1<<(pin&0x7));
	mask=~mask;
	switch(pin/0x10)
	{
		case 0: P0MDOUT &= mask; break;
		case 1: P1MDOUT &= mask; break;
		case 2: P2MDOUT &= mask; break; 
		case 3: P3MDOUT &= mask; break; 
	}	
}

// copied from previous lab - end

void InitADC (void)
{
	SFRPAGE = 0x00;
	ADEN=0; // Disable ADC
	
	ADC0CN1=
		(0x2 << 6) | // 0x0: 10-bit, 0x1: 12-bit, 0x2: 14-bit
        (0x0 << 3) | // 0x0: No shift. 0x1: Shift right 1 bit. 0x2: Shift right 2 bits. 0x3: Shift right 3 bits.		
		(0x0 << 0) ; // Accumulate n conversions: 0x0: 1, 0x1:4, 0x2:8, 0x3:16, 0x4:32
	
	ADC0CF0=
	    ((SYSCLK/SARCLK) << 3) | // SAR Clock Divider. Max is 18MHz. Fsarclk = (Fadcclk) / (ADSC + 1)
		(0x0 << 2); // 0:SYSCLK ADCCLK = SYSCLK. 1:HFOSC0 ADCCLK = HFOSC0.
	
	ADC0CF1=
		(0 << 7)   | // 0: Disable low power mode. 1: Enable low power mode.
		(0x1E << 0); // Conversion Tracking Time. Tadtk = ADTK / (Fsarclk)
	
	ADC0CN0 =
		(0x0 << 7) | // ADEN. 0: Disable ADC0. 1: Enable ADC0.
		(0x0 << 6) | // IPOEN. 0: Keep ADC powered on when ADEN is 1. 1: Power down when ADC is idle.
		(0x0 << 5) | // ADINT. Set by hardware upon completion of a data conversion. Must be cleared by firmware.
		(0x0 << 4) | // ADBUSY. Writing 1 to this bit initiates an ADC conversion when ADCM = 000. This bit should not be polled to indicate when a conversion is complete. Instead, the ADINT bit should be used when polling for conversion completion.
		(0x0 << 3) | // ADWINT. Set by hardware when the contents of ADC0H:ADC0L fall within the window specified by ADC0GTH:ADC0GTL and ADC0LTH:ADC0LTL. Can trigger an interrupt. Must be cleared by firmware.
		(0x0 << 2) | // ADGN (Gain Control). 0x0: PGA gain=1. 0x1: PGA gain=0.75. 0x2: PGA gain=0.5. 0x3: PGA gain=0.25.
		(0x0 << 0) ; // TEMPE. 0: Disable the Temperature Sensor. 1: Enable the Temperature Sensor.

	ADC0CF2= 
		(0x0 << 7) | // GNDSL. 0: reference is the GND pin. 1: reference is the AGND pin.
		(0x1 << 5) | // REFSL. 0x0: VREF pin (external or on-chip). 0x1: VDD pin. 0x2: 1.8V. 0x3: internal voltage reference.
		(0x1F << 0); // ADPWR. Power Up Delay Time. Tpwrtime = ((4 * (ADPWR + 1)) + 2) / (Fadcclk)
	
	ADC0CN2 =
		(0x0 << 7) | // PACEN. 0x0: The ADC accumulator is over-written.  0x1: The ADC accumulator adds to results.
		(0x0 << 0) ; // ADCM. 0x0: ADBUSY, 0x1: TIMER0, 0x2: TIMER2, 0x3: TIMER3, 0x4: CNVSTR, 0x5: CEX5, 0x6: TIMER4, 0x7: TIMER5, 0x8: CLU0, 0x9: CLU1, 0xA: CLU2, 0xB: CLU3

	ADEN=1; // Enable ADC
}

void InitPinADC (unsigned char portno, unsigned char pinno)
{
	xdata unsigned char mask;
	
	mask=1<<pinno;

	SFRPAGE = 0x20;
	switch (portno)
	{
		case 0:
			P0MDIN &= (~mask); // Set pin as analog input
			P0SKIP |= mask; // Skip Crossbar decoding for this pin
		break;
		case 1:
			P1MDIN &= (~mask); // Set pin as analog input
			P1SKIP |= mask; // Skip Crossbar decoding for this pin
		break;
		case 2:
			P2MDIN &= (~mask); // Set pin as analog input
			P2SKIP |= mask; // Skip Crossbar decoding for this pin
		break;
		default:
		break;
	}
	SFRPAGE = 0x00;
}

xdata unsigned int ADC_at_Pin(unsigned char pin)
{
	ADC0MX = pin;   // Select input from pin
	ADINT = 0;
	ADBUSY = 1;     // Convert voltage at the pin
	while (!ADINT); // Wait for conversion to complete
	return (ADC0);
}

float Volts_at_Pin(unsigned char pin) 
{
	 return ((ADC_at_Pin(pin)*VDD)/0b_0011_1111_1111_1111);
}

float ReadPeriod(void)
{
    float period; 
    overflow_count = 0; 
    // Timer0 was configured before already - need clear TH0, TL0
    TR0 = 0; // make sure timer0 is stopped
    TH0 = 0; TL0 = 0; TF0 = 0;

    // measure reference period
    while(Phasor_ref == 1); // wait for the signal to be zero
    while(Phasor_ref == 0); // wait for the signal to be one
    TR0 = 1; // start timing 
    while(Phasor_ref == 1) // Wait for the signal to be zero
	{
		if(TF0==1) // Did the 16-bit timer overflow?
		{
			TF0=0;
			overflow_count++;
		}
	}
	while(Phasor_ref == 0) // Wait for the signal to be one
	{
		if(TF0==1) // Did the 16-bit timer overflow?
		{
			TF0=0;
			overflow_count++;
		}
	}
	TR0=0;

    period=(overflow_count * 65536.0 + TH0 * 256.0 + TL0) * (12.0 / SYSCLK);
    return period; 

}

void ReadPeak(float period, float *vpeak)
{
    float temp = period * 1e6 / 4; // Period/4 in us
	int delay_us = (int) temp; 
	// int delay_ms = period * 10e3 / 4;

    // measure reference 
    while(Phasor_ref == 1);
    while(Phasor_ref == 0); 
    // Timer3us(delay_us);
	// waitms(2);
	waitus(delay_us);
    vpeak[0] = Volts_at_Pin(QFP32_MUX_P2_3);
	
	while(Phasor_sig == 1);
	while(Phasor_sig == 0);
    // measure signal 
    waitus(delay_us);
    vpeak[1] = Volts_at_Pin(QFP32_MUX_P1_5); 

	// printf("V[0]=%.4f, V[1]=%.4f   \r", vpeak[0], vpeak[1]);
}

float ReadDiff(void){
    float time_diff;
    // reset Timer0
    TH0 = 0; 
    TL0 = 0;
    TR0 = 0; 
    TF0 = 0;
    overflow_count = 0;

    while(Phasor_ref == 1);
    while(Phasor_ref == 0);
    TR0 = 1; 
    while(Phasor_sig == 1) // Wait for the signal to be zero
	{
		if(TF0==1) // Did the 16-bit timer overflow?
		{
			TF0=0;
			overflow_count++;
		}
	}
	while(Phasor_sig == 0) // Wait for the signal to be one
	{
		if(TF0==1) // Did the 16-bit timer overflow?
		{
			TF0=0;
			overflow_count++;
		}
	}
	TR0=0;
    time_diff=(overflow_count * 65536.0 + TH0 * 256.0 + TL0) * (12.0 / SYSCLK);
    return time_diff; 
    
}

void DisplayMenu(int menu, int units)
{
    xdata char buff[17];

    switch(menu)
    {
        case 0:
            if (units) // display peak
            {
                sprintf(buff, "Vr=%.1fV", vpeak[0]);
                LCDprint(buff, 1, 0, 1);
                sprintf(buff, "Vs=%.1fV", vpeak[1]);
                LCDprint(buff, 2, 0, 1);
                // LCDprint("peak", 1, 0, 1);
                break; 

            }
            else // display rms 
            {
                sprintf(buff, "%.1f",phase_diff);
                LCDprint(buff, 2, 0, 1);
                // sprintf(buff2, "f=%.1f", frequency/1000.0);
                // LCDprint(buff2, 2, 0, 1);
                // LCDprint("rms", 1, 0, 1);
                break; 
            }
        
        case 1: // main menu 
            LCDprint("Phasor", 1, 4, 1);
            LCDprint("<    Meter     >", 2, 0, 1);
            break;
        case 2: 
            LCDprint("2", 1, 0, 1);
            // sprintf(buff, "f=%.1f", frequency/1000.0);
            // LCDprint(buff, 2, 0, 1);
            break; 

    }
}

void main (void)
{
    //initialize variables 
    xdata float v_rms[2];
    xdata int units = 0; 

    xdata float period; 
    xdata float time_diff; 

    xdata int menu = 1; 
    
    TIMER0_Init();
	LCD_4BIT(); 
	// InitPinADC(1, 5); // Configure P1.5 as analog input - signal 
	// InitPinADC(2, 3); // Configure P2.3 as analog input - reference
    InitPinADC(2,1);
    InitPinADC(2,2);
    InitADC();
    Set_Pin_Input(0x31);
    Set_Pin_Input(0X25);
    waitms(500); // Give PuTTy a chance to start before sending
	printf("\x1b[2J"); // Clear screen using ANSI escape sequence.

	printf ("Phasor Meausrement\n"
            "Test signal: P1.5 and Reference signal: P2.3\n"
	        "File: %s\n"
	        "Compiled: %s, %s\n\n",
	        __FILE__, __DATE__, __TIME__);
	while(1)
	{
        period = ReadPeriod();
        //printf("Period: %.9f\r", period);
        ReadPeak(period, vpeak);
        time_diff = ReadDiff();
        
        v_rms[0] = vpeak[0] / sqrtf(2); 
        v_rms[1] = vpeak[1] / sqrtf(2); 
        if (time_diff > (period / 2.0))
        {
            time_diff -= period; 
        }
        phase_diff = time_diff * -360.0 / period; 
        frequency = 1.0/ period;

        if (ReadButtonDebounced(Buttonleft)){
            if (menu == 1) menu = 0; 
            else if (menu == 2) menu = 1; 
            else if (menu == 0) units = ~units; 
            WriteCommand(0x01);
            waitms(5);
        }
        
        else if (ReadButtonDebounced(Buttonright)){
            if (menu == 0) menu = 1; 
            else if (menu == 1) menu = 2; 
            WriteCommand(0x01);
            waitms(5);
        }
        DisplayMenu(menu, units);

        printf("Vp_ref = %.3fV, Vp_sig = %.3fV, Phase Diff = %.3fdeg, f = %.3fHz, T = %.3fs\r", vpeak[0], vpeak[1], phase_diff, frequency, period);        
        waitms(500);
        
	}  
}	