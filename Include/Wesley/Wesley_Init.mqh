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
  Print("Valor do fuzzao: i=" + i + " - " + Wes.Wesley_Fuzzy_Valor);
  delete(Wes);

}


}

ENUM_INIT_RETCODE Verifica_Init_Xav()
{


      return INIT_SUCCEEDED;
}
