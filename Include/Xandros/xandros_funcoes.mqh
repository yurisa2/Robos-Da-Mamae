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


  double diff = daotick() - mm_X.Valor();

  retorno = MathRound(diff / Tick_Size);

  return retorno;
}


void Xandros::Comentario()
{
  if(Tipo_Comentario > 0)
  {
    Comentario_Robo = "";
    if(xandros_compra) Comentario_Robo += "\n Distancia da MM20 (Compra): " + DoubleToString(this.Distancia(),2) + " | " + DoubleToString(this.Distancia() - xandros_distancia_compra,2) + " do ponto de entrada";
    if(xandros_venda) Comentario_Robo += "\n Distancia da MM20 (Venda): " + DoubleToString(this.Distancia(),2) + " | " + DoubleToString(this.Distancia() - xandros_distancia_venda,2) + " do ponto de entrada";

  }
}


void Xandros::Avalia()
{
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  if(O_Stops.Tipo_Posicao() == 0 && Condicoes.Horario())
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
  delete(Condicoes);
}

MA mm_X(20,MODE_SMA,TimeFrame);
