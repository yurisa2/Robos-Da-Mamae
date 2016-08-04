//+------------------------------------------------------------------+
//|                                            Fermat , o antigo ... |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"


input int N_Ma1 = 5;                                                //Periodos MA1
input int N_Ma2 = 8;                                                //Periodos MA2
input int N_Ma3 = 13;                                               //Periodos MA3

input int Distancia_m1_m3 = 2;                                       //Distanca da M1 a M3

input ENUM_MA_METHOD Metodo = MODE_SMA;                             //Metodo MA
input ENUM_APPLIED_PRICE Preco_Aplicado = PRICE_CLOSE;              //Preço Aplicado

int HandleMA1 = 0;
int HandleMA2 = 0;
int HandleMA3 = 0;
