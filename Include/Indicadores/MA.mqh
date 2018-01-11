/* -*- C++ -*- */
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class MA
{
  public:
  void MA(int ma_period = 3,ENUM_MA_METHOD ma_method = MODE_SMA, ENUM_TIMEFRAMES Periodos_MA = PERIOD_CURRENT,int ma_shift = 0,ENUM_APPLIED_PRICE applied_price = PRICE_CLOSE);
  double Valor(int barra = 0);

  private:
  int HandleMA;

};

void MA::MA(int ma_period = 3,ENUM_MA_METHOD ma_method = MODE_SMA, ENUM_TIMEFRAMES Periodos_MA = PERIOD_CURRENT,int ma_shift = 0,ENUM_APPLIED_PRICE applied_price = PRICE_CLOSE)
{
  HandleMA = 0;
  HandleMA = iMA(Symbol(),Periodos_MA,ma_period,ma_shift,ma_method,applied_price) ;
  // ChartIndicatorAdd(0,0,HandleMA);

  // Print("Handle Stoch: " + IntegerToString(HandleMA));

  if(HandleMA == 0)
  {
    ExpertRemove();
  }
}

double MA::Valor(int barra = 0)
{
     double _MA[];
     double retorno = NULL;

     ArraySetAsSeries(_MA, true);
     int MA_copied = CopyBuffer(HandleMA,0,0,barra+5,_MA);

     retorno = _MA[barra];
     // Print("MA Barra: " + barra); //DEBUG
     // Print("_MA[barra]: " + _MA[barra]); //DEBUG
     // Print("_MA[0]: " + _MA[0]); //DEBUG
     // Print("HandleMA: " + HandleMA); //DEBUG

     return(retorno);
}
