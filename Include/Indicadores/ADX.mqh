/* -*- C++ -*- */
#property copyright "PetroSa, Robï¿½s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"



class ADX
{
  public:
  void ADX(int adx_period = 14, ENUM_TIMEFRAMES  period = PERIOD_CURRENT, string symbol = NULL);
  double Valor(int buffer = 0, int barra = 0);
  double Cx(int buffer = 0, int barra = 0,int periods = 7);
  double Normalizado(int buffer = 0, int barra = 0,int periods = 7);


  private:
  int HandleADX;

};

void ADX::ADX(int adx_period = 14, ENUM_TIMEFRAMES  period = PERIOD_CURRENT, string symbol = NULL)
{
  TesterHideIndicators(mocosa_indicadores);

  HandleADX = 0;
  HandleADX = iADX(symbol,period,adx_period);
  // ChartIndicatorAdd(0,1,HandleADX);

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

double ADX::Cx(int buffer = 0, int barra = 0,int periods = 7)
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

double ADX::Normalizado(int buffer = 0, int barra = 0,int periods = 7)
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
