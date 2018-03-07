/* -*- C++ -*- */


double Ibsen::Crisp_MACD() //Tabela 1 pag 101   |  -2 a 2 (Muito baixo a muito alto)
{
  int retorno = 0;

  if(LinMACD > 0 && LinMACD > LinSinal && m1 > 0 && m1 > m2) retorno = 2; //1
  if(LinMACD > 0 && LinMACD > LinSinal && m1 > 0 && m1 < m2) retorno = 1; //2
  if(LinMACD > 0 && LinMACD > LinSinal && m1 < 0) retorno = 0; //3
  if(LinMACD < 0 && LinMACD > LinSinal && m1 > 0 && m1 > m2) retorno = 1; //4
  if(LinMACD < 0 && LinMACD > LinSinal && m1 > 0 && m1 < m2) retorno = 1; //5
  if(LinMACD < 0 && LinMACD > LinSinal && m1 < 0) retorno = 0; //6
  if(LinMACD < 0 && LinMACD < LinSinal && m1 < 0 && m1 < m2) retorno = -2; //7
  if(LinMACD < 0 && LinMACD < LinSinal && m1 < 0 && m1 > m2) retorno = -1; //8
  if(LinMACD < 0 && LinMACD < LinSinal && m1 > 0) retorno = 0; //9
  if(LinMACD > 0 && LinMACD < LinSinal && m1 < 0 && m1 < m2) retorno = -1; //10
  if(LinMACD > 0 && LinMACD < LinSinal && m1 < 0 && m1 > m2) retorno = -1; //11
  if(LinMACD > 0 && LinMACD < LinSinal && m1 > 0) retorno = 0; //12
  if(LinMACD == 0 && m1 > 0) retorno = 2; //13
  if(LinMACD == 0 && m1 < 0) retorno = -2; //14
  if(m1 == 0) retorno = 0; //15

  return retorno;
}


//Tabela2 - MACD Crisp HIST

double Ibsen::Fuzzy_HIST(double HIST_distancia = NULL, double HIST_alpha = NULL) //Tabela 2 pag 101   |  -2 a 2 (Muito baixo a muito alto)
{
  double retorno = 0;

  //--- Mamdani Fuzzy System
     CMamdaniFuzzySystem *fsHIST=new CMamdaniFuzzySystem();
  //--- Create first input variables for the system
     CFuzzyVariable *fvDistancia=new CFuzzyVariable("distancia",-1,1);
     fvDistancia.Terms().Add(new CFuzzyTerm("Zero", new CTriangularMembershipFunction(-0.1,0,0.1)));
     fsHIST.Input().Add(fvDistancia);
  //--- Create second input variables for the system
     CFuzzyVariable *fvAlpha=new CFuzzyVariable("alpha",-1.57,1.57);
     fvAlpha.Terms().Add(new CFuzzyTerm("MuitoBaixo", new CTrapezoidMembershipFunction(-1.57,-1.570,-0.392,-0.196)));
     fvAlpha.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(-0.392,-0.196,-0.098)));
     fvAlpha.Terms().Add(new CFuzzyTerm("Neutro", new CTriangularMembershipFunction(-0.196,0,0.196)));
     fvAlpha.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(0.098,0.196,0.392)));
     fvAlpha.Terms().Add(new CFuzzyTerm("MuitoAlto", new CTrapezoidMembershipFunction(0.196,0.392,1.57,1.570)));
     fsHIST.Input().Add(fvAlpha);
  //--- Create Output
     CFuzzyVariable *fvHIST=new CFuzzyVariable("HIST",-1.57,1.57);
     fvHIST.Terms().Add(new CFuzzyTerm("MuitoBaixo", new CTrapezoidMembershipFunction(-1.57,-1.570,-0.392,-0.196)));
     fvHIST.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(-0.392,-0.196,-0.098)));
     fvHIST.Terms().Add(new CFuzzyTerm("Neutro", new CTriangularMembershipFunction(-0.196,0,0.196)));
     fvHIST.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(0.098,0.196,0.392)));
     fvHIST.Terms().Add(new CFuzzyTerm("MuitoAlto", new CTrapezoidMembershipFunction(0.196,0.392,1.57,1.570)));
     fsHIST.Output().Add(fvHIST);
  //--- Create three Mamdani fuzzy rule
     CMamdaniFuzzyRule *rule1 = fsHIST.ParseRule("if (distancia is Zero) and (alpha is Alto) then HIST is MuitoAlto");
     CMamdaniFuzzyRule *rule2 = fsHIST.ParseRule("if (distancia is Zero) and (alpha is Baixo) then HIST is MuitoBaixo");
     CMamdaniFuzzyRule *rule3 = fsHIST.ParseRule("if (alpha is Alto) then HIST is Alto");
     CMamdaniFuzzyRule *rule4 = fsHIST.ParseRule("if (alpha is MuitoAlto) then HIST is MuitoAlto");
     CMamdaniFuzzyRule *rule5 = fsHIST.ParseRule("if (alpha is Baixo) then HIST is Baixo");
     CMamdaniFuzzyRule *rule6 = fsHIST.ParseRule("if (alpha is MuitoBaixo) then HIST is MuitoBaixo");
     CMamdaniFuzzyRule *rule7 = fsHIST.ParseRule("if (alpha is Neutro) then HIST is Neutro");
  //--- Add three Mamdani fuzzy rule in system
     fsHIST.Rules().Add(rule1);
     fsHIST.Rules().Add(rule2);
     fsHIST.Rules().Add(rule3);
     fsHIST.Rules().Add(rule4);
     fsHIST.Rules().Add(rule5);
     fsHIST.Rules().Add(rule6);
     fsHIST.Rules().Add(rule7);
  //--- Set input value
     CList *in=new CList;
     CDictionary_Obj_Double *p_od_distancia = new CDictionary_Obj_Double;
     CDictionary_Obj_Double *p_od_alpha = new CDictionary_Obj_Double;
     p_od_distancia.SetAll(fvDistancia, HIST_distancia);
     p_od_alpha.SetAll(fvAlpha, HIST_alpha);
     in.Add(p_od_distancia);
     in.Add(p_od_alpha);
  //--- Get result
     CList *result;
     CDictionary_Obj_Double *p_od_Ipsus;
     result = fsHIST.Calculate(in);
     p_od_Ipsus = result.GetNodeAtIndex(0);
  //   Print("Ipsus, escala: ",p_od_Ipsus.Value());

  retorno = p_od_Ipsus.Value();

  delete in;
  delete result;
  delete fsHIST;

return retorno;
}
