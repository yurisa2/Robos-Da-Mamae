/* -*- C++ -*- */
//+------------------------------------------------------------------+

#include <Math\Fuzzy\MamdaniFuzzySystem.mqh>

class Wesley
{
  public:
  void Wesley::Wesley();
  double Wesley_Fuzzy_Valor;

  private:
  void Get_Dados();
  void Wesley::Comentario();
  void Wesley::Abre();
  void Wesley::Fecha();
  double Wesley::Fuzzy_Respo(double Banda = 0, double Rsi = 50, double Estocastico = 50, double MoneyFI = 50);
  double Wesley_BB_Valor;
  double Wesley_BB_Delta_Valor;
  double Wesley_RSI_Valor;
  double Wesley_Stoch_Valor;
  double Wesley_MF_Valor;
  double Wesley_Volumes;
};


void Wesley::Get_Dados()
{
  if(TaDentroDoHorario_RT)
  {
    BB *Banda_BB = new BB;
    RSI *RSI_OO = new RSI();
    Stoch *Stoch_OO = new Stoch();
    MFI *MFI_OO = new MFI();
    Volumes *Volumes_OO = new Volumes();

    Wesley_BB_Valor = Banda_BB.BB_Posicao_Percent();
    Wesley_BB_Delta_Valor = Banda_BB.Banda_Delta_Valor();
    Wesley_RSI_Valor = RSI_OO.Valor();
    Wesley_Stoch_Valor = Stoch_OO.Valor();
    Wesley_MF_Valor = MFI_OO.Valor();
    Wesley_Volumes = Volumes_OO.Valor();

    Wesley_Fuzzy_Valor = Fuzzy_Respo(Wesley_BB_Valor,Wesley_RSI_Valor,Wesley_Stoch_Valor,Wesley_MF_Valor);

    delete(RSI_OO);
    delete(Banda_BB);
    delete(Volumes_OO);
    delete(Stoch_OO);
    delete(MFI_OO);
  }
  else
  {
    Wesley_BB_Valor = 0;
    Wesley_RSI_Valor = 0;
    Wesley_Stoch_Valor = 0;
    Wesley_MF_Valor = 0;
  }
}

double Wesley::Fuzzy_Respo(double Banda = 0, double Rsi = 50, double Estocastico = 50, double MoneyFI = 50)
{
  double retorno = 0;

  if(Banda < -49) Banda = 0;
  if(Banda > 149) Banda = 149;
  if(Rsi < 0) Rsi = 0;
  if(Rsi > 100) Rsi = 100;

  //--- Mamdani Fuzzy System
  CMamdaniFuzzySystem *fsIpsus=new CMamdaniFuzzySystem();

  //--- Create Output
  CFuzzyVariable *fvIpsus=new CFuzzyVariable("tendencia",-100,100.0);
  fvIpsus.Terms().Add(new CFuzzyTerm("re_venda", new CSigmoidalMembershipFunction(0.1,50)));
  fvIpsus.Terms().Add(new CFuzzyTerm("re_compra", new CSigmoidalMembershipFunction(-0.1,-50)));
  fsIpsus.Output().Add(fvIpsus);
  //--- Create three Mamdani fuzzy rule
  // //--- Create first input variables for the system
  // CFuzzyVariable *fvBanda=new CFuzzyVariable("banda_bollinger",-50.0,150.0);
  // fvBanda.Terms().Add(new CFuzzyTerm("venda", new CTrapezoidMembershipFunction(50,100,120, 150)));
  // fvBanda.Terms().Add(new CFuzzyTerm("compra", new CTrapezoidMembershipFunction(-50,-20,0,50)));
  // fsIpsus.Input().Add(fvBanda);

  //--- Create first input variables for the system
  CFuzzyVariable *fvBanda=new CFuzzyVariable("banda_bollinger",-50.0,150.0);
  fvBanda.Terms().Add(new CFuzzyTerm("venda", new CSigmoidalMembershipFunction(0.1,100)));
  fvBanda.Terms().Add(new CFuzzyTerm("compra", new CSigmoidalMembershipFunction(-0.1,0)));
  fsIpsus.Input().Add(fvBanda);
  CMamdaniFuzzyRule *rule1 = fsIpsus.ParseRule("if (banda_bollinger is compra)  then tendencia is re_compra");
  CMamdaniFuzzyRule *rule2 = fsIpsus.ParseRule("if (banda_bollinger is venda)  then tendencia is re_venda");
  fsIpsus.Rules().Add(rule1);
  fsIpsus.Rules().Add(rule2);

  //--- Create second input variables for the system
  CFuzzyVariable *fvRsi=new CFuzzyVariable("rsi_forca",0.0,100.0);
  fvRsi.Terms().Add(new CFuzzyTerm("venda", new CSigmoidalMembershipFunction(0.3,70)));
  fvRsi.Terms().Add(new CFuzzyTerm("compra", new CSigmoidalMembershipFunction(-0.3,30)));
  fsIpsus.Input().Add(fvRsi);
  CMamdaniFuzzyRule *rule7 = fsIpsus.ParseRule("if (rsi_forca is compra) then tendencia is re_compra");
  CMamdaniFuzzyRule *rule8 = fsIpsus.ParseRule("if (rsi_forca is venda) then tendencia is re_venda");
  fsIpsus.Rules().Add(rule7);
  fsIpsus.Rules().Add(rule8);

  //--- Create first input variables for the system
  CFuzzyVariable *fvStoch=new CFuzzyVariable("stoch",0,100.0);
  fvStoch.Terms().Add(new CFuzzyTerm("venda", new CSigmoidalMembershipFunction(0.2,80)));
  fvStoch.Terms().Add(new CFuzzyTerm("compra", new CSigmoidalMembershipFunction(-0.2,20)));
  fsIpsus.Input().Add(fvStoch);
  CMamdaniFuzzyRule *rule10 = fsIpsus.ParseRule("if (stoch is compra) then tendencia is re_compra");
  CMamdaniFuzzyRule *rule11 = fsIpsus.ParseRule("if (stoch is venda) then tendencia is re_venda");
  fsIpsus.Rules().Add(rule10);
  fsIpsus.Rules().Add(rule11);

  //--- Create first input variables for the system
  CFuzzyVariable *fvMFI=new CFuzzyVariable("mfi",0,100.0);
  fvMFI.Terms().Add(new CFuzzyTerm("venda", new CSigmoidalMembershipFunction(0.2,80)));
  fvMFI.Terms().Add(new CFuzzyTerm("compra", new CSigmoidalMembershipFunction(-0.2,20)));
  fsIpsus.Input().Add(fvMFI);
  CMamdaniFuzzyRule *rule12 = fsIpsus.ParseRule("if (mfi is compra) then tendencia is re_compra");
  CMamdaniFuzzyRule *rule13 = fsIpsus.ParseRule("if (mfi is venda) then tendencia is re_venda");
  fsIpsus.Rules().Add(rule12);
  fsIpsus.Rules().Add(rule13);

  //--- Set input value
  CList *in=new CList;
  CDictionary_Obj_Double *p_od_Banda=new CDictionary_Obj_Double;
  CDictionary_Obj_Double *p_od_Rsi=new CDictionary_Obj_Double;
  CDictionary_Obj_Double *p_od_Stoch=new CDictionary_Obj_Double;
  CDictionary_Obj_Double *p_od_MoneyFI=new CDictionary_Obj_Double;

  p_od_Banda.SetAll(fvBanda, Banda);
  p_od_Rsi.SetAll(fvRsi, Rsi);
  p_od_Stoch.SetAll(fvStoch, Estocastico);
  p_od_MoneyFI.SetAll(fvMFI, MoneyFI);

  in.Add(p_od_Banda);
  in.Add(p_od_Rsi);
  in.Add(p_od_Stoch);
  in.Add(p_od_MoneyFI);

  //--- Get result
  CList *result;
  CDictionary_Obj_Double *p_od_Ipsus;
  result=fsIpsus.Calculate(in);
  p_od_Ipsus=result.GetNodeAtIndex(0);
  //   Print("Ipsus, escala: ",p_od_Ipsus.Value());

  retorno = p_od_Ipsus.Value();
  Wesley_Fuzzy_Valor = retorno;

  delete in;
  delete result;
  delete fsIpsus;

  return retorno;
}

void Wesley::Wesley()
{
  if(TaDentroDoHorario_RT)
  {
    Get_Dados();
    Abre();
  }
  if(!Otimizacao) Comentario();

  if(Wesley_Sai_Em_Zero && O_Stops.Tipo_Posicao() != 0 ) Fecha();
}

void Wesley::Abre()
{
  if(Wesley_Fuzzy_Valor > Wesley_Valor_Venda)
  {
    Opera_Mercado *opera = new Opera_Mercado;
    opera.AbrePosicao(ORDER_TYPE_SELL,DoubleToString(Wesley_BB_Valor,0) + ";" + DoubleToString(Wesley_BB_Delta_Valor,0) + ";" + DoubleToString(Wesley_RSI_Valor,0) + ";" + DoubleToString(Wesley_Stoch_Valor,0) + ";" + DoubleToString(Wesley_MF_Valor,0) + ";" + DoubleToString(Wesley_Volumes,0));
    delete(opera);
  }

  if(Wesley_Fuzzy_Valor < Wesley_Valor_Compra)
  {
    Opera_Mercado *opera = new Opera_Mercado;
    opera.AbrePosicao(ORDER_TYPE_BUY,DoubleToString(Wesley_BB_Valor,0) + ";" + DoubleToString(Wesley_BB_Delta_Valor,0) + ";" + DoubleToString(Wesley_RSI_Valor,0) + ";" + DoubleToString(Wesley_Stoch_Valor,0) + ";" + DoubleToString(Wesley_MF_Valor,0) + ";" + DoubleToString(Wesley_Volumes,0));
    delete(opera);
  }
}

void Wesley::Fecha()
{
  if(O_Stops.Tipo_Posicao() < 0 && Wesley_Fuzzy_Valor <= 0)
  {
    Opera_Mercado *opera = new Opera_Mercado;
    opera.FechaPosicao() ;
    delete(opera);
  }

  if(O_Stops.Tipo_Posicao() > 0 && Wesley_Fuzzy_Valor >= 0)
  {
    Opera_Mercado *opera = new Opera_Mercado;
    opera.FechaPosicao() ;
    delete(opera);
  }
}

void Wesley::Comentario()
{
  Comentario_Robo = "\n Wesley_BB_Tamanho_Porcent BB: " + DoubleToString(Wesley_BB_Valor,2);
  Comentario_Robo = Comentario_Robo + "\n CalculaRSI: " + DoubleToString(Wesley_RSI_Valor,2);
  Comentario_Robo = Comentario_Robo + "\n Stoch: " + DoubleToString(Wesley_Stoch_Valor,2);
  Comentario_Robo = Comentario_Robo + "\n MFI: " + DoubleToString(Wesley_MF_Valor,2);
  Comentario_Robo = Comentario_Robo + "\n Wesley_BB_Delta_Valor: " + DoubleToString(Wesley_BB_Delta_Valor,2);
  Comentario_Robo = Comentario_Robo + "\n Wesley_Volumes: " + DoubleToString(Wesley_Volumes,2);
  Comentario_Robo = Comentario_Robo + "\n Fuzzy_Respo(): " + DoubleToString(Wesley_Fuzzy_Valor,2);
}

//+------------------------------------------------------------------+
