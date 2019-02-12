/* -*- C++ -*- */
int resposta;

class Capta_Dados_Entrada {
  public:
  void Dados_Entrada();
  void Saida(double Profit);
  double Normaliza_NN(double valor, int tipo);
  double Hora();
  double x_entrada[57];

  //Primeiro tier  15 Features
  double BB_Cx_BB_Low;
  double BB_Cx_BB_Base;
  double BB_Cx_BB_High;
  double BB_Cx_BB_Delta_Bruto;
  double BB_Cx_BB_Posicao_Percent;
  double BB_Normalizado_BB_Low;
  double BB_Normalizado_BB_Base;
  double BB_Normalizado_BB_High;
  double BB_Normalizado_BB_Delta_Bruto;
  double BB_Posicao_Percent;
  double RSI_Valor;
  double RSI_Cx;
  double RSI_Normalizado;
  double Hilo;
  double Hora_n;

  //Segundo Tier 13 Features
  double MFI_Normalizado;
  double MFI_Cx;
  double Demarker_Normalizado;
  double Demarker_Cx;
  double Bulls_Normalizado;
  double Bulls_Cx;
  double Bears_Normalizado;
  double Bears_Cx;
  double AC_Normalizado;
  double AC_Cx;
  double ADX_Normalizado;
  double ADX_Cx;
  double Igor_N;

  //Terceiro Tier, agora a jiripoca vai piar
  //Terceiro Tier, 29 Features
  double ATR_Normalizado;
  double ATR_Cx;
  double CCI_Normalizado;
  double CCI_Cx;
  double DP_MM20;
  double DP_PRMM20;
  double DP_mm20AAmm50;
  double DP_Direcao;
  double MACD_normalizado0;
  double MACD_normalizado1;
  double MACD_normalizado2;
  double MACD_Distancia_Linha_Zero;
  double MACD_Distancia_Linha_Sinal;
  double MACD_Diferenca_Angulo_Linha_Sinal;
  double MACD_Cx0;
  double MACD_Cx1;
  double MACD_Cx2;
  double Momentum_Normalizado;
  double Momentum_Cx;
  double Stoch_Normalizado0;
  double Stoch_Normalizado1;
  double Stoch_Cx0;
  double Stoch_Cx1;
  double Volumes_Normalizado;
  double Volumes_Cx;
  double WPR_Normalizado;
  double WPR_Cx;
  double OBV_Normalizado;
  double OBV_Cx;

};

void Capta_Dados_Entrada::Dados_Entrada()
{
  BB *banda_bolinger = new BB(TimeFrame);
  RSI *rsi = new RSI(14,TimeFrame);
  HiLo_OO *hilo = new HiLo_OO(4);
  MFI *mfi = new MFI(TimeFrame);
  DeMarker *demarker = new DeMarker();
  BullsPower *bulls = new BullsPower();
  BearsPower *bears = new BearsPower();
  AC *ac = new AC();
  ADX *adx = new ADX(14,TimeFrame);
  Igor *igor = new Igor(TimeFrame);

  ATR *atr = new ATR();
  CCI *cci = new CCI();
  DP *dp = new DP(); //TUDO SOMAR 1 e dividir por 2
  MACD *macd = new MACD(12,26,9,Symbol(),TimeFrame); //SÃ³ aqui tem uns 4
  Momentum *momentum = new Momentum();
  Stoch *stoch = new Stoch(10,3,3,TimeFrame); //Memo papo do MACD
  Volumes *volumes = new Volumes(Symbol(),TimeFrame);
  WPR *wpr = new WPR();
  OBV *obv = new OBV(TimeFrame);

  BB_Cx_BB_Low = banda_bolinger.Cx_BB_Low(0);
  BB_Cx_BB_Base = banda_bolinger.Cx_BB_Base(0);
  BB_Cx_BB_High = banda_bolinger.Cx_BB_High(0);
  BB_Cx_BB_Delta_Bruto = banda_bolinger.Cx_BB_Delta_Bruto(0);
  BB_Cx_BB_Posicao_Percent = banda_bolinger.Cx_BB_Posicao_Percent(0);
  BB_Normalizado_BB_Low = banda_bolinger.Normalizado_BB_Low(0);
  BB_Normalizado_BB_Base = banda_bolinger.Normalizado_BB_Base(0);
  BB_Normalizado_BB_High = banda_bolinger.Normalizado_BB_High(0);
  BB_Normalizado_BB_Delta_Bruto = banda_bolinger.Normalizado_BB_Delta_Bruto(0);
  BB_Posicao_Percent = banda_bolinger.BB_Posicao_Percent(0);
  RSI_Valor = rsi.Valor(0);
  RSI_Cx = rsi.Cx(0);
  RSI_Normalizado = rsi.Valor(0);
  Hilo = (hilo.Direcao()+1)/2;

  Hora_n = Hora();
  MFI_Normalizado = mfi.Valor(0);
  MFI_Cx = mfi.Cx(0);
  Demarker_Normalizado = demarker.Valor(0);
  Demarker_Cx = demarker.Cx(0);
  Bulls_Normalizado = bulls.Valor(0);
  Bulls_Cx = bulls.Cx(0);
  Bears_Normalizado = bears.Valor(0);
  Bears_Cx = bears.Cx(0);
  AC_Normalizado = ac.Valor(0);
  AC_Cx = ac.Cx(0);
  ADX_Normalizado = adx.Valor(0);
  ADX_Cx = adx.Cx(0);
  Igor_N = igor.Fuzzy_CEV()/100;

  ATR_Normalizado = atr.Valor(0);
  ATR_Cx = atr.Cx(0);
  CCI_Normalizado = cci.Valor(0);
  CCI_Cx = cci.Cx(0);
  DP_MM20 = dp.DirecaoMM20(0);
  DP_PRMM20 = dp.PrecoRMM20(0);
  DP_mm20AAmm50 = dp.MM20AcimaAbaixoMM50(0);
  DP_Direcao = (dp.Direcao(0)+1)/2;
  MACD_normalizado0 = macd.Normalizacao_Valores_MACD(0,0,0);
  MACD_normalizado1 = macd.Normalizacao_Valores_MACD(0,0,1);
  MACD_normalizado2 = macd.Normalizacao_Valores_MACD(0,0,-1);
  MACD_Distancia_Linha_Zero = macd.Distancia_Linha_Zero(0);
  MACD_Distancia_Linha_Sinal = macd.Distancia_Linha_Sinal(0);
  MACD_Diferenca_Angulo_Linha_Sinal = macd.Diferenca_Angulo_Linha_Sinal();
  MACD_Cx0 = macd.Cx(0);
  MACD_Cx1 = macd.Cx(1);
  MACD_Cx2 = macd.Cx(-1);
  Momentum_Normalizado = momentum.Valor(0);
  Momentum_Cx = momentum.Cx(0);
  Stoch_Normalizado0 = stoch.Valor(0,0);
  Stoch_Normalizado1 = stoch.Valor(1,0);
  Stoch_Cx0 = stoch.Cx(0,0);
  Stoch_Cx1 = stoch.Cx(1,0);
  Volumes_Normalizado = volumes.Valor(0);
  Volumes_Cx = volumes.Cx(0);
  WPR_Normalizado = wpr.Valor(0);
  WPR_Cx = wpr.Cx(0);
  OBV_Normalizado = obv.Valor(0);
  OBV_Cx = obv.Cx(0);

  this.x_entrada[0] = BB_Cx_BB_Low;
  this.x_entrada[1] = BB_Cx_BB_Base;
  this.x_entrada[2] = BB_Cx_BB_High;
  this.x_entrada[3] = BB_Cx_BB_Delta_Bruto;
  this.x_entrada[4] = BB_Cx_BB_Posicao_Percent;
  this.x_entrada[5] = BB_Normalizado_BB_Low;
  this.x_entrada[6] = BB_Normalizado_BB_Base;
  this.x_entrada[7] = BB_Normalizado_BB_High;
  this.x_entrada[8] = BB_Normalizado_BB_Delta_Bruto;
  this.x_entrada[9] = BB_Posicao_Percent;
  this.x_entrada[10] = RSI_Valor;
  this.x_entrada[11] = RSI_Cx;
  this.x_entrada[12] = RSI_Normalizado;
  this.x_entrada[13] = Hilo;
  this.x_entrada[14] = Hora_n;
  this.x_entrada[15] = MFI_Normalizado;
  this.x_entrada[16] = MFI_Cx;
  this.x_entrada[17] = Demarker_Normalizado;
  this.x_entrada[18] = Demarker_Cx;
  this.x_entrada[19] = Bulls_Normalizado;
  this.x_entrada[20] = Bulls_Cx;
  this.x_entrada[21] = Bears_Normalizado;
  this.x_entrada[22] = Bears_Cx;
  this.x_entrada[23] = AC_Normalizado;
  this.x_entrada[24] = AC_Cx;
  this.x_entrada[25] = ADX_Normalizado;
  this.x_entrada[26] = ADX_Cx;
  this.x_entrada[27] = Igor_N;
  this.x_entrada[28] = ATR_Normalizado;
  this.x_entrada[29] = ATR_Cx;
  this.x_entrada[30] = CCI_Normalizado;
  this.x_entrada[31] = CCI_Cx;
  this.x_entrada[32] = DP_MM20;
  this.x_entrada[33] = DP_PRMM20;
  this.x_entrada[34] = DP_mm20AAmm50;
  this.x_entrada[35] = DP_Direcao;
  this.x_entrada[36] = MACD_normalizado0;
  this.x_entrada[37] = MACD_normalizado1;
  this.x_entrada[38] = MACD_normalizado2;
  this.x_entrada[39] = MACD_Distancia_Linha_Zero;
  this.x_entrada[40] = MACD_Distancia_Linha_Sinal;
  this.x_entrada[41] = MACD_Diferenca_Angulo_Linha_Sinal;
  this.x_entrada[42] = MACD_Cx0;
  this.x_entrada[43] = MACD_Cx1;
  this.x_entrada[44] = MACD_Cx2;
  this.x_entrada[45] = Momentum_Normalizado;
  this.x_entrada[46] = Momentum_Cx;
  this.x_entrada[47] = Stoch_Normalizado0;
  this.x_entrada[48] = Stoch_Normalizado1;
  this.x_entrada[49] = Stoch_Cx0;
  this.x_entrada[50] = Stoch_Cx1;
  this.x_entrada[51] = Volumes_Normalizado;
  this.x_entrada[52] = Volumes_Cx;
  this.x_entrada[53] = WPR_Normalizado;
  this.x_entrada[54] = WPR_Cx;
  this.x_entrada[55] = OBV_Normalizado;
  this.x_entrada[56] = OBV_Cx;

  delete banda_bolinger;
  delete igor;
  delete rsi;
  delete hilo;
  delete mfi;
  delete demarker;
  delete bulls;
  delete bears;
  delete ac;
  delete adx;

  delete atr;
  delete cci;
  delete dp;
  delete macd;
  delete momentum;
  delete stoch;
  delete volumes;
  delete wpr;
  delete obv;
}

double Capta_Dados_Entrada::Normaliza_NN(double valor, int tipo) //tipo 0 = angular |  1 = normalizado
{
  double retorno = NULL;

  if(tipo == 0) retorno = (valor + 1.57)/3.14;
  else retorno = valor;


  return n_(retorno,0,1);
}

void Capta_Dados_Entrada::Saida(double Profit)
{
  // Print("PRofit "+DoubleToString(Profit));
  string Linha_Montada;
  Linha_Montada += DoubleToString(BB_Cx_BB_Low,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(BB_Cx_BB_Base,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(BB_Cx_BB_High,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(BB_Cx_BB_Delta_Bruto,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(BB_Cx_BB_Posicao_Percent,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(BB_Normalizado_BB_Low,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(BB_Normalizado_BB_Base,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(BB_Normalizado_BB_High,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(BB_Normalizado_BB_Delta_Bruto,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(BB_Posicao_Percent,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(RSI_Valor,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(RSI_Cx,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(RSI_Normalizado,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(Hilo,6);
  Linha_Montada += ",";

  Linha_Montada += DoubleToString(Hora_n,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(MFI_Normalizado,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(MFI_Cx,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(Demarker_Normalizado,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(Demarker_Cx,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(Bulls_Normalizado,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(Bulls_Cx,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(Bears_Normalizado,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(Bears_Cx,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(AC_Normalizado,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(AC_Cx,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(ADX_Normalizado,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(ADX_Cx,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(Igor_N,6);
  Linha_Montada += ",";

  //Terceiro Tier
  Linha_Montada += DoubleToString(ATR_Normalizado,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(ATR_Cx,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(CCI_Normalizado,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(CCI_Cx,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(DP_MM20,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(DP_PRMM20,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(DP_mm20AAmm50,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(DP_Direcao,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(MACD_normalizado0,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(MACD_normalizado1,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(MACD_normalizado2,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(MACD_Distancia_Linha_Zero,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(MACD_Distancia_Linha_Sinal,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(MACD_Diferenca_Angulo_Linha_Sinal,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(MACD_Cx0,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(MACD_Cx1,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(MACD_Cx2,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(Momentum_Normalizado,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(Momentum_Cx,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(Stoch_Normalizado0,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(Stoch_Normalizado1,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(Stoch_Cx0,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(Stoch_Cx1,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(Volumes_Normalizado,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(Volumes_Cx,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(WPR_Normalizado,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(WPR_Cx,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(OBV_Normalizado,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(OBV_Cx,6);
  Linha_Montada += ",";

  //Aqui Ã© o resultado da classe.
  Linha_Montada += DoubleToString(n_(Profit*100,0,1),6); //Que eu pelo visto pilantrei e to colocando direto na normalizacao o x100 Ã© para o Forex que paga em Centavos
    machine_learning.Append(Linha_Montada);

}

double Capta_Dados_Entrada::Hora()
{
  string hrmn[2];
  StringSplit(TimeToString(TimeCurrent(),TIME_MINUTES),StringGetCharacter(":",0),hrmn);

  double horas = StringToInteger(hrmn[0]) * 0.04166666666;
  double minutos = StringToInteger(hrmn[1]) * 0.00069444444;

  return horas+minutos;
}

Capta_Dados_Entrada dados_nn;
