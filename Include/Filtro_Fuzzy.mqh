/* -*- C++ -*- */


class FiltroF
{
  public:
  FiltroF() {};
  ~FiltroF() {};
  double Fuzzy();
  void Aquisicao();

  struct Matrix_Fuzzy
  {
    double a1Neutro;
    double b1Neutro;
    double c1Neutro;
    double d1Neutro;
    double a2Neutro;
    double b2Neutro;
    double c2Neutro;
    double d2Neutro;
    double aRuim;
    double bRuim;
    double cRuim;
    double aMuitoRuim;
    double bMuitoRuim;
    double cMuitoRuim;
    double aMuitoBom;
    double bMuitoBom;
    double cMuitoBom;
    double aBom;
    double bBom;
    double cBom;
  };

  // Matrix_Fuzzy muz;
  Matrix_Fuzzy Calculator(double Bom, double Ruim);

  private:

};

double FiltroF::Fuzzy()
{
  Aquisicao *ind = new Aquisicao;

  double retorno = 0;
  //--- Set input value
  CList *in=new CList;
  CMamdaniFuzzySystem *fsFILTRO=new CMamdaniFuzzySystem();
  //--- Create Output
  CFuzzyVariable *fvFILTRO=new CFuzzyVariable("FILTRO",0,100);
  fvFILTRO.Terms().Add(new CFuzzyTerm("MuitoRuim", new CTrapezoidMembershipFunction(0,0,10,20)));
  fvFILTRO.Terms().Add(new CFuzzyTerm("Ruim", new CTriangularMembershipFunction(10,20,30)));
  fvFILTRO.Terms().Add(new CFuzzyTerm("Neutro", new CTrapezoidMembershipFunction(20,30,70,80)));
  fvFILTRO.Terms().Add(new CFuzzyTerm("Bom", new CTriangularMembershipFunction(70,80,90)));
  fvFILTRO.Terms().Add(new CFuzzyTerm("MuitoBom", new CTrapezoidMembershipFunction(80,90,100,100)));
  fsFILTRO.Output().Add(fvFILTRO);

//Mano, sistema fuzzy automático e serial...CARALHO

//ESQUEMA AQUI VAI SER CRIAR UMA FUNCAO QUE PEGUE OS DADOS DO ARQUIVO USANDO
//O OBJETO FILEREADER, DESMONTE CADA STRING E RETORNE o nome, bom, ruim ...  Var_Input a gente pega do aquisicao
//Monta um while baseado na funcao


{
  string VAR = "Variavel";
  double Var_Input = 10;
  double bom = 90;
  double ruim = 10;

  Matrix_Fuzzy matriz;
  matriz = Calculator(bom,ruim);

  CFuzzyVariable *fvVAR=new CFuzzyVariable(VAR,matriz.a1Neutro,matriz.d2Neutro);
  fvVAR.Terms().Add(new CFuzzyTerm("NeutroA", new CTrapezoidMembershipFunction(matriz.a1Neutro,matriz.b1Neutro,matriz.c1Neutro,matriz.d1Neutro)));
  fvVAR.Terms().Add(new CFuzzyTerm("MuitoRuim", new CTriangularMembershipFunction(matriz.aMuitoRuim,matriz.bMuitoRuim,matriz.cMuitoRuim)));
  fvVAR.Terms().Add(new CFuzzyTerm("Ruim", new CTriangularMembershipFunction(matriz.aRuim,matriz.bRuim,matriz.cRuim)));
  fvVAR.Terms().Add(new CFuzzyTerm("Bom", new CTriangularMembershipFunction(matriz.aBom,matriz.bBom,matriz.cBom)));
  fvVAR.Terms().Add(new CFuzzyTerm("MuitoBom", new CTriangularMembershipFunction(matriz.aMuitoBom,matriz.bMuitoBom,matriz.cMuitoBom)));
  fvVAR.Terms().Add(new CFuzzyTerm("NeutroB", new CTrapezoidMembershipFunction(matriz.a2Neutro,matriz.b2Neutro,matriz.c2Neutro,matriz.d2Neutro)));
  fsFILTRO.Input().Add(fvVAR);
  CMamdaniFuzzyRule *Ac_Neutro1 = fsFILTRO.ParseRule("if ("+ VAR +" is NeutroA) then FILTRO is Neutro");
  CMamdaniFuzzyRule *Ac_MuitoRuim = fsFILTRO.ParseRule("if ("+ VAR +" is MuitoRuim) then FILTRO is MuitoRuim");
  CMamdaniFuzzyRule *Ac_Ruim = fsFILTRO.ParseRule("if ("+ VAR +" is Ruim) then FILTRO is Ruim");
  CMamdaniFuzzyRule *Ac_Bom = fsFILTRO.ParseRule("if ("+ VAR +" is Bom) then FILTRO is Bom");
  CMamdaniFuzzyRule *Ac_MuitoBom = fsFILTRO.ParseRule("if ("+ VAR +" is MuitoBom) then FILTRO is MuitoBom");
  CMamdaniFuzzyRule *Ac_Neutro2 = fsFILTRO.ParseRule("if ("+ VAR +" is NeutroB) then FILTRO is Neutro");
  fsFILTRO.Rules().Add(Ac_Neutro1);
  fsFILTRO.Rules().Add(Ac_MuitoRuim);
  fsFILTRO.Rules().Add(Ac_Ruim);
  fsFILTRO.Rules().Add(Ac_Bom);
  fsFILTRO.Rules().Add(Ac_MuitoBom);
  fsFILTRO.Rules().Add(Ac_Neutro2);
  CDictionary_Obj_Double *p_od_AC_Ind=new CDictionary_Obj_Double;
  in.Add(p_od_AC_Ind);
  p_od_AC_Ind.SetAll(fvVAR, Var_Input);
}
  //--- Get result
  CList *result;
  CDictionary_Obj_Double *p_od_Ipsus;
  result=fsFILTRO.Calculate(in);
  p_od_Ipsus=result.GetNodeAtIndex(0);
  //   Print("Ipsus, escala: ",p_od_Ipsus.Value());

  retorno = p_od_Ipsus.Value();

  delete in;
  delete result;
  delete fsFILTRO;

  delete ind;

  return retorno;
}


Matrix_Fuzzy FiltroF::Calculator(double Bom, double Ruim)
{
  Matrix_Fuzzy muz = {0};
  double Diff = Bom - Ruim;

  double Ia = Ruim - (1000*Diff);
  double Ib = Ruim - (1000*Diff);
  double Ic = Ruim - Diff - Diff;
  double Id = Ruim - Diff;
  double Ja = Ruim - Diff - Diff;
  double Jb = Ruim - Diff;
  double Jc = Ruim;
  double Ka = Ruim - Diff;
  double Kb = Ruim;
  double Kc = Ruim + Diff;
  double La = Bom - Diff;
  double Lb = Bom;
  double Lc = Bom + Diff;
  double Ma = Bom;
  double Mb = Bom + Diff;
  double Mc = Bom + Diff + Diff;
  double Na = Bom + Diff;
  double Nb = Bom + Diff + Diff;
  double Nc = Bom + (1000*Diff);
  double Nd = Bom + (1000*Diff);

  if(Diff > 0)
  {
    muz.a1Neutro = Ia;
    muz.b1Neutro = Ib;
    muz.c1Neutro = Ic;
    muz.d1Neutro = Id;
    muz.aRuim = Ja;
    muz.bRuim = Jb;
    muz.cRuim = Jc;
    muz.aMuitoRuim = Ka;
    muz.bMuitoRuim = Kb;
    muz.cMuitoRuim = Kc;
    muz.aMuitoBom = La;
    muz.bMuitoBom = Lb;
    muz.cMuitoBom = Lc;
    muz.aBom = Ma;
    muz.bBom = Mb;
    muz.cBom = Mc;
    muz.a2Neutro = Na;
    muz.b2Neutro = Nb;
    muz.c2Neutro = Nc;
    muz.d2Neutro = Nd;
  }
  if(Diff < 0)
  {
    muz.a1Neutro = Nd;
    muz.b1Neutro = Nc;
    muz.c1Neutro = Nb;
    muz.d1Neutro = Na;
    muz.aRuim = Jc;
    muz.bRuim = Jb;
    muz.cRuim = Ja;
    muz.aMuitoRuim = Kc;
    muz.bMuitoRuim = Kb;
    muz.cMuitoRuim = Ka;
    muz.aMuitoBom = Lc;
    muz.bMuitoBom = Lb;
    muz.cMuitoBom = La;
    muz.aBom = Mc;
    muz.bBom = Mb;
    muz.cBom = Ma;
    muz.a2Neutro = Id;
    muz.b2Neutro = Ic;
    muz.c2Neutro = Ib;
    muz.d2Neutro = Ia;
  }

  return muz;
}
