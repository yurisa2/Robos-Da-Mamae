/* -*- C++ -*- */

//Tabela3 - MOMENTO Pag 103

double Ibsen::Fuzzy_Momento() //Tabela 3 pag 103   |  -2 a 2 (Muito baixo a muito alto)
{
  double retorno = 0;

  //--- Mamdani Fuzzy System
     CMamdaniFuzzySystem *fsMomento=new CMamdaniFuzzySystem();
  //--- Create first input variables for the system
  CFuzzyVariable *fvIFR=new CFuzzyVariable("IFR",0,100);
  fvIFR.Terms().Add(new CFuzzyTerm("MuitoBaixo", new CTrapezoidMembershipFunction(0,0,20,25)));
  fvIFR.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(20,25,30)));
  fvIFR.Terms().Add(new CFuzzyTerm("Neutro", new CTrapezoidMembershipFunction(25,30,70,75)));
  fvIFR.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(70,75,80)));
  fvIFR.Terms().Add(new CFuzzyTerm("MuitoAlto", new CTrapezoidMembershipFunction(75,80,100,100)));
  fsMomento.Input().Add(fvIFR);
  //--- Create second input variables for the system
  CFuzzyVariable *fvEST=new CFuzzyVariable("EST",0,100);
  fvEST.Terms().Add(new CFuzzyTerm("MuitoBaixo", new CTrapezoidMembershipFunction(0,0,20,25)));
  fvEST.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(20,25,30)));
  fvEST.Terms().Add(new CFuzzyTerm("Neutro", new CTrapezoidMembershipFunction(25,30,70,75)));
  fvEST.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(70,75,80)));
  fvEST.Terms().Add(new CFuzzyTerm("MuitoAlto", new CTrapezoidMembershipFunction(75,80,100,100)));
  fsMomento.Input().Add(fvEST);
  //--- Create Output
     CFuzzyVariable *fvMOMENTO=new CFuzzyVariable("MOMENTO",0,100);
     fvMOMENTO.Terms().Add(new CFuzzyTerm("MuitoBaixo", new CTrapezoidMembershipFunction(0,0,10,20)));
     fvMOMENTO.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(10,20,30)));
     fvMOMENTO.Terms().Add(new CFuzzyTerm("Neutro", new CTrapezoidMembershipFunction(20,30,70,80)));
     fvMOMENTO.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(70,80,90)));
     fvMOMENTO.Terms().Add(new CFuzzyTerm("MuitoAlto", new CTrapezoidMembershipFunction(80,90,100,100)));
     fsMomento.Output().Add(fvMOMENTO);
  //--- Create three Mamdani fuzzy rule
     CMamdaniFuzzyRule *rule1 = fsMomento.ParseRule("if IFR is Alto and EST is MuitoAlto then MOMENTO is MuitoAlto");
     CMamdaniFuzzyRule *rule1b = fsMomento.ParseRule("if IFR is MuitoAlto and EST is MuitoAlto then MOMENTO is MuitoAlto");
     CMamdaniFuzzyRule *rule2 = fsMomento.ParseRule("if IFR is MuitoAlto and EST is MuitoAlto then MOMENTO is MuitoAlto");
     CMamdaniFuzzyRule *rule2b = fsMomento.ParseRule("if IFR is MuitoAlto and EST is Alto then MOMENTO is MuitoAlto");
     CMamdaniFuzzyRule *rule3 = fsMomento.ParseRule("if IFR is Alto and EST is Alto then MOMENTO is Alto");
     CMamdaniFuzzyRule *rule4 = fsMomento.ParseRule("if IFR is Neutro and EST is MuitoAlto then MOMENTO is Alto");
     CMamdaniFuzzyRule *rule5 = fsMomento.ParseRule("if IFR is MuitoAlto and EST is Neutro then MOMENTO is Alto");
     CMamdaniFuzzyRule *rule6 = fsMomento.ParseRule("if IFR is Neutro and EST is Alto then MOMENTO is Neutro");
     CMamdaniFuzzyRule *rule6b = fsMomento.ParseRule("if IFR is Neutro and EST is Baixo then MOMENTO is Neutro");
     CMamdaniFuzzyRule *rule6c = fsMomento.ParseRule("if IFR is Neutro and EST is Neutro then MOMENTO is Neutro");
     CMamdaniFuzzyRule *rule7 = fsMomento.ParseRule("if IFR is MuitoAlto and EST is Baixo then MOMENTO is Neutro");
     CMamdaniFuzzyRule *rule7b = fsMomento.ParseRule("if IFR is MuitoAlto and EST is MuitoBaixo then MOMENTO is Neutro");
     CMamdaniFuzzyRule *rule7c = fsMomento.ParseRule("if IFR is Alto and EST is Baixo then MOMENTO is Neutro");
     CMamdaniFuzzyRule *rule7d = fsMomento.ParseRule("if IFR is Alto and EST is MuitoBaixo then MOMENTO is Neutro");
     CMamdaniFuzzyRule *rule8 = fsMomento.ParseRule("if IFR is Alto and EST is Neutro then MOMENTO is Neutro");
     CMamdaniFuzzyRule *rule8b = fsMomento.ParseRule("if IFR is Neutro and EST is Neutro then MOMENTO is Neutro");
     CMamdaniFuzzyRule *rule8c = fsMomento.ParseRule("if IFR is Baixo and EST is Neutro then MOMENTO is Neutro");
     CMamdaniFuzzyRule *rule9 = fsMomento.ParseRule("if IFR is Baixo and EST is Alto then MOMENTO is Neutro");
     CMamdaniFuzzyRule *rule9a = fsMomento.ParseRule("if IFR is MuitoBaixo and EST is MuitoAlto then MOMENTO is Neutro");
     CMamdaniFuzzyRule *rule9b = fsMomento.ParseRule("if IFR is Alto and EST is Baixo then MOMENTO is Neutro");
     CMamdaniFuzzyRule *rule9c = fsMomento.ParseRule("if IFR is MuitoBaixo and EST is Alto then MOMENTO is Neutro");
     CMamdaniFuzzyRule *rule10 = fsMomento.ParseRule("if IFR is Neutro and EST is MuitoBaixo then MOMENTO is Baixo");
     CMamdaniFuzzyRule *rule11 = fsMomento.ParseRule("if IFR is MuitoBaixo and EST is Neutro then MOMENTO is Baixo");
     CMamdaniFuzzyRule *rule12 = fsMomento.ParseRule("if IFR is Baixo and EST is Baixo then MOMENTO is Baixo");
     CMamdaniFuzzyRule *rule13 = fsMomento.ParseRule("if IFR is Baixo and EST is MuitoBaixo then MOMENTO is MuitoBaixo");
     CMamdaniFuzzyRule *rule13b = fsMomento.ParseRule("if IFR is MuitoBaixo and EST is MuitoBaixo then MOMENTO is MuitoBaixo");
     CMamdaniFuzzyRule *rule14 = fsMomento.ParseRule("if IFR is MuitoBaixo and EST is MuitoBaixo then MOMENTO is MuitoBaixo");
     CMamdaniFuzzyRule *rule14b = fsMomento.ParseRule("if IFR is MuitoBaixo and EST is Baixo then MOMENTO is MuitoBaixo");
//Revisar todas as regras 2x2 DEBUG
  //--- Add three Mamdani fuzzy rule in system
     fsMomento.Rules().Add(rule1);
     fsMomento.Rules().Add(rule1b);
     fsMomento.Rules().Add(rule2);
     fsMomento.Rules().Add(rule2b);
     fsMomento.Rules().Add(rule3);
     fsMomento.Rules().Add(rule4);
     fsMomento.Rules().Add(rule5);
     fsMomento.Rules().Add(rule6);
     fsMomento.Rules().Add(rule6b);
     fsMomento.Rules().Add(rule6c);
     fsMomento.Rules().Add(rule7);
     fsMomento.Rules().Add(rule7b);
     fsMomento.Rules().Add(rule7c);
     fsMomento.Rules().Add(rule7d);
     fsMomento.Rules().Add(rule8);
     fsMomento.Rules().Add(rule8b);
     fsMomento.Rules().Add(rule8c);
     fsMomento.Rules().Add(rule9);
     fsMomento.Rules().Add(rule9a);
     fsMomento.Rules().Add(rule9b);
     fsMomento.Rules().Add(rule9c);
     fsMomento.Rules().Add(rule10);
     fsMomento.Rules().Add(rule11);
     fsMomento.Rules().Add(rule12);
     fsMomento.Rules().Add(rule13);
     fsMomento.Rules().Add(rule13b);
     fsMomento.Rules().Add(rule14);
     fsMomento.Rules().Add(rule14b);
  //--- Set input value

  RSI *IFR = new RSI;
  Stoch *EST = new Stoch;

     CList *in=new CList;
     CDictionary_Obj_Double *p_od_IFR = new CDictionary_Obj_Double;
     CDictionary_Obj_Double *p_od_EST = new CDictionary_Obj_Double;
     p_od_IFR.SetAll(fvIFR, IFR.Valor());
     p_od_EST.SetAll(fvEST, EST.Valor());
     in.Add(p_od_IFR);
     in.Add(p_od_EST);
  //--- Get result
     CList *result;
     CDictionary_Obj_Double *p_od_Ipsus;
     result = fsMomento.Calculate(in);
     p_od_Ipsus = result.GetNodeAtIndex(0);
  //   Print("Ipsus, escala: ",p_od_Ipsus.Value());

    retorno = p_od_Ipsus.Value();

  delete IFR;
  delete EST;

  delete in;
  delete result;
  delete fsMomento;

return retorno;
}
