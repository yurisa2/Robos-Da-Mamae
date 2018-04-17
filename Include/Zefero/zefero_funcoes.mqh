/* -*- C++ -*- */
ML machine_learning;
class Zefero
{

  public:
  Zefero();
  ~Zefero();
  void Comentario();
  void Entra();

  private:

};

void Zefero::Zefero()
{
}

void Zefero::~Zefero()
{
}

void Zefero::Comentario()
{

}

void Zefero::Entra()
{
  Opera_Mercado *opera = new Opera_Mercado;
  // opera.FechaPosicao();
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;
  if(Condicoes.Horario())
  {
    dados_nn.Dados_Entrada();
    BB *banda_bolinger = new BB(TimeFrame);
    double Direcao_Zef = banda_bolinger.Cx_BB_Base(0);

    if(Direcao_Zef > 0) opera.AbrePosicao(1,"Zef: ");


    delete banda_bolinger;
  }
  delete(Condicoes);
  delete opera;
}

void on_trade_robo::on_trade_robo(int es=0, double lucro = 0) //in = 1 |  out = -1
{
  io = es;
  if(io == -1) dados_nn.Saida(lucro);
};



class Capta_Dados_Entrada {
  public:
  void Dados_Entrada();
  void Saida(double Profit);
  double Capta_Dados_Entrada::Normaliza_NN(double valor, int tipo);

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
  double Hora;
  double Hilo;

};

Capta_Dados_Entrada dados_nn;


void Capta_Dados_Entrada::Dados_Entrada()
{
  BB *banda_bolinger = new BB(TimeFrame);
  RSI *rsi = new RSI(14,TimeFrame);
  HiLo_OO *hilo = new HiLo_OO(4);

  BB_Cx_BB_Low = Normaliza_NN(banda_bolinger.Cx_BB_Low(0),0);
  BB_Cx_BB_Base = Normaliza_NN(banda_bolinger.Cx_BB_Base(0),0);
  BB_Cx_BB_High = Normaliza_NN(banda_bolinger.Cx_BB_High(0),0);
  BB_Cx_BB_Delta_Bruto = Normaliza_NN(banda_bolinger.Cx_BB_Delta_Bruto(0),0);
  BB_Cx_BB_Posicao_Percent = Normaliza_NN(banda_bolinger.Cx_BB_Posicao_Percent(0),0);
  BB_Normalizado_BB_Low = Normaliza_NN(banda_bolinger.Normalizado_BB_Low(0),1);
  BB_Normalizado_BB_Base = Normaliza_NN(banda_bolinger.Normalizado_BB_Base(0),1);
  BB_Normalizado_BB_High = Normaliza_NN(banda_bolinger.Normalizado_BB_High(0),1);
  BB_Normalizado_BB_Delta_Bruto = Normaliza_NN(banda_bolinger.Normalizado_BB_Delta_Bruto(0),1);
  BB_Normalizado_BB_Posicao_Percent = Normaliza_NN(banda_bolinger.Normalizado_BB_Posicao_Percent(0),1);
  RSI_Valor = Normaliza_NN(rsi.Valor(0)/100,1);
  RSI_Cx = Normaliza_NN(rsi.Cx(0),0);
  RSI_Normalizado = Normaliza_NN(rsi.Normalizado(0),1);
  Hilo = Normaliza_NN((hilo.Direcao()+1)/2,1);
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
  Linha_Montada += DoubleToString(Hilo,6);
  Linha_Montada += ",";
  Linha_Montada += DoubleToString(n_(Profit,0,1),6);
  machine_learning.Append(Linha_Montada);

}
