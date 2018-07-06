/* -*- C++ -*- */

class Xing_Ind
{
  public:
  Xing_Ind(ENUM_TIMEFRAMES periodo = PERIOD_CURRENT);
  ENUM_TIMEFRAMES Xing_Ind_TF; //TimeFrames especifico do indicador
  double Valor(double XING_RSI = 0, double XING_BBPP = 0, double XING_CX_PRECO = 0);

  private:

};

void Xing_Ind::Xing_Ind(ENUM_TIMEFRAMES periodo = PERIOD_CURRENT)
{
  Xing_Ind_TF = periodo;
}

//Tabela2 - MACD Crisp XING

double Xing_Ind::Valor(double XING_RSI = 0, double XING_BBPP = 0, double XING_CX_PRECO = 0) //Tabela 2 pag 101   |  -2 a 2 (Muito baixo a muito alto)
{
  double retorno = 0;

  // PrintFormat("COMECO de VALOR() %f %f %f",XING_RSI,XING_BBPP,XING_CX_PRECO); //DEBUG

  //--- Mamdani Fuzzy System
  CMamdaniFuzzySystem *fsXING=new CMamdaniFuzzySystem();
  //--- Create first input variables for the system

  // PrintFormat("Antes das fvRSI"); //DEBUG

  CFuzzyVariable *fvRSI=new CFuzzyVariable("RSI",0,100);
  fvRSI.Terms().Add(new CFuzzyTerm("MuitoBaixo", new CTrapezoidMembershipFunction(0,0,10,20)));
  fvRSI.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(10,20,30)));
  fvRSI.Terms().Add(new CFuzzyTerm("Neutro", new CTrapezoidMembershipFunction(20,30,70,80)));
  fvRSI.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(70,80,90)));
  fvRSI.Terms().Add(new CFuzzyTerm("MuitoAlto", new CTrapezoidMembershipFunction(80,90,100,100)));
  fsXING.Input().Add(fvRSI);
  //--- Create second input variables for the system
  // PrintFormat("Antes das fvCXRSI"); //DEBUG


  CFuzzyVariable *fvCXRSI=new CFuzzyVariable("CX_RSI",-1.57,1.57);
  fvCXRSI.Terms().Add(new CFuzzyTerm("MuitoBaixo", new CTrapezoidMembershipFunction(-1.57,-1.570,-0.392,-0.196)));
  fvCXRSI.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(-0.392,-0.196,-0.098)));
  fvCXRSI.Terms().Add(new CFuzzyTerm("Neutro", new CTriangularMembershipFunction(-0.196,0,0.196)));
  fvCXRSI.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(0.098,0.196,0.392)));
  fvCXRSI.Terms().Add(new CFuzzyTerm("MuitoAlto", new CTrapezoidMembershipFunction(0.196,0.392,1.57,1.570)));
  fsXING.Input().Add(fvCXRSI);
  //--- Create Input
  // PrintFormat("Antes das fv_BBPP"); //DEBUG


  CFuzzyVariable *fv_BBPP=new CFuzzyVariable("BBPP",-50,150);
  fv_BBPP.Terms().Add(new CFuzzyTerm("MuitoBaixo", new CTrapezoidMembershipFunction(-50, -50, -30, -10)));
  fv_BBPP.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(-30, -10, 10)));
  fv_BBPP.Terms().Add(new CFuzzyTerm("Neutro", new CTrapezoidMembershipFunction(-10, 10, 90, 110)));
  fv_BBPP.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(90, 110, 130)));
  fv_BBPP.Terms().Add(new CFuzzyTerm("MuitoAlto", new CTrapezoidMembershipFunction(110, 130, 150, 150)));
  fsXING.Input().Add(fv_BBPP);
  //--- Create Output
  // PrintFormat("Antes das OUTPUT"); //DEBUG


  CFuzzyVariable *fvXING=new CFuzzyVariable("XING",0,100);
  fvXING.Terms().Add(new CFuzzyTerm("MuitoBaixo", new CTrapezoidMembershipFunction(0, 0, 10, 20)));
  fvXING.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(10, 20, 30)));
  fvXING.Terms().Add(new CFuzzyTerm("Neutro", new CTrapezoidMembershipFunction(20, 30, 70, 80)));
  fvXING.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(70, 80, 90)));
  fvXING.Terms().Add(new CFuzzyTerm("MuitoAlto", new CTrapezoidMembershipFunction(80, 90, 100, 100)));
  fsXING.Output().Add(fvXING);
  //--- Create three Mamdani fuzzy rule
  // PrintFormat("Antes das Regras PARSE"); //DEBUG

  CMamdaniFuzzyRule *rule1 = fsXING.ParseRule("if (RSI is MuitoBaixo) then XING is MuitoBaixo");
  CMamdaniFuzzyRule *rule2 = fsXING.ParseRule("if (RSI is Baixo) then XING is Baixo");
  CMamdaniFuzzyRule *rule3 = fsXING.ParseRule("if (RSI is Neutro) then XING is Neutro");
  CMamdaniFuzzyRule *rule4 = fsXING.ParseRule("if (RSI is Alto) then XING is Alto");
  CMamdaniFuzzyRule *rule5 = fsXING.ParseRule("if (RSI is MuitoAlto) then XING is MuitoAlto");
  CMamdaniFuzzyRule *rule6 = fsXING.ParseRule("if (CX_RSI is MuitoBaixo) then XING is MuitoAlto");
  CMamdaniFuzzyRule *rule7 = fsXING.ParseRule("if (CX_RSI is Baixo) then XING is Alto");
  CMamdaniFuzzyRule *rule8 = fsXING.ParseRule("if (CX_RSI is Neutro) then XING is Neutro");
  CMamdaniFuzzyRule *rule9 = fsXING.ParseRule("if (CX_RSI is Alto) then XING is Baixo");
  CMamdaniFuzzyRule *rule10 = fsXING.ParseRule("if (CX_RSI is MuitoAlto) then XING is MuitoBaixo");
  CMamdaniFuzzyRule *rule11 = fsXING.ParseRule("if (BBPP is MuitoBaixo) then XING is MuitoBaixo");
  CMamdaniFuzzyRule *rule12 = fsXING.ParseRule("if (BBPP is Baixo) then XING is Baixo");
  CMamdaniFuzzyRule *rule13 = fsXING.ParseRule("if (BBPP is Neutro) then XING is Neutro");
  CMamdaniFuzzyRule *rule14 = fsXING.ParseRule("if (BBPP is Alto) then XING is Alto");
  CMamdaniFuzzyRule *rule15 = fsXING.ParseRule("if (BBPP is MuitoAlto) then XING is MuitoAlto");
  //--- Add three Mamdani fuzzy rule in system
  // PrintFormat("Antes das Regras ADD"); //DEBUG

  fsXING.Rules().Add(rule1);
  fsXING.Rules().Add(rule2);
  fsXING.Rules().Add(rule3);
  fsXING.Rules().Add(rule4);
  fsXING.Rules().Add(rule5);
  fsXING.Rules().Add(rule6);
  fsXING.Rules().Add(rule7);
  fsXING.Rules().Add(rule8);
  fsXING.Rules().Add(rule9);
  fsXING.Rules().Add(rule10);
  fsXING.Rules().Add(rule11);
  fsXING.Rules().Add(rule12);
  fsXING.Rules().Add(rule13);
  fsXING.Rules().Add(rule14);
  fsXING.Rules().Add(rule15);

  // PrintFormat("Antes das in"); //DEBUG

  //--- Set input value
  CList *in=new CList;
  CDictionary_Obj_Double *p_od_RSI = new CDictionary_Obj_Double;
  CDictionary_Obj_Double *p_od_CXRSI = new CDictionary_Obj_Double;
  CDictionary_Obj_Double *p_od_BBPP = new CDictionary_Obj_Double;

  double n_XING_CX_PRECO = n_(XING_CX_PRECO,-1.57,1.57);
  double n_XING_BBPP = n_(XING_BBPP,-50,150);
  double n_XING_RSI = n_(XING_RSI,0,100);

  // PrintFormat("Fim de VALOR() %f %f %f",n_XING_RSI,n_XING_BBPP,n_XING_CX_PRECO); //DEBUG


  p_od_RSI.SetAll(fvRSI, n_XING_RSI);
  p_od_CXRSI.SetAll(fvCXRSI, n_XING_CX_PRECO);
  p_od_BBPP.SetAll(fv_BBPP, n_XING_BBPP);
  in.Add(p_od_RSI);
  in.Add(p_od_CXRSI);
  in.Add(p_od_BBPP);
  //--- Get result
  CList *result;
  CDictionary_Obj_Double *p_od_Ipsus;
  result = fsXING.Calculate(in);
  p_od_Ipsus = result.GetNodeAtIndex(0);
  //   Print("Ipsus, escala: ",p_od_Ipsus.Value());

  retorno = p_od_Ipsus.Value();

  delete in;
  delete result;
  delete fsXING;

  return retorno;
}
