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
  int copied=CopyRates(Symbol(),TimeFrame,0,100,rates);
    ArraySetAsSeries(rates,true);

  double lucro = rates[0].open - rates[1].open;

  // Print("Rates 0 " +  rates[0].open);
  // Print("Rates 1 " +  rates[1].open);


  File *arquivo = new File();
  arquivo.Escreve("POS",IntegerToString(direcao),lucro,DEAL_ENTRY_IN,file_normalizacao);
  delete(arquivo);
  delete(hilo);

}
