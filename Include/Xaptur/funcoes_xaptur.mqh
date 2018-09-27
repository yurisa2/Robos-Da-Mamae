/* -*- C++ -*- */

class Xaptur
{

  public:
  void Avalia();

};


void Xaptur::Avalia()
{
  datetime Data_Inicio_hoje = StringToTime(TimeToString(TimeCurrent(),TIME_DATE)+" 00:01");

  HiLo_OO *hilo = new HiLo_OO(4);
  int direcao = hilo.Direcao();
  MqlRates rates[];
  int copied=CopyRates(Symbol(),PERIOD_CURRENT,Data_Inicio_hoje,10,rates);
  ArraySetAsSeries(rates,true);

  double lucro = rates[0].high - rates[1].high;

  File *arquivo = new File();
  arquivo.Escreve("POS",IntegerToString(direcao),0,DEAL_ENTRY_IN);
  delete(arquivo);
  delete(hilo);

}
