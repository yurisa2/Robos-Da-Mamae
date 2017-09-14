/* -*- C++ -*- */
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"


class HiLo_OO
{

  public:
  void HiLo_OO(int Periodo_Hilo = 4);
  int Direcao();

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
