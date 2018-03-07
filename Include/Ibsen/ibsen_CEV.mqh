/* -*- C++ -*- */


double Ibsen::Fuzzy_Sinal() //Tabela 4 pag 103   |  -2 a 2 (Muito baixo a muito alto)
{
  double retorno = 0;

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
     CFuzzyVariable *fvVolume=new CFuzzyVariable("Volume",-1.57,1.57);
     fvVolume.Terms().Add(new CFuzzyTerm("MuitoBaixo", new CTrapezoidMembershipFunction(-1.57,-1.570,-0.392,-0.196)));
     fvVolume.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(-0.392,-0.196,-0.098)));
     fvVolume.Terms().Add(new CFuzzyTerm("Neutro", new CTriangularMembershipFunction(-0.196,0,0.196)));
     fvVolume.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(0.098,0.196,0.392)));
     fvVolume.Terms().Add(new CFuzzyTerm("MuitoAlto", new CTrapezoidMembershipFunction(0.196,0.392,1.57,1.570)));
     fsSinal.Input().Add(fvVolume);
  //--- Create Output
     CFuzzyVariable *fvSINAL=new CFuzzyVariable("SINAL",-1.57,1.57);
     fvSINAL.Terms().Add(new CFuzzyTerm("MuitoBaixo", new CTrapezoidMembershipFunction(0,0,10,20)));
     fvSINAL.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(10,20,30)));
     fvSINAL.Terms().Add(new CFuzzyTerm("Neutro", new CTrapezoidMembershipFunction(20,30,70,80)));
     fvSINAL.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(70,80,90)));
     fvSINAL.Terms().Add(new CFuzzyTerm("MuitoAlto", new CTrapezoidMembershipFunction(80,90,100,100)));
     fsSinal.Output().Add(fvSINAL);
  //--- Create three Mamdani fuzzy rule
     CMamdaniFuzzyRule *rule1 = fsSinal.ParseRule("if (distancia is Zero) and (Volume is Alto) then HIST is MuitoAlto");
     CMamdaniFuzzyRule *rule2 = fsSinal.ParseRule("if (distancia is Zero) and (Volume is Baixo) then HIST is MuitoBaixo");
     CMamdaniFuzzyRule *rule3 = fsSinal.ParseRule("if (Volume is Alto) then HIST is Alto");
     CMamdaniFuzzyRule *rule4 = fsSinal.ParseRule("if (Volume is MuitoAlto) then HIST is MuitoAlto");
     CMamdaniFuzzyRule *rule5 = fsSinal.ParseRule("if (Volume is Baixo) then HIST is Baixo");
     CMamdaniFuzzyRule *rule6 = fsSinal.ParseRule("if (Volume is MuitoBaixo) then HIST is MuitoBaixo");
     CMamdaniFuzzyRule *rule7 = fsSinal.ParseRule("if (Volume is Neutro) then HIST is Neutro");
  //--- Add three Mamdani fuzzy rule in system
     fsSinal.Rules().Add(rule1);
     fsSinal.Rules().Add(rule2);
     fsSinal.Rules().Add(rule3);
     fsSinal.Rules().Add(rule4);
     fsSinal.Rules().Add(rule5);
     fsSinal.Rules().Add(rule6);
     fsSinal.Rules().Add(rule7);
  //--- Set input value
     CList *in=new CList;
     CDictionary_Obj_Double *p_od_Hist = new CDictionary_Obj_Double;
     CDictionary_Obj_Double *p_od_Volume = new CDictionary_Obj_Double;
     p_od_Hist.SetAll(fvHIST, Fuzzy_HIST(distancia,alpha));
     // p_od_Volume.SetAll(fvVolume, HIST_Volume);   //DESCOMENTAR COM URGENCIA
     in.Add(p_od_Hist);
     in.Add(p_od_Volume);
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

return retorno;
}
