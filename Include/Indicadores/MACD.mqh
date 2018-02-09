/* -*- C++ -*- */
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"



class MACD
{
  public:
  void MACD(int fast_ema_period = 12,int slow_ema_period = 26,int signal_period = 9,string symbol = NULL, ENUM_TIMEFRAMES period = PERIOD_CURRENT, ENUM_APPLIED_PRICE applied_price = PRICE_CLOSE);
  double Valor(int buffer = 0, int barra = 0);
  double Cx(int buffer = 0, int barra = 0);

  private:
  int HandleMACD;

};

void MACD::MACD(int fast_ema_period = 12,int slow_ema_period = 26,int signal_period = 9,string symbol = NULL, ENUM_TIMEFRAMES period = PERIOD_CURRENT, ENUM_APPLIED_PRICE applied_price = PRICE_CLOSE)
{
  HandleMACD = 0;
  HandleMACD = iMACD(symbol,period,fast_ema_period,slow_ema_period,signal_period,applied_price);
  // ChartIndicatorAdd(0,1,HandleMACD);

  // Print("Handle MACD: " + IntegerToString(HandleMACD)); //DEBUG

  if(HandleMACD == 0)
  {
    ExpertRemove();
  }
}

double MACD::Valor(int buffer = 0, int barra = 0)
{
  double _MACD[];
  double retorno = NULL;

  ArraySetAsSeries(_MACD, true);
  int MACD_copied = CopyBuffer(HandleMACD,buffer,0,barra+5,_MACD);

  retorno = _MACD[barra];

  return(retorno);
}

double MACD::Cx(int buffer = 0, int barra = 0)
{
  double retorno = NULL;
  double y1 = 0;
  double y2 = 0;
  double y3 = 0;

  y1 = Valor(buffer,barra+2);
  y2 = Valor(buffer,barra+1);
  y3 = Valor(buffer,barra);

  Matematica *mat = new Matematica;
  retorno = mat.Coeficiente_Angular_3(y1,y2,y3);
  delete(mat);


  return(retorno);
}
