// белый - сигнал, черный - земля.
#include <Adafruit_GFX.h>    
#include <Adafruit_TFTLCD.h>
#define LCD_CS A3 // Chip Select goes to Analog 3
#define LCD_CD A2 // Command/Data goes to Analog 2
#define LCD_WR A1 // LCD Write goes to Analog 1
#define LCD_RD A0 // LCD Read goes to Analog 0
#define LCD_RESET A4
#define  BLACK   0x0000
#define WHITE   0xFFFF
#define NumPoint 128
const double TwoPi = 6.283185307179586;
int         out1[64]   = { 0};
int  data[128], lastpass[64];
int x=32, ylim=64;
int i=0;
Adafruit_TFTLCD tft(LCD_CS, LCD_CD, LCD_WR, LCD_RD, LCD_RESET);
 
void setup() {                                          
Serial.begin(57600);
   tft.begin(0x9341);
   tft.fillScreen(WHITE);
}
void loop() {
 
for (i=0; i < 128; i++){                                    

  data[i] = analogRead(5); 
                                                                                                                          
  }
FFTAnalysis(data,out1,NumPoint , NumPoint/2);

 //Serial.println(String(out1[i]));

for (i=1; i< 64;i++) {
   
  tft.drawLine((i+x)*3,lastpass[i]*3,(i+x)*3,ylim*3,WHITE);         
  tft.drawLine((i+x)*3,ylim*3,(i+x)*3,(ylim-out1[i])*3,BLACK);        
  
  }
}
void FFTAnalysis(int AVal[], int FTvl[], int Nvl, int Nft)
{
  int i, j, n, m, Mmax, Istp;
  int Tmpr, Tmpi, Wtmp, Theta;
  int Wpr, Wpi, Wr, Wi;
  int *Tmvl;

  n = Nvl * 2; Tmvl = new int[n];

  for (i = 0; i < n; i += 2) 
  {
    Tmvl[i] = 0;
    Tmvl[i + 1] = AVal[i / 2];
  }

  i = 1; j = 1;
  while (i < n) 
  {
    if (j > i) 
    {
      Tmpr = Tmvl[i]; Tmvl[i] = Tmvl[j]; Tmvl[j] = Tmpr;
      Tmpr = Tmvl[i + 1]; Tmvl[i + 1] = Tmvl[j + 1]; Tmvl[j + 1] = Tmpr;
    }
    i = i + 2; m = Nvl;
    while ((m >= 2) && (j > m)) 
    {
      j = j - m; m = m >> 1;
    }
    j = j + m;
  }

  Mmax = 2;
  while (n > Mmax) 
  {
    Theta = -TwoPi / Mmax; Wpi = sin(Theta);
    Wtmp = sin(Theta / 2); Wpr = Wtmp * Wtmp * 2;
    Istp = Mmax * 2; Wr = 1; Wi = 0; m = 1;

    while (m < Mmax) 
    {
      i = m; m = m + 2; Tmpr = Wr; Tmpi = Wi;
      Wr = Wr - Tmpr * Wpr - Tmpi * Wpi;
      Wi = Wi + Tmpr * Wpi - Tmpi * Wpr;

      while (i < n) 
      {
        j = i + Mmax;
        Tmpr = Wr * Tmvl[j] - Wi * Tmvl[j - 1];
        Tmpi = Wi * Tmvl[j] + Wr * Tmvl[j - 1];

        Tmvl[j] = Tmvl[i] - Tmpr; Tmvl[j - 1] = Tmvl[i - 1] - Tmpi;
        Tmvl[i] = Tmvl[i] + Tmpr; Tmvl[i - 1] = Tmvl[i - 1] + Tmpi;
        i = i + Istp;
      }
    }

    Mmax = Istp;
  }

  for (i = 0; i < Nft; i++) 
  {
    j = i * 2;
    FTvl[i] = 2 * sqrt(pow(Tmvl[j], 2) + pow(Tmvl[j + 1], 2)) / Nvl;
  }

  delete []Tmvl;
}
