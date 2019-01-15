/* -*- C++ -*- */

#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"


class HiLo_OO
{

  public:
  void HiLo_OO(int Periodo_Hilo = 4);
  int Direcao(int barra = 0);
  int Mudanca();

  private:
  int Periodos_Inputs;

};

void HiLo_OO::HiLo_OO(int Periodo_Hilo = 4)
{
  Periodos_Inputs = Periodo_Hilo;
}

int HiLo_OO::Direcao(int barra = 0)
{
  MA *MediaMovelAlta = new MA(Periodos_Inputs,MODE_SMA,TimeFrame,0,PRICE_HIGH);
  MA *MediaMovelBaixa = new MA(Periodos_Inputs,MODE_SMA,TimeFrame,0,PRICE_LOW);
  int direcao = 0;
  int i = 0;

  double ValorMA_Alta = MediaMovelAlta.Valor(barra);
  double ValorMA_Baixa = MediaMovelBaixa.Valor(barra);

  if(daotick_geral > ValorMA_Alta) direcao = 1;
  if(daotick_geral < ValorMA_Baixa) direcao = -1;

  do
  {
    if(daotick_geral > MediaMovelAlta.Valor(barra+i)) direcao = 1;
    if(daotick_geral < MediaMovelBaixa.Valor(barra+i)) direcao = -1;
    i++;
  }
  while(direcao == 0);

  delete(MediaMovelAlta);
  delete(MediaMovelBaixa);


  return direcao;
}

int HiLo_OO::Mudanca()
{
  MA *MediaMovelAlta = new MA(Periodos_Inputs,MODE_SMA,TimeFrame,0,PRICE_HIGH);
  MA *MediaMovelBaixa = new MA(Periodos_Inputs,MODE_SMA,TimeFrame,0,PRICE_LOW);
  int retorno = 0;

  int historico_direcao[];

  //Pega O historico
  MqlRates rates[];
   ArraySetAsSeries(rates,true);
   int copied=CopyRates(Symbol(),TimeFrame,0,200,rates);

   int i = ArraySize(rates);
   ArrayResize(historico_direcao,i);
   i = i - 50;

  do
  {
    historico_direcao[i] = 0;
    if(rates[i].close > MediaMovelAlta.Valor(i)) historico_direcao[i] = 1; //Se deixar com High ele fica mais sensivel
    if(rates[i].close < MediaMovelBaixa.Valor(i)) historico_direcao[i] = -1; //Aqui seria com o Low, talvez role parametro...nao sei

    if(historico_direcao[i] == 0) historico_direcao[i] = historico_direcao[i+1];

    // Print("Direcao Historica... i = " + i + " Direcao:" + historico_direcao[i]); //DEBUG

    i--;
  }
  while(i>=0);

  // Print("Hilo Mudanca... 0:" + historico_direcao[0] + " 1:" + historico_direcao[1] + " 2:" + historico_direcao[2]); //DEBUG

if(historico_direcao[1] != historico_direcao[2]) retorno = historico_direcao[1]; //testar em tempo real

  delete(MediaMovelAlta);
  delete(MediaMovelBaixa);


  return retorno;
}
