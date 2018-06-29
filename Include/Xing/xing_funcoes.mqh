/* -*- C++ -*- */

class Xing
{

  public:
  void Comentario();
  void Avalia();
  Xing();

  private:

};

void Xing::Xing()
{


}

void Xing::Comentario()
{
  if(Tipo_Comentario > 0)
  {
    Comentario_Robo = "";

  }
}

void Xing::Avalia()
{
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  if(O_Stops.Tipo_Posicao() == 0 && Condicoes.Horario())
  {
    RSI *rsi_o = new RSI(14,TimeFrame);
    BB *bb_o = new BB(TimeFrame);

    Xing_Ind *xing_indicador = new Xing_Ind(TimeFrame);

    double xing_valor = xing_indicador.Valor(rsi_o.Valor(xing_desloc), bb_o.BB_Posicao_Percent(xing_desloc),rsi_o.Cx());
    delete xing_indicador;

    PrintFormat("RSI: %f BBPP %f RSI CX %f Valor: %f",rsi_o.Valor(),bb_o.BB_Posicao_Percent(),rsi_o.Cx(), xing_valor);

    int multip = 1;

    if(xing_invert) multip = -1;

    if(xing_valor < xing_limite_inferior)
    {
      Opera_Mercado *opera = new Opera_Mercado;
      opera.AbrePosicao(1 * multip,"Xing: " + DoubleToString(xing_valor,Digits()));
      delete(opera);
    }

    if(xing_valor > xing_limite_superior)
    {
      Opera_Mercado *opera = new Opera_Mercado;
      opera.AbrePosicao(-1  * multip,"Xing: " + DoubleToString(xing_valor,Digits()));
      delete(opera);
    }

    delete rsi_o;
    delete bb_o;

  }
  delete(Condicoes);
}
