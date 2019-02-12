//+------------------------------------------------------------------+
//|                                                           BB.mq5 |
//|                   Copyright 2009-2017, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright   "2009-2017, MetaQuotes Software Corp."
#property link        "http://www.mql5.com"
#property description "Volatilidade"
#include <MovingAverages.mqh>
//---
#property indicator_separate_window
#property indicator_buffers 6
#property indicator_plots   1
#property indicator_type1   DRAW_LINE
#property indicator_color1  LightSeaGreen
#property indicator_type2   DRAW_LINE
#property indicator_color2  LightSeaGreen
#property indicator_type3   DRAW_LINE
#property indicator_color3  LightSeaGreen
#property indicator_label1  "Delta"

#property indicator_minimum -20
#property indicator_maximum 100

//--- input parametrs
input int     InpBandsPeriod=20;       // Period
input int     InpBandsShift=0;         // Shift
input double  InpBandsDeviations=2.0;  // Deviation
//--- global variables
int           ExtBandsPeriod,ExtBandsShift;
double        ExtBandsDeviations;
int           ExtPlotBegin=0;
//---- indicator buffer
double        ExtMLBuffer[];
double        ExtTLBuffer[];
double        ExtBLBuffer[];
double        ExtStdDevBuffer[];

double        Delta[];
double        Delta_Percent[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
void OnInit()
  {
//--- check for input values
   if(InpBandsPeriod<2)
     {
      ExtBandsPeriod=20;
      printf("Incorrect value for input variable InpBandsPeriod=%d. Indicator will use value=%d for calculations.",InpBandsPeriod,ExtBandsPeriod);
     }
   else ExtBandsPeriod=InpBandsPeriod;
   if(InpBandsShift<0)
     {
      ExtBandsShift=0;
      printf("Incorrect value for input variable InpBandsShift=%d. Indicator will use value=%d for calculations.",InpBandsShift,ExtBandsShift);
     }
   else
      ExtBandsShift=InpBandsShift;
   if(InpBandsDeviations==0.0)
     {
      ExtBandsDeviations=2.0;
      printf("Incorrect value for input variable InpBandsDeviations=%f. Indicator will use value=%f for calculations.",InpBandsDeviations,ExtBandsDeviations);
     }
   else ExtBandsDeviations=InpBandsDeviations;
//--- define buffers
   SetIndexBuffer(0,ExtMLBuffer);
   SetIndexBuffer(1,ExtTLBuffer);
   SetIndexBuffer(2,ExtBLBuffer);
   SetIndexBuffer(3,ExtStdDevBuffer);
   SetIndexBuffer(4,Delta);
   SetIndexBuffer(5,Delta_Percent,INDICATOR_CALCULATIONS);
//--- set index labels
   PlotIndexSetString(0,PLOT_LABEL,"Bands("+string(ExtBandsPeriod)+") Delta Banda");
   PlotIndexSetString(1,PLOT_LABEL,"Bands("+string(ExtBandsPeriod)+") Delta Preco");
   PlotIndexSetString(2,PLOT_LABEL,"Bands("+string(ExtBandsPeriod)+") Lower");
//--- indicator name
   IndicatorSetString(INDICATOR_SHORTNAME,"Volatilidade");
//--- indexes draw begin settings
   ExtPlotBegin=ExtBandsPeriod-1;
   PlotIndexSetInteger(0,PLOT_DRAW_BEGIN,ExtBandsPeriod);
   PlotIndexSetInteger(1,PLOT_DRAW_BEGIN,ExtBandsPeriod);
   PlotIndexSetInteger(2,PLOT_DRAW_BEGIN,ExtBandsPeriod);
//--- indexes shift settings
   PlotIndexSetInteger(0,PLOT_SHIFT,ExtBandsShift);
   PlotIndexSetInteger(1,PLOT_SHIFT,ExtBandsShift);
   PlotIndexSetInteger(2,PLOT_SHIFT,ExtBandsShift);
//--- number of digits of indicator value
   IndicatorSetInteger(INDICATOR_DIGITS,_Digits+1);
//---- OnInit done
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//--- variables
   int pos;
//--- indexes draw begin settings, when we've recieved previous begin
   // if(ExtPlotBegin!=ExtBandsPeriod+begin)
   //   {
   //    ExtPlotBegin=ExtBandsPeriod+begin;
   //    PlotIndexSetInteger(0,PLOT_DRAW_BEGIN,ExtPlotBegin);
   //    PlotIndexSetInteger(1,PLOT_DRAW_BEGIN,ExtPlotBegin);
   //    PlotIndexSetInteger(2,PLOT_DRAW_BEGIN,ExtPlotBegin);
   //   }
//--- check for bars count
   if(rates_total<ExtPlotBegin)
      return(0);
//--- starting calculation
   if(prev_calculated>1) pos=prev_calculated-1;
   else pos=0;
//--- main cycle
   for(int i=pos;i<rates_total && !IsStopped();i++)
     {
      //--- middle line
      ExtMLBuffer[i]=SimpleMA(i,ExtBandsPeriod,close);
      //--- calculate and write down StdDev
      ExtStdDevBuffer[i]=StdDev_Func(i,close,ExtMLBuffer,ExtBandsPeriod);
      //--- upper line
      ExtTLBuffer[i]=ExtMLBuffer[i]+ExtBandsDeviations*ExtStdDevBuffer[i];
      //--- lower line
      ExtBLBuffer[i]=ExtMLBuffer[i]-ExtBandsDeviations*ExtStdDevBuffer[i];

      double Delta_Valor  =  ( ExtTLBuffer[i] -   ExtBLBuffer[i]);

      //--- middle line
      ExtMLBuffer[i] = Delta_Valor ;

      ExtTLBuffer[i] = high[i] - low[i];

      if(ExtMLBuffer[i] == 0) ExtMLBuffer[i] = 1;

      ExtMLBuffer[i] = 100 - (ExtTLBuffer[i] / ExtMLBuffer[i] * 100);

      //---
     }
//---- OnCalculate done. Return new prev_calculated.
   return(rates_total);
  }
//+------------------------------------------------------------------+
//| Calculate Standard Deviation                                     |
//+------------------------------------------------------------------+
double StdDev_Func(int position,const double &close[],const double &MAprice[],int period)
  {
//--- variables
   double StdDev_dTmp=0.0;
//--- check for position
   if(position<period) return(StdDev_dTmp);
//--- calcualte StdDev
   for(int i=0;i<period;i++) StdDev_dTmp+=MathPow(close[position-i]-MAprice[position],2);
   StdDev_dTmp=MathSqrt(StdDev_dTmp/period);
//--- return calculated value
   return(StdDev_dTmp);
  }
//+------------------------------------------------------------------+
