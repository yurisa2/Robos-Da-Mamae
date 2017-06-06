/* -*- C++ -*- */

#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

void Inicializa_RSI ()
{
  HandleRSI = iRSI(NULL,RSI_TimeFrame,RSI_period,RSI_preco);
  ChartIndicatorAdd(0,1,HandleRSI);

  Print("Handle RSI: "+IntegerToString(HandleRSI));
  Print("Valor Inicial RSI: "+DoubleToString(CalculaRSI(),2));


  if(HandleRSI == 0 )
  {
    ExpertRemove();
  }
}

double CalculaRSI ()
{
     double _RSI[];
     ArraySetAsSeries(_RSI, true);
     int ifr_copied=CopyBuffer(HandleRSI,0,0,100,_RSI);

     return(_RSI[0]);
}
