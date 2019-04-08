//+------------------------------------------------------------------+ 
//|                                                      BSI_HTF.mq5 | 
//|                               Copyright © 2016, Nikolay Kositsin | 
//|                              Khabarovsk,   farria@mail.redcom.ru | 
//+------------------------------------------------------------------+ 
#property copyright "Copyright © 2016, Nikolay Kositsin"
#property link "farria@mail.redcom.ru"
//--- íîìåð âåðñèè èíäèêàòîðà
#property version   "1.60"
#property description "BSI ñ ôèêñèðîâàííûì âî âõîäíûõ ïàðàìåòðàõ òàéìôðåéìîì"
//---- îòðèñîâêà èíäèêàòîðà â îòäåëüíîì îêíå
#property indicator_separate_window 
//---- êîëè÷åñòâî èíäèêàòîðíûõ áóôåðîâ 4
#property indicator_buffers 4 
//---- èñïîëüçîâàíî âñåãî òðè ãðàôè÷åñêèõ ïîñòðîåíèÿ
#property indicator_plots   3
//+----------------------------------------------+
//| Îáúÿâëåíèå êîíñòàíò                          |
//+----------------------------------------------+
#define RESET 0                      // êîíñòàíòà äëÿ âîçâðàòà òåðìèíàëó êîìàíäû íà ïåðåñ÷åò èíäèêàòîðà
#define INDICATOR_NAME "BSI_HTF"     // êîíñòàíòà äëÿ èìåíè èíäèêàòîðà
#define SIZE 1                       // êîíñòàíòà äëÿ êîëè÷åñòâà âûçîâîâ ôóíêöèè CountIndicator â êîäå
//+-----------------------------------+
//| Ïàðàìåòðû îòðèñîâêè èíäèêàòîðà    |
//+-----------------------------------+
//---- îòðèñîâêà èíäèêàòîðà â âèäå ãèñòîãðàììû
#property indicator_type1 DRAW_HISTOGRAM
//---- â êà÷åñòâå öâåòà  ãèñòîãðàììû èñïîëüçîâàí
#property indicator_color1 clrTeal
//---- ëèíèÿ èíäèêàòîðà - ñïëîøíàÿ
#property indicator_style1 STYLE_SOLID
//---- òîëùèíà ëèíèè èíäèêàòîðà ðàâíà 2
#property indicator_width1 2
//---- îòîáðàæåíèå ìåòêè èíäèêàòîðà
#property indicator_label1 "Floor Bounce Strength"
//+-----------------------------------+
//| Ïàðàìåòðû îòðèñîâêè èíäèêàòîðà    |
//+-----------------------------------+
//---- îòðèñîâêà èíäèêàòîðà â âèäå ãèñòîãðàììû
#property indicator_type2 DRAW_HISTOGRAM
//---- â êà÷åñòâå öâåòà  ãèñòîãðàììû èñïîëüçîâàí
#property indicator_color2 clrRed
//---- ëèíèÿ èíäèêàòîðà - ñïëîøíàÿ
#property indicator_style2 STYLE_SOLID
//---- òîëùèíà ëèíèè èíäèêàòîðà ðàâíà 2
#property indicator_width2 2
//---- îòîáðàæåíèå ìåòêè èíäèêàòîðà
#property indicator_label2 "Ceiling Bounce Strength"
//+-----------------------------------+
//| Ïàðàìåòðû îòðèñîâêè èíäèêàòîðà    |
//+-----------------------------------+
//---- îòðèñîâêà èíäèêàòîðà â âèäå òðåõöâåòíîé ëèíèè
#property indicator_type3 DRAW_COLOR_LINE
//---- â êà÷åñòâå öâåòîâ òðåõöâåòíîé ëèíèè èñïîëüçîâàíû
#property indicator_color3 clrMagenta,clrGray,clrDodgerBlue
//---- ëèíèÿ èíäèêàòîðà - ñïëîøíàÿ
#property indicator_style3 STYLE_SOLID
//---- òîëùèíà ëèíèè èíäèêàòîðà ðàâíà 5
#property indicator_width3 5
//---- îòîáðàæåíèå ìåòêè ñèãíàëüíîé ëèíèè
#property indicator_label3  "Bounce Strength Index"
//+-----------------------------------+
//| Ïàðàìåòðû îòðèñîâêè óðîâíåé       |
//+-----------------------------------+
#property indicator_level1     10.0
#property indicator_level2     0.0
#property indicator_level3     -10.0
#property indicator_levelcolor clrBlue
#property indicator_levelstyle STYLE_DASHDOTDOT
//+-----------------------------------+
//| Îáúÿâëåíèå ïåðå÷èñëåíèé           |
//+-----------------------------------+
enum Volume_Mode      //òèï êîíñòàíòû
  {
   ENUM_WITHOUT_VOLUME = 1,     //Using without Volume
   ENUM_VOLUME,                 //Using Volume
   ENUM_TICKVOLUME              //Using TickVolume
  };
//+----------------------------------------------+
//| Âõîäíûå ïàðàìåòðû èíäèêàòîðà                 |
//+----------------------------------------------+
input ENUM_TIMEFRAMES TimeFrame=PERIOD_H4;   // Ïåðèîä ãðàôèêà èíäèêàòîðà
//---
input uint InpRangePeriod=20; // Range Period
input uint InpSlowing=3;      // Slowing
input uint InpAvgPeriod=3;    // Avg Period
input Volume_Mode InpUsingVolumeWeight=ENUM_TICKVOLUME;   // Using Volume
input int Shift=0; // Ñäâèã èíäèêàòîðà ïî ãîðèçîíòàëè â áàðàõ
//+----------------------------------------------+
//--- îáúÿâëåíèå äèíàìè÷åñêèõ ìàññèâîâ, êîòîðûå â äàëüíåéøåì
//--- áóäóò èñïîëüçîâàíû â êà÷åñòâå èíäèêàòîðíûõ áóôåðîâ
double Ind1Buffer[];
double Ind2Buffer[];
double Ind3Buffer[];
double Ind4Buffer[];
//--- îáúÿâëåíèå öåëî÷èñëåííûõ ïåðåìåííûõ íà÷àëà îòñ÷åòà äàííûõ
int min_rates_total;
//--- îáúÿâëåíèå öåëî÷èñëåííûõ ïåðåìåííûõ äëÿ õåíäëîâ èíäèêàòîðîâ
int Ind_Handle;
//+------------------------------------------------------------------+
//| Ïîëó÷åíèå òàéìôðåéìà â âèäå ñòðîêè                               |
//+------------------------------------------------------------------+
string GetStringTimeframe(ENUM_TIMEFRAMES timeframe)
  {return(StringSubstr(EnumToString(timeframe),7,-1));}
//+------------------------------------------------------------------+    
//| Custom indicator initialization function                         | 
//+------------------------------------------------------------------+  
int OnInit()
  {
//--- ïðîâåðêà ïåðèîäîâ ãðàôèêîâ íà êîððåêòíîñòü
   if(!TimeFramesCheck(INDICATOR_NAME,TimeFrame)) return(INIT_FAILED);
//--- èíèöèàëèçàöèÿ ïåðåìåííûõ 
   min_rates_total=2;
//--- ïîëó÷åíèå õåíäëà èíäèêàòîðà BSI
   Ind_Handle=iCustom(Symbol(),TimeFrame,"BSI",InpRangePeriod,InpSlowing,InpAvgPeriod,InpUsingVolumeWeight);
   if(Ind_Handle==INVALID_HANDLE)
     {
      Print(" Íå óäàëîñü ïîëó÷èòü õåíäë èíäèêàòîðà BSI");
      return(INIT_FAILED);
     }
//---- ïðåâðàùåíèå äèíàìè÷åñêîãî ìàññèâà â èíäèêàòîðíûé áóôåð
   SetIndexBuffer(0,Ind1Buffer,INDICATOR_DATA);
//---- èíäåêñàöèÿ ýëåìåíòîâ â áóôåðå êàê â òàéìñåðèè
   ArraySetAsSeries(Ind1Buffer,true);
//---- ïðåâðàùåíèå äèíàìè÷åñêîãî ìàññèâà â èíäèêàòîðíûé áóôåð
   SetIndexBuffer(1,Ind2Buffer,INDICATOR_DATA);
//---- èíäåêñàöèÿ ýëåìåíòîâ â áóôåðå êàê â òàéìñåðèè
   ArraySetAsSeries(Ind2Buffer,true);
//---- ïðåâðàùåíèå äèíàìè÷åñêîãî ìàññèâà â öâåòîâîé, èíäåêñíûé áóôåð   
   SetIndexBuffer(2,Ind3Buffer,INDICATOR_COLOR_INDEX);
//---- èíäåêñàöèÿ ýëåìåíòîâ â áóôåðå êàê â òàéìñåðèè
   ArraySetAsSeries(Ind3Buffer,true);
//---- ïðåâðàùåíèå äèíàìè÷åñêîãî ìàññèâà â öâåòîâîé, èíäåêñíûé áóôåð   
   SetIndexBuffer(3,Ind4Buffer,INDICATOR_COLOR_INDEX);
//---- èíäåêñàöèÿ ýëåìåíòîâ â áóôåðå êàê â òàéìñåðèè
   ArraySetAsSeries(Ind4Buffer,true);

//---- îñóùåñòâëåíèå ñäâèãà èíäèêàòîðà 1 ïî ãîðèçîíòàëè
   PlotIndexSetInteger(0,PLOT_SHIFT,Shift);
//---- îñóùåñòâëåíèå ñäâèãà íà÷àëà îòñ÷åòà îòðèñîâêè èíäèêàòîðà
   PlotIndexSetInteger(0,PLOT_DRAW_BEGIN,min_rates_total);
//---- óñòàíîâêà çíà÷åíèé èíäèêàòîðà, êîòîðûå íå áóäóò âèäèìû íà ãðàôèêå
   PlotIndexSetDouble(0,PLOT_EMPTY_VALUE,EMPTY_VALUE);
//---- îñóùåñòâëåíèå ñäâèãà èíäèêàòîðà 2 ïî ãîðèçîíòàëè
   PlotIndexSetInteger(1,PLOT_SHIFT,Shift);
//---- îñóùåñòâëåíèå ñäâèãà íà÷àëà îòñ÷åòà îòðèñîâêè èíäèêàòîðà
   PlotIndexSetInteger(1,PLOT_DRAW_BEGIN,min_rates_total);
//---- óñòàíîâêà çíà÷åíèé èíäèêàòîðà, êîòîðûå íå áóäóò âèäèìû íà ãðàôèêå
   PlotIndexSetDouble(1,PLOT_EMPTY_VALUE,EMPTY_VALUE);
//---- îñóùåñòâëåíèå ñäâèãà èíäèêàòîðà 3 ïî ãîðèçîíòàëè
   PlotIndexSetInteger(2,PLOT_SHIFT,Shift);
//---- îñóùåñòâëåíèå ñäâèãà íà÷àëà îòñ÷åòà îòðèñîâêè èíäèêàòîðà
   PlotIndexSetInteger(2,PLOT_DRAW_BEGIN,min_rates_total);
//---- óñòàíîâêà çíà÷åíèé èíäèêàòîðà, êîòîðûå íå áóäóò âèäèìû íà ãðàôèêå
   PlotIndexSetDouble(2,PLOT_EMPTY_VALUE,EMPTY_VALUE);

//--- ñîçäàíèå èìåíè äëÿ îòîáðàæåíèÿ â îòäåëüíîì ïîäîêíå è âî âñïëûâàþùåé ïîäñêàçêå
   string shortname;
   StringConcatenate(shortname,INDICATOR_NAME,"(",GetStringTimeframe(TimeFrame),")");
//---
   IndicatorSetString(INDICATOR_SHORTNAME,shortname);
//--- îïðåäåëåíèå òî÷íîñòè îòîáðàæåíèÿ çíà÷åíèé èíäèêàòîðà
   IndicatorSetInteger(INDICATOR_DIGITS,0);
//--- çàâåðøåíèå èíèöèàëèçàöèè
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+  
//| Custom iteration function                                        | 
//+------------------------------------------------------------------+  
int OnCalculate(const int rates_total,    // êîëè÷åñòâî èñòîðèè â áàðàõ íà òåêóùåì òèêå
                const int prev_calculated,// êîëè÷åñòâî èñòîðèè â áàðàõ íà ïðåäûäóùåì òèêå
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//--- ïðîâåðêà êîëè÷åñòâà áàðîâ íà äîñòàòî÷íîñòü äëÿ ðàñ÷åòà
   if(rates_total<min_rates_total) return(RESET);
   if(BarsCalculated(Ind_Handle)<Bars(Symbol(),TimeFrame)) return(prev_calculated);
//--- èíäåêñàöèÿ ýëåìåíòîâ â ìàññèâàõ êàê â òàéìñåðèÿõ  
   ArraySetAsSeries(time,true);
//---
   if(!CountIndicator(0,NULL,TimeFrame,Ind_Handle,
      0,Ind1Buffer,1,Ind2Buffer,2,Ind3Buffer,3,Ind4Buffer,
      time,rates_total,prev_calculated,min_rates_total)) return(RESET);
//---     
   return(rates_total);
  }
//+------------------------------------------------------------------+
//| CountIndicator                                                   |
//+------------------------------------------------------------------+
bool CountIndicator(uint     Numb,            // Íîìåð ôóíêöèè CountLine ïî ñïèñêó â êîäå èíäèêàòîðà (ñòàðòîâûé íîìåð - 0)
                    string   Symb,            // Ñèìâîë ãðàôèêà
                    ENUM_TIMEFRAMES TFrame,   // Ïåðèîä ãðàôèêà
                    int      IndHandle,       // Õåíäë îáðàáàòûâàåìîãî èíäèêàòîðà
                    uint     BuffNumb1,       // Íîìåð áóôåðà îáðàáàòûâàåìîãî èíäèêàòîðà 1
                    double&  IndBuf1[],       // Ïðèåìíûé áóôåð èíäèêàòîðà 1
                    uint     BuffNumb2,       // Íîìåð áóôåðà îáðàáàòûâàåìîãî èíäèêàòîðà 2
                    double&  IndBuf2[],       // Ïðèåìíûé áóôåð èíäèêàòîðà 2
                    uint     BuffNumb3,       // Íîìåð áóôåðà îáðàáàòûâàåìîãî èíäèêàòîðà 3
                    double&  IndBuf3[],       // Ïðèåìíûé áóôåð èíäèêàòîðà 3                    
                    uint     BuffNumb4,       // Íîìåð áóôåðà îáðàáàòûâàåìîãî èíäèêàòîðà 4
                    double&  IndBuf4[],       // Ïðèåìíûé áóôåð èíäèêàòîðà 4
                    const datetime& iTime[],  // Òàéìñåðèÿ âðåìåíè
                    const int Rates_Total,    // êîëè÷åñòâî èñòîðèè â áàðàõ íà òåêóùåì òèêå
                    const int Prev_Calculated,// êîëè÷åñòâî èñòîðèè â áàðàõ íà ïðåäûäóùåì òèêå
                    const int Min_Rates_Total)// ìèíèìàëüíîå êîëè÷åñòâî èñòîðèè â áàðàõ äëÿ ðàñ÷åòà
  {
//---
   static int LastCountBar[SIZE];
   datetime IndTime[1];
   int limit;
//--- ðàñ÷åòû íåîáõîäèìîãî êîëè÷åñòâà êîïèðóåìûõ äàííûõ
//--- è ñòàðòîâîãî íîìåðà limit äëÿ öèêëà ïåðåñ÷åòà áàðîâ
   if(Prev_Calculated>Rates_Total || Prev_Calculated<=0)// ïðîâåðêà íà ïåðâûé ñòàðò ðàñ÷åòà èíäèêàòîðà
     {
      limit=Rates_Total-Min_Rates_Total-1; // ñòàðòîâûé íîìåð äëÿ ðàñ÷åòà âñåõ áàðîâ
      LastCountBar[Numb]=limit;
     }
   else limit=LastCountBar[Numb]+Rates_Total-Prev_Calculated; // ñòàðòîâûé íîìåð äëÿ ðàñ÷åòà íîâûõ áàðîâ 
//--- îñíîâíîé öèêë ðàñ÷åòà èíäèêàòîðà
   for(int bar=limit; bar>=0 && !IsStopped(); bar--)
     {
      //--- êîïèðóåì âíîâü ïîÿâèâøèåñÿ äàííûå â ìàññèâ IndTime
      if(CopyTime(Symbol(),TFrame,iTime[bar],1,IndTime)<=0) return(RESET);
      //---
      if(iTime[bar]>=IndTime[0] && iTime[bar+1]<IndTime[0])
        {
         LastCountBar[Numb]=bar;
         double Arr[1];
         //--- êîïèðóåì âíîâü ïîÿâèâøèåñÿ äàííûå â ìàññèâû
         if(CopyBuffer(IndHandle,BuffNumb1,iTime[bar],1,Arr)<=0) return(RESET); IndBuf1[bar]=Arr[0];
         if(CopyBuffer(IndHandle,BuffNumb2,iTime[bar],1,Arr)<=0) return(RESET); IndBuf2[bar]=Arr[0];
         if(CopyBuffer(IndHandle,BuffNumb3,iTime[bar],1,Arr)<=0) return(RESET); IndBuf3[bar]=Arr[0];
         if(CopyBuffer(IndHandle,BuffNumb4,iTime[bar],1,Arr)<=0) return(RESET); IndBuf4[bar]=Arr[0];
        }
      else
        {
         IndBuf1[bar]=IndBuf1[bar+1];
         IndBuf2[bar]=IndBuf2[bar+1];
         IndBuf3[bar]=IndBuf3[bar+1];
         IndBuf4[bar]=IndBuf4[bar+1];
        }
     }
//---     
   return(true);
  }
//+------------------------------------------------------------------+
//| TimeFramesCheck()                                                |
//+------------------------------------------------------------------+    
bool TimeFramesCheck(string IndName,
                     ENUM_TIMEFRAMES TFrame) // Ïåðèîä ãðàôèêà èíäèêàòîðà
  {
//--- ïðîâåðêà ïåðèîäîâ ãðàôèêîâ íà êîððåêòíîñòü
   if(TFrame<Period() && TFrame!=TimeFrame_)
     {
      Print("Ïåðèîä ãðàôèêà äëÿ èíäèêàòîðà "+IndName+" íå ìîæåò áûòü ìåíüøå ïåðèîäà òåêóùåãî ãðàôèêà!");
      Print("Ñëåäóåò èçìåíèòü âõîäíûå ïàðàìåòðû èíäèêàòîðà!");
      return(RESET);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
