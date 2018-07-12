/* -*- C++ -*- */

class Xugo
{

  public:
  void Comentario();
  void Avalia();
  int Conta_Zeros();
  Xugo();

  private:

};

void Xugo::Xugo()
{


}

void Xugo::Comentario()
{
  if(Tipo_Comentario > 0)
  {
    Comentario_Robo = "Xugo: ";
    Comentario_Robo += DoubleToString(this.Conta_Zeros(),2);
    Comentario_Robo += "\n Spread: ";
    Comentario_Robo += IntegerToString(iSpread(Symbol(),TimeFrame,0));

  }
}

void Xugo::Avalia()
{
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;


  if(O_Stops.Tipo_Posicao() == 0 && Condicoes.Horario())
  {

    double xugo_valor = this.Conta_Zeros();

    int multip = 1;

    if(xugo_invert) multip = -1;

    if(this.Conta_Zeros() > xugo_ZerosCompra && iSpread(Symbol(),TimeFrame,0) < xugo_limite_spread_max)
    {

      Opera_Mercado *opera = new Opera_Mercado;
      opera.AbrePosicao(1 * multip,DoubleToString(xugo_valor,1));
      delete(opera);

    }
  }

  // if(this.Conta_Zeros() > 8) Print("Conta_Zeros" + this.Conta_Zeros());

  delete(Condicoes);
}

int Xugo::Conta_Zeros()
{
  int retorno = 0;
  double soma = 0;

  Preco_O *preco = new Preco_O;

  for(int i = 0; i < 20; i++)
  {
  if(preco.Normalizado(i) == 0) retorno++;
  else break;
  }


  delete preco;

  return retorno;
}
