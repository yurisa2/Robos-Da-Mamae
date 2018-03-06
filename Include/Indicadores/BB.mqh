/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class BB
{
  public:
  void BB(
    ENUM_TIMEFRAMES     period = PERIOD_CURRENT,            // per�odo
    string              symbol = NULL,            // s�mbolo nome
    int                 bands_period = 20,      // per�odo para o c�lculo da m�dia da linha
    int                 bands_shift = 0,       // deslocamento horizontal do indicador
    double              deviation = 2,         // n�mero de desvios padr�o
    ENUM_APPLIED_PRICE  applied_price = PRICE_CLOSE     // tipo de pre�o ou manipulador
  );

  double BB_Low(int barra = 0);
  double BB_Base(int barra = 0);
  double BB_High(int barra = 0);
  double BB_Delta_Bruto(int barra = 0);
  double BB_Posicao_Percent(int barra = 0);
  double Banda_Delta_Valor();

  double Cx_BB_Low(int barra = 0);
  double Cx_BB_Base(int barra = 0);
  double Cx_BB_High(int barra = 0);
  double Cx_BB_Delta_Bruto(int barra = 0);
  double Cx_BB_Posicao_Percent(int barra = 0);



  private:
  int HandleBBOO;
  string simbolo;
  ENUM_TIMEFRAMES     periodos;
};

void BB::BB(
  ENUM_TIMEFRAMES     period = PERIOD_CURRENT,            // per�odo
  string              symbol = NULL,            // s�mbolo nome
  int                 bands_period = 20,      // per�odo para o c�lculo da m�dia da linha
  int                 bands_shift = 0,       // deslocamento horizontal do indicador
  double              deviation = 2,         // n�mero de desvios padr�o
  ENUM_APPLIED_PRICE  applied_price = PRICE_CLOSE     // tipo de pre�o ou manipulador
)
{

  simbolo = symbol;
  periodos = period;

  HandleBBOO = 0;
  HandleBBOO = iBands(symbol,period, bands_period,bands_shift,deviation,applied_price);
  // ChartIndicatorAdd(0,0,HandleBBOO);

  // Print("Handle Stoch: " + IntegerToString(HandleBBOO));

  if(HandleBBOO == 0)
  {
    ExpertRemove();
  }
}

double BB::BB_Low(int barra = 0)
{
  double _BB_Low[];
  double retorno = 0;
  ArraySetAsSeries(_BB_Low, true);
  CopyBuffer(HandleBBOO,2,0,barra+5,_BB_Low);

  retorno = (_BB_Low[barra]);
  return(retorno);
}

double BB::BB_High(int barra = 0)
{
  double _BB_High[];
  double retorno = 0;
  ArraySetAsSeries(_BB_High, true);
  CopyBuffer(HandleBBOO,1,0,barra+5,_BB_High);

  retorno = (_BB_High[barra]);
  return(retorno);
}

double BB::BB_Base(int barra = 0)
{
  double _BB_Base[];
  double retorno = 0;
  ArraySetAsSeries(_BB_Base, true);
  CopyBuffer(HandleBBOO,0,0,barra+5,_BB_Base);

  retorno = (_BB_Base[barra]);
  return(retorno);
}

double BB::BB_Delta_Bruto(int barra = 0)
{
  double retorno = 0;
  double delta_BB = 0;

  delta_BB = BB_High(barra) - BB_Low(barra);
  retorno = delta_BB / Tick_Size;

  return retorno;
}

double BB::BB_Posicao_Percent(int barra = 0)
{
  double retorno = 0;
  double delta_BB = 1;
  double trans_size = 0;

  delta_BB = BB_High(barra) - BB_Low(barra);

  if(barra == 0) trans_size = daotick_geral - BB_Low(barra);

  if(barra > 0)
  {
    MqlRates rates[];
    CopyRates(simbolo,periodos,0,barra+1,rates);
    ArraySetAsSeries(rates,true);

    // Print("BB Barra: " + barra); //DEBUG
    trans_size = rates[barra].close - BB_Low(barra);
  }
  if(delta_BB == 0) delta_BB = 0.0000001;

  retorno = trans_size/delta_BB*100;

  return retorno;
}

double BB::Banda_Delta_Valor()
{
  double delta = 0;
  double delta_media_candle = 0;


  //Pega O historico
  MqlRates rates[];
  ArraySetAsSeries(rates,true);
  int copied=CopyRates(Symbol(),0,0,200,rates);
  // delta_media_candle = (((rates[1].high + rates[2].high + rates[3].high) / 3 ) - ((rates[1].low + rates[2].low + rates[3].low) / 3 )/Tick_Size);
  delta_media_candle = (rates[1].high - rates[1].low);

  if(delta_media_candle == 0) delta_media_candle = 1;

  delta = (BB_Delta_Bruto()/delta_media_candle) * 100 ;

  // Print("delta: " + delta);

  return delta;
}

double BB::Cx_BB_Low(int barra = 0)
{
  double retorno = NULL;

  double y1 = BB_Low(barra+6);
  double y2 = BB_Low(barra+5);
  double y3 = BB_Low(barra+4);
  double y4 = BB_Low(barra+3);
  double y5 = BB_Low(barra+2);
  double y6 = BB_Low(barra+1);
  double y7 = BB_Low(barra);

  Normalizacao *mat = new Normalizacao(y1,y2,y3,y4,y5,y6,y7);
  retorno = mat.Coeficiente_Angular;
  delete(mat);

  return(retorno);
}

double BB::Cx_BB_Base(int barra = 0)
{
  double retorno = NULL;

  double y1 = BB_Base(barra+6);
  double y2 = BB_Base(barra+5);
  double y3 = BB_Base(barra+4);
  double y4 = BB_Base(barra+3);
  double y5 = BB_Base(barra+2);
  double y6 = BB_Base(barra+1);
  double y7 = BB_Base(barra);

  Normalizacao *mat = new Normalizacao(y1,y2,y3,y4,y5,y6,y7);
  retorno = mat.Coeficiente_Angular;
  delete(mat);

  return(retorno);
}


double BB::Cx_BB_High(int barra = 0)
{
  double retorno = NULL;

  double y1 = BB_High(barra+6);
  double y2 = BB_High(barra+5);
  double y3 = BB_High(barra+4);
  double y4 = BB_High(barra+3);
  double y5 = BB_High(barra+2);
  double y6 = BB_High(barra+1);
  double y7 = BB_High(barra);

  Normalizacao *mat = new Normalizacao(y1,y2,y3,y4,y5,y6,y7);
  retorno = mat.Coeficiente_Angular;
  delete(mat);

  return(retorno);
}



double BB::Cx_BB_Delta_Bruto(int barra = 0)
{
  double retorno = NULL;

  double y1 = BB_Delta_Bruto(barra+6);
  double y2 = BB_Delta_Bruto(barra+5);
  double y3 = BB_Delta_Bruto(barra+4);
  double y4 = BB_Delta_Bruto(barra+3);
  double y5 = BB_Delta_Bruto(barra+2);
  double y6 = BB_Delta_Bruto(barra+1);
  double y7 = BB_Delta_Bruto(barra);

  Normalizacao *mat = new Normalizacao(y1,y2,y3,y4,y5,y6,y7);
  retorno = mat.Coeficiente_Angular;
  delete(mat);

  return(retorno);
}

double BB::Cx_BB_Posicao_Percent(int barra = 0)
{
  double retorno = NULL;

  double y1 = BB_Posicao_Percent(barra+6);
  double y2 = BB_Posicao_Percent(barra+5);
  double y3 = BB_Posicao_Percent(barra+4);
  double y4 = BB_Posicao_Percent(barra+3);
  double y5 = BB_Posicao_Percent(barra+2);
  double y6 = BB_Posicao_Percent(barra+1);
  double y7 = BB_Posicao_Percent(barra);

  Normalizacao *mat = new Normalizacao(y1,y2,y3,y4,y5,y6,y7);
  retorno = mat.Coeficiente_Angular;
  delete(mat);

  return(retorno);
}
