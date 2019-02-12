/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class Interruptor
{
  public:
  Interruptor();
  void Interruptor::Interrompe_Ganho();


  private:



};

void Interruptor::Interruptor()
{

}



void Interruptor::Interrompe_Ganho()
{
  double valor_totalizador = 0;
  double valor_atual = 0;

  Totalizador *totalizator2 = new Totalizador(1);
  string resultado2 = DoubleToString(totalizator2.ganho_liquido());
  valor_atual = totalizator2.ganho_liquido();
  delete(totalizator2);

  CTrade *trade=new CTrade();


  if((valor_totalizador + valor_atual) >= lucro_dia)   trade.PositionClose(Symbol());


  delete trade;
}



Interruptor interruptor;
