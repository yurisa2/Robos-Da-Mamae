/* -*- C++ -*- */
#property copyright "PetroSa, Robï¿½s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class BB
{
  public:
  void BB(
    ENUM_TIMEFRAMES     period = PERIOD_CURRENT,            // perï¿½odo
    string              symbol = NULL,            // sï¿½mbolo nome
    int                 bands_period = 20,      // perï¿½odo para o cï¿½lculo da mï¿½dia da linha
    int                 bands_shift = 0,       // deslocamento horizontal do indicador
    double              deviation = 2,         // nï¿½mero de desvios padrï¿½o
    ENUM_APPLIED_PRICE  applied_price = PRICE_CLOSE     // tipo de preï¿½o ou manipulador
  );

  double BB_Low(int barra = 0);
  double BB_Base(int barra = 0);
  double BB_High(int barra = 0);
  double BB_Delta_Bruto(int barra = 0);
  double BB_Posicao_Percent(int barra = 0);
  double Banda_Delta_Valor(int barra = 0);

  double Cx_BB_Low(int barra = 0, int periods = 7);
  double Cx_BB_Base(int barra = 0, int periods = 7);
  double Cx_BB_High(int barra = 0, int periods = 7);
  double Cx_BB_Delta_Bruto(int barra = 0, int periods = 7);
  double Cx_BB_Posicao_Percent(int barra = 0, int periods = 7);
  double Normalizado_BB_Low(int barra = 0, int periods = 7);
  double Normalizado_BB_Base(int barra = 0, int periods = 7);
  double Normalizado_BB_High(int barra = 0, int periods = 7);
  double Normalizado_BB_Delta_Bruto(int barra = 0, int periods = 7);
  double Normalizado_BB_Posicao_Percent(int barra = 0, int periods = 7);



  private:
  int HandleBBOO;
  string simbolo;
  ENUM_TIMEFRAMES     periodos;
};

void BB::BB(
  ENUM_TIMEFRAMES     period = PERIOD_CURRENT,            // perï¿½odo
  string              symbol = NULL,            // sï¿½mbolo nome
  int                 bands_period = 20,      // perï¿½odo para o cï¿½lculo da mï¿½dia da linha
  int                 bands_shift = 0,       // deslocamento horizontal do indicador
  double              deviation = 2,         // nï¿½mero de desvios padrï¿½o
  ENUM_APPLIED_PRICE  applied_price = PRICE_CLOSE     // tipo de preï¿½o ou manipulador
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
  double TS_Div = 0.00000000001;


  if(Tick_Size > 0)  TS_Div = Tick_Size;
  delta_BB = BB_High(barra) - BB_Low(barra);
  retorno = delta_BB / SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_SIZE);
  //retorno = delta_BB / TS_Div;
  // Print("BB::BB_Delta_Bruto() Tick_Size" + DoubleToString(Tick_Size)); // DEBUG;
  // Print("BB::BB_High() Tick_Size" + DoubleToString(BB_High(barra))); // DEBUG
  // Print("BB::BB_Low() Tick_Size" + DoubleToString(BB_Low(barra))); // DEBUG
  // Print(retorno);

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

double BB::Banda_Delta_Valor(int barra = 0)
{
  double delta = 0;
  double delta_media_candle = 0;


  //Pega O historico
  MqlRates rates[];
  ArraySetAsSeries(rates,true);
  int copied=CopyRates(Symbol(),0,0,barra+10,rates);
  // delta_media_candle = (((rates[1].high + rates[2].high + rates[3].high) / 3 ) - ((rates[1].low + rates[2].low + rates[3].low) / 3 )/Tick_Size);
  delta_media_candle = (rates[barra+1].high - rates[barra+1].low);

  if(delta_media_candle == 0) delta_media_candle = 1;

  delta = (BB_Delta_Bruto(barra)/delta_media_candle) * 100 ;

  // Print("delta: " + delta);

  return delta;
}

double BB::Cx_BB_Low(int barra = 0,int periods = 7)
{
  double retorno = NULL;

  double vetor_norm[];
  ArrayResize(vetor_norm,periods);

  for(int i = 0; i < periods; i++) {
    vetor_norm[i] = BB_Low(barra+i);
  }

  Normalizacao *mat = new Normalizacao(vetor_norm);
  retorno = mat.Coeficiente_Angular;
  delete(mat);

  return(retorno);
}

double BB::Cx_BB_Base(int barra = 0,int periods = 7)
{
  double retorno = NULL;

  double vetor_norm[];
  ArrayResize(vetor_norm,periods);

  for(int i = 0; i < periods; i++) {
    vetor_norm[i] = BB_Base(barra+i);
  }

  Normalizacao *mat = new Normalizacao(vetor_norm);
  retorno = mat.Coeficiente_Angular;
  delete(mat);

  return(retorno);
}


double BB::Cx_BB_High(int barra = 0,int periods = 7)
{
  double retorno = NULL;

  double vetor_norm[];
  ArrayResize(vetor_norm,periods);

  for(int i = 0; i < periods; i++) {
    vetor_norm[i] = BB_High(barra+i);
  }

  Normalizacao *mat = new Normalizacao(vetor_norm);
  retorno = mat.Coeficiente_Angular;
  delete(mat);

  return(retorno);
}



double BB::Cx_BB_Delta_Bruto(int barra = 0,int periods = 7)
{
  double retorno = NULL;

  double vetor_norm[];
  ArrayResize(vetor_norm,periods);

  for(int i = 0; i < periods; i++) {
    vetor_norm[i] = BB_Delta_Bruto(barra+i);
  }

  Normalizacao *mat = new Normalizacao(vetor_norm);
  retorno = mat.Coeficiente_Angular;
  delete(mat);

  return(retorno);
}


double BB::Cx_BB_Posicao_Percent(int barra = 0,int periods = 7)
{
  double retorno = NULL;

  double vetor_norm[];
  ArrayResize(vetor_norm,periods);

  for(int i = 0; i < periods; i++) {
    vetor_norm[i] = BB_Posicao_Percent(barra+i);
  }

  Normalizacao *mat = new Normalizacao(vetor_norm);
  retorno = mat.Coeficiente_Angular;
  delete(mat);

  return(retorno);
}


/////////////////////////////////

double BB::Normalizado_BB_Low(int barra = 0,int periods = 7)
{
  double retorno = NULL;

  double vetor_norm[];
  ArrayResize(vetor_norm,periods);

  for(int i = 0; i < periods; i++) {
    vetor_norm[i] = BB_Low(barra+i);
  }

  Normalizacao *mat = new Normalizacao(vetor_norm);
  retorno = mat.Valor_Normalizado;
  delete(mat);


  return(retorno);
}

double BB::Normalizado_BB_Base(int barra = 0,int periods = 7)
{
  double retorno = NULL;

  double vetor_norm[];
  ArrayResize(vetor_norm,periods);

  for(int i = 0; i < periods; i++) {
    vetor_norm[i] = BB_Base(barra+i);
  }

  Normalizacao *mat = new Normalizacao(vetor_norm);
  retorno = mat.Valor_Normalizado;
  delete(mat);


  return(retorno);
}


double BB::Normalizado_BB_High(int barra = 0,int periods = 7)
{
  double retorno = NULL;

  double vetor_norm[];
  ArrayResize(vetor_norm,periods);

  for(int i = 0; i < periods; i++) {
    vetor_norm[i] = BB_High(barra+i);
  }

  Normalizacao *mat = new Normalizacao(vetor_norm);
  retorno = mat.Valor_Normalizado;
  delete(mat);


  return(retorno);
}



double BB::Normalizado_BB_Delta_Bruto(int barra = 0,int periods = 7)
{
  double retorno = NULL;

  double vetor_norm[];
  ArrayResize(vetor_norm,periods);

  for(int i = 0; i < periods; i++) {
    vetor_norm[i] = BB_Delta_Bruto(barra+i);
  }

  Normalizacao *mat = new Normalizacao(vetor_norm);
  retorno = mat.Valor_Normalizado;
  delete(mat);


  return(retorno);
}

double BB::Normalizado_BB_Posicao_Percent(int barra = 0,int periods = 7)
{
  double retorno = NULL;

  double vetor_norm[];
  ArrayResize(vetor_norm,periods);

  for(int i = 0; i < periods; i++) {
    vetor_norm[i] = BB_Posicao_Percent(barra+i);
  }

  Normalizacao *mat = new Normalizacao(vetor_norm);
  retorno = mat.Valor_Normalizado;
  delete(mat);


  return(retorno);
}
