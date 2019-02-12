/* -*- C++ -*- */

class Ibsen
{

  public:
  Ibsen();
  ~Ibsen();
  void Comentario();
  void Avalia();
  void Timer();
  double Candle_x_BB_abs();
  double Candle_x_BB_out();
  int Direcao();



  private:


};

void Ibsen::Ibsen()
{
}

void Ibsen::~Ibsen()
{
}

void Ibsen::Comentario()
{
  //AQUI ESTA COMENTADO PARA PERFORMANCE DE OTIMIZACAO
  BB *O_BB = new BB(TimeFrame,NULL,p_bb);
  MACD *MACD_oo = new MACD;

  if(!Otimizacao) Comentario_Robo = "\n Candle / Banda ABSOLUTO: " + DoubleToString(Candle_x_BB_abs());
  if(!Otimizacao) Comentario_Robo += "\n Candle / Banda FORA DA BANDA: " + DoubleToString(Candle_x_BB_out());
  // if(!Otimizacao) Comentario_Robo += "\n tamanho_candle: " + DoubleToString(PrecoAtual().high - PrecoAtual().low); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n BB_Posicao_Percent: " + DoubleToString(O_BB.BB_Posicao_Percent()); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n Cx_BB_High: " + DoubleToString(O_BB.Cx_BB_High(0)); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n Cx_BB_Base: " + DoubleToString(O_BB.Cx_BB_Base(0)); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n Cx_BB_Low: " + DoubleToString(O_BB.Cx_BB_Low(0)); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n MACD : " + DoubleToString(MACD_oo.Cx()); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n Distancia_Linha_Zero : " + DoubleToString(MACD_oo.Distancia_Linha_Zero()); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n Distancia_Linha_Sinal : " + DoubleToString(MACD_oo.Distancia_Linha_Sinal()); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n Diferenca_Angulo_Linha_Sinal : " + DoubleToString(MACD_oo.Diferenca_Angulo_Linha_Sinal()); //DEBUG

  delete(MACD_oo);
  delete O_BB;
}

double Ibsen::Candle_x_BB_abs()
{
  BB *O_BB = new BB(TimeFrame,NULL,p_bb);

  double retorno = 0;
  double proporcao = 0;
  double tamanho_candle = (PrecoAtual().high - PrecoAtual().low) / Tick_Size;

  if(O_BB.BB_Delta_Bruto() != 0) proporcao = tamanho_candle / O_BB.BB_Delta_Bruto() * 100;

  retorno = proporcao;
  delete O_BB;

  return retorno;

}

double Ibsen::Candle_x_BB_out()
{
  BB *O_BB = new BB(TimeFrame,NULL,p_bb);

  double retorno = 0;
  double BB_delta_absoluto = O_BB.BB_Delta_Bruto() * Tick_Size;
  double tamanho_fora = 0;

  if(PrecoAtual().close > O_BB.BB_High()) tamanho_fora = PrecoAtual().close - O_BB.BB_High();
  if(PrecoAtual().close < O_BB.BB_Low()) tamanho_fora = O_BB.BB_Low() -  PrecoAtual().close;

  if(BB_delta_absoluto == 0) retorno = 0;
  else retorno = tamanho_fora / BB_delta_absoluto * 100;

  delete O_BB;
  return retorno;
}

int Ibsen::Direcao()
{
int retorno = 0;
BB *O_BB = new BB(TimeFrame,NULL,p_bb);


if(O_BB.BB_Posicao_Percent() > 100) retorno = -1;
if(O_BB.BB_Posicao_Percent() < 0) retorno = 1;

  delete O_BB;

return retorno;
}


void Ibsen::Avalia()
{
  BB *O_BB = new BB(TimeFrame,NULL,p_bb);

 if(Candle_x_BB_out() > tamanho_candle_para_fora_p)
 {
   Opera_Mercado *opera = new Opera_Mercado;

   opera.AbrePosicao(Direcao(),"Ibsen: " + "BB_%"+DoubleToString(O_BB.BB_Posicao_Percent())+" | Candle_x_BB_out: " + DoubleToString(Candle_x_BB_out()));


   delete(opera);
 }
delete O_BB;
}



void Ibsen::Timer()
{


}

Ibsen Ibsen_o ;
