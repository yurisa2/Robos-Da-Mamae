/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"



class ADX
{
  public:
  void ADX(int adx_period = 14, ENUM_TIMEFRAMES  period = PERIOD_CURRENT, string symbol = NULL);
  double Valor(int buffer = 0, int barra = 0);
  double Cx(int buffer = 0, int barra = 0);
  double Normalizado(int buffer = 0, int barra = 0);


  private:
  int HandleADX;

};

void ADX::ADX(int adx_period = 14, ENUM_TIMEFRAMES  period = PERIOD_CURRENT, string symbol = NULL)
{
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

double ADX::Cx(int buffer = 0, int barra = 0)
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

double ADX::Normalizado(int buffer = 0, int barra = 0)
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
