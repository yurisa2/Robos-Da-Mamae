﻿//+------------------------------------------------------------------+
//|                                                  xeon_script.mq5 |
//|                                                              Sa2 |
//|                                           https://www.sa2.com.br |
//+------------------------------------------------------------------+
#property copyright "Sa2"
#property link      "https://www.sa2.com.br"
#property version   "1.00"
#property script_show_inputs

#include <Math\Stat\Normal.mqh>
#include <Math\Stat\Math.mqh>
//--- input parameters
double ota[10000];
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
  for(int i = 0; i < 10000 ; i++) {

    MqlRates rates_Preco[];
    ArraySetAsSeries(rates_Preco,true);
    int copied=CopyRates(Symbol(),0,0,i+1,rates_Preco);


    ota[i] = rates_Preco[i].close;
    }

  double        minimum;
  double        lower_hinge;
  double        median;
  double        upper_hinge;
  double        maximum;

  MathTukeySummary(ota,true,minimum,lower_hinge,median,upper_hinge,maximum);


  Print("minimum: " + DoubleToString(minimum));
  Print("lower_hinge: " + DoubleToString(lower_hinge));
  Print("median: " + DoubleToString(median));
  Print("upper_hinge: " + DoubleToString(upper_hinge));
  Print("maximum: " + DoubleToString(maximum));
  Print("DeltaMax: " + DoubleToString(maximum-minimum));

}
