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
  if(Tipo_Comentario > 0)
  {
    Igor *Igor_oo = new Igor;
    BB *BB_oo = new BB;
    FiltroF *filtro_teste = new FiltroF;
    // Print("Filtro_Fuzzy(): " + DoubleToString(filtro_teste.Fuzzy()));



    if(!Otimizacao) Comentario_Robo = " Igor CEV: " + DoubleToString(Igor_oo.Fuzzy_CEV()) ;
    if(!Otimizacao) Comentario_Robo += "\n BB_Posicao_Percent: " + DoubleToString(BB_oo.BB_Posicao_Percent ()) ;
    if(!Otimizacao) Comentario_Robo += "\n Filtro_Fuzzy: " + DoubleToString(filtro_teste.Fuzzy()) ;

    delete(filtro_teste);
    delete BB_oo;
    delete Igor_oo;
  }
}

void Zwift::Avalia()
{

  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  if(Condicoes.Horario())
  {
    Igor *Igor_oo = new Igor;
    Opera_Mercado *opera = new Opera_Mercado;
    FiltroF *filtro_fuzzy = new FiltroF;

    double CEV = Igor_oo.Fuzzy_CEV();

    double FF = filtro_fuzzy.Fuzzy();

    if(CEV > Zwift_limite_superior && O_Stops.Tipo_Posicao() == 0)   opera.AbrePosicao(-1,"Igor_oo: " + DoubleToString(CEV));
    if(CEV < Zwift_limite_inferior && O_Stops.Tipo_Posicao() == 0 && ( FF >= 50 || FF == 0)  )   opera.AbrePosicao(1,"Igor_oo: " + DoubleToString(CEV,3) + "FF: " + DoubleToString(FF,3));
    if(Zwift_sair_indicador && CEV >= 50 && O_Stops.Tipo_Posicao() > 0)        opera.FechaPosicao() ;
    if(Zwift_sair_indicador && CEV <= 50 && O_Stops.Tipo_Posicao() < 0)        opera.FechaPosicao() ;

    delete Igor_oo;
    delete opera;
    delete filtro_fuzzy;
  }

  delete(Condicoes);
}

void Zwift::Timer()
{


}
