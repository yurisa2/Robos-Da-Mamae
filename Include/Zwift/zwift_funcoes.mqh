/* -*- C++ -*- */

class Zwift
{

  public:
  Zwift();
  ~Zwift();
  void Comentario();
  void Avalia();
  void Timer();

  private:

};

void Zwift::Zwift()
{
}

void Zwift::~Zwift()
{
}

void Zwift::Comentario()
{
  Igor *Igor_oo = new Igor;
  BB *BB_oo = new BB;

  if(!Otimizacao) Comentario_Robo = " Igor CEV: " + DoubleToString(Igor_oo.Fuzzy_CEV()) ;
  if(!Otimizacao) Comentario_Robo += "\n BB_Posicao_Percent: " + DoubleToString(BB_oo.BB_Posicao_Percent ()) ;


  delete BB_oo;
  delete Igor_oo;
}

void Zwift::Avalia()
{

  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  if(Condicoes.Horario())
  {
    Igor *Igor_oo = new Igor;
    Opera_Mercado *opera = new Opera_Mercado;

    if(Igor_oo.Fuzzy_CEV() > Zwift_limite_superior && O_Stops.Tipo_Posicao() == 0)   opera.AbrePosicao(-1,"Igor_oo: " + DoubleToString(Igor_oo.Fuzzy_CEV()));
    if(Igor_oo.Fuzzy_CEV() < Zwift_limite_inferior && O_Stops.Tipo_Posicao() == 0)   opera.AbrePosicao(1,"Igor_oo: " + DoubleToString(Igor_oo.Fuzzy_CEV()));
    if(Igor_oo.Fuzzy_CEV() == 50 && O_Stops.Tipo_Posicao() != 0 && Zwift_sair_indicador)        opera.FechaPosicao() ;

    delete Igor_oo;
    delete opera;

  }

  delete(Condicoes);
}



void Zwift::Timer()
{


}
