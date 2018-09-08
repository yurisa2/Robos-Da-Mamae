/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class RSI
{
  public:
  void RSI(int ma_period = 14, ENUM_TIMEFRAMES periodos_r = PERIOD_CURRENT, string Simbolo = NULL, ENUM_APPLIED_PRICE applied_price = PRICE_CLOSE);
  double Valor(int barra = 0);
  double Cx(int barra = 0);
  double Normalizado(int barra = 0,int periods = 7);

  private:
  int HandleRSI;

};

void RSI::RSI(int ma_period = 14, ENUM_TIMEFRAMES periodos_r = PERIOD_CURRENT, string Simbolo = NULL, ENUM_APPLIED_PRICE applied_price = PRICE_CLOSE)
{
  HandleRSI = 0;
  HandleRSI = iRSI(Simbolo,periodos_r,ma_period,applied_price) ;
  // ChartIndicatorAdd(0,1,HandleRSI);

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
     int RSI_copied = CopyBuffer(HandleRSI,0,0,barra+5,_RSI);

     retorno = _RSI[barra];

     return(retorno);
}


double RSI::Cx(int barra = 0)
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

double RSI::Normalizado(int barra = 0,int periods = 7)
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
