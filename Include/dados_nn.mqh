/* -*- C++ -*- */
int resposta;

class Capta_Dados_Entrada {
  public:
  void Dados_Entrada();
  void Saida(double Profit);
  double Capta_Dados_Entrada::Normaliza_NN(double valor, int tipo);
  double Capta_Dados_Entrada::Hora();

  double BB_Cx_BB_Low;
  double BB_Cx_BB_Base;
  double BB_Cx_BB_High;
  double BB_Cx_BB_Delta_Bruto;
  double BB_Cx_BB_Posicao_Percent;
  double BB_Normalizado_BB_Low;
  double BB_Normalizado_BB_Base;
  double BB_Normalizado_BB_High;
  double BB_Normalizado_BB_Delta_Bruto;
  double BB_Normalizado_BB_Posicao_Percent;
  double RSI_Valor;
  double RSI_Cx;
  double RSI_Normalizado;
  double Hilo;
  double Hora_n;

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


  BB_Cx_BB_Low = Normaliza_NN(banda_bolinger.Cx_BB_Low(0),0);
  BB_Cx_BB_Base = Normaliza_NN(banda_bolinger.Cx_BB_Base(0),0);
  BB_Cx_BB_High = Normaliza_NN(banda_bolinger.Cx_BB_High(0),0);
  BB_Cx_BB_Delta_Bruto = Normaliza_NN(banda_bolinger.Cx_BB_Delta_Bruto(0),0);
  BB_Cx_BB_Posicao_Percent = Normaliza_NN(banda_bolinger.Cx_BB_Posicao_Percent(0),0);
  BB_Normalizado_BB_Low = Normaliza_NN(banda_bolinger.Normalizado_BB_Low(0),1);
  BB_Normalizado_BB_Base = Normaliza_NN(banda_bolinger.Normalizado_BB_Base(0),1);
  BB_Normalizado_BB_High = Normaliza_NN(banda_bolinger.Normalizado_BB_High(0),1);
  BB_Normalizado_BB_Delta_Bruto = Normaliza_NN(banda_bolinger.Normalizado_BB_Delta_Bruto(0),1);
  BB_Normalizado_BB_Posicao_Percent = Normaliza_NN((banda_bolinger.Normalizado_BB_Posicao_Percent(0)+50)/200,1);
  RSI_Valor = Normaliza_NN(rsi.Valor(0)/100,1);
  RSI_Cx = Normaliza_NN(rsi.Cx(0),0);
  RSI_Normalizado = Normaliza_NN(rsi.Normalizado(0),1);
  Hilo = Normaliza_NN((hilo.Direcao()+1)/2,1);

  Hora_n = Normaliza_NN(Hora(),1);
  MFI_Normalizado = Normaliza_NN(mfi.Normalizado(0),1) ;
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
  string Linha_Montada = DoubleToString(BB_Cx_BB_Low,6);
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
  Linha_Montada += DoubleToString(BB_Normalizado_BB_Posicao_Percent,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(RSI_Valor,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(RSI_Cx,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(RSI_Normalizado,6);
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

  Linha_Montada += DoubleToString(n_(Profit,0,1),6);
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
