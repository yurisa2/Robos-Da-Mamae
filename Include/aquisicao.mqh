class Aquisicao {

  public:
  Aquisicao(int norm_period = 7);
  void Aquisicao::Dados();
  double Busca_Var(string Var);
  double AC_Var;
  double AC_cx;
  double AC_norm;
  double AD_Var;
  double AD_cx;
  double AD_norm;
  double ADX_FW;
  double adx_cx;
  double adx_norm;
  double ATR_Var;
  double ATR_cx;
  double ATR_norm;
  double BB_Delta_Bruto;
  double BB_Delta_Bruto_Cx;
  double BB_Delta_Bruto_norm;
  double Banda_Delta_Valor;
  double BB_Posicao_Percent;
  double BB_Posicao_Percent_Cx;
  double BB_Posicao_Percent_norm;
  double BullsP_Var;
  double BullsP_Var_Cx;
  double BullsP_norm;
  double BearsP_Var;
  double BearsP_Var_Cx;
  double BearsP_norm;
  double BWMFI_Var;
  double BWMFI_Var_Cx;
  double BWMFI_norm;
  double CCI_Var;
  double CCI_Var_Cx;
  double CCI_norm;
  double DeMarker_Var;
  double DeMarker_Var_Cx;
  double DeMarker_norm;
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
  double MFI_norm;
  double Momentum_Var;
  double Momentum_Var_Cx;
  double Momentum_norm;
  double RSI_Var;
  double RSI_Var_Cx;
  double RSI_norm;
  double Stoch_FW;
  double Stoch_Cx_0;
  double Stoch_Cx_1;
  double Stoch_norm_1;
  double Stoch_norm_2;
  double Volume_FW;
  double Volume_Cx;
  double Volume_norm;
  double WPR_Var;
  double WPR_Var_Cx;
  double WPR_norm;

  private:
  int norm_period_;

};

void Aquisicao::Aquisicao(int norm_period = 7)
{
  this.norm_period_ = norm_period;
  Dados();
}

void Aquisicao::Dados()
{
  double conv = 180 / 3.14159265359;

  TesterHideIndicators(mocosa_indicadores);
  // Print("norm_period_ " + this.norm_period_);

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

  //Valores 0-100
  AC_Var  =  AC_Ind.Valor(0)  ;
  AD_Var   =  AD_Ind.Valor(0)  ;
  ADX_FW  = ADX_OO.Valor(0) ;
  ATR_Var =   ATR_Ind.Valor(0) ;
  BullsP_Var =   BullsPower_Ind.Valor(1) ;
  BearsP_Var =   BearsPower_Ind.Valor(1) ;
  MACD_Distancia_Linha_Sinal = macd.Distancia_Linha_Sinal();
  MACD_Distancia_Linha_Zero = macd.Distancia_Linha_Zero();
  MACD_Normalizacao = macd.Normalizacao_Valores_MACD(0,0,0);
  MACD_Normalizacao_Zero = macd.Normalizacao_Valores_MACD(0,0,-1);
  MFI_FW = MFI_OO.Valor(0) ;
  Volume_FW = Volumes_OO.Valor(1) ;
  DeMarker_Var =  DeMarker_Ind.Valor(0)  ;
  BB_Posicao_Percent = Banda_BB.BB_Posicao_Percent(0);
  RSI_Var =  RSI_OO.Valor(0)  ;
  Stoch_FW = Stoch_OO.Valor(0) ;

  //Angulares -90-90 (mas....n�)
  AC_cx  =  AC_Ind.Cx(0)*conv  ;
  AD_cx   =  AD_Ind.Cx(0)*conv  ;
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
  BB_Delta_Bruto_Cx = Banda_BB.Cx_BB_Delta_Bruto(0)*conv ;
  BB_Posicao_Percent_Cx = Banda_BB.Cx_BB_Posicao_Percent(0)*conv ;

  //Brutos e Livres (as vezes at� bin�rios e relativos)
  BB_Delta_Bruto = Banda_BB.BB_Delta_Bruto(0) ;
  Banda_Delta_Valor = Banda_BB.Banda_Delta_Valor() ;
  BWMFI_Var =   BWMFI_Ind.Valor(1) ;
  CCI_Var =  CCI_Ind.Valor(0)  ;
  DP_DMM20 = DP_Ind.DirecaoMM20(0);
  DP_PAAMM20 = DP_Ind.PrecoRMM20(0);
  DP_MM20MM50 = DP_Ind.MM20AcimaAbaixoMM50(0);
  DP_D = DP_Ind.Direcao(0);
  Hilo_Direcao = hilo.Direcao() ;
  MACD_FW = macd.Valor(0) ;
  Momentum_Var =  Momentum_OO.Valor(0)  ;
  WPR_Var = WPR_Ind.Valor(0)   ;

  // Normalizados 0..1
  AC_norm = AC_Ind.Normalizado(0,this.norm_period_);
  AD_norm = AD_Ind.Normalizado(0,this.norm_period_);
  adx_norm = ADX_OO.Normalizado(0,this.norm_period_);
  ATR_norm = ATR_Ind.Normalizado(0,this.norm_period_);
  BB_Delta_Bruto_norm = Banda_BB.Normalizado_BB_Delta_Bruto(0,this.norm_period_);
  BB_Posicao_Percent_norm = Banda_BB.Normalizado_BB_Posicao_Percent(0,this.norm_period_);
  BullsP_norm = BullsPower_Ind.Normalizado(0,this.norm_period_);
  BearsP_norm = BullsPower_Ind.Normalizado(0,this.norm_period_);
  BWMFI_norm = BWMFI_Ind.Normalizado(0,this.norm_period_);
  CCI_norm = CCI_Ind.Normalizado(0,this.norm_period_);
  DeMarker_norm = DeMarker_Ind.Normalizado(0,this.norm_period_);
  MFI_norm = MFI_OO.Normalizado(0,this.norm_period_);
  Momentum_norm = Volumes_OO.Normalizado(0,this.norm_period_);
  RSI_norm = RSI_OO.Normalizado(0,this.norm_period_);
  Stoch_norm_1 = Stoch_OO.Normalizado(0,0,this.norm_period_);
  Stoch_norm_2 = Stoch_OO.Normalizado(1,0,this.norm_period_);
  Volume_norm = Volumes_OO.Normalizado(0,this.norm_period_);
  WPR_norm = WPR_Ind.Normalizado(0,this.norm_period_);



  delete(AC_Ind);
  delete(AD_Ind);
  delete(ADX_OO);
  delete(ATR_Ind);
  delete(Banda_BB);
  delete(DP_Ind);
  delete(BullsPower_Ind);
  delete(BearsPower_Ind);
  delete(BWMFI_Ind);
  delete(CCI_Ind);
  delete(DeMarker_Ind);
  delete(hilo);
  delete(macd);
  delete(MFI_OO);
  delete(Momentum_OO);
  delete(RSI_OO);
  delete(Stoch_OO);
  delete(Volumes_OO);
  delete(WPR_Ind);

}

double Aquisicao::Busca_Var(string Var)
{
  if(Var == "AC_Var") return AC_Var;
  if(Var == "AC_cx") return AC_cx;
  if(Var == "AD_Var") return AD_Var;
  if(Var == "AD_cx") return AD_cx;
  if(Var == "ADX_FW") return ADX_FW;
  if(Var == "adx_cx") return adx_cx;
  if(Var == "ATR_Var") return ATR_Var;
  if(Var == "ATR_cx") return ATR_cx;
  if(Var == "BB_Delta_Bruto") return BB_Delta_Bruto;
  if(Var == "BB_Delta_Bruto_Cx") return BB_Delta_Bruto_Cx;
  if(Var == "Banda_Delta_Valor") return Banda_Delta_Valor;
  if(Var == "BB_Posicao_Percent") return BB_Posicao_Percent;
  if(Var == "BB_Posicao_Percent_Cx") return BB_Posicao_Percent_Cx;
  if(Var == "BullsP_Var") return BullsP_Var;
  if(Var == "BullsP_Var_Cx") return BullsP_Var_Cx;
  if(Var == "BearsP_Var") return BearsP_Var;
  if(Var == "BearsP_Var_Cx") return BearsP_Var_Cx;
  if(Var == "BWMFI_Var") return BWMFI_Var;
  if(Var == "BWMFI_Var_Cx") return BWMFI_Var_Cx;
  if(Var == "CCI_Var") return CCI_Var;
  if(Var == "CCI_Var_Cx") return CCI_Var_Cx;
  if(Var == "DeMarker_Var") return DeMarker_Var;
  if(Var == "DeMarker_Var_Cx") return DeMarker_Var_Cx;
  if(Var == "DP_DMM20") return DP_DMM20;
  if(Var == "DP_PAAMM20") return DP_PAAMM20;
  if(Var == "DP_MM20MM50") return DP_MM20MM50;
  if(Var == "DP_D") return DP_D;
  if(Var == "Hilo_Direcao") return Hilo_Direcao;
  if(Var == "MACD_FW") return MACD_FW;
  if(Var == "MACD_Cx_0") return MACD_Cx_0;
  if(Var == "MACD_Cx_1") return MACD_Cx_1;
  if(Var == "MACD_Diff_Angulo_LS") return MACD_Diff_Angulo_LS;
  if(Var == "MACD_Distancia_Linha_Sinal") return MACD_Distancia_Linha_Sinal;
  if(Var == "MACD_Distancia_Linha_Zero") return MACD_Distancia_Linha_Zero;
  if(Var == "MACD_Normalizacao") return MACD_Normalizacao;
  if(Var == "MACD_Normalizacao_Zero") return MACD_Normalizacao_Zero;
  if(Var == "MFI_FW") return MFI_FW;
  if(Var == "MFI_Cx") return MFI_Cx;
  if(Var == "Momentum_Var") return Momentum_Var;
  if(Var == "Momentum_Var_Cx") return Momentum_Var_Cx;
  if(Var == "RSI_Var") return RSI_Var;
  if(Var == "RSI_Var_Cx") return RSI_Var_Cx;
  if(Var == "Stoch_FW") return Stoch_FW;
  if(Var == "Stoch_Cx_0") return Stoch_Cx_0;
  if(Var == "Stoch_Cx_1") return Stoch_Cx_1;
  if(Var == "Volume_FW") return Volume_FW;
  if(Var == "Volume_Cx") return Volume_Cx;
  if(Var == "WPR_Var") return WPR_Var;
  if(Var == "WPR_Var_Cx") return WPR_Var_Cx;

  return NULL;

}
