/* -*- C++ -*- */

//+------------------------------------------------------------------+
//|                                                     OnNewBar.mqh |
//|                                            Copyright 2010, Lizar |
//|                                                    Lizar@mail.ru |
//+------------------------------------------------------------------+
#property copyright "Copyright 2010, Lizar"
#property link      "Lizar@mail.ru"

#include <Lib_CisNewBar.mqh>
CisNewBar current_chart; // instance of the CisNewBar class: current chart

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
         // When new bar appears - launch the NewBar event handler
  }
