﻿/* -*- C++ -*- */

class Xorg
{

  public:
  Xorg();
  ~Xorg();
  void Comentario();
  void Avalia();
  void Timer();
  double Filtro();
  double Xorg_Ind(double Igor_CEV, double BBPP);


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
    Igor *Igor_oo = new Igor(TimeFrame);
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
    Igor *Igor_oo = new Igor(TimeFrame);
    Opera_Mercado *opera = new Opera_Mercado;
    BB *BB_oo = new BB(TimeFrame);

    double CEV = Igor_oo.Fuzzy_CEV();
    double BBPP = BB_oo.BB_Posicao_Percent();

    double XORG = Xorg_Ind(n_(CEV,0,100),n_(BBPP,-50,150));


    if(XORG > Xorg_inf_compra && XORG < Xorg_sup_compra && O_Stops.Tipo_Posicao() == 0)   opera.AbrePosicao(1,"Igor_oo: " + DoubleToString(XORG));
    if(XORG < Xorg_sup_venda && XORG > Xorg_inf_venda && O_Stops.Tipo_Posicao() == 0)   opera.AbrePosicao(-1,"Igor_oo: " + DoubleToString(XORG));
    if((XORG <= 50 || XORG > Xorg_sup_compra) && O_Stops.Tipo_Posicao() > 0 && Xorg_sair_indicador)        opera.FechaPosicao() ;
    if((XORG >= 50 || XORG < Xorg_inf_venda) && O_Stops.Tipo_Posicao() < 0 && Xorg_sair_indicador)        opera.FechaPosicao() ;

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

double Zumba_Agressao_Igor = 0;
double Zumba_Agressao_BBPP = 0;

double Xorg::Xorg_Ind(double Igor_CEV, double BBPP)
{

  double retorno = 0;
  //--- Mamdani Fuzzy System
  CMamdaniFuzzySystem *fsZumba=new CMamdaniFuzzySystem();
  //--- Create first input variables for the system
  CFuzzyVariable *fvIgor_CEV=new CFuzzyVariable("Igor",0,100);
  fvIgor_CEV.Terms().Add(new CFuzzyTerm("MuitoBaixo", new CTrapezoidMembershipFunction(0.000, 0.000, 10.000-Zumba_Agressao_Igor, 20.000-Zumba_Agressao_Igor)));
  fvIgor_CEV.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(10.000-Zumba_Agressao_Igor, 20.000-Zumba_Agressao_Igor, 30.000-Zumba_Agressao_Igor)));
  fvIgor_CEV.Terms().Add(new CFuzzyTerm("Neutro", new CTrapezoidMembershipFunction(20.000-Zumba_Agressao_Igor, 30.000-Zumba_Agressao_Igor, 70.000+Zumba_Agressao_Igor, 80.000+Zumba_Agressao_Igor)));
  fvIgor_CEV.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(70.000+Zumba_Agressao_Igor, 80.000+Zumba_Agressao_Igor, 90.000+Zumba_Agressao_Igor)));
  fvIgor_CEV.Terms().Add(new CFuzzyTerm("MuitoAlto", new CTrapezoidMembershipFunction(80.000+Zumba_Agressao_Igor, 90.000+Zumba_Agressao_Igor, 100.000, 100.000)));
  fsZumba.Input().Add(fvIgor_CEV);
  //--- Create second input variables for the system
  CFuzzyVariable *fv_BBPP=new CFuzzyVariable("BBPP",-50,150);
  fv_BBPP.Terms().Add(new CFuzzyTerm("MuitoBaixo", new CTrapezoidMembershipFunction(-50.000, -50.000, -30.000-Zumba_Agressao_BBPP, -10.000-Zumba_Agressao_BBPP)));
  fv_BBPP.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(-30.000-Zumba_Agressao_BBPP, -10.000-Zumba_Agressao_BBPP, 10.000-Zumba_Agressao_BBPP)));
  fv_BBPP.Terms().Add(new CFuzzyTerm("Neutro", new CTrapezoidMembershipFunction(-10.000-Zumba_Agressao_BBPP, 10.000-Zumba_Agressao_BBPP, 90.000+Zumba_Agressao_BBPP, 110.000+Zumba_Agressao_BBPP)));
  fv_BBPP.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(90.000+Zumba_Agressao_BBPP, 110.000+Zumba_Agressao_BBPP, 130.000+Zumba_Agressao_BBPP)));
  fv_BBPP.Terms().Add(new CFuzzyTerm("MuitoAlto", new CTrapezoidMembershipFunction(110.000+Zumba_Agressao_BBPP, 130.000+Zumba_Agressao_BBPP, 150.000, 150.000)));
  fsZumba.Input().Add(fv_BBPP);
  //--- Create Output
  CFuzzyVariable *fvHALLEY=new CFuzzyVariable("ZUMBA",0,100);
  fvHALLEY.Terms().Add(new CFuzzyTerm("MuitoBaixo", new CTrapezoidMembershipFunction(0.000, 0.000, 10.000, 20.000)));
  fvHALLEY.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(10.000, 20.000, 30.000)));
  fvHALLEY.Terms().Add(new CFuzzyTerm("Neutro", new CTrapezoidMembershipFunction(20.000, 30.000, 70.000, 80.000)));
  fvHALLEY.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(70.000, 80.000, 90.000)));
  fvHALLEY.Terms().Add(new CFuzzyTerm("MuitoAlto", new CTrapezoidMembershipFunction(80.000, 90.000, 100.000, 100.000)));
  fsZumba.Output().Add(fvHALLEY);
  //--- Create three Mamdani fuzzy rule

  CMamdaniFuzzyRule *rule1 = fsZumba.ParseRule("if (Igor is MuitoBaixo) then ZUMBA is MuitoBaixo");
  CMamdaniFuzzyRule *rule2 = fsZumba.ParseRule("if (Igor is Baixo) then ZUMBA is Baixo");
  CMamdaniFuzzyRule *rule3 = fsZumba.ParseRule("if (Igor is Neutro) then ZUMBA is Neutro");
  CMamdaniFuzzyRule *rule4 = fsZumba.ParseRule("if (Igor is Alto) then ZUMBA is Alto");
  CMamdaniFuzzyRule *rule5 = fsZumba.ParseRule("if (Igor is MuitoAlto) then ZUMBA is MuitoAlto");
  CMamdaniFuzzyRule *rule6 = fsZumba.ParseRule("if (BBPP is MuitoBaixo) then ZUMBA is MuitoBaixo");
  CMamdaniFuzzyRule *rule7 = fsZumba.ParseRule("if (BBPP is Baixo) then ZUMBA is Baixo");
  CMamdaniFuzzyRule *rule8 = fsZumba.ParseRule("if (BBPP is Neutro) then ZUMBA is Neutro");
  CMamdaniFuzzyRule *rule9 = fsZumba.ParseRule("if (BBPP is Alto) then ZUMBA is Alto");
  CMamdaniFuzzyRule *rule10 = fsZumba.ParseRule("if (BBPP is MuitoAlto) then ZUMBA is MuitoAlto");

  //--- Add three Mamdani fuzzy rule in system
  fsZumba.Rules().Add(rule1);
  fsZumba.Rules().Add(rule2);
  fsZumba.Rules().Add(rule3);
  fsZumba.Rules().Add(rule4);
  fsZumba.Rules().Add(rule5);
  fsZumba.Rules().Add(rule6);
  fsZumba.Rules().Add(rule7);
  fsZumba.Rules().Add(rule8);
  fsZumba.Rules().Add(rule9);
  fsZumba.Rules().Add(rule10);

  //--- Set input value
  CList *in=new CList;
  CDictionary_Obj_Double *p_od_IGOR_DEV = new CDictionary_Obj_Double;
  CDictionary_Obj_Double *p_od_BBPP = new CDictionary_Obj_Double;

  p_od_IGOR_DEV.SetAll(fvIgor_CEV,Igor_CEV);
  p_od_BBPP.SetAll(fv_BBPP,BBPP);

  in.Add(p_od_IGOR_DEV);
  in.Add(p_od_BBPP);

  //--- Get result
  CList *result;
  CDictionary_Obj_Double *p_od_Ipsus;
  result = fsZumba.Calculate(in);
  p_od_Ipsus = result.GetNodeAtIndex(0);
  //   Print("Ipsus, escala: ",p_od_Ipsus.Value());

  retorno = p_od_Ipsus.Value();

  delete in;
  delete result;
  delete fsZumba;

  return retorno;
}
