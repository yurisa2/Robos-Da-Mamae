/* -*- C++ -*- */

class Xing
{

  public:
  void Comentario();
  void Avalia();
  double Valor();
  Xing();
  void PosInfo();

  private:

};

void Xing::Xing()
{


}

void Xing::Comentario()
{
  if(Tipo_Comentario > 0)
  {
    Comentario_Robo = "Xing: ";
    Comentario_Robo += DoubleToString(this.Valor(),2);
    Comentario_Robo += "\n Spread: ";
    Comentario_Robo += IntegerToString(iSpread(Symbol(),TimeFrame,0));

  }
}

void Xing::Avalia()
{
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;


  if(O_Stops.Tipo_Posicao() == 0 && Condicoes.Horario())
  {

    double xing_valor = this.Valor();

    int multip = 1;

    if(xing_invert) multip = -1;

    if(xing_valor < xing_limite_inferior && iSpread(Symbol(),TimeFrame,0) < xing_limite_spread_max)
    {
      PrintFormat("Voadora é pouco: " + iSpread(Symbol(),TimeFrame,0));

      Opera_Mercado *opera = new Opera_Mercado;
      opera.AbrePosicao(1 * multip,DoubleToString(xing_valor,1));
      delete(opera);
    }

    if(xing_valor > xing_limite_superior && iSpread(Symbol(),TimeFrame,0) < xing_limite_spread_max)
    {
      PrintFormat("Voadora é pouco: " + iSpread(Symbol(),TimeFrame,0));

      Opera_Mercado *opera = new Opera_Mercado;
      opera.AbrePosicao(-1  * multip,DoubleToString(xing_valor,1));
      delete(opera);
    }


  }
  delete(Condicoes);
}

double Xing::Valor()
{
  double retorno = 50;

  RSI *rsi_o = new RSI(14,TimeFrame);
  BB *bb_o = new BB(TimeFrame);

  Xing_Ind *xing_indicador = new Xing_Ind(TimeFrame);

  retorno = xing_indicador.Valor(rsi_o.Valor(xing_desloc), bb_o.BB_Posicao_Percent(xing_desloc),rsi_o.Cx());
  delete xing_indicador;


      delete rsi_o;
      delete bb_o;

  return retorno;
}


void Xing::PosInfo()
{
  long posMagic = 0;

  posicao *posicao_oo = new posicao();
  posicao_oo.SelectByMagic(Symbol(),TimeMagic);

  posMagic = posicao_oo.Magic();

  delete posicao_oo;


  Print("posMagic: " + posMagic);
}
