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
input bool   Xavier_Sai_Em_Zero = false;                                        //Sai Quando Neutraliza
input double Xavier_Valor_Venda = 98;                                           //Valor M�nimo para Venda do Fuzz�o
input double Xavier_Valor_Compra = -98;                                           //Valor M�nimo para Compra do Fuzz�o (Negativo)
