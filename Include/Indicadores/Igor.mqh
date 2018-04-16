/* -*- C++ -*- */

class Igor
{

  public:
  Igor();
  double MACD_Resultado; //Resultado da Tabela 1
  double Volume_Resultado; //Mais Ou Menos Fuzzy
  double Entrada_fvHIST_M; //Mais Ou Menos Fuzzy
  double Entrada_fvMACD_M; //Mais Ou Menos Fuzzy
  double Igor::Fuzzy_HIST(double HIST_distancia = NULL, double HIST_alpha = NULL);
  double Igor::Fuzzy_Momento(int barra = 0);
  double Igor::Fuzzy_Sinal();
  double Igor::Fuzzy_CEV(); //Tabela 4 pag 103   |  -2 a 2 (Muito baixo a muito alto)
  ENUM_TIMEFRAMES Igor_TF; //TimeFrames especifico do indicador


  private:
  void Igor::Dados();
  double Igor::Crisp_MACD();

};

void Igor::Igor()
{

}


double Igor::Crisp_MACD() //Tabela 1 pag 101   |  -2 a 2 (Muito baixo a muito alto)
{
  int retorno = 0;

  OBV *OBV_oo = new OBV;
  MACD *MACD_oo = new MACD(NULL,NULL,NULL,NULL,TimeFrame);

  double LinMACD = MACD_oo.Valor(0,0); //0 - Main line
  double LinSinal = MACD_oo.Valor(1,0); //1 - Signal Line
  double m1 = MACD_oo.Cx(0); //Cx MACD
  double m2 = MACD_oo.Cx(1); //Cx Sinal
  double distancia = MACD_oo.Distancia_Linha_Zero(); //distância do indicador Histograma MACD ao eixo zero;

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

  delete(OBV_oo);
  delete(MACD_oo);
  return retorno;
}


//Tabela2 - MACD Crisp HIST

double Igor::Fuzzy_HIST(double HIST_distancia = NULL, double HIST_alpha = NULL) //Tabela 2 pag 101   |  -2 a 2 (Muito baixo a muito alto)
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

     double n_HIST_distancia = n_(HIST_distancia,-1,1);
     double n_HIST_alpha = n_(HIST_alpha,-1.57,1.57);

     p_od_distancia.SetAll(fvDistancia, n_HIST_distancia);
     p_od_alpha.SetAll(fvAlpha, n_HIST_alpha);
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

//Tabela3 - MOMENTO Pag 103

double Igor::Fuzzy_Momento(int barra = 0) //Tabela 3 pag 103   |  -2 a 2 (Muito baixo a muito alto)
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

  RSI *IFR = new RSI(NULL,TimeFrame);
  Stoch *EST = new Stoch(NULL,NULL,NULL,TimeFrame);

    double n_IFR = n_(IFR.Valor(barra),0,100);
    double n_EST = n_(EST.Valor(0,barra),0,100);

     CList *in=new CList;
     CDictionary_Obj_Double *p_od_IFR = new CDictionary_Obj_Double;
     CDictionary_Obj_Double *p_od_EST = new CDictionary_Obj_Double;
     p_od_IFR.SetAll(fvIFR, n_IFR);
     p_od_EST.SetAll(fvEST, n_EST);
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

/* -*- C++ -*- */


double Igor::Fuzzy_Sinal() //Tabela 4 pag 103   |  -2 a 2 (Muito baixo a muito alto)
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

    double n_Entrada_fvMACD = n_(Entrada_fvMACD,-2,2);
    double n_Entrada_fvHIST = n_(Entrada_fvHIST,-1.57,1.57);



     CList *in=new CList;
     CDictionary_Obj_Double *p_od_Hist = new CDictionary_Obj_Double;
     CDictionary_Obj_Double *p_od_MACD = new CDictionary_Obj_Double;
     p_od_Hist.SetAll(fvHIST, n_Entrada_fvHIST);
     p_od_MACD.SetAll(fvMACD, n_Entrada_fvMACD);   //DESCOMENTAR COM URGENCIA
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

/* -*- C++ -*- */


double Igor::Fuzzy_CEV() //Tabela 4 pag 103   |  -2 a 2 (Muito baixo a muito alto)
{
  double retorno = 0;
  double input_momento = 0;
  double input_volume = 0;
  double input_sinal = 0;

  OBV *OBV_oo = new OBV;

  input_momento = n_(Fuzzy_Momento(),0,100);
  input_volume = n_(OBV_oo.Cx(),-1.57,1.57);
  input_sinal = n_(Fuzzy_Sinal(),0,100);




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
