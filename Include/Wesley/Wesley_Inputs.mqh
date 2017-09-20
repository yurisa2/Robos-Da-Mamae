/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             SA2 - Investment soft|
//+------------------------------------------------------------------+
#property copyright "Sa2, pq s�o s� dois na empresa agora."
#property link      "http://www.sa2.com.br"


ENUM_TIMEFRAMES RSI_TimeFrame = PERIOD_CURRENT;
int RSI_period = 14;
ENUM_APPLIED_PRICE RSI_preco =  PRICE_CLOSE;

input string Indicadores = "-------------------------------------";
input bool   Wesley_Sai_Em_Zero = true;                                          //Sai Quando Neutraliza
input double Wesley_Valor_Venda = 71.7;                                           //Valor M�nimo para Venda do Fuzz�o
input double Wesley_Valor_Compra = -71.7;                                         //Valor M�nimo para Compra do Fuzz�o (Negativo)
