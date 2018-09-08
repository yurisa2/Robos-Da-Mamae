/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class MA
{
  public:
  void MA(int ma_period = 3,ENUM_MA_METHOD ma_method = MODE_SMA, ENUM_TIMEFRAMES Periodos_MA = PERIOD_CURRENT,int ma_shift = 0,ENUM_APPLIED_PRICE applied_price = PRICE_CLOSE);
  double Valor(int barra = 0);
  double Cx(int barra = 0);
  double Normalizado(int barra = 0,int periods = 7);

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


double MA::Cx(int barra = 0)
{
  double retorno = NULL;

  double y1 = Valor(barra+6);
  double y2 = Valor(barra+5);
  double y3 = Valor(barra+4);
  double y4 = Valor(barra+3);
  double y5 = Valor(barra+2);
  double y6 = Valor(barra+1);
  double y7 = Valor(barra);

  Normalizacao *mat = new Normalizacao(y1,y2,y3,y4,y5,y6,y7);
  retorno = mat.Coeficiente_Angular;
  delete(mat);


  return(retorno);
}

double MA::Normalizado(int barra = 0,int periods = 7)
{
  double retorno = NULL;

  double y1 = Valor(barra+6);
  double y2 = Valor(barra+5);
  double y3 = Valor(barra+4);
  double y4 = Valor(barra+3);
  double y5 = Valor(barra+2);
  double y6 = Valor(barra+1);
  double y7 = Valor(barra);

  Normalizacao *mat = new Normalizacao(y1,y2,y3,y4,y5,y6,y7);
  retorno = mat.Valor_Normalizado;
  delete(mat);


  return(retorno);
}
