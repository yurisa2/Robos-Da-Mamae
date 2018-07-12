//+------------------------------------------------------------------+
//|                                            AnguloPriceAction.mq5 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

#include <Normalizacao.mqh>
#include <Indicadores\MA.mqh>
#include <Indicadores\BB.mqh>

#property indicator_separate_window
#property indicator_buffers 1
#property indicator_plots   1

#property indicator_label1  "BBPP"
#property indicator_type1   DRAW_LINE
#property indicator_color1  Green
#property indicator_style1  STYLE_SOLID
#property indicator_width1  3

double         BBPP[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,BBPP,INDICATOR_DATA);
PlotIndexSetInteger(0, PLOT_SHIFT, -1);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const int begin,
                const double &price[])
  {

//---
BB *bb_o = new BB();

// Print(rates_total-prev_calculated);

for(int i=rates_total-1000;i<rates_total;i++)
  {
    Tick_Size = 5;
  daotick_geral = price[i];
    // Print(rates_total-prev_calculated);
  BBPP[i] = bb_o.BB_Posicao_Percent(rates_total-i);
  }


delete bb_o;
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
