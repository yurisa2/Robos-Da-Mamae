/* -*- C++ -*- */

class Zwift
{

  public:
  Zwift();
  ~Zwift();
  void Comentario();
  void Avalia();
  void Timer();
  double Zwift::Filtro();

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

    double CEV = Igor_oo.Fuzzy_CEV();


    if(CEV > Zwift_limite_superior && O_Stops.Tipo_Posicao() == 0)   opera.AbrePosicao(-1,"Igor_oo: " + DoubleToString(CEV));
    if(CEV < Zwift_limite_inferior && O_Stops.Tipo_Posicao() == 0 && (!Zwift_Filtro_Fuzzy || (Zwift_Filtro_Fuzzy && Filtro() > 50)) )   opera.AbrePosicao(1,"Igor_oo: " + DoubleToString(CEV));
    if(Zwift_sair_indicador && CEV >= 50 && O_Stops.Tipo_Posicao() > 0)        opera.FechaPosicao() ;
    if(Zwift_sair_indicador && CEV <= 50 && O_Stops.Tipo_Posicao() < 0)        opera.FechaPosicao() ;

    delete Igor_oo;
    delete opera;

  }

  delete(Condicoes);
}

double Zwift::Filtro()
{
  double retorno = NULL;
  AC *AC_Ind = new AC();
  BB *Banda_BB = new BB(TimeFrame);
  CCI *CCI_Ind = new CCI();

  double AC_v = AC_Ind.Normalizado(0);
  double ACX_v = AC_Ind.Cx(0);
  double BBDB_v = Banda_BB.BB_Delta_Bruto(0);
  double BBDV_v = Banda_BB.Banda_Delta_Valor();
  double CCI_v = CCI_Ind.Valor(0);

  if(AC_v > 1 || AC_v < -1  ) AC_v = 0 ;
  if(ACX_v > 1.57 || ACX_v < -1.57) ACX_v = 0 ;
  if(BBDB_v > 200 || BBDB_v < 0 ) BBDB_v = 0 ;
  if(BBDV_v > 300 || BBDV_v <0 ) BBDV_v = 0 ;
  if(CCI_v > 0 || CCI_v < -1) CCI_v = 0 ;

  //--- Mamdani Fuzzy System
  CMamdaniFuzzySystem *fsFILTRO=new CMamdaniFuzzySystem();
  //--- Create first input variables for the system
  // CFuzzyVariable *fvAC=new CFuzzyVariable("AC",-1,1);
  // fvAC.Terms().Add(new CFuzzyTerm("BOM", new CTriangularMembershipFunction(0.24,0.35,0.46)));
  // fvAC.Terms().Add(new CFuzzyTerm("RUIM", new CTriangularMembershipFunction(0.120,0.240,0.36)));
  // fsFILTRO.Input().Add(fvAC);
  // //--- Create second input variables for the system
  // CFuzzyVariable *fvACX=new CFuzzyVariable("ACX",-1.57,1.57);
  // fvACX.Terms().Add(new CFuzzyTerm("BOM", new CTriangularMembershipFunction(-0.2,-0.108,1)));
  // fvACX.Terms().Add(new CFuzzyTerm("RUIM", new CTriangularMembershipFunction(-0.5,-0.18,-0.1)));
  // fsFILTRO.Input().Add(fvACX);
  //--- Create Output
  CFuzzyVariable *fvBBDB=new CFuzzyVariable("BBDB",0,200);
  fvBBDB.Terms().Add(new CFuzzyTerm("BOM", new CTriangularMembershipFunction(80,90,150)));
  fvBBDB.Terms().Add(new CFuzzyTerm("RUIM", new CTriangularMembershipFunction(20,80,90)));
  fsFILTRO.Input().Add(fvBBDB);
  //--- Create Output
  CFuzzyVariable *fvBBDV=new CFuzzyVariable("BBDV",0,300);
  fvBBDV.Terms().Add(new CFuzzyTerm("BOM", new CTriangularMembershipFunction(154,191,228)));
  fvBBDV.Terms().Add(new CFuzzyTerm("RUIM", new CTriangularMembershipFunction(117,154,191)));
  fsFILTRO.Input().Add(fvBBDV);
  //--- Create Output
  // CFuzzyVariable *fvCCI=new CFuzzyVariable("CCI",-1,0);
  // fvCCI.Terms().Add(new CFuzzyTerm("BOM", new CTriangularMembershipFunction(-0.64,-0.55,-0.3)));
  // fvCCI.Terms().Add(new CFuzzyTerm("RUIM", new CTriangularMembershipFunction(-0.9,-0.64,-0.552)));
  // fsFILTRO.Input().Add(fvCCI);
  //--- Create Output
  CFuzzyVariable *fvFILTRO=new CFuzzyVariable("FILTRO",0,100);
  fvFILTRO.Terms().Add(new CFuzzyTerm("MuitoBaixo", new CTrapezoidMembershipFunction(0,0,10,20)));
  // fvFILTRO.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(10,20,30)));
  // fvFILTRO.Terms().Add(new CFuzzyTerm("Neutro", new CTrapezoidMembershipFunction(20,30,70,80)));
  // fvFILTRO.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(70,80,90)));
  fvFILTRO.Terms().Add(new CFuzzyTerm("MuitoAlto", new CTrapezoidMembershipFunction(80,90,100,100)));
  fsFILTRO.Output().Add(fvFILTRO);
  //--- Create three Mamdani fuzzy rule
  // CMamdaniFuzzyRule *rule1 = fsFILTRO.ParseRule("if (AC is BOM) then FILTRO is MuitoAlto");
  // CMamdaniFuzzyRule *rule2 = fsFILTRO.ParseRule("if (AC is RUIM) then FILTRO is MuitoBaixo");
  // CMamdaniFuzzyRule *rule3 = fsFILTRO.ParseRule("if (ACX is BOM) then FILTRO is MuitoAlto");
  // CMamdaniFuzzyRule *rule4 = fsFILTRO.ParseRule("if (ACX is RUIM) then FILTRO is MuitoBaixo");
  CMamdaniFuzzyRule *rule5 = fsFILTRO.ParseRule("if (BBDB is BOM) then FILTRO is MuitoAlto");
  CMamdaniFuzzyRule *rule6 = fsFILTRO.ParseRule("if (BBDB is RUIM) then FILTRO is MuitoBaixo");
  CMamdaniFuzzyRule *rule7 = fsFILTRO.ParseRule("if (BBDV is BOM) then FILTRO is MuitoAlto");
  CMamdaniFuzzyRule *rule8 = fsFILTRO.ParseRule("if (BBDV is RUIM) then FILTRO is MuitoBaixo");
  // CMamdaniFuzzyRule *rule9 = fsFILTRO.ParseRule("if (CCI is BOM) then FILTRO is MuitoAlto");
  // CMamdaniFuzzyRule *rule10 = fsFILTRO.ParseRule("if (CCI is RUIM) then FILTRO is MuitoBaixo");
  //--- Add three Mamdani fuzzy rule in system
  // fsFILTRO.Rules().Add(rule1);
  // fsFILTRO.Rules().Add(rule2);
  // fsFILTRO.Rules().Add(rule3);
  // fsFILTRO.Rules().Add(rule4);
  fsFILTRO.Rules().Add(rule5);
  fsFILTRO.Rules().Add(rule6);
  fsFILTRO.Rules().Add(rule7);
  fsFILTRO.Rules().Add(rule8);
  // fsFILTRO.Rules().Add(rule9);
  // fsFILTRO.Rules().Add(rule10);
  //--- Set input value
  CList *in=new CList;
  // CDictionary_Obj_Double *p_od_AC = new CDictionary_Obj_Double;
  // CDictionary_Obj_Double *p_od_ACX = new CDictionary_Obj_Double;
  CDictionary_Obj_Double *p_od_BBDB = new CDictionary_Obj_Double;
  CDictionary_Obj_Double *p_od_BBDV = new CDictionary_Obj_Double;
  // CDictionary_Obj_Double *p_od_CCI = new CDictionary_Obj_Double;
  // p_od_AC.SetAll(fvAC, AC_v);
  // p_od_ACX.SetAll(fvACX, ACX_v);
  p_od_BBDB.SetAll(fvBBDB, BBDB_v);
  p_od_BBDV.SetAll(fvBBDV, BBDV_v);
  // p_od_CCI.SetAll(fvCCI, CCI_v);
  // in.Add(p_od_AC);
  // in.Add(p_od_ACX);
  in.Add(p_od_BBDB);
  in.Add(p_od_BBDV);
  // in.Add(p_od_CCI);
  //--- Get result
  CList *result;
  CDictionary_Obj_Double *p_od_Ipsus;
  result = fsFILTRO.Calculate(in);
  p_od_Ipsus = result.GetNodeAtIndex(0);
  //   Print("Ipsus, escala: ",p_od_Ipsus.Value());

  retorno = p_od_Ipsus.Value();

  delete in;
  delete result;
  delete fsFILTRO;

  delete AC_Ind;
  delete Banda_BB;
  delete CCI_Ind;

  return retorno;
}

void Zwift::Timer()
{


}
