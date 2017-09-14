/* -*- C++ -*- */
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"


class HiLo_OO
{

  public:
  void HiLo_OO(int Periodo_Hilo = 4);
  int Direcao();
  int Mudanca();

  private:
  int Periodos_Inputs;

};

void HiLo_OO::HiLo_OO(int Periodo_Hilo = 4)
{
  Periodos_Inputs = Periodo_Hilo;
}

int HiLo_OO::Direcao()
{
  MA *MediaMovelAlta = new MA(Periodos_Inputs,MODE_SMA,PERIOD_CURRENT,0,PRICE_HIGH);
  MA *MediaMovelBaixa = new MA(Periodos_Inputs,MODE_SMA,PERIOD_CURRENT,0,PRICE_LOW);
  int direcao = 0;
  int i = 0;

  double ValorMA_Alta = MediaMovelAlta.Valor();
  double ValorMA_Baixa = MediaMovelBaixa.Valor();

  if(daotick_geral > ValorMA_Alta) direcao = 1;
  if(daotick_geral < ValorMA_Baixa) direcao = -1;

  do
  {
    if(daotick_geral > MediaMovelAlta.Valor(i)) direcao = 1;
    if(daotick_geral < MediaMovelBaixa.Valor(i)) direcao = -1;
    i++;
  }
  while(direcao == 0);

  delete(MediaMovelAlta);
  delete(MediaMovelBaixa);


  return direcao;
}

int HiLo_OO::Mudanca()
{
  MA *MediaMovelAlta = new MA(Periodos_Inputs,MODE_SMA,PERIOD_CURRENT,0,PRICE_HIGH);
  MA *MediaMovelBaixa = new MA(Periodos_Inputs,MODE_SMA,PERIOD_CURRENT,0,PRICE_LOW);

  int historico_direcao[];

  double ValorMA_Alta1 = MediaMovelAlta.Valor(1);
  double ValorMA_Baixa1 = MediaMovelBaixa.Valor(1);
  double ValorMA_Alta2 = MediaMovelAlta.Valor(2);
  double ValorMA_Baixa2 = MediaMovelBaixa.Valor(2);

//Pega O historico
  MqlRates rates[];
   ArraySetAsSeries(rates,true);
   int copied=CopyRates(Symbol(),0,0,100,rates);

   int i = ArraySize(rates);
   ArrayResize(historico_direcao,i);
   i--;

  do
  {
    historico_direcao[i] = 0;
    if(rates[i].high > MediaMovelAlta.Valor(i)) historico_direcao[i] = 1;
    if(rates[i].low < MediaMovelBaixa.Valor(i)) historico_direcao[i] = -1;

    if(historico_direcao[i] == 0) historico_direcao[i] = historico_direcao[i+1];

    Print("Direcao Historica... i = " + i + " Direcao:" + historico_direcao[i]);

    i--;
  }
  while(i==0);




  delete(MediaMovelAlta);
  delete(MediaMovelBaixa);


  return true; //Mudar hein...
}
