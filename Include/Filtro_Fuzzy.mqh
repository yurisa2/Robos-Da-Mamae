/* -*- C++ -*- */


class FiltroF
{
  public:
  FiltroF() {Aquisicao();};
  ~FiltroF() {};
  double Fuzzy();
  void Aquisicao();
  struct Matrix_Fuzzy
  {
    double a1Neutro;
    double b1Neutro;
    double c1Neutro;
    double d1Neutro;
    double a2Neutro;
    double b2Neutro;
    double c2Neutro;
    double d2Neutro;
    double aRuim;
    double bRuim;
    double cRuim;
    double aMuitoRuim;
    double bMuitoRuim;
    double cMuitoRuim;
    double aMuitoBom;
    double bMuitoBom;
    double cMuitoBom;
    double aBom;
    double bBom;
    double cBom;
  };

  // Matrix_Fuzzy muz;
  Matrix_Fuzzy Calculator(double Bom, double Ruim);

  double AC_Var;
  private:
  double AC_cx;
  double AD_Var;
  double AD_cx;
  double ADX_FW;
  double adx_cx;
  double ATR_Var;
  double ATR_cx;
  double BB_Delta_Bruto;
  double BB_Delta_Bruto_Cx;
  double Banda_Delta_Valor;
  double BB_Posicao_Percent;
  double BB_Posicao_Percent_Cx;
  double BullsP_Var;
  double BullsP_Var_Cx;
  double BearsP_Var;
  double BearsP_Var_Cx;
  double BWMFI_Var;
  double BWMFI_Var_Cx;
  double CCI_Var;
  double CCI_Var_Cx;
  double DeMarker_Var;
  double DeMarker_Var_Cx;
  int DP_DMM20;
  int DP_PAAMM20;
  int DP_MM20MM50;
  int DP_D;
  int Hilo_Direcao;
  double MACD_FW;
  double MACD_Cx_0;
  double MACD_Cx_1;
  double MACD_Diff_Angulo_LS;
  double MACD_Distancia_Linha_Sinal;
  double MACD_Distancia_Linha_Zero;
  double MACD_Normalizacao;
  double MACD_Normalizacao_Zero;
  double MFI_FW;
  double MFI_Cx;
  double Momentum_Var;
  double Momentum_Var_Cx;
  double RSI_Var;
  double RSI_Var_Cx;
  double Stoch_FW;
  double Stoch_Cx_0;
  double Stoch_Cx_1;
  double Volume_FW;
  double Volume_Cx;
  double WPR_Var;
  double WPR_Var_Cx;

};

double FiltroF::Fuzzy()
{
  double retorno = 0;
  //--- Set input value
  CList *in=new CList;
  CMamdaniFuzzySystem *fsFILTRO=new CMamdaniFuzzySystem();
  //--- Create Output
  CFuzzyVariable *fvFILTRO=new CFuzzyVariable("FILTRO",0,100);
  fvFILTRO.Terms().Add(new CFuzzyTerm("MuitoRuim", new CTrapezoidMembershipFunction(0,0,10,20)));
  fvFILTRO.Terms().Add(new CFuzzyTerm("Ruim", new CTriangularMembershipFunction(10,20,30)));
  fvFILTRO.Terms().Add(new CFuzzyTerm("Neutro", new CTrapezoidMembershipFunction(20,30,70,80)));
  fvFILTRO.Terms().Add(new CFuzzyTerm("Bom", new CTriangularMembershipFunction(70,80,90)));
  fvFILTRO.Terms().Add(new CFuzzyTerm("MuitoBom", new CTrapezoidMembershipFunction(80,90,100,100)));
  fsFILTRO.Output().Add(fvFILTRO);

  //--- Create first input variables for the system

  if((Filtro_Fuzzy_AC_Bom - Filtro_Fuzzy_AC_Ruim) != 0)
  {
  Matrix_Fuzzy matriz;
  matriz = Calculator(Filtro_Fuzzy_AC_Bom,Filtro_Fuzzy_AC_Ruim);
  Print("matriz.a1Neutro: "+matriz.a1Neutro);
  Print("matriz.d2Neutro: "+matriz.d2Neutro);

  CFuzzyVariable *fvAC_Ind=new CFuzzyVariable("AC_Ind",matriz.a1Neutro,matriz.d2Neutro);
  fvAC_Ind.Terms().Add(new CFuzzyTerm("NeutroA", new CTrapezoidMembershipFunction(matriz.a1Neutro,matriz.b1Neutro,matriz.c1Neutro,matriz.d1Neutro)));
  fvAC_Ind.Terms().Add(new CFuzzyTerm("MuitoRuim", new CTriangularMembershipFunction(matriz.aMuitoRuim,matriz.bMuitoRuim,matriz.cMuitoRuim)));
  fvAC_Ind.Terms().Add(new CFuzzyTerm("Ruim", new CTriangularMembershipFunction(matriz.aRuim,matriz.bRuim,matriz.cRuim)));
  fvAC_Ind.Terms().Add(new CFuzzyTerm("Bom", new CTriangularMembershipFunction(matriz.aBom,matriz.bBom,matriz.cBom)));
  fvAC_Ind.Terms().Add(new CFuzzyTerm("MuitoBom", new CTriangularMembershipFunction(matriz.aMuitoBom,matriz.bMuitoBom,matriz.cMuitoBom)));
  fvAC_Ind.Terms().Add(new CFuzzyTerm("NeutroB", new CTrapezoidMembershipFunction(matriz.a2Neutro,matriz.b2Neutro,matriz.c2Neutro,matriz.d2Neutro)));
  fsFILTRO.Input().Add(fvAC_Ind);
  CMamdaniFuzzyRule *Ac_Neutro1 = fsFILTRO.ParseRule("if (AC_Ind is NeutroA) then FILTRO is Neutro");
  CMamdaniFuzzyRule *Ac_MuitoRuim = fsFILTRO.ParseRule("if (AC_Ind is MuitoRuim) then FILTRO is MuitoRuim");
  CMamdaniFuzzyRule *Ac_Ruim = fsFILTRO.ParseRule("if (AC_Ind is Ruim) then FILTRO is Ruim");
  CMamdaniFuzzyRule *Ac_Bom = fsFILTRO.ParseRule("if (AC_Ind is Bom) then FILTRO is Bom");
  CMamdaniFuzzyRule *Ac_MuitoBom = fsFILTRO.ParseRule("if (AC_Ind is MuitoBom) then FILTRO is MuitoBom");
  CMamdaniFuzzyRule *Ac_Neutro2 = fsFILTRO.ParseRule("if (AC_Ind is NeutroB) then FILTRO is Neutro");
  fsFILTRO.Rules().Add(Ac_Neutro1);
  fsFILTRO.Rules().Add(Ac_MuitoRuim);
  fsFILTRO.Rules().Add(Ac_Ruim);
  fsFILTRO.Rules().Add(Ac_Bom);
  fsFILTRO.Rules().Add(Ac_MuitoBom);
  fsFILTRO.Rules().Add(Ac_Neutro2);
  CDictionary_Obj_Double *p_od_AC_Ind=new CDictionary_Obj_Double;
  in.Add(p_od_AC_Ind);
  p_od_AC_Ind.SetAll(fvAC_Ind, AC_Var);
  }

  //--- Get result
  CList *result;
  CDictionary_Obj_Double *p_od_Ipsus;
  result=fsFILTRO.Calculate(in);
  p_od_Ipsus=result.GetNodeAtIndex(0);
  //   Print("Ipsus, escala: ",p_od_Ipsus.Value());

  retorno = p_od_Ipsus.Value();

  delete in;
  delete result;
  delete fsFILTRO;

  return retorno;
}


void FiltroF::Aquisicao()
{
  AC *AC_Ind = new AC();
  AD *AD_Ind = new AD();
  ADX *ADX_OO = new ADX(14,TimeFrame);
  ATR *ATR_Ind = new ATR();
  BB *Banda_BB = new BB(TimeFrame);
  BullsPower *BullsPower_Ind = new BullsPower();
  BearsPower *BearsPower_Ind = new BearsPower();
  BWMFI *BWMFI_Ind = new BWMFI();
  CCI *CCI_Ind = new CCI();
  DeMarker *DeMarker_Ind = new DeMarker();
  DP *DP_Ind = new DP();
  HiLo_OO *hilo = new HiLo_OO(4);
  MACD *macd = new MACD(12,26,9,NULL,TimeFrame);
  MFI *MFI_OO = new MFI(TimeFrame);
  Momentum *Momentum_OO = new Momentum();
  RSI *RSI_OO = new RSI(14,TimeFrame);
  Stoch *Stoch_OO = new Stoch(10,3,3,TimeFrame);
  Volumes *Volumes_OO = new Volumes(NULL,TimeFrame);
  WPR *WPR_Ind = new WPR();

  //Normalizados 0-100
  AC_Var  =  AC_Ind.Normalizado(0)*100  ;
  AD_Var   =  AD_Ind.Normalizado(0)*100  ;
  ATR_Var =   ATR_Ind.Normalizado(0)*100 ;
  BullsP_Var =   BullsPower_Ind.Normalizado(1)*100 ;
  BearsP_Var =   BearsPower_Ind.Normalizado(1)*100 ;
  MACD_Distancia_Linha_Sinal = macd.Distancia_Linha_Sinal()*100;
  MACD_Distancia_Linha_Zero = macd.Distancia_Linha_Zero()*100;
  MACD_Normalizacao = macd.Normalizacao_Valores_MACD(0,0,0)*100;
  MACD_Normalizacao_Zero = macd.Normalizacao_Valores_MACD(0,0,-1)*100;
  MFI_FW = MFI_OO.Valor(0) ;
  Volume_FW = Volumes_OO.Normalizado(1)*100 ;
  DeMarker_Var =  DeMarker_Ind.Valor(0)*100  ;
  BB_Posicao_Percent = Banda_BB.BB_Posicao_Percent(0)*0.666666 ;


  double conv = 180 / 3.14159265359;
  //Angulares -90-90 (mas....né)
  AC_cx  =  AC_Ind.Cx(0)*conv  ;
  AD_cx   =  AD_Ind.Cx(0)*conv  ;
  ADX_FW  = ADX_OO.Valor(0) ;
  adx_cx  = ADX_OO.Cx(0)*conv  ;
  ATR_cx =   ATR_Ind.Cx(0)*conv;
  BullsP_Var_Cx =   BullsPower_Ind.Cx(0)*conv;
  BearsP_Var_Cx =   BearsPower_Ind.Cx(0)*conv;
  BWMFI_Var_Cx =   BWMFI_Ind.Cx(0)*conv;
  CCI_Var_Cx =  CCI_Ind.Cx(0)*conv;
  DeMarker_Var_Cx =  DeMarker_Ind.Cx(0)*conv;
  MACD_Cx_0 = macd.Cx(0)*conv ;
  MACD_Cx_1 = macd.Cx(1)*conv ;
  MACD_Diff_Angulo_LS = macd.Diferenca_Angulo_Linha_Sinal()*conv;
  MFI_Cx = MFI_OO.Cx(0)*conv;
  Momentum_Var_Cx =  Momentum_OO.Cx(0)*conv;
  RSI_Var_Cx =  RSI_OO.Cx(0)*conv  ;
  Stoch_Cx_0 = Stoch_OO.Cx(0,0)*conv ;
  Stoch_Cx_1 = Stoch_OO.Cx(1,0)*conv ;
  Volume_Cx = Volumes_OO.Cx(1)*conv ;
  WPR_Var_Cx = WPR_Ind.Cx(0)*conv   ;


  //Brutos e Livres (as vezes até binários e relativos)
  BB_Delta_Bruto = Banda_BB.BB_Delta_Bruto(0) ;
  BB_Delta_Bruto_Cx = Banda_BB.Cx_BB_Delta_Bruto(0) ;
  Banda_Delta_Valor = Banda_BB.Banda_Delta_Valor() ;
  BB_Posicao_Percent_Cx = Banda_BB.Cx_BB_Posicao_Percent(0) ;
  BWMFI_Var =   BWMFI_Ind.Valor(1) ;
  CCI_Var =  CCI_Ind.Valor(0)  ;
  DP_DMM20 = DP_Ind.DirecaoMM20(0);
  DP_PAAMM20 = DP_Ind.PrecoRMM20(0);
  DP_MM20MM50 = DP_Ind.MM20AcimaAbaixoMM50(0);
  DP_D = DP_Ind.Direcao(0);
  Hilo_Direcao = hilo.Direcao() ;
  MACD_FW = macd.Valor(0) ;
  Momentum_Var =  Momentum_OO.Valor(0)  ;
  RSI_Var =  RSI_OO.Valor(0)  ;
  Stoch_FW = Stoch_OO.Valor(0) ;
  WPR_Var = WPR_Ind.Valor(0)   ;

  delete(AC_Ind);
  delete(AD_Ind);
  delete(ADX_OO);
  delete(ATR_Ind);
  delete(BullsPower_Ind);
  delete(BearsPower_Ind);
  delete(BWMFI_Ind);
  delete(CCI_Ind);
  delete(hilo);
  delete(macd);
  delete(MFI_OO);
  delete(Momentum_OO);
  delete(RSI_OO);
  delete(Stoch_OO);
  delete(Volumes_OO);
  delete(WPR_Ind);
}

Matrix_Fuzzy FiltroF::Calculator(double Bom, double Ruim)
{
  Matrix_Fuzzy muz = {0};
  double Diff = Bom - Ruim;

  double Ia = Ruim - (1000*Diff);
  double Ib = Ruim - (1000*Diff);
  double Ic = Ruim - Diff - Diff;
  double Id = Ruim - Diff;
  double Ja = Ruim - Diff - Diff;
  double Jb = Ruim - Diff;
  double Jc = Ruim;
  double Ka = Ruim - Diff;
  double Kb = Ruim;
  double Kc = Ruim + Diff;
  double La = Bom - Diff;
  double Lb = Bom;
  double Lc = Bom + Diff;
  double Ma = Bom;
  double Mb = Bom + Diff;
  double Mc = Bom + Diff + Diff;
  double Na = Bom + Diff;
  double Nb = Bom + Diff + Diff;
  double Nc = Bom + (1000*Diff);
  double Nd = Bom + (1000*Diff);




  if(Diff > 0)
  {
    muz.a1Neutro = Ia;
    muz.b1Neutro = Ib;
    muz.c1Neutro = Ic;
    muz.d1Neutro = Id;
    muz.aRuim = Ja;
    muz.bRuim = Jb;
    muz.cRuim = Jc;
    muz.aMuitoRuim = Ka;
    muz.bMuitoRuim = Kb;
    muz.cMuitoRuim = Kc;
    muz.aMuitoBom = La;
    muz.bMuitoBom = Lb;
    muz.cMuitoBom = Lc;
    muz.aBom = Ma;
    muz.bBom = Mb;
    muz.cBom = Mc;
    muz.a2Neutro = Na;
    muz.b2Neutro = Nb;
    muz.c2Neutro = Nc;
    muz.d2Neutro = Nd;

  }
  if(Diff < 0)
  {
    muz.a1Neutro = Nd;
    muz.b1Neutro = Nc;
    muz.c1Neutro = Nb;
    muz.d1Neutro = Na;
    muz.aRuim = Jc;
    muz.bRuim = Jb;
    muz.cRuim = Ja;
    muz.aMuitoRuim = Kc;
    muz.bMuitoRuim = Kb;
    muz.cMuitoRuim = Ka;
    muz.aMuitoBom = Lc;
    muz.bMuitoBom = Lb;
    muz.cMuitoBom = La;
    muz.aBom = Mc;
    muz.bBom = Mb;
    muz.cBom = Ma;
    muz.a2Neutro = Id;
    muz.b2Neutro = Ic;
    muz.c2Neutro = Ib;
    muz.d2Neutro = Ia;
  }


  return muz;
}
