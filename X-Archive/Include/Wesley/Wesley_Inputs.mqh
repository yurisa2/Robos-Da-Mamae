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
input bool  Wesley_Tempo_Real = true;   //Tempo real
input bool Wesley_Inverte = true;       //Inversão (precisa fazer sistema de continuidade)
input bool   Wesley_Sai_Em_Zero = true;                                          //Sai Quando Zera
input bool   Wesley_Igual_Lados = true;                                           //Parametros Simetricos
input double Wesley_Valor_Venda = 52.203;                                           //Valor Mínimo para Venda (Usa esse para Simetricos)
input double Wesley_Valor_Compra = -52.203;                                         //Valor Mínimo para Compra (ignorado se Simetricos)

// input bool Wesley_Permite_Large = true;         //Permite o uso de 2 timeframes (large)
// input ENUM_TIMEFRAMES Wesley_Large = PERIOD_M5;                                         //Periodo Large
bool Wesley_Permite_Large = false;         //Permite o uso de 2 timeframes (large)
ENUM_TIMEFRAMES Wesley_Large = PERIOD_M5;                                         //Periodo Large

bool Wesley_BBG_Enable = false;
bool Wesley_RSIG_Enable = false;
bool Wesley_StochG_Enable = false;
bool Wesley_MFIG_Enable = false;

bool Wesley_BBL_Enable = false; //BBL Enable
bool Wesley_RSIL_Enable = false; //RSIL Enable
bool Wesley_StochL_Enable = false; //StochL Enable
bool Wesley_MFIL_Enable = false;  //MFIL Enable
// input string Indicadores_Especificos_Por_Grupo = "-------------------------------------";
// input bool Wesley_BBG_Enable = true;
// input bool Wesley_RSIG_Enable = true;
// input bool Wesley_StochG_Enable = true;
// input bool Wesley_MFIG_Enable = true;
//
input string Indicadores_Especificos = "-------------------------------------";
input bool Wesley_BB_Enable = true; //BB Enable
input bool Wesley_RSI_Enable = true; //RSI Enable
input bool Wesley_Stoch_Enable = true; //Stoch Enable
input bool Wesley_MFI_Enable = true; //MFI Enable
// input bool Wesley_BBL_Enable = true; //BBL Enable
// input bool Wesley_RSIL_Enable = true; //RSIL Enable
// input bool Wesley_StochL_Enable = true; //StochL Enable
// input bool Wesley_MFIL_Enable = true;  //MFIL Enable
