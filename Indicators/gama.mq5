//+------------------------------------------------------------------+
//|                                                          BSI.mq5 |
//|                                          Copyright 2015, fxborg. |
//|                                  http://blog.livedoor.jp/fxborg/ |
//+------------------------------------------------------------------+ 
#property copyright   "Copyright 2015, fxborg"
#property link        "http://blog.livedoor.jp/fxborg/"
#property description "Bounce Strength Indicator" 
//---- íîìåð âåðñèè èíäèêàòîðà
#property version   "1.00"
//---- îòðèñîâêà èíäèêàòîðà â îòäåëüíîì îêíå
#property indicator_separate_window 
//---- êîëè÷åñòâî èíäèêàòîðíûõ áóôåðîâ 4
#property indicator_buffers 4 
//---- èñïîëüçîâàíî âñåãî òðè ãðàôè÷åñêèõ ïîñòðîåíèÿ
#property indicator_plots   3
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
//---- òîëùèíà ëèíèè èíäèêàòîðà ðàâíà 3
#property indicator_width3 3
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
//+-----------------------------------+
//| Âõîäíûå ïàðàìåòðû èíäèêàòîðà      |
//+-----------------------------------+
input uint InpRangePeriod=20; // Range Period
input uint InpSlowing=3;      // Slowing
input uint InpAvgPeriod=3;    // Avg Period
input Volume_Mode InpUsingVolumeWeight=ENUM_TICKVOLUME;   // Using Volume
//+-----------------------------------+
//---- îáúÿâëåíèå ãëîáàëüíûõ ïåðåìåííûõ
int Count[];
double ExtHighest[],ExtLowest[],ExtVolume[];
//---- îáúÿâëåíèå öåëî÷èñëåííûõ ïåðåìåííûõ íà÷àëà îòñ÷åòà äàííûõ
int min_rates_total,size,min_rates_1;
//---- îáúÿâëåíèå äèíàìè÷åñêèõ ìàññèâîâ, êîòîðûå áóäóò â 
//---- äàëüíåéøåì èñïîëüçîâàíû â êà÷åñòâå èíäèêàòîðíûõ áóôåðîâ
double ExtPosBuffer[],ExtNegBuffer[],BSIBuffer[],ColorBSIBuffer[];
//+------------------------------------------------------------------+
//| Ïåðåñ÷åò ïîçèöèè ñàìîãî íîâîãî ýëåìåíòà â ìàññèâå                |
//+------------------------------------------------------------------+   
void Recount_ArrayZeroPos(int &CoArr[],// âîçâðàò ïî ññûëêå íîìåðà òåêóùåãî çíà÷åíèÿ öåíîâîãî ðÿäà
                          int Size)
  {
//----
   int numb,Max1,Max2;
   static int count=1;
//----
   Max2=Size;
   Max1=Max2-1;
//----
   count--;
   if(count<0) count=Max1;
//----
   for(int iii=0; iii<Max2; iii++)
     {
      numb=iii+count;
      if(numb>Max1) numb-=Max2;
      CoArr[iii]=numb;
     }
//----
  }
//+------------------------------------------------------------------+    
//| BSI indicator initialization function                            | 
//+------------------------------------------------------------------+  
void OnInit()
  {
//---- èíèöèàëèçàöèÿ ïåðåìåííûõ íà÷àëà îòñ÷åòà äàííûõ
   min_rates_total=int(InpRangePeriod+InpSlowing+InpAvgPeriod);
   size=int(MathMax(InpRangePeriod,InpSlowing));
   min_rates_1=size;
//---- ðàñïðåäåëåíèå ïàìÿòè ïîä ìàññèâû ïåðåìåííûõ  
   ArrayResize(Count,size);
   ArrayResize(ExtHighest,size);
   ArrayResize(ExtLowest,size);
   ArrayResize(ExtVolume,size);
//---- ïðåâðàùåíèå äèíàìè÷åñêîãî ìàññèâà BSIBuffer â èíäèêàòîðíûé áóôåð
   SetIndexBuffer(0,ExtPosBuffer,INDICATOR_DATA);
//---- îñóùåñòâëåíèå ñäâèãà íà÷àëà îòñ÷åòà îòðèñîâêè èíäèêàòîðà
   PlotIndexSetInteger(0,PLOT_DRAW_BEGIN,min_rates_total);
//---- óñòàíîâêà çíà÷åíèé èíäèêàòîðà, êîòîðûå íå áóäóò âèäèìû íà ãðàôèêå
   PlotIndexSetDouble(0,PLOT_EMPTY_VALUE,EMPTY_VALUE);

//---- ïðåâðàùåíèå äèíàìè÷åñêîãî ìàññèâà BSIBuffer â èíäèêàòîðíûé áóôåð
   SetIndexBuffer(1,ExtNegBuffer,INDICATOR_DATA);
//---- îñóùåñòâëåíèå ñäâèãà íà÷àëà îòñ÷åòà îòðèñîâêè èíäèêàòîðà
   PlotIndexSetInteger(1,PLOT_DRAW_BEGIN,min_rates_total);
//---- óñòàíîâêà çíà÷åíèé èíäèêàòîðà, êîòîðûå íå áóäóò âèäèìû íà ãðàôèêå
   PlotIndexSetDouble(1,PLOT_EMPTY_VALUE,EMPTY_VALUE);

//---- ïðåâðàùåíèå äèíàìè÷åñêîãî ìàññèâà SignBuffer â èíäèêàòîðíûé áóôåð
   SetIndexBuffer(2,BSIBuffer,INDICATOR_DATA);
//---- îñóùåñòâëåíèå ñäâèãà íà÷àëà îòñ÷åòà îòðèñîâêè èíäèêàòîðà
   PlotIndexSetInteger(2,PLOT_DRAW_BEGIN,min_rates_total);
//---- óñòàíîâêà çíà÷åíèé èíäèêàòîðà, êîòîðûå íå áóäóò âèäèìû íà ãðàôèêå
   PlotIndexSetDouble(2,PLOT_EMPTY_VALUE,EMPTY_VALUE);
//---- ïðåâðàùåíèå äèíàìè÷åñêîãî ìàññèâà â öâåòîâîé, èíäåêñíûé áóôåð   
   SetIndexBuffer(3,ColorBSIBuffer,INDICATOR_COLOR_INDEX);

//---- èíèöèàëèçàöèÿ ïåðåìåííîé äëÿ êîðîòêîãî èìåíè èíäèêàòîðà
   string shortname;
   StringConcatenate(shortname,"BSI( ",InpRangePeriod,", ",InpSlowing,", ",InpAvgPeriod,", ",EnumToString(InpUsingVolumeWeight)," )");
//--- ñîçäàíèå èìåíè äëÿ îòîáðàæåíèÿ â îòäåëüíîì ïîäîêíå è âî âñïëûâàþùåé ïîäñêàçêå
   IndicatorSetString(INDICATOR_SHORTNAME,shortname);
//--- îïðåäåëåíèå òî÷íîñòè îòîáðàæåíèÿ çíà÷åíèé èíäèêàòîðà
   IndicatorSetInteger(INDICATOR_DIGITS,0);
//---- çàâåðøåíèå èíèöèàëèçàöèè
  }
//+------------------------------------------------------------------+  
//| BSI iteration function                                           | 
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
//---- ïðîâåðêà êîëè÷åñòâà áàðîâ íà äîñòàòî÷íîñòü äëÿ ðàñ÷åòà
   if(rates_total<min_rates_total) return(0);
//---- îáúÿâëåíèå öåëî÷èñëåííûõ ïåðåìåííûõ
   int first1,first2,bar;
//---- èíèöèàëèçàöèÿ èíäèêàòîðà â áëîêå OnCalculate()
   if(prev_calculated>rates_total || prev_calculated<=0)// ïðîâåðêà íà ïåðâûé ñòàðò ðàñ÷åòà èíäèêàòîðà
     {
      first1=min_rates_1; // ñòàðòîâûé íîìåð äëÿ ðàñ÷åòà âñåõ áàðîâ ïåðâîãî öèêëà
      first2=min_rates_total; // ñòàðòîâûé íîìåð äëÿ ðàñ÷åòà âñåõ áàðîâ âòîðîãî öèêëà
      ArrayInitialize(Count,NULL);
      ArrayInitialize(ExtHighest,NULL);
      ArrayInitialize(ExtLowest,NULL);
      ArrayInitialize(ExtVolume,NULL);
     }
   else // ñòàðòîâûé íîìåð äëÿ ðàñ÷åòà íîâûõ áàðîâ
     {
      first1=prev_calculated-1;
      first2=first1;
     }
//---- îñíîâíîé öèêë ðàñ÷åòà èíäèêàòîðà
   for(bar=first1; bar<rates_total && !IsStopped(); bar++)
     {
      double dmin=1000000.0;
      double dmax=-1000000.0;
      double volmax=NULL;
      for(int kkk=0; kkk<int(InpRangePeriod); kkk++)
        {
         dmin=MathMin(dmin,low[bar-kkk]);
         dmax=MathMax(dmax,high[bar-kkk]);
        }
      ExtLowest[Count[0]]=dmin;
      ExtHighest[Count[0]]=dmax;
      //----
      switch(InpUsingVolumeWeight)
        {
         case ENUM_WITHOUT_VOLUME :
           {
            ExtVolume[Count[0]]=1.0;
            break;
           }
         case ENUM_VOLUME :
           {
            for(int kkk=0; kkk<int(InpRangePeriod); kkk++) volmax=MathMax(volmax,volume[bar-kkk]);
            ExtVolume[Count[0]]=volmax;
            break;
           }
         case ENUM_TICKVOLUME :
           {
            for(int kkk=0; kkk<int(InpRangePeriod); kkk++) volmax=MathMax(volmax,tick_volume[bar-kkk]);
            ExtVolume[Count[0]]=volmax;
           }
        }
      //----
      double sumpos=NULL;
      double sumneg=NULL;
      double sumhigh=NULL;
      double sumpvol=NULL;
      double sumnvol=NULL;
      for(int kkk=0; kkk<int(InpSlowing); kkk++)
        {
         //---
         int barkkk=bar-kkk;
         double vol=1.0;
         switch(InpUsingVolumeWeight)
           {
            case ENUM_WITHOUT_VOLUME :
              {
               break;
              }
            case ENUM_VOLUME :
              {
               if(ExtVolume[Count[kkk]]) vol=volume[barkkk]/ExtVolume[Count[kkk]];
               break;
              }
            case ENUM_TICKVOLUME :
              {
               if(ExtVolume[Count[kkk]]) vol=tick_volume[barkkk]/ExtVolume[Count[kkk]];
              }
           }
         //--- Range position ratio
         double ratio=0;
         //--- Range spread
         double range=ExtHighest[Count[kkk]]-ExtLowest[Count[kkk]];
         range=MathMax(range,_Point);
         //--- Bar Spread
         double sp=(high[barkkk]-low[barkkk]);
         //--- Not DownBar
         if(!(close[barkkk-1]-sp*0.2>close[barkkk]))
           {
            //--- low equal range low
            if(low[barkkk]==ExtLowest[Count[kkk]]) ratio=1;
            else // upper - low / range spread
            ratio=(ExtHighest[Count[kkk]]-low[barkkk])/range;
            sumpos+=(close[barkkk]-low[barkkk])*ratio *vol;
           }
         //--- Not UpBar
         if(!(close[barkkk-1]+sp*0.2<close[barkkk]))
           {
            //--- high equal range high 
            if(high[barkkk]==ExtHighest[Count[kkk]]) ratio=1;
            else // high - lower / range spread
            ratio=(high[barkkk]-ExtLowest[Count[kkk]])/range;
            sumneg+=(high[barkkk]-close[barkkk])*ratio*vol*-1;
           }
         //---
         sumhigh+=range;
        }
      //---
      if(!sumhigh)
        {
         ExtPosBuffer[bar]=NULL;
         ExtNegBuffer[bar]=NULL;
        }
      else
        {
         ExtPosBuffer[bar]=sumpos/sumhigh*100;
         ExtNegBuffer[bar]=sumneg/sumhigh*100;
        }
      if(bar<rates_total-1) Recount_ArrayZeroPos(Count,size);
     }
//---- îñíîâíîé öèêë ðàñ÷åòà èíäèêàòîðà
   for(bar=first2; bar<rates_total && !IsStopped(); bar++)
     {
      double sumPos=NULL;
      double sumNeg=NULL;
      double sum=NULL;
      for(int kkk=0; kkk<int(InpAvgPeriod); kkk++) sum+=ExtPosBuffer[bar-kkk]+ExtNegBuffer[bar-kkk];
      BSIBuffer[bar]=sum/InpAvgPeriod;
     }
//---- îñíîâíîé öèêë ðàñêðàñêè èíäèêàòîðà BSI
   for(bar=first2; bar<rates_total; bar++)
     {
      int clr=1;
      if(BSIBuffer[bar-1]>BSIBuffer[bar]) clr=0;
      if(BSIBuffer[bar-1]<BSIBuffer[bar]) clr=2;
      ColorBSIBuffer[bar]=clr;
     }
//----     
   return(rates_total);
  }
//+------------------------------------------------------------------+
