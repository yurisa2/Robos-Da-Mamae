/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             SA2 - Investment soft|
//+------------------------------------------------------------------+
#property copyright "Sa2, pq são só dois na empresa agora."
#property link      "http://www.sa2.com.br"


ENUM_TIMEFRAMES RSI_TimeFrame = PERIOD_CURRENT;
int RSI_period = 14;
ENUM_APPLIED_PRICE RSI_preco =  PRICE_CLOSE;



input string Indicadores = "-------------------------------------";
input int   Holo_Periodos_BB = 20;                                        //Periodos da BB (20)
// input int   Histerese_Media = 0;                                     //Histerese (da Média) (0)
input bool  Holo_Mediana = false;
input int   Holo_Distancia = 0;

input bool Holo_Menor_TP = true;  //Usa o Menor TP (defindo ou banda)
input bool Holo_Inverte = false;  //Inverte o Universo!
input bool Holo_Menor_SL = true;  //Usa o Menor SL (defindo ou banda)
input double Holo_Delta_Menor_q = 9999; //Delta Menor Que (Tick_Size)
input double Holo_Delta_Maior_q = 0;    //Delta Maior Que (Tick_Size)
input int Holo_Max_Contador_Barras = 999; //Contador De Barras Max
