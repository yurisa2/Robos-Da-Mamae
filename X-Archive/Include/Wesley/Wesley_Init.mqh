/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             SA2 - Investment soft|
//+------------------------------------------------------------------+
#property copyright "Sa2, pq saum soh dois (mas ta aumentando) na empresa agora."
#property link      "http://www.sa2.com.br"

void Init_Wesley()
{


for(int i=0; i<=10; i++)
{

  Wesley *Wes = new Wesley(i);
  Print("fuzzao: i=" + IntegerToString(i) + " - " +  DoubleToString(Wes.Wesley_Fuzzy_Valor,2) +
  "| BB: " + DoubleToString(Wes.Wesley_BB_Valor,2) +
  "| RSI: " + DoubleToString(Wes.Wesley_RSI_Valor,2) +
  "| Stoch: " + DoubleToString(Wes.Wesley_Stoch_Valor,2) +
  "| MFI: " + DoubleToString(Wes.Wesley_MF_Valor,2) +
  "| ADX: " + DoubleToString(Wes.Wesley_ADX_Valor,2)
);
  delete(Wes);

}


}

ENUM_INIT_RETCODE Verifica_Init_Xav()
{


      return INIT_SUCCEEDED;
}
