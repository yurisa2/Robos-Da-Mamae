/* -*- C++ -*- */

class Xing
{

  public:
  void Comentario();
  void Avalia();
  double Distancia();
  Xing();

  private:

};

void Xing::Xing()
{


}

double Xing::Distancia()
{
  double retorno = 0;


  double diff = SymbolInfoDouble(Symbol(),SYMBOL_BID) - mm_X.Valor();

  retorno = MathRound(diff / Tick_Size);

  return retorno;
}


void Xing::Comentario()
{
  if(Tipo_Comentario > 0)
  {
    double distancia = this.Distancia();

    Comentario_Robo = "";
    if(xing_compra) Comentario_Robo += "\n Distancia da MM20 (Compra): " + DoubleToString(distancia,2) + " | " + DoubleToString(distancia - xing_distancia_compra,2) + " do ponto de entrada";
    if(xing_venda) Comentario_Robo += "\n Distancia da MM20 (Venda): " + DoubleToString(distancia,2) + " | " + DoubleToString(distancia - xing_distancia_venda,2) + " do ponto de entrada";

  }
}


void Xing::Avalia()
{
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  if(O_Stops.Tipo_Posicao() == 0 && Condicoes.Horario())
  {
    double distancia = this.Distancia();

    if(distancia > xing_distancia_compra && distancia < (xing_distancia_compra + 5 * Tick_Size) && xing_compra)
    {
      Opera_Mercado *opera = new Opera_Mercado;
      opera.AbrePosicao(1,"Distancia: " + DoubleToString(distancia,Digits()));
      delete(opera);
    }
    if(distancia > xing_distancia_venda && distancia < (xing_distancia_venda + 5 * Tick_Size) && xing_venda)
    {
      Opera_Mercado *opera = new Opera_Mercado;
      opera.AbrePosicao(-1,"Distancia: " + DoubleToString(distancia,Digits()));
      delete(opera);
    }
  }
  delete(Condicoes);
}

MA mm_X(20,MODE_SMA,TimeFrame);
