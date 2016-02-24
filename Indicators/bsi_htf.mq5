//+------------------------------------------------------------------+ 
//|                                                      BSI_HTF.mq5 | 
//|                               Copyright � 2016, Nikolay Kositsin | 
//|                              Khabarovsk,   farria@mail.redcom.ru | 
//+------------------------------------------------------------------+ 
#property copyright "Copyright � 2016, Nikolay Kositsin"
#property link "farria@mail.redcom.ru"
//--- ����� ������ ����������
#property version   "1.60"
#property description "BSI � ������������� �� ������� ���������� �����������"
//---- ��������� ���������� � ��������� ����
#property indicator_separate_window 
//---- ���������� ������������ ������� 4
#property indicator_buffers 4 
//---- ������������ ����� ��� ����������� ����������
#property indicator_plots   3
//+----------------------------------------------+
//| ���������� ��������                          |
//+----------------------------------------------+
#define RESET 0                      // ��������� ��� �������� ��������� ������� �� �������� ����������
#define INDICATOR_NAME "BSI_HTF"     // ��������� ��� ����� ����������
#define SIZE 1                       // ��������� ��� ���������� ������� ������� CountIndicator � ����
//+-----------------------------------+
//| ��������� ��������� ����������    |
//+-----------------------------------+
//---- ��������� ���������� � ���� �����������
#property indicator_type1 DRAW_HISTOGRAM
//---- � �������� �����  ����������� �����������
#property indicator_color1 clrTeal
//---- ����� ���������� - ��������
#property indicator_style1 STYLE_SOLID
//---- ������� ����� ���������� ����� 2
#property indicator_width1 2
//---- ����������� ����� ����������
#property indicator_label1 "Floor Bounce Strength"
//+-----------------------------------+
//| ��������� ��������� ����������    |
//+-----------------------------------+
//---- ��������� ���������� � ���� �����������
#property indicator_type2 DRAW_HISTOGRAM
//---- � �������� �����  ����������� �����������
#property indicator_color2 clrRed
//---- ����� ���������� - ��������
#property indicator_style2 STYLE_SOLID
//---- ������� ����� ���������� ����� 2
#property indicator_width2 2
//---- ����������� ����� ����������
#property indicator_label2 "Ceiling Bounce Strength"
//+-----------------------------------+
//| ��������� ��������� ����������    |
//+-----------------------------------+
//---- ��������� ���������� � ���� ����������� �����
#property indicator_type3 DRAW_COLOR_LINE
//---- � �������� ������ ����������� ����� ������������
#property indicator_color3 clrMagenta,clrGray,clrDodgerBlue
//---- ����� ���������� - ��������
#property indicator_style3 STYLE_SOLID
//---- ������� ����� ���������� ����� 5
#property indicator_width3 5
//---- ����������� ����� ���������� �����
#property indicator_label3  "Bounce Strength Index"
//+-----------------------------------+
//| ��������� ��������� �������       |
//+-----------------------------------+
#property indicator_level1     10.0
#property indicator_level2     0.0
#property indicator_level3     -10.0
#property indicator_levelcolor clrBlue
#property indicator_levelstyle STYLE_DASHDOTDOT
//+-----------------------------------+
//| ���������� ������������           |
//+-----------------------------------+
enum Volume_Mode      //��� ���������
  {
   ENUM_WITHOUT_VOLUME = 1,     //Using without Volume
   ENUM_VOLUME,                 //Using Volume
   ENUM_TICKVOLUME              //Using TickVolume
  };
//+----------------------------------------------+
//| ������� ��������� ����������                 |
//+----------------------------------------------+
input ENUM_TIMEFRAMES TimeFrame=PERIOD_H4;   // ������ ������� ����������
//---
input uint InpRangePeriod=20; // Range Period
input uint InpSlowing=3;      // Slowing
input uint InpAvgPeriod=3;    // Avg Period
input Volume_Mode InpUsingVolumeWeight=ENUM_TICKVOLUME;   // Using Volume
input int Shift=0; // ����� ���������� �� ����������� � �����
//+----------------------------------------------+
//--- ���������� ������������ ��������, ������� � ����������
//--- ����� ������������ � �������� ������������ �������
double Ind1Buffer[];
double Ind2Buffer[];
double Ind3Buffer[];
double Ind4Buffer[];
//--- ���������� ������������� ���������� ������ ������� ������
int min_rates_total;
//--- ���������� ������������� ���������� ��� ������� �����������
int Ind_Handle;
//+------------------------------------------------------------------+
//| ��������� ���������� � ���� ������                               |
//+------------------------------------------------------------------+
string GetStringTimeframe(ENUM_TIMEFRAMES timeframe)
  {return(StringSubstr(EnumToString(timeframe),7,-1));}
//+------------------------------------------------------------------+    
//| Custom indicator initialization function                         | 
//+------------------------------------------------------------------+  
int OnInit()
  {
//--- �������� �������� �������� �� ������������
   if(!TimeFramesCheck(INDICATOR_NAME,TimeFrame)) return(INIT_FAILED);
//--- ������������� ���������� 
   min_rates_total=2;
//--- ��������� ������ ���������� BSI
   Ind_Handle=iCustom(Symbol(),TimeFrame,"BSI",InpRangePeriod,InpSlowing,InpAvgPeriod,InpUsingVolumeWeight);
   if(Ind_Handle==INVALID_HANDLE)
     {
      Print(" �� ������� �������� ����� ���������� BSI");
      return(INIT_FAILED);
     }
//---- ����������� ������������� ������� � ������������ �����
   SetIndexBuffer(0,Ind1Buffer,INDICATOR_DATA);
//---- ���������� ��������� � ������ ��� � ���������
   ArraySetAsSeries(Ind1Buffer,true);
//---- ����������� ������������� ������� � ������������ �����
   SetIndexBuffer(1,Ind2Buffer,INDICATOR_DATA);
//---- ���������� ��������� � ������ ��� � ���������
   ArraySetAsSeries(Ind2Buffer,true);
//---- ����������� ������������� ������� � ��������, ��������� �����   
   SetIndexBuffer(2,Ind3Buffer,INDICATOR_COLOR_INDEX);
//---- ���������� ��������� � ������ ��� � ���������
   ArraySetAsSeries(Ind3Buffer,true);
//---- ����������� ������������� ������� � ��������, ��������� �����   
   SetIndexBuffer(3,Ind4Buffer,INDICATOR_COLOR_INDEX);
//---- ���������� ��������� � ������ ��� � ���������
   ArraySetAsSeries(Ind4Buffer,true);

//---- ������������� ������ ���������� 1 �� �����������
   PlotIndexSetInteger(0,PLOT_SHIFT,Shift);
//---- ������������� ������ ������ ������� ��������� ����������
   PlotIndexSetInteger(0,PLOT_DRAW_BEGIN,min_rates_total);
//---- ��������� �������� ����������, ������� �� ����� ������ �� �������
   PlotIndexSetDouble(0,PLOT_EMPTY_VALUE,EMPTY_VALUE);
//---- ������������� ������ ���������� 2 �� �����������
   PlotIndexSetInteger(1,PLOT_SHIFT,Shift);
//---- ������������� ������ ������ ������� ��������� ����������
   PlotIndexSetInteger(1,PLOT_DRAW_BEGIN,min_rates_total);
//---- ��������� �������� ����������, ������� �� ����� ������ �� �������
   PlotIndexSetDouble(1,PLOT_EMPTY_VALUE,EMPTY_VALUE);
//---- ������������� ������ ���������� 3 �� �����������
   PlotIndexSetInteger(2,PLOT_SHIFT,Shift);
//---- ������������� ������ ������ ������� ��������� ����������
   PlotIndexSetInteger(2,PLOT_DRAW_BEGIN,min_rates_total);
//---- ��������� �������� ����������, ������� �� ����� ������ �� �������
   PlotIndexSetDouble(2,PLOT_EMPTY_VALUE,EMPTY_VALUE);

//--- �������� ����� ��� ����������� � ��������� ������� � �� ����������� ���������
   string shortname;
   StringConcatenate(shortname,INDICATOR_NAME,"(",GetStringTimeframe(TimeFrame),")");
//---
   IndicatorSetString(INDICATOR_SHORTNAME,shortname);
//--- ����������� �������� ����������� �������� ����������
   IndicatorSetInteger(INDICATOR_DIGITS,0);
//--- ���������� �������������
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+  
//| Custom iteration function                                        | 
//+------------------------------------------------------------------+  
int OnCalculate(const int rates_total,    // ���������� ������� � ����� �� ������� ����
                const int prev_calculated,// ���������� ������� � ����� �� ���������� ����
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//--- �������� ���������� ����� �� ������������� ��� �������
   if(rates_total<min_rates_total) return(RESET);
   if(BarsCalculated(Ind_Handle)<Bars(Symbol(),TimeFrame)) return(prev_calculated);
//--- ���������� ��������� � �������� ��� � ����������  
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
bool CountIndicator(uint     Numb,            // ����� ������� CountLine �� ������ � ���� ���������� (��������� ����� - 0)
                    string   Symb,            // ������ �������
                    ENUM_TIMEFRAMES TFrame,   // ������ �������
                    int      IndHandle,       // ����� ��������������� ����������
                    uint     BuffNumb1,       // ����� ������ ��������������� ���������� 1
                    double&  IndBuf1[],       // �������� ����� ���������� 1
                    uint     BuffNumb2,       // ����� ������ ��������������� ���������� 2
                    double&  IndBuf2[],       // �������� ����� ���������� 2
                    uint     BuffNumb3,       // ����� ������ ��������������� ���������� 3
                    double&  IndBuf3[],       // �������� ����� ���������� 3                    
                    uint     BuffNumb4,       // ����� ������ ��������������� ���������� 4
                    double&  IndBuf4[],       // �������� ����� ���������� 4
                    const datetime& iTime[],  // ��������� �������
                    const int Rates_Total,    // ���������� ������� � ����� �� ������� ����
                    const int Prev_Calculated,// ���������� ������� � ����� �� ���������� ����
                    const int Min_Rates_Total)// ����������� ���������� ������� � ����� ��� �������
  {
//---
   static int LastCountBar[SIZE];
   datetime IndTime[1];
   int limit;
//--- ������� ������������ ���������� ���������� ������
//--- � ���������� ������ limit ��� ����� ��������� �����
   if(Prev_Calculated>Rates_Total || Prev_Calculated<=0)// �������� �� ������ ����� ������� ����������
     {
      limit=Rates_Total-Min_Rates_Total-1; // ��������� ����� ��� ������� ���� �����
      LastCountBar[Numb]=limit;
     }
   else limit=LastCountBar[Numb]+Rates_Total-Prev_Calculated; // ��������� ����� ��� ������� ����� ����� 
//--- �������� ���� ������� ����������
   for(int bar=limit; bar>=0 && !IsStopped(); bar--)
     {
      //--- �������� ����� ����������� ������ � ������ IndTime
      if(CopyTime(Symbol(),TFrame,iTime[bar],1,IndTime)<=0) return(RESET);
      //---
      if(iTime[bar]>=IndTime[0] && iTime[bar+1]<IndTime[0])
        {
         LastCountBar[Numb]=bar;
         double Arr[1];
         //--- �������� ����� ����������� ������ � �������
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
                     ENUM_TIMEFRAMES TFrame) // ������ ������� ����������
  {
//--- �������� �������� �������� �� ������������
   if(TFrame<Period() && TFrame!=PERIOD_CURRENT)
     {
      Print("������ ������� ��� ���������� "+IndName+" �� ����� ���� ������ ������� �������� �������!");
      Print("������� �������� ������� ��������� ����������!");
      return(RESET);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
