/* -*- C++ -*- */
int resposta;

class Capta_Dados_Entrada {
  public:
  void Dados_Entrada();
  void Saida(double Profit);
  double Capta_Dados_Entrada::Normaliza_NN(double valor, int tipo);
  double Capta_Dados_Entrada::Hora();

  //Primeiro tier  7 Features
  double BB_Normalizado_BB_Delta_Bruto;
  double BB_Posicao_Percent;
  double RSI_Valor;
  double RSI_Cx;
  double Hilo;
  double Hora_n;

};

void Capta_Dados_Entrada::Dados_Entrada()
{
  BB *banda_bolinger = new BB(TimeFrame);
  RSI *rsi = new RSI(14,TimeFrame);
  HiLo_OO *hilo = new HiLo_OO(4);

  BB_Normalizado_BB_Delta_Bruto = Normaliza_NN(banda_bolinger.Normalizado_BB_Delta_Bruto(0),1);
  BB_Posicao_Percent = Normaliza_NN((banda_bolinger.BB_Posicao_Percent(0)+50)/200,1);
  RSI_Valor = Normaliza_NN(rsi.Valor(0)/100,1);
  RSI_Cx = Normaliza_NN(rsi.Cx(0),0);
  Hilo = Normaliza_NN((hilo.Direcao()+1)/2,1);
  Hora_n = Normaliza_NN(Hora(),1);

  delete banda_bolinger;
  delete rsi;
  delete hilo;
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
  Linha_Montada += DoubleToString(BB_Normalizado_BB_Delta_Bruto,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(BB_Posicao_Percent,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(RSI_Valor,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(RSI_Cx,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(Hilo,6);
  Linha_Montada += ",";

  Linha_Montada += DoubleToString(Hora_n,6);
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
