/* -*- C++ -*- */

class Xuwabunga
{

  public:
  void Comentario();
  void Avalia();
  double Valor();
  Xuwabunga();
  void MainTrend(ENUM_TIMEFRAMES Periodo = TimeFrame_);
  void SecTrend(ENUM_TIMEFRAMES Periodo = TimeFrame_);


  private:

};

void Xuwabunga::Xuwabunga()
{


}

void Xuwabunga::Comentario()
{
  if(Tipo_Comentario > 0)
  {
    Comentario_Robo = "Xuwabunga: ";
    Comentario_Robo += DoubleToString(this.Valor(),2);
    Comentario_Robo += "\n Spread: ";
    Comentario_Robo += IntegerToString(iSpread(Symbol(),TimeFrame,0));

  }
}

void Xuwabunga::Avalia()
{
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;


  if(O_Stops.Tipo_Posicao() == 0 && Condicoes.Horario())
  {

    double Xuwabunga_valor = this.Valor();

    int multip = 1;

    if(Xuwabunga_invert) multip = -1;

    if(Xuwabunga_valor < Xuwabunga_limite_inferior && iSpread(Symbol(),TimeFrame,0) < Xuwabunga_limite_spread_max)
    {

      Opera_Mercado *opera = new Opera_Mercado;
      opera.AbrePosicao(1 * multip,DoubleToString(Xuwabunga_valor,1));
      delete(opera);

    }

    if(Xuwabunga_valor > Xuwabunga_limite_superior && iSpread(Symbol(),TimeFrame,0) < Xuwabunga_limite_spread_max)
    {
     // PrintFormat("Voadora Ã© pouco: " + iSpread(Symbol(),TimeFrame,0));

      Opera_Mercado *opera = new Opera_Mercado;
      opera.AbrePosicao(-1  * multip,DoubleToString(Xuwabunga_valor,1));
      delete(opera);
    }


  }
  delete(Condicoes);
}

double Xuwabunga::Valor()
{
 return 1;
}


void Xuwabunga:: MainTrend(ENUM_TIMEFRAMES Periodo = TimeFrame_)
{


  
}
