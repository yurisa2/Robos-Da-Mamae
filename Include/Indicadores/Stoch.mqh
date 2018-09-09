/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class Stoch
{
  public:
  void Stoch(int STOCH_k_period = 10,int STOCH_d_period = 3,int STOCH_slowing = 3,ENUM_TIMEFRAMES STOCH_periods = PERIOD_CURRENT,string symbol = NULL, ENUM_MA_METHOD STOCH_method = MODE_SMA,ENUM_STO_PRICE STOCH_price = STO_LOWHIGH);
  double Valor(int buffer = 0, int barra = 0);
  double Cx(int buffer = 0, int barra = 0,int periods = 7);
  double Normalizado(int buffer = 0, int barra = 0,int periods = 7);


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


double Stoch::Cx(int buffer = 0, int barra = 0,int periods = 7)
{
  double retorno = NULL;

  double vetor_norm[];
  ArrayResize(vetor_norm,periods);

  for(int i = 0; i < periods; i++) {
    vetor_norm[i] = Valor(buffer,barra+i);
  }

  Normalizacao *mat = new Normalizacao(vetor_norm);
  retorno = mat.Coeficiente_Angular;
  delete(mat);

  return(retorno);
}

double Stoch::Normalizado(int buffer = 0, int barra = 0,int periods = 7)
{
  double retorno = NULL;

  double vetor_norm[];
  ArrayResize(vetor_norm,periods);

  for(int i = 0; i < periods; i++) {
    vetor_norm[i] = Valor(buffer,barra+i);
  }

  Normalizacao *mat = new Normalizacao(vetor_norm);
  retorno = mat.Valor_Normalizado;
  delete(mat);


  return(retorno);
}
