/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class Preco_O
{
  public:
  Preco_O(ENUM_TIMEFRAMES Periodo_MA_PA = PERIOD_CURRENT);
  double Cx(int barra = 0);
  double Normalizado(int barra = 0,int periods = 7);
  double Amplitude_N;

  private:
  double HighMA;
  double LowMA;
  double CloseMA;
  double DeltaMA;
  ENUM_TIMEFRAMES Periodo_MA;

};

void Preco_O::Preco_O(ENUM_TIMEFRAMES Periodo_MA_PA = PERIOD_CURRENT)
{
  Periodo_MA = Periodo_MA_PA;
  MA *OO_HighMA = new MA(3,MODE_SMA,Periodo_MA_PA,0,PRICE_HIGH);
  MA *OO_LowMA = new MA(3,MODE_SMA,Periodo_MA_PA,0,PRICE_LOW);
  MA *OO_CloseMA = new MA(3,MODE_SMA,Periodo_MA_PA,0,PRICE_CLOSE);

  HighMA = (OO_HighMA.Valor(2) + OO_HighMA.Valor(1) + OO_HighMA.Valor(0)) /3;
  LowMA = (OO_LowMA.Valor(2) + OO_LowMA.Valor(1) + OO_LowMA.Valor(0)) /3;
  CloseMA = (OO_CloseMA.Valor(2) + OO_CloseMA.Valor(1) + OO_CloseMA.Valor(0)) /3;
  DeltaMA = HighMA - LowMA;

  delete OO_LowMA;
  delete OO_HighMA;
  delete OO_CloseMA;
}


double Preco_O::Normalizado(int barra = 0,int periods = 7)
{
  MA *OO_CloseMA = new MA(1,MODE_SMA,Periodo_MA,0,PRICE_CLOSE);

  double retorno = NULL;

  double y1 = OO_CloseMA.Valor(barra+6);
  double y2 = OO_CloseMA.Valor(barra+5);
  double y3 = OO_CloseMA.Valor(barra+4);
  double y4 = OO_CloseMA.Valor(barra+3);
  double y5 = OO_CloseMA.Valor(barra+2);
  double y6 = OO_CloseMA.Valor(barra+1);
  double y7 = OO_CloseMA.Valor(barra);

  Normalizacao *mat = new Normalizacao(y1,y2,y3,y4,y5,y6,y7);
  retorno = mat.Valor_Normalizado;
  delete(mat);

  delete OO_CloseMA;

  return(retorno);
}


double Preco_O::Cx(int barra = 0)
{
  MA *OO_CloseMA = new MA(1,MODE_SMA,Periodo_MA,0,PRICE_CLOSE);

  double retorno = NULL;

  double y1 = OO_CloseMA.Valor(barra+6);
  double y2 = OO_CloseMA.Valor(barra+5);
  double y3 = OO_CloseMA.Valor(barra+4);
  double y4 = OO_CloseMA.Valor(barra+3);
  double y5 = OO_CloseMA.Valor(barra+2);
  double y6 = OO_CloseMA.Valor(barra+1);
  double y7 = OO_CloseMA.Valor(barra);

  Normalizacao *mat = new Normalizacao(y1,y2,y3,y4,y5,y6,y7);
  retorno = mat.Coeficiente_Angular;
  delete(mat);

  delete OO_CloseMA;

  return(retorno);
}
