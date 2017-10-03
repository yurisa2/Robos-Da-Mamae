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
  double Wesley::Fuzzy_Respo(double Banda = 0, double Rsi = 50, double Estocastico = 50, double MoneyFI = 50,
double BandaL = 0, double RsiL = 50, double EstocasticoL = 50, double MoneyFIL = 50);
  double Wesley_BB_Valor;
  double Wesley_BB_Delta_Valor;
  double Wesley_RSI_Valor;
  double Wesley_Stoch_Valor;
  double Wesley_MF_Valor;
  double Wesley_Volumes;
  double Wesley_BB_ValorL;
  double Wesley_BB_Delta_ValorL;
  double Wesley_RSI_ValorL;
  double Wesley_Stoch_ValorL;
  double Wesley_MF_ValorL;
  double Wesley_VolumesL;
};


void Wesley::Get_Dados()
{
  if(TaDentroDoHorario_RT)
  {
    BB *Banda_BB = new BB(TimeFrame);
    RSI *RSI_OO = new RSI(14,TimeFrame);
    Stoch *Stoch_OO = new Stoch(10,3,3,TimeFrame);
    MFI *MFI_OO = new MFI(TimeFrame);
    Volumes *Volumes_OO = new Volumes(NULL,TimeFrame);
    BB *Banda_BBL = new BB(Wesley_Large);
    RSI *RSI_OOL = new RSI(14,Wesley_Large);
    Stoch *Stoch_OOL = new Stoch(10,3,3,Wesley_Large);
    MFI *MFI_OOL = new MFI(Wesley_Large);
    Volumes *Volumes_OOL = new Volumes(NULL,Wesley_Large);

    Wesley_BB_Valor = Banda_BB.BB_Posicao_Percent();
    Wesley_BB_Delta_Valor = Banda_BB.Banda_Delta_Valor();
    Wesley_RSI_Valor = RSI_OO.Valor();
    Wesley_Stoch_Valor = Stoch_OO.Valor();
    Wesley_MF_Valor = MFI_OO.Valor();
    Wesley_Volumes = Volumes_OO.Valor();
    Wesley_BB_ValorL = Banda_BBL.BB_Posicao_Percent();
    Wesley_BB_Delta_ValorL = Banda_BBL.Banda_Delta_Valor();
    Wesley_RSI_ValorL = RSI_OOL.Valor();
    Wesley_Stoch_ValorL = Stoch_OOL.Valor();
    Wesley_MF_ValorL = MFI_OOL.Valor();
    Wesley_VolumesL = Volumes_OOL.Valor();

    Wesley_Fuzzy_Valor = Fuzzy_Respo(Wesley_BB_Valor,Wesley_RSI_Valor,Wesley_Stoch_Valor,Wesley_MF_Valor,
      Wesley_BB_ValorL,Wesley_RSI_ValorL,Wesley_Stoch_ValorL,Wesley_MF_ValorL
    );

    delete(RSI_OO);
    delete(Banda_BB);
    delete(Volumes_OO);
    delete(Stoch_OO);
    delete(MFI_OO);
    delete(RSI_OOL);
    delete(Banda_BBL);
    delete(Volumes_OOL);
    delete(Stoch_OOL);
    delete(MFI_OOL);
  }
  else
  {
    Wesley_BB_Valor = 0;
    Wesley_RSI_Valor = 0;
    Wesley_Stoch_Valor = 0;
    Wesley_MF_Valor = 0;
    Wesley_BB_ValorL = 0;
    Wesley_RSI_ValorL = 0;
    Wesley_Stoch_ValorL = 0;
    Wesley_MF_ValorL = 0;
  }
}

double Wesley::Fuzzy_Respo(
  double Banda = 0, double Rsi = 50, double Estocastico = 50, double MoneyFI = 50,
double BandaL = 0, double RsiL = 50, double EstocasticoL = 50, double MoneyFIL = 50
)
{
  double retorno = 0;

  // Bloco para nao estourar o FUzzão
  if(Banda < -49) Banda = 0;
  if(Banda > 149) Banda = 149;
  if(Rsi < 0) Rsi = 0;
  if(Rsi > 100) Rsi = 100;
  if(Estocastico < 0) Estocastico = 0;
  if(Estocastico > 100) Estocastico = 100;
  if(MoneyFI < 0) MoneyFI = 0;
  if(MoneyFI > 100) MoneyFI = 100;
  if(BandaL < -49) BandaL = 0;
  if(BandaL > 149) BandaL = 149;
  if(RsiL < 0) RsiL = 0;
  if(RsiL > 100) RsiL = 100;
  if(EstocasticoL < 0) EstocasticoL = 0;
  if(EstocasticoL > 100) EstocasticoL = 100;
  if(MoneyFIL < 0) MoneyFIL = 0;
  if(MoneyFIL > 100) MoneyFIL = 100;
  // Bloco para nao estourar o FUzzão



  //--- Mamdani Fuzzy System
  CMamdaniFuzzySystem *fsIpsus=new CMamdaniFuzzySystem();

  //--- Create Output
  CFuzzyVariable *fvIpsus=new CFuzzyVariable("tendencia",-100,100.0);
  fvIpsus.Terms().Add(new CFuzzyTerm("re_compra", new CSigmoidalMembershipFunction(-0.1,-50)));
  fvIpsus.Terms().Add(new CFuzzyTerm("re_intermediario", new CGeneralizedBellShapedMembershipFunction(50,20,3)));
  fvIpsus.Terms().Add(new CFuzzyTerm("re_venda", new CSigmoidalMembershipFunction(0.1,50)));
  fsIpsus.Output().Add(fvIpsus);

  //--- Create first input variables for the system
  CFuzzyVariable *fvBanda=new CFuzzyVariable("banda_bollinger",-50.0,150.0);
  fvBanda.Terms().Add(new CFuzzyTerm("BB_Compra", new CSigmoidalMembershipFunction(-0.1,0)));
  fvBanda.Terms().Add(new CFuzzyTerm("BB_Meio", new CGeneralizedBellShapedMembershipFunction(50,28,3)));
  fvBanda.Terms().Add(new CFuzzyTerm("BB_Venda", new CSigmoidalMembershipFunction(0.1,100)));
  fsIpsus.Input().Add(fvBanda);
  CMamdaniFuzzyRule *R_Compra_BB = fsIpsus.ParseRule("if (banda_bollinger is BB_Compra)  then tendencia is re_compra");
  CMamdaniFuzzyRule *R_Meio_BB = fsIpsus.ParseRule("if (banda_bollinger is BB_Meio)  then tendencia is re_intermediario");
  CMamdaniFuzzyRule *R_Venda_BB = fsIpsus.ParseRule("if (banda_bollinger is BB_Venda)  then tendencia is re_venda");
  fsIpsus.Rules().Add(R_Compra_BB);
  fsIpsus.Rules().Add(R_Meio_BB);
  fsIpsus.Rules().Add(R_Venda_BB);
  //--- Create first input variables for the system
  CFuzzyVariable *fvBandaBBL=new CFuzzyVariable("banda_bollinger_large",-50.0,150.0);
  fvBandaBBL.Terms().Add(new CFuzzyTerm("BBL_Compra", new CSigmoidalMembershipFunction(-0.1,0)));
  fvBandaBBL.Terms().Add(new CFuzzyTerm("BBL_Meio", new CGeneralizedBellShapedMembershipFunction(50,28,3)));
  fvBandaBBL.Terms().Add(new CFuzzyTerm("BBL_Venda", new CSigmoidalMembershipFunction(0.1,100)));
  fsIpsus.Input().Add(fvBandaBBL);
  CMamdaniFuzzyRule *R_Compra_BBL = fsIpsus.ParseRule("if (banda_bollinger_large is BBL_Compra)  then tendencia is re_compra");
  CMamdaniFuzzyRule *R_Meio_BBL = fsIpsus.ParseRule("if (banda_bollinger_large is BBL_Meio)  then tendencia is re_intermediario");
  CMamdaniFuzzyRule *R_Venda_BBL = fsIpsus.ParseRule("if (banda_bollinger_large is BBL_Venda)  then tendencia is re_venda");
  fsIpsus.Rules().Add(R_Compra_BBL);
  fsIpsus.Rules().Add(R_Meio_BBL);
  fsIpsus.Rules().Add(R_Venda_BBL);

  //--- Create second input variables for the system
  CFuzzyVariable *fvRsi=new CFuzzyVariable("rsi_forca",0.0,100.0);
  fvRsi.Terms().Add(new CFuzzyTerm("RSI_Compra", new CSigmoidalMembershipFunction(-0.2,30)));
  fvRsi.Terms().Add(new CFuzzyTerm("RSI_Meio", new CGeneralizedBellShapedMembershipFunction(50,15,3)));
  fvRsi.Terms().Add(new CFuzzyTerm("RSI_Venda", new CSigmoidalMembershipFunction(0.2,70)));
  fsIpsus.Input().Add(fvRsi);
  CMamdaniFuzzyRule *R_Compra_RSI = fsIpsus.ParseRule("if (rsi_forca is RSI_Compra) then tendencia is re_compra");
  CMamdaniFuzzyRule *R_Meio_RSI = fsIpsus.ParseRule("if (rsi_forca is RSI_Meio) then tendencia is re_intermediario");
  CMamdaniFuzzyRule *R_Venda_RSI = fsIpsus.ParseRule("if (rsi_forca is RSI_Venda) then tendencia is re_venda");
  fsIpsus.Rules().Add(R_Compra_RSI);
  fsIpsus.Rules().Add(R_Meio_RSI);
  fsIpsus.Rules().Add(R_Venda_RSI);
  //--- Create second input variables for the system
  CFuzzyVariable *fvRsil=new CFuzzyVariable("rsil_forca",0,100);
  fvRsil.Terms().Add(new CFuzzyTerm("RSIL_Compra", new CSigmoidalMembershipFunction(-0.2,30)));
  fvRsil.Terms().Add(new CFuzzyTerm("RSIL_Meio", new CGeneralizedBellShapedMembershipFunction(50,15,3)));
  fvRsil.Terms().Add(new CFuzzyTerm("RSIL_Venda", new CSigmoidalMembershipFunction(0.2,70)));
  fsIpsus.Input().Add(fvRsil);
  CMamdaniFuzzyRule *R_Compra_RSIL = fsIpsus.ParseRule("if (rsil_forca is RSIL_Compra) then tendencia is re_compra");
  CMamdaniFuzzyRule *R_Meio_RSIL = fsIpsus.ParseRule("if (rsil_forca is RSIL_Meio) then tendencia is re_intermediario");
  CMamdaniFuzzyRule *R_Venda_RSIL = fsIpsus.ParseRule("if (rsil_forca is RSIL_Venda) then tendencia is re_venda");
  fsIpsus.Rules().Add(R_Compra_RSIL);
  fsIpsus.Rules().Add(R_Meio_RSIL);
  fsIpsus.Rules().Add(R_Venda_RSIL);

  //--- Create first input variables for the system
  CFuzzyVariable *fvStoch=new CFuzzyVariable("stoch",0,100.0);
  fvStoch.Terms().Add(new CFuzzyTerm("S_Compra", new CSigmoidalMembershipFunction(-0.15,20)));
  fvStoch.Terms().Add(new CFuzzyTerm("S_Meio", new CGeneralizedBellShapedMembershipFunction(50,20,3)));
  fvStoch.Terms().Add(new CFuzzyTerm("S_Venda", new CSigmoidalMembershipFunction(0.15,80)));
  fsIpsus.Input().Add(fvStoch);
  CMamdaniFuzzyRule *R_S_Compra = fsIpsus.ParseRule("if (stoch is S_Compra) then tendencia is re_compra");
  CMamdaniFuzzyRule *R_S_Meio = fsIpsus.ParseRule("if (stoch is S_Meio) then tendencia is re_intermediario");
  CMamdaniFuzzyRule *R_S_Venda = fsIpsus.ParseRule("if (stoch is S_Venda) then tendencia is re_venda");
  fsIpsus.Rules().Add(R_S_Compra);
  fsIpsus.Rules().Add(R_S_Meio);
  fsIpsus.Rules().Add(R_S_Venda);
  //--- Create first input variables for the system
  CFuzzyVariable *fvStochl=new CFuzzyVariable("stochL",0,100.0);
  fvStochl.Terms().Add(new CFuzzyTerm("SL_Compra", new CSigmoidalMembershipFunction(-0.15,20)));
  fvStochl.Terms().Add(new CFuzzyTerm("SL_Meio", new CGeneralizedBellShapedMembershipFunction(50,20,3)));
  fvStochl.Terms().Add(new CFuzzyTerm("SL_Venda", new CSigmoidalMembershipFunction(0.15,80)));
  fsIpsus.Input().Add(fvStochl);
  CMamdaniFuzzyRule *R_SL_Compra = fsIpsus.ParseRule("if (stochL is SL_Compra) then tendencia is re_compra");
  CMamdaniFuzzyRule *R_SL_Meio = fsIpsus.ParseRule("if (stochL is SL_Meio) then tendencia is re_intermediario");
  CMamdaniFuzzyRule *R_SL_Venda = fsIpsus.ParseRule("if (stochL is SL_Venda) then tendencia is re_venda");
  fsIpsus.Rules().Add(R_SL_Compra);
  fsIpsus.Rules().Add(R_SL_Meio);
  fsIpsus.Rules().Add(R_SL_Venda);

  //--- Create first input variables for the system
  CFuzzyVariable *fvMFI=new CFuzzyVariable("mfi",0,100.0);
  fvMFI.Terms().Add(new CFuzzyTerm("MFI_Compra", new CSigmoidalMembershipFunction(-0.15,20)));
  fvMFI.Terms().Add(new CFuzzyTerm("MFI_Meio", new CGeneralizedBellShapedMembershipFunction(50,20,3)));
  fvMFI.Terms().Add(new CFuzzyTerm("MFI_Venda", new CSigmoidalMembershipFunction(0.15,80)));
  fsIpsus.Input().Add(fvMFI);
  CMamdaniFuzzyRule *R_MFI_Compra = fsIpsus.ParseRule("if (mfi is MFI_Compra) then tendencia is re_compra");
  CMamdaniFuzzyRule *R_MFI_Meio = fsIpsus.ParseRule("if (mfi is MFI_Meio) then tendencia is re_intermediario");
  CMamdaniFuzzyRule *R_MFI_Venda = fsIpsus.ParseRule("if (mfi is MFI_Venda) then tendencia is re_venda");
  fsIpsus.Rules().Add(R_MFI_Compra);
  fsIpsus.Rules().Add(R_MFI_Meio);
  fsIpsus.Rules().Add(R_MFI_Venda);
  //--- Create first input variables for the system
  CFuzzyVariable *fvMFIL=new CFuzzyVariable("mfiL",0,100.0);
  fvMFIL.Terms().Add(new CFuzzyTerm("MFIL_Compra", new CSigmoidalMembershipFunction(-0.15,20)));
  fvMFIL.Terms().Add(new CFuzzyTerm("MFIL_Meio", new CGeneralizedBellShapedMembershipFunction(50,20,3)));
  fvMFIL.Terms().Add(new CFuzzyTerm("MFIL_Venda", new CSigmoidalMembershipFunction(0.15,80)));
  fsIpsus.Input().Add(fvMFIL);
  CMamdaniFuzzyRule *R_MFIL_Compra = fsIpsus.ParseRule("if (mfiL is MFIL_Compra) then tendencia is re_compra");
  CMamdaniFuzzyRule *R_MFIL_Meio = fsIpsus.ParseRule("if (mfiL is MFIL_Meio) then tendencia is re_intermediario");
  CMamdaniFuzzyRule *R_MFIL_Venda = fsIpsus.ParseRule("if (mfiL is MFIL_Venda) then tendencia is re_venda");
  fsIpsus.Rules().Add(R_MFIL_Compra);
  fsIpsus.Rules().Add(R_MFIL_Meio);
  fsIpsus.Rules().Add(R_MFIL_Venda);

  //--- Set input value
  CList *in=new CList;
  CDictionary_Obj_Double *p_od_Banda=new CDictionary_Obj_Double;
  CDictionary_Obj_Double *p_od_Rsi=new CDictionary_Obj_Double;
  CDictionary_Obj_Double *p_od_Stoch=new CDictionary_Obj_Double;
  CDictionary_Obj_Double *p_od_MoneyFI=new CDictionary_Obj_Double;
  CDictionary_Obj_Double *p_od_BandaL=new CDictionary_Obj_Double;
  CDictionary_Obj_Double *p_od_RsiL=new CDictionary_Obj_Double;
  CDictionary_Obj_Double *p_od_StochL=new CDictionary_Obj_Double;
  CDictionary_Obj_Double *p_od_MoneyFIL=new CDictionary_Obj_Double;

  p_od_Banda.SetAll(fvBanda, Banda);
  p_od_Rsi.SetAll(fvRsi, Rsi);
  p_od_Stoch.SetAll(fvStoch, Estocastico);
  p_od_MoneyFI.SetAll(fvMFI, MoneyFI);
  p_od_BandaL.SetAll(fvBandaBBL, BandaL);
  p_od_RsiL.SetAll(fvRsil, RsiL);
  p_od_StochL.SetAll(fvStochl, EstocasticoL);
  p_od_MoneyFIL.SetAll(fvMFIL, MoneyFIL);

  in.Add(p_od_Banda);
  in.Add(p_od_Rsi);
  in.Add(p_od_Stoch);
  in.Add(p_od_MoneyFI);
  in.Add(p_od_BandaL);
  in.Add(p_od_RsiL);
  in.Add(p_od_StochL);
  in.Add(p_od_MoneyFIL);

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
  double Wesley_Valor_Compra_Mod = 0;

  if(Wesley_Igual_Lados) Wesley_Valor_Compra_Mod = Wesley_Valor_Venda * -1;   //ME DA O TACAPEEEEEEEEEEEEEEEE
  else Wesley_Valor_Compra_Mod = Wesley_Valor_Compra;

  if(Wesley_Fuzzy_Valor > Wesley_Valor_Venda)
  {
    Opera_Mercado *opera = new Opera_Mercado;
    if(!Wesley_Inverte) opera.AbrePosicao(ORDER_TYPE_SELL,DoubleToString(Wesley_BB_Valor,0) + ";" + DoubleToString(Wesley_BB_Delta_Valor,0) + ";" + DoubleToString(Wesley_RSI_Valor,0) + ";" + DoubleToString(Wesley_Stoch_Valor,0) + ";" + DoubleToString(Wesley_MF_Valor,0) + ";" + DoubleToString(Wesley_Volumes,0));
    if(Wesley_Inverte) opera.AbrePosicao(ORDER_TYPE_BUY,DoubleToString(Wesley_BB_Valor,0) + ";" + DoubleToString(Wesley_BB_Delta_Valor,0) + ";" + DoubleToString(Wesley_RSI_Valor,0) + ";" + DoubleToString(Wesley_Stoch_Valor,0) + ";" + DoubleToString(Wesley_MF_Valor,0) + ";" + DoubleToString(Wesley_Volumes,0));
    delete(opera);
  }

  if(Wesley_Fuzzy_Valor < Wesley_Valor_Compra_Mod)
  {
    Opera_Mercado *opera = new Opera_Mercado;
    if(!Wesley_Inverte) opera.AbrePosicao(ORDER_TYPE_BUY,DoubleToString(Wesley_BB_Valor,0) + ";" + DoubleToString(Wesley_BB_Delta_Valor,0) + ";" + DoubleToString(Wesley_RSI_Valor,0) + ";" + DoubleToString(Wesley_Stoch_Valor,0) + ";" + DoubleToString(Wesley_MF_Valor,0) + ";" + DoubleToString(Wesley_Volumes,0));
    if(Wesley_Inverte) opera.AbrePosicao(ORDER_TYPE_SELL,DoubleToString(Wesley_BB_Valor,0) + ";" + DoubleToString(Wesley_BB_Delta_Valor,0) + ";" + DoubleToString(Wesley_RSI_Valor,0) + ";" + DoubleToString(Wesley_Stoch_Valor,0) + ";" + DoubleToString(Wesley_MF_Valor,0) + ";" + DoubleToString(Wesley_Volumes,0));
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
