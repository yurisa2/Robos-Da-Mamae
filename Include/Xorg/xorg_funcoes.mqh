/* -*- C++ -*- */

class Xorg
{

  public:
  Xorg();
  ~Xorg();
  void Comentario();
  void Avalia();
  void Timer();
  double Xorg::Filtro();

  private:

};

void Xorg::Xorg()
{
}

void Xorg::~Xorg()
{
}

void Xorg::Comentario()
{
  if(Tipo_Comentario > 0)
  {
    Igor *Igor_oo = new Igor;
    BB *BB_oo = new BB;

    if(!Otimizacao) Comentario_Robo = " Igor CEV: " + DoubleToString(Igor_oo.Fuzzy_CEV()) ;
    if(!Otimizacao) Comentario_Robo += "\n BB_Posicao_Percent: " + DoubleToString(BB_oo.BB_Posicao_Percent ()) ;


    delete BB_oo;
    delete Igor_oo;
  }
}

void Xorg::Avalia()
{

  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  if(Condicoes.Horario())
  {
    Igor *Igor_oo = new Igor;
    Opera_Mercado *opera = new Opera_Mercado;

    double CEV = Igor_oo.Fuzzy_CEV();

    if(CEV > Xorg_inf_compra && CEV < Xorg_sup_compra && O_Stops.Tipo_Posicao() == 0)   opera.AbrePosicao(1,"Igor_oo: " + DoubleToString(CEV));
    if(CEV < Xorg_sup_venda && CEV > Xorg_inf_venda && O_Stops.Tipo_Posicao() == 0)   opera.AbrePosicao(-1,"Igor_oo: " + DoubleToString(CEV));
    if((CEV <= 50 || CEV > Xorg_sup_compra) && O_Stops.Tipo_Posicao() > 0 && Xorg_sair_indicador)        opera.FechaPosicao() ;
    if((CEV >= 50 || CEV < Xorg_inf_venda) && O_Stops.Tipo_Posicao() < 0 && Xorg_sair_indicador)        opera.FechaPosicao() ;

    delete Igor_oo;
    delete opera;

  }

  delete(Condicoes);
}

double Xorg::Filtro()
{
return 0;
}

void Xorg::Timer()
{


}
