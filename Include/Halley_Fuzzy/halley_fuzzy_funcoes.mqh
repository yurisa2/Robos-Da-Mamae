/* -*- C++ -*- */

class Halley_Fuzzy
{

  public:
  void Halley_Fuzzy_Comentario();
  void Avalia();
  void Timer();
  int  Formato(int barra = 0);
  double Halley_Fuzzy::Classificacao_Fuzzy(double PROP_SOMBRA1T,double  PROP_SOMBRA2T,double  PROP_SOMBRA12,double  PROP_CORPOT);
  double Classifica_Formato;
  int Formato_vlr;

  private:
  double Halley_Corpo;
  double Halley_Sombra;
  double Halley_Sombra2;
  double Halley_PropSombra12;
  double Halley_Tamanho;

};



void Halley_Fuzzy::Halley_Fuzzy_Comentario()
{

}

int  Halley_Fuzzy::Formato(int barra = 0)
{
  int  retorno = 0;
  double sombra = NULL;
  double sombra2 = NULL;
  double corpo = NULL;
  double total = NULL;

  total = MathAbs(Preco(barra+1).high) - MathAbs(Preco(barra+1).low);

  //  Print("Hora: " +  Preco(barra+1).time +" | OHLC:" + Preco(barra+1).open + " | " + Preco(barra+1).high +" | " + Preco(barra+1).low +" | " + Preco(barra+1).close);

  /*  REGRAS PARA O FORMATO
  Invés de ter as regras clássicas, as regras para construção dos formatos são:

  Sombra > Corpo (classificatória)
  Sombra > sombra2 ou sombra2 == 0.01

  Fica excluído o n_vezes, nem sei se vou incluir ele (provável que nao)

  Queria ver se tudo relativo ao candle em si funfa.

  ERA ASSIM     if(sombra > (n_vezes * corpo) && ((sombra/sombra2) > prop_sombra || sombra2 == 0.01))


  */

  if(Preco(barra+1).close >= Preco(barra+1).open) //Candle de alta //MARTELO
  {
    corpo = MathAbs(Preco(barra+1).close - Preco(barra+1).open);
    sombra =  MathAbs(Preco(barra+1).high - Preco(barra+1).close);
    sombra2 = MathAbs(Preco(barra+1).open - Preco(barra+1).low);
    if(sombra2 == 0) sombra2 = 0.01;

    if(sombra > corpo && (sombra > sombra2 || sombra2 == 0.01))
    {
      Halley_Corpo = MathAbs(corpo);
      Halley_Sombra = MathAbs(sombra);
      Halley_Sombra2 = MathAbs(sombra2);
      Halley_PropSombra12 = MathAbs(sombra2/sombra*100);
      Halley_Tamanho = MathAbs(Preco(barra+1).high) - MathAbs(Preco(barra+1).low);

      retorno = -1;
    }
  }

  if(Preco(barra+1).close <= Preco(barra+1).open)  //Candle de baixa //MARTELO
  {
    corpo = MathAbs(Preco(barra+1).open - Preco(barra+1).close);
    sombra =  MathAbs(Preco(barra+1).high - Preco(barra+1).open);
    sombra2 = MathAbs(Preco(barra+1).close - Preco(barra+1).low);
    if(sombra2 == 0) sombra2 = 0.01;

    if(sombra > corpo && (sombra > sombra2 || sombra2 == 0.01))
    {
      Halley_Corpo = MathAbs(corpo);
      Halley_Sombra = MathAbs(sombra);
      Halley_Sombra2 = MathAbs(sombra2);
      Halley_PropSombra12 = MathAbs(sombra2/sombra*100);
      Halley_Tamanho = MathAbs(Preco(barra+1).high) - MathAbs(Preco(barra+1).low);

      retorno = -1;
    }
  }


  if(Preco(barra+1).close >= Preco(barra+1).open) //Candle de alta //SStar
  {
    corpo = MathAbs(Preco(barra+1).close - Preco(barra+1).open);
    sombra =  MathAbs(Preco(barra+1).open - Preco(barra+1).low);
    sombra2 = MathAbs(Preco(barra+1).high - Preco(barra+1).close);
    if(sombra2 == 0) sombra2 = 0.01;

    if(sombra > corpo && (sombra > sombra2 || sombra2 == 0.01))
    {
      Halley_Corpo = MathAbs(corpo);
      Halley_Sombra = MathAbs(sombra);
      Halley_Sombra2 = MathAbs(sombra2);
      Halley_PropSombra12 = MathAbs(sombra2/sombra*100);
      Halley_Tamanho = MathAbs(Preco(barra+1).high) - MathAbs(Preco(barra+1).low);

      retorno = 1;
    }
  }

  if(Preco(barra+1).close <= Preco(barra+1).open)  //Candle de baixa //SStar
  {
    corpo = MathAbs(Preco(barra+1).open - Preco(barra+1).close);
    sombra =  MathAbs(Preco(barra+1).close - Preco(barra+1).low);
    sombra2 = MathAbs(Preco(barra+1).high - Preco(barra+1).open);
    if(sombra2 == 0) sombra2 = 0.01;

    if(sombra > corpo && (sombra > sombra2 || sombra2 == 0.01))
    {
      Halley_Corpo = MathAbs(corpo);
      Halley_Sombra = MathAbs(sombra);
      Halley_Sombra2 = MathAbs(sombra2);
      Halley_PropSombra12 = MathAbs(sombra2/sombra*100);
      Halley_Tamanho = MathAbs(Preco(barra+1).high) - MathAbs(Preco(barra+1).low);

      retorno = 1;
    }
  }

  //Print("Corpo: " + corpo + " | Sombra: " + sombra); //DEBUG

  if(retorno != 0)
  {
    double PROP_SOMBRA1T = n_(Halley_Sombra / Halley_Tamanho * 100,0,100);
    double PROP_SOMBRA2T = n_(Halley_Sombra2 / Halley_Tamanho * 100,0,100);
    double PROP_SOMBRA12 = n_(Halley_Sombra2 / Halley_Sombra * 100,0,100);
    double PROP_CORPOT = n_(Halley_Corpo / Halley_Tamanho * 100,0,100);

    Classifica_Formato =  Classificacao_Fuzzy(PROP_SOMBRA1T, PROP_SOMBRA2T, PROP_SOMBRA12, PROP_CORPOT);
  }

  Formato_vlr = retorno;
  return retorno;
}

void Halley_Fuzzy::Avalia()
{
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  if(Condicoes.Horario())
  {
    if(Formato(0) != 0 && Classifica_Formato >= Halley_Fuzzy_Min_Classificacao)
    {
    PrintFormat("Formato %f, Classificacao: %f",Formato_vlr,Classifica_Formato) ;
    Opera_Mercado *opera = new Opera_Mercado;
    opera.AbrePosicao(Formato_vlr,"Halley: " + "Formato("+IntegerToString(Formato_vlr)+"): " + DoubleToString(Formato_vlr));
    delete(opera);
    }
  }
  delete(Condicoes);
}

void Halley_Fuzzy::Timer()
{

}

double Halley_Fuzzy::Classificacao_Fuzzy(double PROP_SOMBRA1T, double PROP_SOMBRA2T, double PROP_SOMBRA12,double PROP_CORPOT)
{
  double retorno = 0;
  //--- Mamdani Fuzzy System
  CMamdaniFuzzySystem *fsHalley=new CMamdaniFuzzySystem();
  //--- Create first input variables for the system
  CFuzzyVariable *fvPROP_SOMBRA1T=new CFuzzyVariable("PROP_SOMBRA1T",0,100);
  fvPROP_SOMBRA1T.Terms().Add(new CFuzzyTerm("MuitoRuim", new CTrapezoidMembershipFunction(0,0,30,40)));
  fvPROP_SOMBRA1T.Terms().Add(new CFuzzyTerm("Ruim", new CTriangularMembershipFunction(30,40,50)));
  fvPROP_SOMBRA1T.Terms().Add(new CFuzzyTerm("Neutro", new CTrapezoidMembershipFunction(40.000, 50.000, 50.000, 60.000)));
  fvPROP_SOMBRA1T.Terms().Add(new CFuzzyTerm("Bom", new CTriangularMembershipFunction(50.000, 60.000, 70.000)));
  fvPROP_SOMBRA1T.Terms().Add(new CFuzzyTerm("MuitoBom", new CTrapezoidMembershipFunction(60.000, 80.000, 100.000, 100.000)));
  fsHalley.Input().Add(fvPROP_SOMBRA1T);
  //--- Create second input variables for the system
  CFuzzyVariable *fvPROP_SOMBRA2T=new CFuzzyVariable("PROP_SOMBRA2T",0,100);
  fvPROP_SOMBRA2T.Terms().Add(new CFuzzyTerm("MuitoBom", new CTrapezoidMembershipFunction(0.000, 0.000, 10.000, 20.000)));
  fvPROP_SOMBRA2T.Terms().Add(new CFuzzyTerm("Bom", new CTriangularMembershipFunction(10.000, 20.000, 30.000)));
  fvPROP_SOMBRA2T.Terms().Add(new CFuzzyTerm("Neutro", new CTrapezoidMembershipFunction(25.000, 40.000, 40.000, 50.000)));
  fvPROP_SOMBRA2T.Terms().Add(new CFuzzyTerm("Ruim", new CTriangularMembershipFunction(35.000, 50.000, 55.000)));
  fvPROP_SOMBRA2T.Terms().Add(new CFuzzyTerm("MuitoRuim", new CTrapezoidMembershipFunction(50.000, 60.000, 100.000, 100.000)));
  fsHalley.Input().Add(fvPROP_SOMBRA2T);
  //--- Create second input variables for the system
  CFuzzyVariable *fvPROP_SOMBRA12=new CFuzzyVariable("PROP_SOMBRA12",0,100);
  fvPROP_SOMBRA12.Terms().Add(new CFuzzyTerm("MuitoBom", new CTrapezoidMembershipFunction(0.000, 0.000, 20.000, 30.000)));
  fvPROP_SOMBRA12.Terms().Add(new CFuzzyTerm("Bom", new CTriangularMembershipFunction(20.000, 30.000, 40.000)));
  fvPROP_SOMBRA12.Terms().Add(new CFuzzyTerm("Neutro", new CTrapezoidMembershipFunction(30.000, 50.000, 50.000, 70.000)));
  fvPROP_SOMBRA12.Terms().Add(new CFuzzyTerm("Ruim", new CTriangularMembershipFunction(60.000, 70.000, 80.000)));
  fvPROP_SOMBRA12.Terms().Add(new CFuzzyTerm("MuitoRuim", new CTrapezoidMembershipFunction(70.000, 80.000, 100.000, 100.000)));
  fsHalley.Input().Add(fvPROP_SOMBRA12);
  //--- Create second input variables for the system
  CFuzzyVariable *fvPROP_CORPOT=new CFuzzyVariable("PROP_CORPOT",0,100);
  fvPROP_CORPOT.Terms().Add(new CFuzzyTerm("MuitoBom", new CTrapezoidMembershipFunction(0.000, 0.000, 5.000, 10.000)));
  fvPROP_CORPOT.Terms().Add(new CFuzzyTerm("Bom", new CTriangularMembershipFunction(5.000, 15.000, 25.000)));
  fvPROP_CORPOT.Terms().Add(new CFuzzyTerm("Neutro", new CTrapezoidMembershipFunction(15.000, 30.000, 40.000, 40.000)));
  fvPROP_CORPOT.Terms().Add(new CFuzzyTerm("Ruim", new CTriangularMembershipFunction(30.000, 45.000, 45.000)));
  fvPROP_CORPOT.Terms().Add(new CFuzzyTerm("MuitoRuim", new CTrapezoidMembershipFunction(40.000, 50.000, 100.000, 100.000)));
  fsHalley.Input().Add(fvPROP_CORPOT);
  //--- Create Output
  CFuzzyVariable *fvHALLEY=new CFuzzyVariable("HALLEY",0,100);
  fvHALLEY.Terms().Add(new CFuzzyTerm("MuitoRuim", new CTrapezoidMembershipFunction(0.000, 0.000, 20.000, 30.000)));
  fvHALLEY.Terms().Add(new CFuzzyTerm("Ruim", new CTriangularMembershipFunction(20.000, 30.000, 40.000)));
  fvHALLEY.Terms().Add(new CFuzzyTerm("Neutro", new CTrapezoidMembershipFunction(30.000, 50.000, 50.000, 70.000)));
  fvHALLEY.Terms().Add(new CFuzzyTerm("Bom", new CTriangularMembershipFunction(60.000, 70.000, 80.000)));
  fvHALLEY.Terms().Add(new CFuzzyTerm("MuitoBom", new CTrapezoidMembershipFunction(70.000, 80.000, 100.000, 100.000)));
  fsHalley.Output().Add(fvHALLEY);
  //--- Create three Mamdani fuzzy rule
  CMamdaniFuzzyRule *rule1 = fsHalley.ParseRule("if (PROP_SOMBRA1T is MuitoRuim) then HALLEY is MuitoRuim");
  CMamdaniFuzzyRule *rule2 = fsHalley.ParseRule("if (PROP_SOMBRA1T is Ruim) then HALLEY is Ruim");
  CMamdaniFuzzyRule *rule3 = fsHalley.ParseRule("if (PROP_SOMBRA1T is Neutro) then HALLEY is Neutro");
  CMamdaniFuzzyRule *rule4 = fsHalley.ParseRule("if (PROP_SOMBRA1T is Bom) then HALLEY is Bom");
  CMamdaniFuzzyRule *rule5 = fsHalley.ParseRule("if (PROP_SOMBRA1T is MuitoBom) then HALLEY is MuitoBom");
  CMamdaniFuzzyRule *rule6 = fsHalley.ParseRule("if (PROP_SOMBRA2T is MuitoRuim) then HALLEY is MuitoRuim");
  CMamdaniFuzzyRule *rule7 = fsHalley.ParseRule("if (PROP_SOMBRA2T is Ruim) then HALLEY is Ruim");
  CMamdaniFuzzyRule *rule8 = fsHalley.ParseRule("if (PROP_SOMBRA2T is Neutro) then HALLEY is Neutro");
  CMamdaniFuzzyRule *rule9 = fsHalley.ParseRule("if (PROP_SOMBRA2T is Bom) then HALLEY is Bom");
  CMamdaniFuzzyRule *rule10 = fsHalley.ParseRule("if (PROP_SOMBRA2T is MuitoBom) then HALLEY is MuitoBom");
  CMamdaniFuzzyRule *rule11 = fsHalley.ParseRule("if (PROP_SOMBRA12 is MuitoRuim) then HALLEY is MuitoRuim");
  CMamdaniFuzzyRule *rule12 = fsHalley.ParseRule("if (PROP_SOMBRA12 is Ruim) then HALLEY is Ruim");
  CMamdaniFuzzyRule *rule13 = fsHalley.ParseRule("if (PROP_SOMBRA12 is Neutro) then HALLEY is Neutro");
  CMamdaniFuzzyRule *rule14 = fsHalley.ParseRule("if (PROP_SOMBRA12 is Bom) then HALLEY is Bom");
  CMamdaniFuzzyRule *rule15 = fsHalley.ParseRule("if (PROP_SOMBRA12 is MuitoBom) then HALLEY is MuitoBom");
  CMamdaniFuzzyRule *rule16 = fsHalley.ParseRule("if (PROP_CORPOT is MuitoRuim) then HALLEY is MuitoRuim");
  CMamdaniFuzzyRule *rule17 = fsHalley.ParseRule("if (PROP_CORPOT is Ruim) then HALLEY is Ruim");
  CMamdaniFuzzyRule *rule18 = fsHalley.ParseRule("if (PROP_CORPOT is Neutro) then HALLEY is Neutro");
  CMamdaniFuzzyRule *rule19 = fsHalley.ParseRule("if (PROP_CORPOT is Bom) then HALLEY is Bom");
  CMamdaniFuzzyRule *rule20 = fsHalley.ParseRule("if (PROP_CORPOT is MuitoBom) then HALLEY is MuitoBom");
  //--- Add three Mamdani fuzzy rule in system
  fsHalley.Rules().Add(rule1);
  fsHalley.Rules().Add(rule2);
  fsHalley.Rules().Add(rule3);
  fsHalley.Rules().Add(rule4);
  fsHalley.Rules().Add(rule5);
  fsHalley.Rules().Add(rule6);
  fsHalley.Rules().Add(rule7);
  fsHalley.Rules().Add(rule8);
  fsHalley.Rules().Add(rule9);
  fsHalley.Rules().Add(rule10);
  fsHalley.Rules().Add(rule11);
  fsHalley.Rules().Add(rule12);
  fsHalley.Rules().Add(rule13);
  fsHalley.Rules().Add(rule14);
  fsHalley.Rules().Add(rule15);
  fsHalley.Rules().Add(rule16);
  fsHalley.Rules().Add(rule17);
  fsHalley.Rules().Add(rule18);
  fsHalley.Rules().Add(rule19);
  fsHalley.Rules().Add(rule20);
  //--- Set input value
  CList *in=new CList;
  CDictionary_Obj_Double *p_od_PROP_SOMBRA1T = new CDictionary_Obj_Double;
  CDictionary_Obj_Double *p_od_PROP_SOMBRA2T = new CDictionary_Obj_Double;
  CDictionary_Obj_Double *p_od_PROP_SOMBRA12 = new CDictionary_Obj_Double;
  CDictionary_Obj_Double *p_od_PROP_CORPOT = new CDictionary_Obj_Double;
  p_od_PROP_SOMBRA1T.SetAll(fvPROP_SOMBRA1T,PROP_SOMBRA1T);
  p_od_PROP_SOMBRA2T.SetAll(fvPROP_SOMBRA2T,PROP_SOMBRA2T);
  p_od_PROP_SOMBRA12.SetAll(fvPROP_SOMBRA12,PROP_SOMBRA12);
  p_od_PROP_CORPOT.SetAll(fvPROP_CORPOT,PROP_CORPOT);
  in.Add(p_od_PROP_SOMBRA1T);
  in.Add(p_od_PROP_SOMBRA2T);
  in.Add(p_od_PROP_SOMBRA12);
  in.Add(p_od_PROP_CORPOT);
  //--- Get result
  CList *result;
  CDictionary_Obj_Double *p_od_Ipsus;
  result = fsHalley.Calculate(in);
  p_od_Ipsus = result.GetNodeAtIndex(0);
  //   Print("Ipsus, escala: ",p_od_Ipsus.Value());

  retorno = p_od_Ipsus.Value();

  delete in;
  delete result;
  delete fsHalley;


  return retorno;

}
