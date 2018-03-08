/* -*- C++ -*- */


double Ibsen::Fuzzy_CEV() //Tabela 4 pag 103   |  -2 a 2 (Muito baixo a muito alto)
{
  double retorno = 0;
  double input_momento = 0;
  double input_volume = 0;
  double input_sinal = 0;

  OBV *OBV_oo = new OBV;

  input_momento = Fuzzy_Momento();
  input_volume = OBV_oo.Cx();
  input_sinal = Fuzzy_Sinal();


  delete OBV_oo;
  //--- Mamdani Fuzzy System
  CMamdaniFuzzySystem *fsCEV=new CMamdaniFuzzySystem();

  CList *in=new CList;



  //--- Create first input variables for the system
  CFuzzyVariable *fvMOMENTO=new CFuzzyVariable("MOMENTO",0,100);
  fvMOMENTO.Terms().Add(new CFuzzyTerm("MuitoBaixo", new CTrapezoidMembershipFunction(0,0,10,20)));
  fvMOMENTO.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(10,20,30)));
  fvMOMENTO.Terms().Add(new CFuzzyTerm("Neutro", new CTrapezoidMembershipFunction(20,30,70,80)));
  fvMOMENTO.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(70,80,90)));
  fvMOMENTO.Terms().Add(new CFuzzyTerm("MuitoAlto", new CTrapezoidMembershipFunction(80,90,100,100)));
  fsCEV.Input().Add(fvMOMENTO);

  CDictionary_Obj_Double *p_od_Momento = new CDictionary_Obj_Double;
  p_od_Momento.SetAll(fvMOMENTO, input_momento);
  in.Add(p_od_Momento);


  //--- Create second input variables for the system
  CFuzzyVariable *fvVolume=new CFuzzyVariable("VOLUME",-1.57,1.57);
  fvVolume.Terms().Add(new CFuzzyTerm("MuitoBaixo", new CTrapezoidMembershipFunction(-1.57,-1.570,-0.392,-0.196)));
  fvVolume.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(-0.392,-0.196,-0.098)));
  fvVolume.Terms().Add(new CFuzzyTerm("Neutro", new CTriangularMembershipFunction(-0.196,0,0.196)));
  fvVolume.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(0.098,0.196,0.392)));
  fvVolume.Terms().Add(new CFuzzyTerm("MuitoAlto", new CTrapezoidMembershipFunction(0.196,0.392,1.57,1.570)));
  fsCEV.Input().Add(fvVolume);

  CDictionary_Obj_Double *p_od_Volume = new CDictionary_Obj_Double;
  p_od_Volume.SetAll(fvVolume, input_volume);
  in.Add(p_od_Volume);

  // //--- Create Input
  CFuzzyVariable *fvSINAL=new CFuzzyVariable("SINAL",0,100);
  fvSINAL.Terms().Add(new CFuzzyTerm("MuitoBaixo", new CTrapezoidMembershipFunction(0,0,10,20)));
  fvSINAL.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(10,20,30)));
  fvSINAL.Terms().Add(new CFuzzyTerm("Neutro", new CTrapezoidMembershipFunction(20,30,70,80)));
  fvSINAL.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(70,80,90)));
  fvSINAL.Terms().Add(new CFuzzyTerm("MuitoAlto", new CTrapezoidMembershipFunction(80,90,100,100)));
  fsCEV.Input().Add(fvSINAL);

  CDictionary_Obj_Double *p_od_Sinal = new CDictionary_Obj_Double;
  p_od_Sinal.SetAll(fvSINAL, input_sinal);
  in.Add(p_od_Sinal);
  //--- Create Output
  CFuzzyVariable *fvCEV=new CFuzzyVariable("CEV",0,100);
  fvCEV.Terms().Add(new CFuzzyTerm("MuitoBaixo", new CTrapezoidMembershipFunction(0,0,20,30)));
  fvCEV.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(20,30,40)));
  fvCEV.Terms().Add(new CFuzzyTerm("Neutro", new CTriangularMembershipFunction(30,50,70)));
  fvCEV.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(60,70,80)));
  fvCEV.Terms().Add(new CFuzzyTerm("MuitoAlto", new CTrapezoidMembershipFunction(70,80,100,100)));
  fsCEV.Output().Add(fvCEV);
  //--- Create three Mamdani fuzzy rule
  CMamdaniFuzzyRule *rule1 = fsCEV.ParseRule("if (MOMENTO is MuitoAlto) then CEV is Alto");
  CMamdaniFuzzyRule *rule2 = fsCEV.ParseRule("if (MOMENTO is MuitoAlto) and (SINAL is MuitoAlto) then CEV is Alto");
  CMamdaniFuzzyRule *rule2b = fsCEV.ParseRule("if (MOMENTO is MuitoAlto) and (SINAL is Alto) then CEV is Alto");
  CMamdaniFuzzyRule *rule2c = fsCEV.ParseRule("if (MOMENTO is Alto) and (SINAL is MuitoAlto) then CEV is Alto");
  CMamdaniFuzzyRule *rule2d = fsCEV.ParseRule("if (MOMENTO is Alto) and (SINAL is Alto) then CEV is Alto");
  CMamdaniFuzzyRule *rule3 = fsCEV.ParseRule("if (MOMENTO is MuitoAlto) and (VOLUME is MuitoAlto) then CEV is Alto");
  CMamdaniFuzzyRule *rule3b = fsCEV.ParseRule("if (MOMENTO is Alto) and (VOLUME is MuitoAlto) then CEV is Alto");
  CMamdaniFuzzyRule *rule3c = fsCEV.ParseRule("if (MOMENTO is MuitoAlto) and (VOLUME is Alto) then CEV is Alto");
  CMamdaniFuzzyRule *rule3d = fsCEV.ParseRule("if (MOMENTO is Alto) and (VOLUME is Alto) then CEV is Alto");
  CMamdaniFuzzyRule *rule4 = fsCEV.ParseRule("if (SINAL is MuitoAlto) and (VOLUME is MuitoAlto) then CEV is Alto");
  CMamdaniFuzzyRule *rule4b = fsCEV.ParseRule("if (SINAL is MuitoAlto) and (VOLUME is Alto) then CEV is Alto");
  CMamdaniFuzzyRule *rule4c = fsCEV.ParseRule("if (SINAL is Alto) and (VOLUME is MuitoAlto) then CEV is Alto");
  CMamdaniFuzzyRule *rule4d = fsCEV.ParseRule("if (SINAL is Alto) and (VOLUME is Alto) then CEV is Alto");
  CMamdaniFuzzyRule *rule5 = fsCEV.ParseRule("if (MOMENTO is MuitoAlto) and (SINAL is MuitoAlto) and (VOLUME is MuitoAlto) then CEV is MuitoAlto");
  CMamdaniFuzzyRule *rule5b = fsCEV.ParseRule("if (MOMENTO is MuitoAlto) and (SINAL is MuitoAlto) and (VOLUME is Alto) then CEV is MuitoAlto");
  CMamdaniFuzzyRule *rule5c = fsCEV.ParseRule("if (MOMENTO is MuitoAlto) and (SINAL is Alto) and (VOLUME is Alto) then CEV is MuitoAlto");
  CMamdaniFuzzyRule *rule5d = fsCEV.ParseRule("if (MOMENTO is Alto) and (SINAL is MuitoAlto) and (VOLUME is MuitoAlto) then CEV is MuitoAlto");
  CMamdaniFuzzyRule *rule5e = fsCEV.ParseRule("if (MOMENTO is Alto) and (SINAL is Alto) and (VOLUME is MuitoAlto) then CEV is MuitoAlto");
  CMamdaniFuzzyRule *rule5f = fsCEV.ParseRule("if (MOMENTO is Alto) and (SINAL is Alto) and (VOLUME is Alto) then CEV is MuitoAlto");
  CMamdaniFuzzyRule *rule5g = fsCEV.ParseRule("if (MOMENTO is Alto) and (SINAL is MuitoAlto) and (VOLUME is Alto) then CEV is MuitoAlto");
  CMamdaniFuzzyRule *rule5h = fsCEV.ParseRule("if (MOMENTO is MuitoAlto) and (SINAL is Alto) and (VOLUME is MuitoAlto) then CEV is MuitoAlto");
  CMamdaniFuzzyRule *rule6 = fsCEV.ParseRule("if (MOMENTO is Neutro) and (SINAL is Neutro) then CEV is Neutro");
  CMamdaniFuzzyRule *rule7 = fsCEV.ParseRule("if (MOMENTO is Neutro) and (VOLUME is Neutro) then CEV is Neutro");
  CMamdaniFuzzyRule *rule8 = fsCEV.ParseRule("if (SINAL is Neutro) and (VOLUME is Neutro) then CEV is Neutro");
  CMamdaniFuzzyRule *rule9 = fsCEV.ParseRule("if (MOMENTO is MuitoAlto) and (SINAL is MuitoBaixo) then CEV is Neutro");
  CMamdaniFuzzyRule *rule9b = fsCEV.ParseRule("if (MOMENTO is MuitoAlto) and (SINAL is Baixo) then CEV is Neutro");
  CMamdaniFuzzyRule *rule9c = fsCEV.ParseRule("if (MOMENTO is Alto) and (SINAL is Baixo) then CEV is Neutro");
  CMamdaniFuzzyRule *rule9d = fsCEV.ParseRule("if (MOMENTO is Alto) and (SINAL is MuitoBaixo) then CEV is Neutro");
  CMamdaniFuzzyRule *rule10 = fsCEV.ParseRule("if (MOMENTO is MuitoAlto) and (VOLUME is MuitoBaixo) then CEV is Neutro");
  CMamdaniFuzzyRule *rule10b = fsCEV.ParseRule("if (MOMENTO is Alto) and (VOLUME is MuitoBaixo) then CEV is Neutro");
  CMamdaniFuzzyRule *rule10c = fsCEV.ParseRule("if (MOMENTO is Alto) and (VOLUME is Baixo) then CEV is Neutro");
  CMamdaniFuzzyRule *rule10d = fsCEV.ParseRule("if (MOMENTO is MuitoAlto) and (VOLUME is Baixo) then CEV is Neutro");
  CMamdaniFuzzyRule *rule11 = fsCEV.ParseRule("if (SINAL is MuitoAlto) and (VOLUME is MuitoBaixo) then CEV is Neutro");
  CMamdaniFuzzyRule *rule11b = fsCEV.ParseRule("if (SINAL is Alto) and (VOLUME is MuitoBaixo) then CEV is Neutro");
  CMamdaniFuzzyRule *rule11c = fsCEV.ParseRule("if (SINAL is MuitoAlto) and (VOLUME is Baixo) then CEV is Neutro");
  CMamdaniFuzzyRule *rule11d = fsCEV.ParseRule("if (SINAL is Alto) and (VOLUME is Baixo) then CEV is Neutro");
  CMamdaniFuzzyRule *rule12 = fsCEV.ParseRule("if (MOMENTO is MuitoBaixo) and (SINAL is MuitoAlto) then CEV is Neutro");
  CMamdaniFuzzyRule *rule12b = fsCEV.ParseRule("if (MOMENTO is Baixo) and (SINAL is MuitoAlto) then CEV is Neutro");
  CMamdaniFuzzyRule *rule12c = fsCEV.ParseRule("if (MOMENTO is Baixo) and (SINAL is Alto) then CEV is Neutro");
  CMamdaniFuzzyRule *rule12d = fsCEV.ParseRule("if (MOMENTO is MuitoBaixo) and (SINAL is Alto) then CEV is Neutro");
  CMamdaniFuzzyRule *rule13 = fsCEV.ParseRule("if (MOMENTO is MuitoBaixo) and (VOLUME is MuitoAlto) then CEV is Neutro");
  CMamdaniFuzzyRule *rule13b = fsCEV.ParseRule("if (MOMENTO is MuitoBaixo) and (VOLUME is Alto) then CEV is Neutro");
  CMamdaniFuzzyRule *rule13c = fsCEV.ParseRule("if (MOMENTO is Baixo) and (VOLUME is Alto) then CEV is Neutro");
  CMamdaniFuzzyRule *rule13d = fsCEV.ParseRule("if (MOMENTO is Baixo) and (VOLUME is MuitoAlto) then CEV is Neutro");
  CMamdaniFuzzyRule *rule14 = fsCEV.ParseRule("if (SINAL is MuitoBaixo) and (VOLUME is MuitoAlto) then CEV is Neutro");
  CMamdaniFuzzyRule *rule14b = fsCEV.ParseRule("if (SINAL is Baixo) and (VOLUME is MuitoAlto) then CEV is Neutro");
  CMamdaniFuzzyRule *rule14c = fsCEV.ParseRule("if (SINAL is Baixo) and (VOLUME is Alto) then CEV is Neutro");
  CMamdaniFuzzyRule *rule14d = fsCEV.ParseRule("if (SINAL is MuitoBaixo) and (VOLUME is Alto) then CEV is Neutro");
  CMamdaniFuzzyRule *rule15 = fsCEV.ParseRule("if (MOMENTO is MuitoBaixo) then CEV is Baixo");
  CMamdaniFuzzyRule *rule16 = fsCEV.ParseRule("if (MOMENTO is MuitoBaixo) and (SINAL is MuitoBaixo) then CEV is Baixo");
  CMamdaniFuzzyRule *rule16b = fsCEV.ParseRule("if (MOMENTO is Baixo) and (SINAL is MuitoBaixo) then CEV is Baixo");
  CMamdaniFuzzyRule *rule16c = fsCEV.ParseRule("if (MOMENTO is MuitoBaixo) and (SINAL is Baixo) then CEV is Baixo");
  CMamdaniFuzzyRule *rule16d = fsCEV.ParseRule("if (MOMENTO is Baixo) and (SINAL is Baixo) then CEV is Baixo");
  CMamdaniFuzzyRule *rule17 = fsCEV.ParseRule("if (MOMENTO is MuitoBaixo) and (VOLUME is MuitoBaixo) then CEV is Baixo");
  CMamdaniFuzzyRule *rule17b = fsCEV.ParseRule("if (MOMENTO is MuitoBaixo) and (VOLUME is Baixo) then CEV is Baixo");
  CMamdaniFuzzyRule *rule17c = fsCEV.ParseRule("if (MOMENTO is Baixo) and (VOLUME is MuitoBaixo) then CEV is Baixo");
  CMamdaniFuzzyRule *rule17d = fsCEV.ParseRule("if (MOMENTO is Baixo) and (VOLUME is Baixo) then CEV is Baixo");
  CMamdaniFuzzyRule *rule18 = fsCEV.ParseRule("if (SINAL is MuitoBaixo) and (VOLUME is MuitoBaixo) then CEV is Baixo");
  CMamdaniFuzzyRule *rule18b = fsCEV.ParseRule("if (SINAL is MuitoBaixo) and (VOLUME is Baixo) then CEV is Baixo");
  CMamdaniFuzzyRule *rule18c = fsCEV.ParseRule("if (SINAL is Baixo) and (VOLUME is Baixo) then CEV is Baixo");
  CMamdaniFuzzyRule *rule18d = fsCEV.ParseRule("if (SINAL is Baixo) and (VOLUME is MuitoBaixo) then CEV is Baixo");
  CMamdaniFuzzyRule *rule19 = fsCEV.ParseRule("if (MOMENTO is MuitoBaixo) and (SINAL is MuitoBaixo) and (VOLUME is MuitoBaixo) then CEV is MuitoBaixo");
  CMamdaniFuzzyRule *rule19b = fsCEV.ParseRule("if (MOMENTO is MuitoBaixo) and (SINAL is MuitoBaixo) and (VOLUME is Baixo) then CEV is MuitoBaixo");
  CMamdaniFuzzyRule *rule19c = fsCEV.ParseRule("if (MOMENTO is MuitoBaixo) and (SINAL is Baixo) and (VOLUME is Baixo) then CEV is MuitoBaixo");
  CMamdaniFuzzyRule *rule19d = fsCEV.ParseRule("if (MOMENTO is Baixo) and (SINAL is MuitoBaixo) and (VOLUME is MuitoBaixo) then CEV is MuitoBaixo");
  CMamdaniFuzzyRule *rule19e = fsCEV.ParseRule("if (MOMENTO is Baixo) and (SINAL is Baixo) and (VOLUME is MuitoBaixo) then CEV is MuitoBaixo");
  CMamdaniFuzzyRule *rule19f = fsCEV.ParseRule("if (MOMENTO is Baixo) and (SINAL is Baixo) and (VOLUME is Baixo) then CEV is MuitoBaixo");
  CMamdaniFuzzyRule *rule19g = fsCEV.ParseRule("if (MOMENTO is Baixo) and (SINAL is MuitoBaixo) and (VOLUME is Baixo) then CEV is MuitoBaixo");
  CMamdaniFuzzyRule *rule19h = fsCEV.ParseRule("if (MOMENTO is MuitoBaixo) and (SINAL is Baixo) and (VOLUME is MuitoBaixo) then CEV is MuitoBaixo");

  //--- Add three Mamdani fuzzy rule in system
  fsCEV.Rules().Add(rule1);
  fsCEV.Rules().Add(rule2);
  fsCEV.Rules().Add(rule2b);
  fsCEV.Rules().Add(rule2c);
  fsCEV.Rules().Add(rule2d);
  fsCEV.Rules().Add(rule3);
  fsCEV.Rules().Add(rule3b);
  fsCEV.Rules().Add(rule3c);
  fsCEV.Rules().Add(rule3d);
  fsCEV.Rules().Add(rule4);
  fsCEV.Rules().Add(rule4b);
  fsCEV.Rules().Add(rule4c);
  fsCEV.Rules().Add(rule4d);
  fsCEV.Rules().Add(rule5);
  fsCEV.Rules().Add(rule5b);
  fsCEV.Rules().Add(rule5c);
  fsCEV.Rules().Add(rule5d);
  fsCEV.Rules().Add(rule5e);
  fsCEV.Rules().Add(rule5f);
  fsCEV.Rules().Add(rule5g);
  fsCEV.Rules().Add(rule5h);
  fsCEV.Rules().Add(rule6);
  fsCEV.Rules().Add(rule7);
  fsCEV.Rules().Add(rule8);
  fsCEV.Rules().Add(rule9);
  fsCEV.Rules().Add(rule9b);
  fsCEV.Rules().Add(rule9c);
  fsCEV.Rules().Add(rule9d);
  fsCEV.Rules().Add(rule10);
  fsCEV.Rules().Add(rule10b);
  fsCEV.Rules().Add(rule10c);
  fsCEV.Rules().Add(rule10d);
  fsCEV.Rules().Add(rule11);
  fsCEV.Rules().Add(rule11b);
  fsCEV.Rules().Add(rule11c);
  fsCEV.Rules().Add(rule11d);
  fsCEV.Rules().Add(rule12);
  fsCEV.Rules().Add(rule12b);
  fsCEV.Rules().Add(rule12c);
  fsCEV.Rules().Add(rule12d);
  fsCEV.Rules().Add(rule13);
  fsCEV.Rules().Add(rule13b);
  fsCEV.Rules().Add(rule13c);
  fsCEV.Rules().Add(rule13d);
  fsCEV.Rules().Add(rule14);
  fsCEV.Rules().Add(rule14b);
  fsCEV.Rules().Add(rule14c);
  fsCEV.Rules().Add(rule14d);
  fsCEV.Rules().Add(rule15);
  fsCEV.Rules().Add(rule16);
  fsCEV.Rules().Add(rule16b);
  fsCEV.Rules().Add(rule16c);
  fsCEV.Rules().Add(rule16d);
  fsCEV.Rules().Add(rule17);
  fsCEV.Rules().Add(rule17b);
  fsCEV.Rules().Add(rule17c);
  fsCEV.Rules().Add(rule17d);
  fsCEV.Rules().Add(rule18);
  fsCEV.Rules().Add(rule18b);
  fsCEV.Rules().Add(rule18c);
  fsCEV.Rules().Add(rule18d);
  fsCEV.Rules().Add(rule19);
  fsCEV.Rules().Add(rule19b);
  fsCEV.Rules().Add(rule19c);
  fsCEV.Rules().Add(rule19d);
  fsCEV.Rules().Add(rule19e);
  fsCEV.Rules().Add(rule19f);
  fsCEV.Rules().Add(rule19g);
  fsCEV.Rules().Add(rule19h);

  //--- Get result
  CList *result;
  CDictionary_Obj_Double *p_od_Ipsus;
  result = fsCEV.Calculate(in);
  p_od_Ipsus = result.GetNodeAtIndex(0);
  //   Print("Ipsus, escala: ",p_od_Ipsus.Value());

  retorno = p_od_Ipsus.Value();

  delete in;
  delete result;
  delete fsCEV;

  return retorno;
}
