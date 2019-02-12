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
input bool   Xavier_Sai_Em_Zero = false;                                        //Sai Quando Neutraliza
input double Xavier_Valor_Venda = 98;                                           //Valor Mínimo para Venda do Fuzzão
input double Xavier_Valor_Compra = -98;                                           //Valor Mínimo para Compra do Fuzzão (Negativo)

int Xavier_Autorizado = 0;
