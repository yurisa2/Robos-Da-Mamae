/* -*- C++ -*- */


double Ibsen::Fuzzy_Sinal() //Tabela 4 pag 103   |  -2 a 2 (Muito baixo a muito alto)
{
  double retorno = 0;
  MACD *MACD_oo = new MACD;



  //--- Mamdani Fuzzy System
     CMamdaniFuzzySystem *fsSinal=new CMamdaniFuzzySystem();
  //--- Create first input variables for the system
  CFuzzyVariable *fvHIST=new CFuzzyVariable("HIST",-1.57,1.57);
  fvHIST.Terms().Add(new CFuzzyTerm("MuitoBaixo", new CTrapezoidMembershipFunction(-1.57,-1.570,-0.392,-0.196)));
  fvHIST.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(-0.392,-0.196,-0.098)));
  fvHIST.Terms().Add(new CFuzzyTerm("Neutro", new CTriangularMembershipFunction(-0.196,0,0.196)));
  fvHIST.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(0.098,0.196,0.392)));
  fvHIST.Terms().Add(new CFuzzyTerm("MuitoAlto", new CTrapezoidMembershipFunction(0.196,0.392,1.57,1.570)));
  fsSinal.Input().Add(fvHIST);
  //--- Create second input variables for the system
  CFuzzyVariable *fvMACD=new CFuzzyVariable("MACD",-2,2);
  fvMACD.Terms().Add(new CFuzzyTerm("MuitoBaixo", new CTriangularMembershipFunction(-2,-2,-1)));
  fvMACD.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(-2,-1,0)));
  fvMACD.Terms().Add(new CFuzzyTerm("Neutro", new CTriangularMembershipFunction(-1,0,1)));
  fvMACD.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(0,1,2)));
  fvMACD.Terms().Add(new CFuzzyTerm("MuitoAlto", new CTriangularMembershipFunction(1,2,2)));
  fsSinal.Input().Add(fvMACD);

  //--- Create Output
     CFuzzyVariable *fvSINAL=new CFuzzyVariable("SINAL",0,100);
     fvSINAL.Terms().Add(new CFuzzyTerm("MuitoBaixo", new CTrapezoidMembershipFunction(0,0,10,20)));
     fvSINAL.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(10,20,30)));
     fvSINAL.Terms().Add(new CFuzzyTerm("Neutro", new CTrapezoidMembershipFunction(20,30,70,80)));
     fvSINAL.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(70,80,90)));
     fvSINAL.Terms().Add(new CFuzzyTerm("MuitoAlto", new CTrapezoidMembershipFunction(80,90,100,100)));
     fsSinal.Output().Add(fvSINAL);
  //--- Create three Mamdani fuzzy rule
     CMamdaniFuzzyRule *rule1 = fsSinal.ParseRule("if MACD is MuitoAlto and HIST is MuitoAlto then SINAL is MuitoAlto");
     CMamdaniFuzzyRule *rule1b = fsSinal.ParseRule("if MACD is Alto and HIST is MuitoAlto then SINAL is MuitoAlto");
     CMamdaniFuzzyRule *rule2 = fsSinal.ParseRule("if MACD is MuitoAlto and HIST is MuitoAlto then SINAL is MuitoAlto");
     CMamdaniFuzzyRule *rule2b = fsSinal.ParseRule("if MACD is MuitoAlto and HIST is Alto then SINAL is MuitoAlto");
     CMamdaniFuzzyRule *rule3 = fsSinal.ParseRule("if MACD is Alto and HIST is Alto then SINAL is Alto");
     CMamdaniFuzzyRule *rule4 = fsSinal.ParseRule("if MACD is MuitoAlto and HIST is Baixo then SINAL is Neutro");
     CMamdaniFuzzyRule *rule4a = fsSinal.ParseRule("if MACD is Alto and HIST is Baixo then SINAL is Neutro");
     CMamdaniFuzzyRule *rule4b = fsSinal.ParseRule("if MACD is MuitoAlto and HIST is MuitoBaixo then SINAL is Neutro");
     CMamdaniFuzzyRule *rule4c = fsSinal.ParseRule("if MACD is Alto and HIST is MuitoBaixo then SINAL is Neutro");
     CMamdaniFuzzyRule *rule5 = fsSinal.ParseRule("if MACD is Neutro and HIST is Neutro then SINAL is Neutro");
     CMamdaniFuzzyRule *rule6 = fsSinal.ParseRule("if MACD is MuitoAlto and HIST is Neutro then SINAL is Alto");
     CMamdaniFuzzyRule *rule6b = fsSinal.ParseRule("if MACD is Alto and HIST is Neutro then SINAL is Alto");
     CMamdaniFuzzyRule *rule7 = fsSinal.ParseRule("if MACD is MuitoBaixo and HIST is Neutro then SINAL is Baixo");
     CMamdaniFuzzyRule *rule7b = fsSinal.ParseRule("if MACD is Baixo and HIST is Neutro then SINAL is Baixo");
     CMamdaniFuzzyRule *rule8 = fsSinal.ParseRule("if MACD is Neutro and HIST is MuitoAlto then SINAL is Alto");
     CMamdaniFuzzyRule *rule8b = fsSinal.ParseRule("if MACD is Neutro and HIST is Alto then SINAL is Alto");
     CMamdaniFuzzyRule *rule9 = fsSinal.ParseRule("if MACD is Neutro and HIST is MuitoBaixo then SINAL is Baixo");
     CMamdaniFuzzyRule *rule9b = fsSinal.ParseRule("if MACD is Neutro and HIST is Baixo then SINAL is Baixo");
     CMamdaniFuzzyRule *rule10 = fsSinal.ParseRule("if MACD is MuitoBaixo and HIST is MuitoAlto then SINAL is Neutro");
     CMamdaniFuzzyRule *rule10b = fsSinal.ParseRule("if MACD is MuitoBaixo and HIST is Alto then SINAL is Neutro");
     CMamdaniFuzzyRule *rule10c = fsSinal.ParseRule("if MACD is Baixo and HIST is MuitoAlto then SINAL is Neutro");
     CMamdaniFuzzyRule *rule10d = fsSinal.ParseRule("if MACD is Baixo and HIST is Alto then SINAL is Neutro");
     CMamdaniFuzzyRule *rule11 = fsSinal.ParseRule("if MACD is Baixo and HIST is Baixo then SINAL is Baixo");
     CMamdaniFuzzyRule *rule12 = fsSinal.ParseRule("if MACD is MuitoBaixo and HIST is MuitoBaixo then SINAL is MuitoBaixo");
     CMamdaniFuzzyRule *rule12b = fsSinal.ParseRule("if MACD is Baixo and HIST is MuitoBaixo then SINAL is MuitoBaixo");
     CMamdaniFuzzyRule *rule13 = fsSinal.ParseRule("if MACD is MuitoBaixo and HIST is MuitoBaixo then SINAL is MuitoBaixo");
     CMamdaniFuzzyRule *rule13b = fsSinal.ParseRule("if MACD is MuitoBaixo and HIST is Baixo then SINAL is MuitoBaixo");
  //--- Add three Mamdani fuzzy rule in system
     fsSinal.Rules().Add(rule1);
     fsSinal.Rules().Add(rule1b);
     fsSinal.Rules().Add(rule2);
     fsSinal.Rules().Add(rule2b);
     fsSinal.Rules().Add(rule3);
     fsSinal.Rules().Add(rule4);
     fsSinal.Rules().Add(rule4a);
     fsSinal.Rules().Add(rule4b);
     fsSinal.Rules().Add(rule4c);
     fsSinal.Rules().Add(rule5);
     fsSinal.Rules().Add(rule6);
     fsSinal.Rules().Add(rule6b);
     fsSinal.Rules().Add(rule7);
     fsSinal.Rules().Add(rule7b);
     fsSinal.Rules().Add(rule8);
     fsSinal.Rules().Add(rule8b);
     fsSinal.Rules().Add(rule9);
     fsSinal.Rules().Add(rule9b);
     fsSinal.Rules().Add(rule10);
     fsSinal.Rules().Add(rule10b);
     fsSinal.Rules().Add(rule10c);
     fsSinal.Rules().Add(rule10d);
     fsSinal.Rules().Add(rule11);
     fsSinal.Rules().Add(rule12);
     fsSinal.Rules().Add(rule12b);
     fsSinal.Rules().Add(rule13);
     fsSinal.Rules().Add(rule13b);
  //--- Set input value

  double Entrada_fvHIST = NULL;
    double Entrada_fvMACD = NULL;

    Entrada_fvHIST = Fuzzy_HIST(MACD_oo.Distancia_Linha_Zero(),MACD_oo.Cx(0));
    Entrada_fvMACD = Crisp_MACD();

    Entrada_fvMACD_M = Entrada_fvMACD;
    Entrada_fvHIST_M = Entrada_fvHIST;

     CList *in=new CList;
     CDictionary_Obj_Double *p_od_Hist = new CDictionary_Obj_Double;
     CDictionary_Obj_Double *p_od_MACD = new CDictionary_Obj_Double;
     p_od_Hist.SetAll(fvHIST, Entrada_fvHIST);
     p_od_MACD.SetAll(fvMACD, Entrada_fvMACD);   //DESCOMENTAR COM URGENCIA
     in.Add(p_od_Hist);
     in.Add(p_od_MACD);
  //--- Get result
     CList *result;
     CDictionary_Obj_Double *p_od_Ipsus;
     result = fsSinal.Calculate(in);
     p_od_Ipsus = result.GetNodeAtIndex(0);
  //   Print("Ipsus, escala: ",p_od_Ipsus.Value());

  retorno = p_od_Ipsus.Value();

  delete in;
  delete result;
  delete fsSinal;

  delete MACD_oo;

return retorno;
}
