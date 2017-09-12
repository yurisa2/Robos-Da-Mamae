/* -*- C++ -*- */
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class RSI
{
  public:
  void RSI(int ma_period = 14, ENUM_TIMEFRAMES periodos_r = PERIOD_CURRENT, string Simbolo = NULL, ENUM_APPLIED_PRICE applied_price = PRICE_CLOSE);
  double Valor(int barra = 0);

  private:
  int HandleRSI;

};

void RSI::RSI(int ma_period = 14, ENUM_TIMEFRAMES periodos_r = PERIOD_CURRENT, string Simbolo = NULL, ENUM_APPLIED_PRICE applied_price = PRICE_CLOSE)
{
  HandleRSI = 0;
  HandleRSI = iRSI(Simbolo,periodos_r,ma_period,applied_price) ;
  ChartIndicatorAdd(0,1,HandleRSI);

  // Print("Handle Stoch: " + IntegerToString(HandleRSI));

  if(HandleRSI == 0)
  {
    ExpertRemove();
  }
}

double RSI::Valor(int barra = 0)
{
     double _RSI[];
     double retorno = NULL;

     ArraySetAsSeries(_RSI, true);
     int RSI_copied = CopyBuffer(HandleRSI,0,0,100,_RSI);

     retorno = _RSI[barra];

     return(retorno);
}
