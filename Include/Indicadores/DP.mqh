/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class DP
{
  public:
  void DP();
  int DirecaoMM20(int barra = 0);
  int MM20AcimaAbaixoMM50(int barra = 0);
  int PrecoRMM20(int barra = 0);
  int Direcao(int barra = 0);

  private:

};

void DP::DP()
{


}

int DP::DirecaoMM20(int barra = 0)
{
     int retorno = 0;
     MA *mm20 = new MA(20,MODE_SMA,TimeFrame);

     if(mm20.Valor(barra) > mm20.Valor(barra+1)) retorno = 1;
     if(mm20.Valor(barra) < mm20.Valor(barra+1)) retorno = -1;

     delete(mm20);

     return(retorno);
}


int DP::PrecoRMM20(int barra = 0)
{
     int retorno = 0;

     MqlRates rates[];
     ArraySetAsSeries(rates,true);
     int copied=CopyRates(Symbol(),0,0,barra+2,rates);

     MA *mm20 = new MA(20,MODE_SMA,TimeFrame);

     if(rates[barra].close > mm20.Valor(barra)) retorno = 1;
     if(rates[barra].close < mm20.Valor(barra)) retorno = -1;

     delete(mm20);

     return(retorno);
}


int DP::MM20AcimaAbaixoMM50(int barra = 0)
{
       int retorno = 0;
       MA *mm20 = new MA(20,MODE_SMA,TimeFrame);
       MA *mm50 = new MA(50,MODE_SMA,TimeFrame);

       if(mm20.Valor(barra) > mm50.Valor(barra)) retorno = 1;
       if(mm20.Valor(barra) < mm50.Valor(barra)) retorno = -1;

       delete(mm20);
       delete(mm50);

     return(retorno);
}

int DP::Direcao(int barra = 0)
{
     int retorno = 0;

     if(MM20AcimaAbaixoMM50(barra) > 0 && PrecoRMM20(barra) > 0 && DirecaoMM20(barra)  > 0) retorno = 1;
     if(MM20AcimaAbaixoMM50(barra) < 0 && PrecoRMM20(barra) < 0 && DirecaoMM20(barra)  < 0) retorno = -1;

     return(retorno);
}
