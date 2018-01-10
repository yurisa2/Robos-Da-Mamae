/* -*- C++ -*- */

class Halley
{

  public:
  void Halley_Comentario();
  void Avalia();
  void Timer();
  bool Formato(int barra = 0);
  int Direcao(int barra = 0);
  int Forma_Direcao(int barra = 0);



};



void Halley::Halley_Comentario()
{



}

bool Halley::Formato(int barra = 0)
{
  double corpo = 0;
  double sombra = 0;
  bool retorno = false;


  MqlRates rates[];
  ArraySetAsSeries(rates,true);
  int copied=CopyRates(Symbol(),PERIOD_CURRENT,0,200,rates);

  corpo = MathAbs(rates[barra+1].open - rates[barra+1].close);
  sombra = (rates[barra+1].high - rates[barra+1].open);

  if(sombra > (n_vezes * corpo)) retorno = true;

  //Print("Corpo: " + corpo + " | Sombra: " + sombra); //DEBUG

  return retorno;
}

int Halley::Direcao(int barra = 0)
{
  int retorno = 0;
  double valor_ma = 0;
  double preco = 0;
  int direcao_ma = 0;

  MqlRates rates[];
  ArraySetAsSeries(rates,true);
  int copied=CopyRates(Symbol(),PERIOD_CURRENT,0,200,rates);

  preco =  rates[barra+1].close;

  MA *ma = new MA(20);

  valor_ma = ma.Valor(barra);
  if(ma.Valor(barra+2) < ma.Valor(barra+1)) direcao_ma = 1;
  if(ma.Valor(barra+2) > ma.Valor(barra+1)) direcao_ma = -1;

  delete(ma);

  if(direcao_ma == 1 && preco > valor_ma ) retorno = 1;
  if(direcao_ma == -1 && preco < valor_ma ) retorno = -1;

//  Print("Direcao(int barra = 0): " + retorno); //DEBUG
  return retorno;
}


void Halley::Avalia()
{
  int mudanca = 0;
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  if(Condicoes.Horario())
  {

    Print("Formato: " + Formato(0));

    Opera_Mercado *opera = new Opera_Mercado;
  //  if(O_Stops.Tipo_Posicao() == 0 )   opera.AbrePosicao(-1,"Halley: ");
    delete(opera);

    //  Print("Halley: " + DoubleToString(Valor_Halley_atual)); //DEBUG
  }

  delete(Condicoes);
}

void Halley::Timer()
{

  /////// Inicio Apagar ordens pendentes
  if(O_Stops.Tipo_Posicao() == 0)
  {
    int ord_total=OrdersTotal();
    if(ord_total > 0)
    {
      for(int i=ord_total-1;i>=0;i--)
      {
        ulong ticket=OrderGetTicket(i);
        if(OrderSelect(ticket) && OrderGetString(ORDER_SYMBOL)==Symbol())
        {
          CTrade *trade=new CTrade();
          trade.OrderDelete(ticket);
          delete trade;
        }
      }
    }
  }
  /////// FIM Apagar ordens pendentes


}
