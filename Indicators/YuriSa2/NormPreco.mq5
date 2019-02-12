//+------------------------------------------------------------------+
//|                                            AnguloPriceAction.mq5 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

#include <Normalizacao.mqh>
#include <Indicadores\MA.mqh>
#include <Indicadores\Preco.mqh>

#property indicator_separate_window
#property indicator_buffers 1
#property indicator_plots   1

#property indicator_label1  "Preco Normalizado"
#property indicator_type1   DRAW_HISTOGRAM
#property indicator_color1  Green
#property indicator_style1  STYLE_SOLID
#property indicator_width1  3

input int shift = -1;

double         Normalizado_Buffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,Normalizado_Buffer,INDICATOR_DATA);
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
Preco_O *preco = new Preco_O;

// Print(rates_total-prev_calculated);

for(int i=rates_total-1000;i<rates_total;i++)
  {
    // Print(rates_total-prev_calculated);
  Normalizado_Buffer[i] = preco.Normalizado(rates_total-i);
  }


delete preco;
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
