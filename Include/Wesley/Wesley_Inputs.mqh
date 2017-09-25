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
input bool   Wesley_Sai_Em_Zero = true;                                          //Sai Quando Zera
input bool   Wesley_Igual_Lados = true;                                           //Parametros Simetricos
input double Wesley_Valor_Venda = 71.7;                                           //Valor M�nimo para Venda (Usa esse para Simetricos)
input double Wesley_Valor_Compra = -71.7;                                         //Valor M�nimo para Compra (ignorado se Simetricos)
