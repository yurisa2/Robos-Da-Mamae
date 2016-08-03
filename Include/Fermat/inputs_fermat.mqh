//+------------------------------------------------------------------+
//|                                            Fermat , o antigo ... |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"


input int N_Ma1 = 5;                                                //Periodos MA1
input int N_Ma2 = 8;                                                //Periodos MA2
input int N_Ma3 = 13;                                               //Periodos MA3

input ENUM_MA_METHOD Metodo = MODE_SMA;                             //Metodo MA
input ENUM_APPLIED_PRICE Preco_Aplicado = PRICE_CLOSE;              //Pre�o Aplicado
