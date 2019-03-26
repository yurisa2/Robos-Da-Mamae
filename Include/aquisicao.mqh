class Aquisicao {

  public:
  Aquisicao(int norm_period = 7);
  void Dados(int barra = 0);
  void Zerar();
  void passArray();
  double todosDados[72]; // CONTAR FEATURES ABAIXO

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
  // 10 Acima
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
  // 10 Acima
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
  // 10 Acima
  double CCI_norm;
  double DeMarker_Var;
  double DeMarker_Var_Cx;
  double DeMarker_norm;
  int DP_DMM20;
  int DP_PAAMM20;
  int DP_MM20MM50;
  int DP_D;
  int DP_D_Perm;
  int Hilo_Direcao;
  // 10 Acima
  int Hilo_Perm;
  double MA_high;
  double MA_low;
  double MA_delta;
  double MACD_FW;
  double MACD_Cx_0;
  double MACD_Cx_1;
  double MACD_Diff_Angulo_LS;
  double MACD_Distancia_Linha_Sinal;
  double MACD_Distancia_Linha_Zero;
  // 10 Acima
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
  // 10 Acima
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
  // 10 Acima
  double WPR_Var_Cx;
  double WPR_norm;

  int norm_period_;

  private:

};

void Aquisicao::Aquisicao(int norm_period = 7)
{
  this.norm_period_ = norm_period;
  Dados();
}

void Aquisicao::Dados(int barra = 0)
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
  MA *MA_High_o = new MA(3,MODE_SMA,PERIOD_CURRENT,0,PRICE_HIGH);
  MA *MA_Low_o = new MA(3,MODE_SMA,PERIOD_CURRENT,0,PRICE_LOW);
  MACD *macd = new MACD(12,26,9,NULL,TimeFrame);
  MFI *MFI_OO = new MFI(TimeFrame);
  Momentum *Momentum_OO = new Momentum();
  RSI *RSI_OO = new RSI(14,TimeFrame);
  Stoch *Stoch_OO = new Stoch(10,3,3,TimeFrame);
  Volumes *Volumes_OO = new Volumes(NULL,TimeFrame);
  WPR *WPR_Ind = new WPR();

  //Valores 0-100
  AC_Var  =  AC_Ind.Valor(barra)  ;
  AD_Var   =  AD_Ind.Valor(barra)  ;
  ADX_FW  = ADX_OO.Valor(0,barra) ;
  ATR_Var =   ATR_Ind.Valor(barra) ;
  BullsP_Var =   BullsPower_Ind.Valor(barra+1) ;
  BearsP_Var =   BearsPower_Ind.Valor(barra+1) ;
  MACD_Distancia_Linha_Sinal = macd.Distancia_Linha_Sinal();
  MACD_Distancia_Linha_Zero = macd.Distancia_Linha_Zero();
  MACD_Normalizacao = macd.Normalizacao_Valores_MACD(0,0,0);
  MACD_Normalizacao_Zero = macd.Normalizacao_Valores_MACD(0,0,-1);
  MFI_FW = MFI_OO.Valor(barra) ;
  Volume_FW = Volumes_OO.Valor(barra+1) ;
  DeMarker_Var =  DeMarker_Ind.Valor(barra)  ;
  BB_Posicao_Percent = Banda_BB.BB_Posicao_Percent(barra);
  RSI_Var =  RSI_OO.Valor(barra)  ;
  Stoch_FW = Stoch_OO.Valor(barra) ;

  //Angulares -90-90 (mas....nï¿½)
  AC_cx  =  AC_Ind.Cx(barra)*conv  ;
  AD_cx   =  AD_Ind.Cx(barra)*conv  ;
  adx_cx  = ADX_OO.Cx(0,barra)*conv  ;
  ATR_cx =   ATR_Ind.Cx(barra)*conv;
  BullsP_Var_Cx =   BullsPower_Ind.Cx(barra)*conv;
  BearsP_Var_Cx =   BearsPower_Ind.Cx(barra)*conv;
  BWMFI_Var_Cx =   BWMFI_Ind.Cx(barra)*conv;
  CCI_Var_Cx =  CCI_Ind.Cx(barra)*conv;
  DeMarker_Var_Cx =  DeMarker_Ind.Cx(barra)*conv;
  MACD_Cx_0 = macd.Cx(barra)*conv ;
  MACD_Cx_1 = macd.Cx(barra+1)*conv ;
  MACD_Diff_Angulo_LS = macd.Diferenca_Angulo_Linha_Sinal()*conv;
  MFI_Cx = MFI_OO.Cx(barra)*conv;
  Momentum_Var_Cx =  Momentum_OO.Cx(barra)*conv;
  RSI_Var_Cx =  RSI_OO.Cx(barra)*conv  ;
  Stoch_Cx_0 = Stoch_OO.Cx(0,barra)*conv ;
  Stoch_Cx_1 = Stoch_OO.Cx(1,barra)*conv ;
  Volume_Cx = Volumes_OO.Cx(barra+1)*conv ;
  WPR_Var_Cx = WPR_Ind.Cx(barra)*conv   ;
  BB_Delta_Bruto_Cx = Banda_BB.Cx_BB_Delta_Bruto(barra)*conv ;
  BB_Posicao_Percent_Cx = Banda_BB.Cx_BB_Posicao_Percent(barra)*conv ;

  //Brutos e Livres (as vezes atï¿½ binï¿½rios e relativos)
  BB_Delta_Bruto = Banda_BB.BB_Delta_Bruto(barra) ;
  Banda_Delta_Valor = Banda_BB.Banda_Delta_Valor(barra) ;
  BWMFI_Var =   BWMFI_Ind.Valor(barra+1) ;
  CCI_Var =  CCI_Ind.Valor(barra)  ;
  DP_DMM20 = DP_Ind.DirecaoMM20(barra);
  DP_PAAMM20 = DP_Ind.PrecoRMM20(barra);
  DP_MM20MM50 = DP_Ind.MM20AcimaAbaixoMM50(barra);
  DP_D = DP_Ind.Direcao(barra);
  DP_D_Perm = DP_Ind.Permanencia(barra);
  Hilo_Direcao = hilo.Direcao(barra+1);
  Hilo_Perm = hilo.Permanencia(barra+1);
  MA_high = MA_High_o.Valor(barra);
  MA_low = MA_Low_o.Valor(barra);
  MA_delta = MA_high - MA_low;
  MACD_FW = macd.Valor(barra) ;
  Momentum_Var =  Momentum_OO.Valor(barra)  ;
  WPR_Var = WPR_Ind.Valor(barra)   ;

  // Normalizados 0..1
  AC_norm = AC_Ind.Normalizado(barra,this.norm_period_);
  AD_norm = AD_Ind.Normalizado(barra,this.norm_period_);
  adx_norm = ADX_OO.Normalizado(0,barra,this.norm_period_);
  ATR_norm = ATR_Ind.Normalizado(barra,this.norm_period_);
  BB_Delta_Bruto_norm = Banda_BB.Normalizado_BB_Delta_Bruto(barra,this.norm_period_);
  BB_Posicao_Percent_norm = Banda_BB.Normalizado_BB_Posicao_Percent(barra,this.norm_period_);
  BullsP_norm = BullsPower_Ind.Normalizado(barra,this.norm_period_);
  BearsP_norm = BullsPower_Ind.Normalizado(barra,this.norm_period_);
  BWMFI_norm = BWMFI_Ind.Normalizado(barra,this.norm_period_);
  CCI_norm = CCI_Ind.Normalizado(barra,this.norm_period_);
  DeMarker_norm = DeMarker_Ind.Normalizado(barra,this.norm_period_);
  MFI_norm = MFI_OO.Normalizado(barra,this.norm_period_);
  Momentum_norm = Volumes_OO.Normalizado(barra,this.norm_period_);
  RSI_norm = RSI_OO.Normalizado(barra,this.norm_period_);
  Stoch_norm_1 = Stoch_OO.Normalizado(0,barra,this.norm_period_);
  Stoch_norm_2 = Stoch_OO.Normalizado(1,barra+1,this.norm_period_);
  Volume_norm = Volumes_OO.Normalizado(barra,this.norm_period_);
  WPR_norm = WPR_Ind.Normalizado(barra,this.norm_period_);

  this.passArray();

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
  delete(MA_High_o);
  delete(MA_Low_o);
  delete(macd);
  delete(MFI_OO);
  delete(Momentum_OO);
  delete(RSI_OO);
  delete(Stoch_OO);
  delete(Volumes_OO);
  delete(WPR_Ind);

}

void Aquisicao::Zerar() {
  this.AC_Var = NULL;
  this.AC_cx = NULL;
  this.AC_norm = NULL;
  this.AD_Var = NULL;
  this.AD_cx = NULL;
  this.AD_norm = NULL;
  this.ADX_FW = NULL;
  this.adx_cx = NULL;
  this.adx_norm = NULL;
  this.ATR_Var = NULL;
  this.ATR_cx = NULL;
  this.ATR_norm = NULL;
  this.BB_Delta_Bruto = NULL;
  this.BB_Delta_Bruto_Cx = NULL;
  this.BB_Delta_Bruto_norm = NULL;
  this.Banda_Delta_Valor = NULL;
  this.BB_Posicao_Percent = NULL;
  this.BB_Posicao_Percent_Cx = NULL;
  this.BB_Posicao_Percent_norm = NULL;
  this.BullsP_Var = NULL;
  this.BullsP_Var_Cx = NULL;
  this.BullsP_norm = NULL;
  this.BearsP_Var = NULL;
  this.BearsP_Var_Cx = NULL;
  this.BearsP_norm = NULL;
  this.BWMFI_Var = NULL;
  this.BWMFI_Var_Cx = NULL;
  this.BWMFI_norm = NULL;
  this.CCI_Var = NULL;
  this.CCI_Var_Cx = NULL;
  this.CCI_norm = NULL;
  this.DeMarker_Var = NULL;
  this.DeMarker_Var_Cx = NULL;
  this.DeMarker_norm = NULL;
  this.DP_DMM20 = NULL;
  this.DP_PAAMM20 = NULL;
  this.DP_MM20MM50 = NULL;
  this.DP_D = NULL;
  this.DP_D_Perm = NULL;
  this.Hilo_Direcao = NULL;
  this.Hilo_Perm = NULL;
  this.MA_high = NULL;
  this.MA_low = NULL;
  this.MA_delta = NULL;
  this.MACD_FW = NULL;
  this.MACD_Cx_0 = NULL;
  this.MACD_Cx_1 = NULL;
  this.MACD_Diff_Angulo_LS = NULL;
  this.MACD_Distancia_Linha_Sinal = NULL;
  this.MACD_Distancia_Linha_Zero = NULL;
  this.MACD_Normalizacao = NULL;
  this.MACD_Normalizacao_Zero = NULL;
  this.MFI_FW = NULL;
  this.MFI_Cx = NULL;
  this.MFI_norm = NULL;
  this.Momentum_Var = NULL;
  this.Momentum_Var_Cx = NULL;
  this.Momentum_norm = NULL;
  this.RSI_Var = NULL;
  this.RSI_Var_Cx = NULL;
  this.RSI_norm = NULL;
  this.Stoch_FW = NULL;
  this.Stoch_Cx_0 = NULL;
  this.Stoch_Cx_1 = NULL;
  this.Stoch_norm_1 = NULL;
  this.Stoch_norm_2 = NULL;
  this.Volume_FW = NULL;
  this.Volume_Cx = NULL;
  this.Volume_norm = NULL;
  this.WPR_Var = NULL;
  this.WPR_Var_Cx = NULL;
  this.WPR_norm = NULL;
}

void Aquisicao::passArray() {
  int f = 0;
  this.todosDados[f] = this.AC_Var;
  this.todosDados[f++] = this.AC_cx;
  this.todosDados[f++] = this.AC_norm;
  this.todosDados[f++] = this.AD_Var;
  this.todosDados[f++] = this.AD_cx;
  this.todosDados[f++] = this.AD_norm;
  this.todosDados[f++] = this.ADX_FW;
  this.todosDados[f++] = this.adx_cx;
  this.todosDados[f++] = this.adx_norm;
  this.todosDados[f++] = this.ATR_Var;
  this.todosDados[f++] = this.ATR_cx;
  this.todosDados[f++] = this.ATR_norm;
  this.todosDados[f++] = this.BB_Delta_Bruto;
  this.todosDados[f++] = this.BB_Delta_Bruto_Cx;
  this.todosDados[f++] = this.BB_Delta_Bruto_norm;
  this.todosDados[f++] = this.Banda_Delta_Valor;
  this.todosDados[f++] = this.BB_Posicao_Percent;
  this.todosDados[f++] = this.BB_Posicao_Percent_Cx;
  this.todosDados[f++] = this.BB_Posicao_Percent_norm;
  this.todosDados[f++] = this.BullsP_Var;
  this.todosDados[f++] = this.BullsP_Var_Cx;
  this.todosDados[f++] = this.BullsP_norm;
  this.todosDados[f++] = this.BearsP_Var;
  this.todosDados[f++] = this.BearsP_Var_Cx;
  this.todosDados[f++] = this.BearsP_norm;
  this.todosDados[f++] = this.BWMFI_Var;
  this.todosDados[f++] = this.BWMFI_Var_Cx;
  this.todosDados[f++] = this.BWMFI_norm;
  this.todosDados[f++] = this.CCI_Var;
  this.todosDados[f++] = this.CCI_Var_Cx;
  this.todosDados[f++] = this.CCI_norm;
  this.todosDados[f++] = this.DeMarker_Var;
  this.todosDados[f++] = this.DeMarker_Var_Cx;
  this.todosDados[f++] = this.DeMarker_norm;
  this.todosDados[f++] = this.DP_DMM20;
  this.todosDados[f++] = this.DP_PAAMM20;
  this.todosDados[f++] = this.DP_MM20MM50;
  this.todosDados[f++] = this.DP_D;
  this.todosDados[f++] = this.DP_D_Perm;
  this.todosDados[f++] = this.Hilo_Direcao;
  this.todosDados[f++] = this.Hilo_Perm;
  this.todosDados[f++] = this.MA_high;
  this.todosDados[f++] = this.MA_low;
  this.todosDados[f++] = this.MA_delta;
  this.todosDados[f++] = this.MACD_FW;
  this.todosDados[f++] = this.MACD_Cx_0;
  this.todosDados[f++] = this.MACD_Cx_1;
  this.todosDados[f++] = this.MACD_Diff_Angulo_LS;
  this.todosDados[f++] = this.MACD_Distancia_Linha_Sinal;
  this.todosDados[f++] = this.MACD_Distancia_Linha_Zero;
  this.todosDados[f++] = this.MACD_Normalizacao;
  this.todosDados[f++] = this.MACD_Normalizacao_Zero;
  this.todosDados[f++] = this.MFI_FW;
  this.todosDados[f++] = this.MFI_Cx;
  this.todosDados[f++] = this.MFI_norm;
  this.todosDados[f++] = this.Momentum_Var;
  this.todosDados[f++] = this.Momentum_Var_Cx;
  this.todosDados[f++] = this.Momentum_norm;
  this.todosDados[f++] = this.RSI_Var;
  this.todosDados[f++] = this.RSI_Var_Cx;
  this.todosDados[f++] = this.RSI_norm;
  this.todosDados[f++] = this.Stoch_FW;
  this.todosDados[f++] = this.Stoch_Cx_0;
  this.todosDados[f++] = this.Stoch_Cx_1;
  this.todosDados[f++] = this.Stoch_norm_1;
  this.todosDados[f++] = this.Stoch_norm_2;
  this.todosDados[f++] = this.Volume_FW;
  this.todosDados[f++] = this.Volume_Cx;
  this.todosDados[f++] = this.Volume_norm;
  this.todosDados[f++] = this.WPR_Var;
  this.todosDados[f++] = this.WPR_Var_Cx;
  this.todosDados[f++] = this.WPR_norm;
  this.todosDados[f++] = this.norm_period_;
}

Aquisicao aquisicao_entrada;
