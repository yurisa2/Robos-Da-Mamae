/* -*- C++ -*- */

class Xandros
{

  public:
  void Comentario();
  void Avalia();
  double Distancia();
  Xandros();

  private:

};

void Xandros::Xandros()
{


}

double Xandros::Distancia()
{
    double retorno = 0;

    MqlRates rates[];
    CopyRates(Symbol(),TimeFrame,0,0,rates);
    ArraySetAsSeries(rates,true);
    double preco_atual = rates[0].close;

    double diff = preco_atual - mm_X.Valor();

    retorno = MathRound(diff / Tick_Size);

    return retorno;
}


void Xandros::Comentario()
{

}


void Xandros::Avalia()
{

  if(this.Distancia() > xandros_distancia_compra  && xandros_compra)
  {
    Opera_Mercado *opera = new Opera_Mercado;
    opera.AbrePosicao(1,"Distancia: " + DoubleToString(this.Distancia()));
    delete(opera);
  }
  if(this.Distancia() > xandros_distancia_venda && xandros_venda)
  {
    Opera_Mercado *opera = new Opera_Mercado;
    opera.AbrePosicao(-1,"Distancia: " + DoubleToString(this.Distancia()));
    delete(opera);
  }

}

MA mm_X(20,MODE_SMA,TimeFrame);
