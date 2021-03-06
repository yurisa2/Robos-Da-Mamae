﻿/* -*- C++ -*- */

class Just
{

  public:
  void Comentario();
  void Avalia();
  double Distancia();
  Just();

  private:

};

void Just::Just()
{


}

double Just::Distancia()
{
  double retorno = 0;


  double diff = SymbolInfoDouble(Symbol(),SYMBOL_BID) - mm_X.Valor();

  retorno = MathRound(diff / Tick_Size);

  return retorno;
}


void Just::Comentario()
{
  if(Tipo_Comentario > 0)
  {
    Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;


    double distancia = this.Distancia();
    bool Condicao = Condicoes.Condicao();




    Comentario_Robo = "";
    if(just_compra) Comentario_Robo += "\n Distancia da MM20 (Compra): " + DoubleToString(distancia,2) + " | " + DoubleToString(distancia - just_distancia_compra,2);
    if(just_venda) Comentario_Robo += "\n Distancia da MM20 (Venda): " + DoubleToString(distancia,2) + " | " + DoubleToString(distancia - just_distancia_venda,2);

  }
}


void Just::Avalia()
{
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  if(O_Stops.Tipo_Posicao() == 0 && Condicoes.Horario())
  {
    double distancia = this.Distancia();

    if(distancia > just_distancia_compra && just_compra)
    {
      Opera_Mercado *opera = new Opera_Mercado;
      opera.AbrePosicao(1,"Distancia: " + DoubleToString(distancia,Digits()));
      delete(opera);
    }
    if(distancia > just_distancia_venda && just_venda)
    {
      Opera_Mercado *opera = new Opera_Mercado;
      opera.AbrePosicao(-1,"Distancia: " + DoubleToString(distancia,Digits()));
      delete(opera);
    }
  }
  delete(Condicoes);
}

MA mm_X(20,MODE_SMA,TimeFrame);
