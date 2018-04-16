/* -*- C++ -*- */

class Zefero
{

  public:
  Zefero();
  ~Zefero();
  void Comentario();
  void Entra();

  private:

};

void Zefero::Zefero()
{
}

void Zefero::~Zefero()
{
}

void Zefero::Comentario()
{

}

void Zefero::Entra()
{
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;
  if(Condicoes.Horario())
  {
    Opera_Mercado *opera = new Opera_Mercado;
    delete opera;
  }
  delete(Condicoes);
}

void on_trade_robo::on_trade_robo(int es=0)
{
  io = es;
};
