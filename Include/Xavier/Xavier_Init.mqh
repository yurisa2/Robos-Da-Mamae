/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             SA2 - Investment soft|
//+------------------------------------------------------------------+
#property copyright "Sa2, pq saum soh dois (mas ta aumentando) na empresa agora."
#property link      "http://www.sa2.com.br"


void Init_Xav ()
{
  Inicializa_RSI();

  ChartIndicatorAdd(0,0,Xavier_Handle_BB);

  Direcao = 1;

//  Print("Valor da Banda: ",Xavier_BB_Tamanho_Porcent());
}

ENUM_INIT_RETCODE Verifica_Init_Xav ()
{

      return INIT_SUCCEEDED;
}
