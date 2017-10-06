/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"



class ADX
{
  public:
  void ADX(int adx_period = 14, ENUM_TIMEFRAMES  period = PERIOD_CURRENT, string symbol = NULL);
  double Valor(int buffer = 0, int barra = 0);

  private:
  int HandleADX;

};

void ADX::ADX(int adx_period = 14, ENUM_TIMEFRAMES  period = PERIOD_CURRENT, string symbol = NULL)
{
  HandleADX = 0;
  HandleADX = iADX(symbol,period,adx_period);
  ChartIndicatorAdd(0,1,HandleADX);

  // Print("Handle ADX: " + IntegerToString(HandleADX));

  if(HandleADX == 0)
  {
    ExpertRemove();
  }
}

double ADX::Valor(int buffer = 0, int barra = 0)
{
     double _ADX[];
     double retorno = NULL;

     ArraySetAsSeries(_ADX, true);
     int ADX_copied = CopyBuffer(HandleADX,buffer,0,barra+3,_ADX);

     retorno = _ADX[barra];

     return(retorno);
}
