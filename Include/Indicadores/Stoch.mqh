/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class Stoch
{
  public:
  void Stoch(int STOCH_k_period = 10,int STOCH_d_period = 3,int STOCH_slowing = 3,ENUM_TIMEFRAMES STOCH_periods = PERIOD_CURRENT,string symbol = NULL, ENUM_MA_METHOD STOCH_method = MODE_SMA,ENUM_STO_PRICE STOCH_price = STO_LOWHIGH);
  double Valor(int buffer = 0, int barra = 0);
  double Cx(int buffer = 0, int barra = 0);
  double Normalizado(int buffer = 0, int barra = 0);


  private:
  int HandleStoch;

};

void Stoch::Stoch(int STOCH_k_period = 10,int STOCH_d_period = 3,int STOCH_slowing = 3,ENUM_TIMEFRAMES STOCH_periods = PERIOD_CURRENT,string symbol = NULL, ENUM_MA_METHOD STOCH_method = MODE_SMA,ENUM_STO_PRICE STOCH_price = STO_LOWHIGH)
{
  HandleStoch = 0;
  HandleStoch = iStochastic(symbol,STOCH_periods,STOCH_k_period,STOCH_d_period,STOCH_slowing,STOCH_method,STOCH_price);
  // ChartIndicatorAdd(0,1,HandleStoch);

  // Print("Handle Stoch: " + IntegerToString(HandleStoch));

  if(HandleStoch == 0)
  {
    ExpertRemove();
  }
}

double Stoch::Valor(int buffer = 0, int barra = 0)
{
     double _Stoch[];
     double retorno = NULL;

     ArraySetAsSeries(_Stoch, true);
     int Stoch_copied = CopyBuffer(HandleStoch,buffer,0,barra+5,_Stoch);

     retorno = _Stoch[barra];

     return(retorno);
}


double Stoch::Cx(int buffer = 0, int barra = 0)
{
  double retorno = NULL;

  double y1 = Valor(buffer,barra+6);
  double y2 = Valor(buffer,barra+5);
  double y3 = Valor(buffer,barra+4);
  double y4 = Valor(buffer,barra+3);
  double y5 = Valor(buffer,barra+2);
  double y6 = Valor(buffer,barra+1);
  double y7 = Valor(buffer,barra);

  Normalizacao *mat = new Normalizacao(y1,y2,y3,y4,y5,y6,y7);
  retorno = mat.Coeficiente_Angular;
  delete(mat);


  return(retorno);
}
double Stoch::Normalizado(int buffer = 0, int barra = 0)
{
  double retorno = NULL;

  double y1 = Valor(buffer,barra+6);
  double y2 = Valor(buffer,barra+5);
  double y3 = Valor(buffer,barra+4);
  double y4 = Valor(buffer,barra+3);
  double y5 = Valor(buffer,barra+2);
  double y6 = Valor(buffer,barra+1);
  double y7 = Valor(buffer,barra);

  Normalizacao *mat = new Normalizacao(y1,y2,y3,y4,y5,y6,y7);
  retorno = mat.Valor_Normalizado;
  delete(mat);


  return(retorno);
}
