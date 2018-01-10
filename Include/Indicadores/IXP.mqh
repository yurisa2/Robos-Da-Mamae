/* -*- C++ -*- */
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class IXP
{
  public:
  void IXP(int Periodos = 21,int Shift = 0, int Deviation = 2);
  double Valor(int barra = 0);

  private:
  int HandleIXP;

};

void IXP::IXP(int Periodos = 21,int Shift = 0, int Deviation = 2)
{




}

double IXP::Valor(int barra = 0)
{
     double retorno = NULL;
     double delta_preco = 0;
     double delta_bb = 1;


     MqlRates rates[];
     ArraySetAsSeries(rates,true);
     int copied=CopyRates(Symbol(),PERIOD_CURRENT,0,200,rates);
     delta_preco = (rates[barra].high - rates[barra].low);

     BB *Banda_BB = new BB(NULL,NULL,IXP_Periodos);
     delta_bb = Banda_BB.BB_Delta_Bruto() * Tick_Size;
     delete(Banda_BB);

     if(delta_bb == 0) delta_bb = 1;

     retorno = 100 - (delta_preco/delta_bb * 100);

     return(retorno);
}
