/* -*- C++ -*- */
int resposta;

class Capta_Dados_Entrada {
  public:
  void Dados_Entrada();
  void Saida(double Profit);
  double Capta_Dados_Entrada::Normaliza_NN(double valor, int tipo);
  double Capta_Dados_Entrada::Hora();

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
  MACD *macd = new MACD(12,26,9,Symbol(),TimeFrame); //Só aqui tem uns 4
  Momentum *momentum = new Momentum();
  Stoch *stoch = new Stoch(10,3,3,TimeFrame); //Memo papo do MACD
  Volumes *volumes = new Volumes(Symbol(),TimeFrame);
  WPR *wpr = new WPR();
  OBV *obv = new OBV(TimeFrame);

  BB_Cx_BB_Low = Normaliza_NN(banda_bolinger.Cx_BB_Low(0),0);
  BB_Cx_BB_Base = Normaliza_NN(banda_bolinger.Cx_BB_Base(0),0);
  BB_Cx_BB_High = Normaliza_NN(banda_bolinger.Cx_BB_High(0),0);
  BB_Cx_BB_Delta_Bruto = Normaliza_NN(banda_bolinger.Cx_BB_Delta_Bruto(0),0);
  BB_Cx_BB_Posicao_Percent = Normaliza_NN(banda_bolinger.Cx_BB_Posicao_Percent(0),0);
  BB_Normalizado_BB_Low = Normaliza_NN(banda_bolinger.Normalizado_BB_Low(0),1);
  BB_Normalizado_BB_Base = Normaliza_NN(banda_bolinger.Normalizado_BB_Base(0),1);
  BB_Normalizado_BB_High = Normaliza_NN(banda_bolinger.Normalizado_BB_High(0),1);
  BB_Normalizado_BB_Delta_Bruto = Normaliza_NN(banda_bolinger.Normalizado_BB_Delta_Bruto(0),1);
  BB_Posicao_Percent = Normaliza_NN((banda_bolinger.BB_Posicao_Percent(0)+50)/200,1);
  RSI_Valor = Normaliza_NN(rsi.Valor(0)/100,1);
  RSI_Cx = Normaliza_NN(rsi.Cx(0),0);
  RSI_Normalizado = Normaliza_NN(rsi.Normalizado(0),1);
  Hilo = Normaliza_NN((hilo.Direcao()+1)/2,1);

  Hora_n = Normaliza_NN(Hora(),1);
  MFI_Normalizado = Normaliza_NN(mfi.Normalizado(0)/100,1) ;
  MFI_Cx = Normaliza_NN(mfi.Cx(0),0);
  Demarker_Normalizado = Normaliza_NN(demarker.Normalizado(0),1);
  Demarker_Cx = Normaliza_NN(demarker.Cx(0),0);
  Bulls_Normalizado = Normaliza_NN(bulls.Normalizado(0),1);
  Bulls_Cx = Normaliza_NN(bulls.Cx(0),0);
  Bears_Normalizado = Normaliza_NN(bears.Normalizado(0),1);
  Bears_Cx = Normaliza_NN(bears.Cx(0),0);
  AC_Normalizado = Normaliza_NN(ac.Normalizado(0),1);
  AC_Cx = Normaliza_NN(ac.Cx(0),0);
  ADX_Normalizado = Normaliza_NN(adx.Normalizado(0),1);
  ADX_Cx = Normaliza_NN(adx.Cx(0),0);
  Igor_N = Normaliza_NN(igor.Fuzzy_CEV()/100,1);

  ATR_Normalizado = Normaliza_NN(atr.Normalizado(0),1);
  ATR_Cx = Normaliza_NN(atr.Cx(0),0);
  CCI_Normalizado = Normaliza_NN(cci.Normalizado(0),1);
  CCI_Cx = Normaliza_NN(cci.Cx(0),0);
  DP_MM20 = Normaliza_NN((dp.DirecaoMM20(0)+1)/2,1);
  DP_PRMM20 = Normaliza_NN((dp.PrecoRMM20(0)+1)/2,1);
  DP_mm20AAmm50 = Normaliza_NN((dp.MM20AcimaAbaixoMM50(0)+1)/2,1);
  DP_Direcao = Normaliza_NN((dp.Direcao(0)+1)/2,1);
  MACD_normalizado0 = Normaliza_NN(macd.Normalizacao_Valores_MACD(0,0,0),1);
  MACD_normalizado1 = Normaliza_NN(macd.Normalizacao_Valores_MACD(0,0,1),1);
  MACD_normalizado2 = Normaliza_NN(macd.Normalizacao_Valores_MACD(0,0,-1),1);
  MACD_Distancia_Linha_Zero = Normaliza_NN(macd.Distancia_Linha_Zero(0),1);
  MACD_Distancia_Linha_Sinal = Normaliza_NN(macd.Distancia_Linha_Sinal(0),1);
  MACD_Diferenca_Angulo_Linha_Sinal = Normaliza_NN(macd.Diferenca_Angulo_Linha_Sinal(),0);
  MACD_Cx0 = Normaliza_NN(macd.Cx(0),0);
  MACD_Cx1 = Normaliza_NN(macd.Cx(1),0);
  MACD_Cx2 = Normaliza_NN(macd.Cx(-1),0);
  Momentum_Normalizado = Normaliza_NN(momentum.Normalizado(0),1);
  Momentum_Cx = Normaliza_NN(momentum.Cx(0),0);
  Stoch_Normalizado0 = Normaliza_NN(stoch.Normalizado(0,0),1);
  Stoch_Normalizado1 = Normaliza_NN(stoch.Normalizado(1,0),1);
  Stoch_Cx0 = Normaliza_NN(stoch.Cx(0,0),0);
  Stoch_Cx1 = Normaliza_NN(stoch.Cx(1,0),0);
  Volumes_Normalizado = Normaliza_NN(volumes.Normalizado(0),1);
  Volumes_Cx = Normaliza_NN(volumes.Cx(0),0);
  WPR_Normalizado = Normaliza_NN(wpr.Normalizado(0),1);
  WPR_Cx = Normaliza_NN(wpr.Cx(0),0);
  OBV_Normalizado = Normaliza_NN(obv.Normalizado(0),1);
  OBV_Cx = Normaliza_NN(obv.Cx(0),0);


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

  //Aqui é o resultado da classe.
  Linha_Montada += DoubleToString(n_(Profit*100,0,1),6); //Que eu pelo visto pilantrei e to colocando direto na normalizacao o x100 é para o Forex que paga em Centavos
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
