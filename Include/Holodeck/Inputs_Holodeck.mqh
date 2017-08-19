/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             SA2 - Investment soft|
//+------------------------------------------------------------------+
#property copyright "Sa2, pq são só dois na empresa agora."
#property link      "http://www.sa2.com.br"


input string Indicadores = "-------------------------------------";
input int   Holo_Periodos_BB = 20;                                        //Periodos da BB (20)
// input int   Histerese_Media = 0;                                     //Histerese (da Média) (0)
input bool  Holo_Mediana = false;
input int   Holo_Distancia = 0;

input bool Holo_Menor_TP = true;  //Usa o Menor TP (defindo ou banda)
input bool Holo_Menor_SL = true;  //Usa o Menor SL (defindo ou banda)
