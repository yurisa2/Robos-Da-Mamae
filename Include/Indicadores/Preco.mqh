/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class Preco
{
  public:
  Preco(ENUM_TIMEFRAMES Periodo_MA = PERIOD_CURRENT);
  double Cx(int barra = 0);
  double Normalizado(int barra = 0);
  double Amplitude_N;

  private:
  double HighMA;
  double LowMA;
  double DeltaMA;

  ENUM_TIMEFRAMES Preco_Periodo_MA = Periodo_MA;

};

void Preco::Preco(ENUM_TIMEFRAMES Periodo_MA = PERIOD_CURRENT);
{
  MA *OO_HighMA = new MA(3,MODE_SMA,Periodo_MA,0,PRICE_HIGH);
  MA *OO_LowMA = new MA(3,MODE_SMA,Periodo_MA,0,PRICE_LOW);

  HighMA = (OO_HighMA.Valor(2) + OO_HighMA.Valor(1) + OO_HighMA.Valor(0)) /3;
  LowMA = (OO_LowMA.Valor(2) + OO_LowMA.Valor(1) + OO_LowMA.Valor(0)) /3;
  DeltaMA = HighMA - LowMA;

  delete OO_LowMA;
  delete OO_HighMA;
}
