
/* -----------------------------------------------------------------------------
  Copyright: (C) Daniel Lu, RasVector Technology.

  Email : dan59314@gmail.com
   Web :     http://www.rasvector.url.tw/
  YouTube : http://www.youtube.com/dan59314/playlist

  This software may be freely copied, modified, and redistributed
  provided that this copyright notice is preserved on all copies.
  The intellectual property rights of the algorithms used reside
  with the Daniel Lu, RasVector Technology.

  You may not distribute this software, in whole or in part, as
  part of any commercial product without the express consent of
  the author.

  There is no warranty or other guarantee of fitness of this
  software for any purpose. It is provided solely "as is".

  ---------------------------------------------------------------------------------
  版權宣告  (C) Daniel Lu, RasVector Technology.

  Email : dan59314@gmail.com
  Web :     http://www.rasvector.url.tw/
  YouTube : http://www.youtube.com/dan59314/playlist

  使用或修改軟體，請註明引用出處資訊如上。未經過作者明示同意，禁止使用在商業用途。
*/



/*
 BlueTooth Test

 PWM PIN   3, 5, 6, 9, 10, 11

 Daniel Lu : dan59314@gmail.com
 http://www.rasvector.url.tw/
 http://www.youtube.com/dan59314/playlists

  傳入字串:[A/D],[Pin#],[Value], EX: D,13,0->將 Digitial Pin 13 　設為 0
  
  1. D,3,255  ->  　設定 Digintal D3 　為 255
  2. A,1 -> 　讀取 A3 　的 analog 　　數值
  3. C,255,255,255 -> 　設定 R,G,B 　顏色直到 PinR,PinG,PinB
  4, M,1  　設定 PlayMode, cListerning, cAuto, cRandom, cRambo ....
  5. P,3,5,6  -> 　　設定 PinR=3, PinG=5, PinB=6E
  6. TD,200  -> gDelayMsc = 200 msec
  7. TI,30000  -> gIdleMsec = 30000 msec
  8. RS/RE ->　開始/結束紀錄
*/

#define UseButton
#define UseBuzzer     //會影響 BlueTooth
#define UseUltraSonic  
#define debug

#ifdef UseButton
#include <ButtonManage.h>
#endif 
#ifdef UseBuzzer
#include <BuzzerPlay.h>
#include <BuzzerNoteDefine.h>
#endif
#ifdef UseUltraSonic
#include <UltraSonicManage.h>
#endif

#include <StringManage.h>
#include <CommonTypeDefine.h>
#include <PCSerialManage.h>
#include <BlueToothSerialManage.h>

#include "RgbLedControl.h"

// constants --------------------------------------------------------------
#ifdef UseButton
const int cButtonPin=4;  // 將 pin4 連接button和一個10K ohm電阻，接到 Ground
#endif 
#ifdef UseBuzzer
const int cBuzzerPin = 7;
#endif
#ifdef UseUltraSonic
const int cTrigPin = 12;
const int cEchoPin = 13;
#endif
const byte cCommandCount = 5;

// variables --------------------------------------------------------
#ifdef debug
char sPrnt[64];
#endif
#ifdef UseBuzzer
byte gTempo = cNormalTempo;
#endif
#ifdef UseUltraSonic
float gDistance;
#endif
String sCommand[cCommandCount];  //將 Digitial Pin 13 　設為 0;
unsigned long gLastListerningTime=millis();
unsigned long gIdleMsec=3000;



void BuzzerPlay(unsigned short aFrequency, unsigned short aDuration)
{
#ifdef UseBuzzer
  BuzzerPlayer.Play_Tone( aFrequency, aDuration );
#endif
}

void Println_Serial(String sPrnt)
{
  PCSerialManager.Send_String(sPrnt);
}

void Println_BlueTooth(String sPrnt)
{
  BlueToothSerialManager.Send_String(sPrnt);
}

bool Check_HasInput()
{
  
  if (BlueToothSerialManager.Check_And_Process_String())
  {        
    return true;
  }
  else if (PCSerialManager.Check_And_Process_String())
  {        
      return true;
  }
#ifdef UseButton 
  else if ( ButtonManager.Check_ButtonEvent(cButtonPin) )
  {
    return true;
  }
#endif 
#ifdef UseUltraSonic
  else if (UltraSonicGesturer.Check_WaveEvent() )
  {
    return true;
  }
#endif
   
  return false;
}

#ifdef UseButton
void Process_ButtonEvent(TButtonManager*, int buttonPin, TButtonState bs, int clickCnt)
{
  if (buttonPin==cButtonPin)
  {  
//#ifdef debug
    sprintf(sPrnt, "Pin%d: Sts:%d, Clicks:%d", buttonPin, bs, clickCnt);   
    Println_Serial(sPrnt); 
//#endif    

    switch (bs)
    {
      case bsClick: 
#ifdef UseBuzzer
        for (int i=0; i<clickCnt; i++)
          BuzzerPlay( cFrequency[Do4], 250 );       
#endif          
        RgbLedControler.Next_PlayMode(clickCnt);          
#ifdef debug
        sprintf(sPrnt, "PlayMode:%d", RgbLedControler.FPlayMode);   
        Println_Serial(sPrnt); 
#endif    
        RgbLedControler.Process_PlayMode();
        break;
        
      case bsDoubleClick:
#ifdef UseBuzzer
        BuzzerPlay( cFrequency[Do2], 50 );
        BuzzerPlay( cFrequency[Do2], 50 );
#endif
        break;

      case bsHolding:
#ifdef UseBuzzer
        BuzzerPlay( cFrequency[Do4], 50 );
#endif 
        break;
        
      case bsHold:
#ifdef UseBuzzer
        BuzzerPlay( cFrequency[Do4], 500 );
#endif
        if (1==clickCnt)
        {
        }
        else if (2==clickCnt)
        {         
        }
        else if (3==clickCnt)
        {
        }
        break;
        
      case bsLongHold:
#ifdef UseBuzzer
        BuzzerPlay( cFrequency[Do6], 500 );
#endif
        break;
    }
  }
  else
  {
  }
}
#endif 



#ifdef UseUltraSonic
// Triggered if WaveEven ---------------------------------
void Process_WaveEvent(TUltraSonicGesturer*, TWaveState ws, int aCnt, float frDistCM, float toDistCM)
{
#ifdef debug
    sprintf(sPrnt, "ws:%d, N:%d, D:",  ws, aCnt);
    Serial.print(sPrnt);
    Serial.print("   ");
    Serial.print(frDistCM);
    Serial.print(" -> ");
    Serial.println(toDistCM);
#endif    

  switch (ws)
  {
    case wsWaveIn:
#ifdef UseBuzzer
       BuzzerPlay(cFrequency[Do1], 50 );
#endif
      break;
      
    case wsWaveOut:
#ifdef UseBuzzer
       BuzzerPlay(cFrequency[Do1], 50 );
#endif
      break;
      
    case wsWave:
#ifdef UseBuzzer
      for (int i=0; i<aCnt; i++)
         BuzzerPlay(cFrequency[Do4], 250 );
#endif         
      RgbLedControler.Next_PlayMode();     
#ifdef debug
      sprintf(sPrnt, "PlayMode:%d", RgbLedControler.FPlayMode);   
      Println_Serial(sPrnt); 
#endif    
      RgbLedControler.Process_PlayMode();
      break;

    case wsHolding:    
#ifdef UseBuzzer
      BuzzerPlay( 2100+2000/toDistCM, 250 );
#endif
      break;

    case wsHold:
#ifdef UseBuzzer
       BuzzerPlay(cFrequency[Do4], 500 );
#endif
      break;
      
    case wsNearToFar:
#ifdef UseBuzzer
       BuzzerPlay(cFrequency[Do2], 500 );
#endif
      break;
      
    case wsFarToNear:
#ifdef UseBuzzer
       BuzzerPlay(cFrequency[Do6], 500 );
#endif
      break;
  }
}
#endif





void initial_DigitalPins()
{
  for (int i=2; i<14; i++)
  //if (! isHardware_RxTx_Pin(i))
  {
    pinMode(i, OUTPUT);
    RgbLedControler.Set_DigitalPin(i, 0);  
    delay(100);
    RgbLedControler.Set_DigitalPin(i, 255); 
  }  

}


void Process_Command(String sCmd[])
{   
  
  // {"D","13","0"};  //將 Digitial Pin 13 　設為 0 ----------------
  if (sCmd[0].indexOf("A")==0)  //  || sCmd[0].indexOf("a")==0) // Analog
  { 
    /*byte pin=sCmd[1].toInt();
    byte value =  Get_AnalogPin(pin);   */
  }
  else if (sCmd[0].indexOf("C")==0)  // || sCmd[0].indexOf("c")==0) //C,255,255,255,500   Color,R,G,B,DelayMsec
  {
    byte aR=sCmd[1].toInt(), aG=sCmd[2].toInt(), aB=sCmd[3].toInt();
    unsigned long delyMsc = sCmd[4].toInt();

    RgbLedControler.Update_ActRGB(aR,aG,aB);
    RgbLedControler.Set_RGBColor(aR,aG,aB,delyMsc);

    //sprintf(sPrnt, "%d,%d,%d", aR,aG,aB,delyMsc);
    //Println_Serial(sPrnt);
  }
  else if (sCmd[0].indexOf("D")==0)  //  || sCmd[0].indexOf("d")==0) //D,13,255
  {
    RgbLedControler.Set_DigitalPin( sCmd[1].toInt(), sCmd[2].toInt());
  }
  else if (sCmd[0].indexOf("M")==0)  //  || sCmd[0].indexOf("m")==0) //m,1    PlayMode, mode
  { 
    TPlayMode playMode = (TPlayMode) ( sCmd[1].toInt() % (int)pmFinal );
    RgbLedControler.Set_PlayMode( playMode  );

    sprintf(sPrnt, "PlayMode : %d", playMode);
	  Println_Serial(sPrnt); 
	  Println_BlueTooth(sPrnt); 
  }
  else if (sCmd[0].indexOf("P")==0)  //  || sCmd[0].indexOf("p")==0) //p,3,5,6,  Pin,R,G,B
  {
    RgbLedControler.Set_PinRGB(sCmd[1].toInt(), sCmd[2].toInt(), sCmd[3].toInt());    
  }
  else if (sCmd[0].indexOf("R")==0)  //  || sCmd[0].indexOf("r")==0) //RS,RE  　紀錄開始，結束
  { 
    if (sCmd[0].indexOf("S")==1)  //  || sCmd[0].indexOf("s")==1) 
    {
      RgbLedControler.Start_RecordPlayRGBs();
    }
    else if (sCmd[0].indexOf("E")==1)  //  || sCmd[0].indexOf("e")==1) 
    {
      RgbLedControler.End_RecordPlayRGBs();      
    }  
    else ;    
  }
  else if (sCmd[0].indexOf("T")==0)  //  || sCmd[0].indexOf("t")==0) //TI, TD
  {
    if (sCmd[0].indexOf("D")==1)  //  || sCmd[0].indexOf("d")==1) // TD,200   delay msec
    {
      RgbLedControler.Set_DelayMSec(sCmd[1].toInt());    
    }
    else if (sCmd[0].indexOf("I")==1)  //  || sCmd[0].indexOf("i")==1) // TI, 2000 Idel time msec
    {
      gIdleMsec = sCmd[1].toInt() % cMaxIdleMsec;   
    }
    else ;    

  }
  else if (sCmd[0].indexOf("V") == 0)  //  || sCmd[0].indexOf("v") == 0) //v,0,255   value,type,integer
  {    
    TValueType aValueTp = (TValueType)(sCmd[1].toInt() % (int)vtFinal);
    RgbLedControler.Set_TypeValue(aValueTp, sCmd[2].toInt());   
  }
  else
  {
#ifdef debug
    Println_BlueTooth("Command : " + sCmd[0]+"-"+sCmd[1]+"-"+sCmd[2]+"not processed");
#endif
  }
}



void Process_String(String &str)
{
  byte cmdCnt;

  str.toUpperCase();
  
  if (StringManager.Split(str, ",", sCommand, cmdCnt))
  {
    Process_Command(sCommand);
  }
}


void setup() {
  
  initial_DigitalPins; //不能放在 RgbLedControler 內，Member function() 會造成 BlueTooth 失效

  RgbLedControler.Initial(5,6,9,pmBreath);

#ifdef UseButton
   pinMode(cButtonPin, INPUT); //INPUT_PULLUP);   //pinMode(cButtonPin, INPUT);
   digitalWrite(cButtonPin, HIGH );
  ButtonManager.Initial( &Process_ButtonEvent);
#endif 

#ifdef UseBuzzer
  BuzzerPlayer.Initial(cBuzzerPin, 3, NULL);
#endif

#ifdef UseUltraSonic
  UltraSonicGesturer.Initial(cTrigPin, cEchoPin, &Process_WaveEvent);
#endif
  
  
  PCSerialManager.begin(115200, &Process_String); 
  BlueToothSerialManager.begin(BaudRate_CH05, &Process_String);  // BaudRate_CH05 = 38400 
}

void loop() {
  if ( Check_HasInput() )
  {
     gLastListerningTime = millis();//有收到字串，接著繼續接收，不去作 Process_PlayMode() loading 大的工作
  }
  else 
  {
    unsigned long dMsec = millis()-gLastListerningTime;    
    
    if (dMsec > gIdleMsec)
    {
      RgbLedControler.Process_PlayMode();
    } 
    
  }

}



