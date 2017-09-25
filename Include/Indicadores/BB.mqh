/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class BB
{
  public:
  void BB(
    string              symbol = NULL,            // s�mbolo nome
    ENUM_TIMEFRAMES     period = PERIOD_CURRENT,            // per�odo
    int                 bands_period = 20,      // per�odo para o c�lculo da m�dia da linha
    int                 bands_shift = 0,       // deslocamento horizontal do indicador
    double              deviation = 2,         // n�mero de desvios padr�o
    ENUM_APPLIED_PRICE  applied_price = PRICE_CLOSE     // tipo de pre�o ou manipulador
  );
  double BB_Low(int barra = 0);
  double BB_High(int barra = 0);
  double BB_Delta_Bruto(int barra = 0);
  double BB_Posicao_Percent();
  double Banda_Delta_Valor();

  private:
  int HandleBBOO;

};

void BB::BB(
  string              symbol = NULL,            // s�mbolo nome
  ENUM_TIMEFRAMES     period = PERIOD_CURRENT,            // per�odo
  int                 bands_period = 20,      // per�odo para o c�lculo da m�dia da linha
  int                 bands_shift = 0,       // deslocamento horizontal do indicador
  double              deviation = 2,         // n�mero de desvios padr�o
  ENUM_APPLIED_PRICE  applied_price = PRICE_CLOSE     // tipo de pre�o ou manipulador
)
{
  HandleBBOO = 0;
  HandleBBOO = iBands(symbol,period, bands_period,bands_shift,deviation,applied_price);
  ChartIndicatorAdd(0,0,HandleBBOO);

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
  CopyBuffer(HandleBBOO,2,0,3,_BB_Low);

  retorno = (_BB_Low[barra]);
  return(retorno);
}

double BB::BB_High(int barra = 0)
{
  double _BB_High[];
  double retorno = 0;
  ArraySetAsSeries(_BB_High, true);
  CopyBuffer(HandleBBOO,1,0,3,_BB_High);

  retorno = (_BB_High[barra]);
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

double BB::BB_Posicao_Percent()
{
  double retorno = 0;
  double delta_BB = 1;
  double trans_size = 0;

  delta_BB = BB_High() - BB_Low();
  trans_size = daotick_geral - BB_Low();

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
