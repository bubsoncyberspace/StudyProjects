#include <mega128.h>
#include <alcd.h>
#include <delay.h>

    #define A   0
    #define B   1
    #define C   6
    #define D   2
    #define E   3
    #define F   4
    #define G   5
    #define DP  7  
    
    #define SEGMENT_PORT    PORTF
    #define DIGIT_PORT      PORTG
    #define DIGIT_PIN_1     1
    #define DIGIT_PIN_2     2 
    #define DIGIT_MAX       2
    
// Declare your global variables here  
unsigned char   digit, digit_point = 0;
unsigned char   digit_data [2];
unsigned char   s = 0;
unsigned char   number = 0x5;
unsigned int    ms = 0;
bit             input_flag = 0;

#define DATA_REGISTER_EMPTY (1<<UDRE0)
#define RX_COMPLETE (1<<RXC0)
#define FRAMING_ERROR (1<<FE0)
#define PARITY_ERROR (1<<UPE0)
#define DATA_OVERRUN (1<<DOR0)

// USART0 Receiver buffer
#define RX_BUFFER_SIZE0 8
char rx_buffer0[RX_BUFFER_SIZE0];

#if RX_BUFFER_SIZE0 <= 256
unsigned char rx_wr_index0=0,rx_rd_index0=0;
#else
unsigned int rx_wr_index0=0,rx_rd_index0=0;
#endif

#if RX_BUFFER_SIZE0 < 256
unsigned char rx_counter0=0;
#else
unsigned int rx_counter0=0;
#endif

// This flag is set on USART0 Receiver buffer overflow
bit rx_buffer_overflow0;

// USART0 Receiver interrupt service routine
interrupt [USART0_RXC] void usart0_rx_isr(void)
{
char status,data;
status=UCSR0A;
data=UDR0;
if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
   {
    if (data != 0x0D){ 
       rx_buffer0[rx_wr_index0++]=data;
    #if RX_BUFFER_SIZE0 == 256
       // special case for receiver buffer size=256
       if (++rx_counter0 == 0) rx_buffer_overflow0=1;
    #else
       if (rx_wr_index0 == RX_BUFFER_SIZE0) rx_wr_index0=0;
       if (++rx_counter0 == RX_BUFFER_SIZE0)
          {
          rx_counter0=0;
          rx_buffer_overflow0=1;
          }
    #endif 
    }
    else input_flag = 1;
   }
}

#ifndef _DEBUG_TERMINAL_IO_
// Get a character from the USART0 Receiver buffer
#define _ALTERNATE_GETCHAR_
#pragma used+
char getchar(void)
{
char data;
while (rx_counter0==0);
data=rx_buffer0[rx_rd_index0++];
#if RX_BUFFER_SIZE0 != 256
if (rx_rd_index0 == RX_BUFFER_SIZE0) rx_rd_index0=0;
#endif
#asm("cli")
--rx_counter0;
#asm("sei")
return data;
}
#pragma used-
#endif

// Standard Input/Output functions
#include <stdio.h>

void NumberTHScreen (void){
    DIGIT_PORT |= (DIGIT_PIN_1 | DIGIT_PIN_2);
    SEGMENT_PORT = 0;
    if (digit == 1) DIGIT_PORT &= ~DIGIT_PIN_1;
    else if (digit == 2) DIGIT_PORT &= ~DIGIT_PIN_2;
    //else if (digit == 3) PORTB |= 4;
    //else if (digit == 4) PORTB |= 16;
    
    switch (digit_data [digit - 1]) {
        case 0:{ 
            SEGMENT_PORT = (1 << A)|(1 << B)|(0 << C)|(1 << D)|(1 << E)|(1 << F)|(1 << G);
            break;
        }                         
        case 1:{
            SEGMENT_PORT = (0 << A)|(1 << B)|(0 << C)|(1 << D)|(0 << E)|(0 << F)|(0 << G);
            break;
        }
        case 2:{ 
            SEGMENT_PORT = (1 << A)|(1 << B)|(1 << C)|(0 << D)|(1 << E)|(1 << F)|(0 << G);
            break;
        }
        case 3:{ 
            SEGMENT_PORT = (1 << A)|(1 << B)|(1 << C)|(1 << D)|(1 << E)|(0 << F)|(0 << G);
            break;
        }
        case 4:{ 
            SEGMENT_PORT = (0 << A)|(1 << B)|(1 << C)|(1 << D)|(0 << E)|(0 << F)|(1 << G);
            break;
        }
        case 5:{  
            SEGMENT_PORT = (1 << A)|(0 << B)|(1 << C)|(1 << D)|(1 << E)|(0 << F)|(1 << G);
            break;
        }
        case 6:{         
            SEGMENT_PORT = (1 << A)|(0 << B)|(1 << C)|(1 << D)|(1 << E)|(1 << F)|(1 << G);
            break;
        }
        case 7:{      
            SEGMENT_PORT = (1 << A)|(1 << B)|(0 << C)|(1 << D)|(0 << E)|(0 << F)|(0 << G);
            break;
        }
        case 8:{          
            SEGMENT_PORT = (1 << A)|(1 << B)|(1 << C)|(1 << D)|(1 << E)|(1 << F)|(1 << G);
            break;
        }
        case 9:{     
            SEGMENT_PORT = (1 << A)|(1 << B)|(1 << C)|(1 << D)|(1 << E)|(0 << F)|(1 << G);
            break;
        }
        case '-':{      
            SEGMENT_PORT = (0 << A)|(0 << B)|(1 << C)|(0 << D)|(0 << E)|(0 << F)|(0 << G);
            break;
        }    
        case 'b':{
            SEGMENT_PORT = (0 << A)|(0 << B)|(1 << C)|(1 << D)|(1 << E)|(1 << F)|(1 << G);
            break;
        }         
        case 'e':{
            SEGMENT_PORT = (1 << A)|(0 << B)|(1 << C)|(0 << D)|(1 << E)|(1 << F)|(1 << G);
            break;
        }                 
        case 'g':{
            SEGMENT_PORT = (1 << A)|(0 << B)|(0 << C)|(1 << D)|(1 << E)|(1 << F)|(1 << G); 
            break;
        }            
        case 'l':{
            SEGMENT_PORT = (0 << A)|(0 << B)|(0 << C)|(0 << D)|(1 << E)|(1 << F)|(1 << G); 
            break;
        }             
        case 'n':{
            SEGMENT_PORT = (0 << A)|(0 << B)|(1 << C)|(1 << D)|(0 << E)|(1 << F)|(0 << G); 
            break;
        }                   
        case 'o':{
            SEGMENT_PORT = (0 << A)|(0 << B)|(1 << C)|(1 << D)|(1 << E)|(1 << F)|(0 << G); 
            break;
        }
        case 'p':{
            SEGMENT_PORT = (1 << A)|(1 << B)|(1 << C)|(0 << D)|(0 << E)|(1 << F)|(1 << G); 
            break;
        }        
        case ' ':{
            SEGMENT_PORT = (0 << A)|(0 << B)|(0 << C)|(0 << D)|(0 << E)|(0 << F)|(0 << G); 
            break;
        }
    } 
    if ((digit_point >> (digit - 1))&1) SEGMENT_PORT |= 1 << DP;  
    digit ++;
    if (digit == DIGIT_MAX+1) digit = 1;    
}

// Timer 0 output compare interrupt service routine
interrupt [TIM0_COMP] void timer0_comp_isr(void)
{
    if (ms++ == 4000) {  
        ms = 0;
        if (s++ == 100) {
            s = 0;
        }   
        digit_data [0] = s / 10;
        digit_data [1] = s % 10; 
        if (s == number) PORTG |= 1 << 2;
        else PORTG &= ~(1 << 2);
    }
    NumberTHScreen ();
}

void main(void)
{
// Declare your local variables here
unsigned char st [17];
unsigned char input_string [8];
unsigned char i;

// Input/Output Ports initialization
// Port A initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

// Port B initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRB=(1<<DDB7) | (1<<DDB6) | (1<<DDB5) | (1<<DDB4) | (0<<DDB3) | (1<<DDB2) | (1<<DDB1) | (1<<DDB0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (1<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

// Port C initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

// Port D initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);

// Port E initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRE=(0<<DDE7) | (0<<DDE6) | (0<<DDE5) | (0<<DDE4) | (0<<DDE3) | (0<<DDE2) | (0<<DDE1) | (0<<DDE0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTE=(0<<PORTE7) | (0<<PORTE6) | (0<<PORTE5) | (0<<PORTE4) | (0<<PORTE3) | (0<<PORTE2) | (0<<PORTE1) | (0<<PORTE0);

// Port F initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRF=(1<<DDF7) | (1<<DDF6) | (1<<DDF5) | (1<<DDF4) | (1<<DDF3) | (1<<DDF2) | (1<<DDF1) | (1<<DDF0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTF=(0<<PORTF7) | (0<<PORTF6) | (0<<PORTF5) | (0<<PORTF4) | (0<<PORTF3) | (0<<PORTF2) | (0<<PORTF1) | (0<<PORTF0);

// Port G initialization
// Function: Bit4=In Bit3=In Bit2=Out Bit1=Out Bit0=Out 
DDRG=(0<<DDG4) | (0<<DDG3) | (1<<DDG2) | (1<<DDG1) | (1<<DDG0);
// State: Bit4=T Bit3=T Bit2=0 Bit1=0 Bit0=0 
PORTG=(0<<PORTG4) | (0<<PORTG3) | (0<<PORTG2) | (0<<PORTG1) | (0<<PORTG0);

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 1000,000 kHz
// Mode: CTC top=OCR0
// OC0 output: Disconnected
// Timer Period: 0,25 ms
ASSR=0<<AS0;
TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (1<<WGM01) | (0<<CS02) | (1<<CS01) | (0<<CS00);
TCNT0=0x00;
OCR0=0xF9;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: Timer1 Stopped
// Mode: Normal top=0xFFFF
// OC1A output: Disconnected
// OC1B output: Disconnected
// OC1C output: Disconnected
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<COM1C1) | (0<<COM1C0) | (0<<WGM11) | (0<<WGM10);
TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;
OCR1CH=0x00;
OCR1CL=0x00;

// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer2 Stopped
// Mode: Normal top=0xFF
// OC2 output: Disconnected
TCCR2=(0<<WGM20) | (0<<COM21) | (0<<COM20) | (0<<WGM21) | (0<<CS22) | (0<<CS21) | (0<<CS20);
TCNT2=0x00;
OCR2=0x00;

// Timer/Counter 3 initialization
// Clock source: System Clock
// Clock value: Timer3 Stopped
// Mode: Normal top=0xFFFF
// OC3A output: Disconnected
// OC3B output: Disconnected
// OC3C output: Disconnected
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer3 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
TCCR3A=(0<<COM3A1) | (0<<COM3A0) | (0<<COM3B1) | (0<<COM3B0) | (0<<COM3C1) | (0<<COM3C0) | (0<<WGM31) | (0<<WGM30);
TCCR3B=(0<<ICNC3) | (0<<ICES3) | (0<<WGM33) | (0<<WGM32) | (0<<CS32) | (0<<CS31) | (0<<CS30);
TCNT3H=0x00;
TCNT3L=0x00;
ICR3H=0x00;
ICR3L=0x00;
OCR3AH=0x00;
OCR3AL=0x00;
OCR3BH=0x00;
OCR3BL=0x00;
OCR3CH=0x00;
OCR3CL=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (1<<OCIE0) | (0<<TOIE0);
ETIMSK=(0<<TICIE3) | (0<<OCIE3A) | (0<<OCIE3B) | (0<<TOIE3) | (0<<OCIE3C) | (0<<OCIE1C);

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
// INT3: Off
// INT4: Off
// INT5: Off
// INT6: Off
// INT7: Off
EICRA=(0<<ISC31) | (0<<ISC30) | (0<<ISC21) | (0<<ISC20) | (0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
EICRB=(0<<ISC71) | (0<<ISC70) | (0<<ISC61) | (0<<ISC60) | (0<<ISC51) | (0<<ISC50) | (0<<ISC41) | (0<<ISC40);
EIMSK=(0<<INT7) | (0<<INT6) | (0<<INT5) | (0<<INT4) | (0<<INT3) | (0<<INT2) | (0<<INT1) | (0<<INT0);

// USART0 initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART0 Receiver: On
// USART0 Transmitter: Off
// USART0 Mode: Asynchronous
// USART0 Baud Rate: 9600
UCSR0A=(0<<RXC0) | (0<<TXC0) | (0<<UDRE0) | (0<<FE0) | (0<<DOR0) | (0<<UPE0) | (0<<U2X0) | (0<<MPCM0);
UCSR0B=(1<<RXCIE0) | (0<<TXCIE0) | (0<<UDRIE0) | (1<<RXEN0) | (0<<TXEN0) | (0<<UCSZ02) | (0<<RXB80) | (0<<TXB80);
UCSR0C=(0<<UMSEL0) | (0<<UPM01) | (0<<UPM00) | (0<<USBS0) | (1<<UCSZ01) | (1<<UCSZ00) | (0<<UCPOL0);
UBRR0H=0x00;
UBRR0L=0x33;

// USART1 initialization
// USART1 disabled
UCSR1B=(0<<RXCIE1) | (0<<TXCIE1) | (0<<UDRIE1) | (0<<RXEN1) | (0<<TXEN1) | (0<<UCSZ12) | (0<<RXB81) | (0<<TXB81);

// Analog Comparator initialization
// Analog Comparator: Off
// The Analog Comparator's positive input is
// connected to the AIN0 pin
// The Analog Comparator's negative input is
// connected to the AIN1 pin
ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
SFIOR=(0<<ACME);

// ADC initialization
// ADC disabled
ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADFR) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);

// SPI initialization
// SPI disabled
SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);

// TWI initialization
// TWI disabled
TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
                                
    digit = 1;
    lcd_init (4);

// Global enable interrupts
#asm("sei")

while (1)
{
//    if (rx_counter0 != 0){  
//        lcd_gotoxy (0, 0);    
//        sprintf (st, "%02X %02X", getchar (), getchar ());
//        lcd_puts (st);
//    }   
    if (input_flag == 1){
        i = 0;  
        input_flag = 0;
        if (rx_counter0 == 2) {
            while (rx_counter0 != 0) {
                input_string [i++] = getchar ();      
            } 
            if (((input_string [0] >= 0x30) && (input_string [0] <= 0x39)) && ((input_string [1] >= 0x30) && (input_string [1] <= 0x39))){
                number = ((input_string [0] - 0x30) * 10) + (input_string [1] - 0x30);
            }
            else {
                lcd_gotoxy (0, 1);
                lcd_puts ("ERROR2");
                delay_ms (1000);
                lcd_clear ();
            } 
        }
        else if (rx_counter0 == 1) {   
            if ((input_string [0] >= 0x30) && (input_string [0] <= 0x39)){
                number = getchar () - 0x30;
            }
            else {
                lcd_gotoxy (0, 1);
                lcd_puts ("ERROR2");
                delay_ms (1000);
                lcd_clear ();
            } 
        }     
        else {
            lcd_gotoxy (0, 1);
            lcd_puts ("error1");
            delay_ms (1000);
            lcd_clear ();
        }
            lcd_gotoxy (0, 0);
            sprintf (st, "%02d ", number);
            lcd_puts (st);
    }
}
}