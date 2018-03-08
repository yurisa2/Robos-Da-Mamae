/* -*- C++ -*- */
 
class Ibsen
{

  public:
  Ibsen();
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

void Ibsen::Comentario()
{
  //AQUI ESTA COMENTADO PARA PERFORMANCE DE OTIMIZACAO

  MACD *MACD_oo = new MACD;

  if(!Otimizacao) Comentario_Robo = "\n Candle / Banda ABSOLUTO: " + DoubleToString(Candle_x_BB_abs());
  if(!Otimizacao) Comentario_Robo += "\n Candle / Banda FORA DA BANDA: " + DoubleToString(Candle_x_BB_out());
  if(!Otimizacao) Comentario_Robo += "\n BB_Posicao_Percent: " + DoubleToString(O_BB.BB_Posicao_Percent()); //DEBUG

  // if(!Otimizacao) Comentario_Robo += "\n MACD 7: " + DoubleToString(MACD_oo.Valor(0,6)); //DEBUG
  // if(!Otimizacao) Comentario_Robo += "\n MACD 6: " + DoubleToString(MACD_oo.Valor(0,5)); //DEBUG
  // if(!Otimizacao) Comentario_Robo += "\n MACD 5: " + DoubleToString(MACD_oo.Valor(0,4)); //DEBUG
  // if(!Otimizacao) Comentario_Robo += "\n MACD 4: " + DoubleToString(MACD_oo.Valor(0,3)); //DEBUG
  // if(!Otimizacao) Comentario_Robo += "\n MACD 3: " + DoubleToString(MACD_oo.Valor(0,2)); //DEBUG
  // if(!Otimizacao) Comentario_Robo += "\n MACD 2: " + DoubleToString(MACD_oo.Valor(0,1)); //DEBUG
  // if(!Otimizacao) Comentario_Robo += "\n MACD 1: " + DoubleToString(MACD_oo.Valor(0,0)); //DEBUG
  //
  // if(!Otimizacao) Comentario_Robo += "\n MACD a Risca 7: " + DoubleToString(MACD_oo.Normalizacao_Valores(0,6)); //DEBUG
  // if(!Otimizacao) Comentario_Robo += "\n MACD a Risca 6: " + DoubleToString(MACD_oo.Normalizacao_Valores(0,5)); //DEBUG
  // if(!Otimizacao) Comentario_Robo += "\n MACD a Risca 5: " + DoubleToString(MACD_oo.Normalizacao_Valores(0,4)); //DEBUG
  // if(!Otimizacao) Comentario_Robo += "\n MACD a Risca 4: " + DoubleToString(MACD_oo.Normalizacao_Valores(0,3)); //DEBUG
  // if(!Otimizacao) Comentario_Robo += "\n MACD a Risca 3: " + DoubleToString(MACD_oo.Normalizacao_Valores(0,2)); //DEBUG
  // if(!Otimizacao) Comentario_Robo += "\n MACD a Risca 2: " + DoubleToString(MACD_oo.Normalizacao_Valores(0,1)); //DEBUG
  // if(!Otimizacao) Comentario_Robo += "\n MACD a Risca 1: " + DoubleToString(MACD_oo.Normalizacao_Valores(0,0)); //DEBUG

  if(!Otimizacao) Comentario_Robo += "\n MACD Cx(0) : " + DoubleToString(MACD_oo.Cx(0)); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n MACD Cx(1) : " + DoubleToString(MACD_oo.Cx(1)); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n Normalizacao_Valores_MACD(0,0,-1) : " + DoubleToString(MACD_oo.Normalizacao_Valores_MACD(0,0,0)); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n Normalizacao_Valores_MACD(0,-1,-1) : " + DoubleToString(MACD_oo.Normalizacao_Valores_MACD(0,-1,-1)); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n Distancia_Linha_Zero() : " + DoubleToString(MACD_oo.Distancia_Linha_Zero()); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n Distancia_Linha_Sinal() : " + DoubleToString(MACD_oo.Distancia_Linha_Sinal()); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n Diferenca_Angulo_Linha_Sinal() : " + DoubleToString(MACD_oo.Diferenca_Angulo_Linha_Sinal()); //DEBUG

  delete(MACD_oo);
}

double Ibsen::Candle_x_BB_abs()
{
  double retorno = 0;
  double proporcao = 0;
  double tamanho_candle = (PrecoAtual().high - PrecoAtual().low) / Tick_Size;

  if(O_BB.BB_Delta_Bruto() != 0) proporcao = tamanho_candle / O_BB.BB_Delta_Bruto() * 100;

  retorno = proporcao;

  return retorno;

}

double Ibsen::Candle_x_BB_out()
{
  double retorno = 0;
  double BB_delta_absoluto = O_BB.BB_Delta_Bruto() * Tick_Size;
  double tamanho_fora = 0;

  if(PrecoAtual().close > O_BB.BB_High()) tamanho_fora = PrecoAtual().close - O_BB.BB_High();
  if(PrecoAtual().close < O_BB.BB_Low()) tamanho_fora = O_BB.BB_Low() -  PrecoAtual().close;

  if(BB_delta_absoluto == 0) retorno = 0;
  else retorno = tamanho_fora / BB_delta_absoluto * 100;

  return retorno;
}

int Ibsen::Direcao()
{
int retorno = 0;

if(O_BB.BB_Posicao_Percent() > 100) retorno = -1;
if(O_BB.BB_Posicao_Percent() < 0) retorno = 1;



return retorno;
}


void Ibsen::Avalia()
{

 if(Candle_x_BB_out() > tamanho_candle_para_fora_p)
 {
   Opera_Mercado *opera = new Opera_Mercado;

   opera.AbrePosicao(Direcao(),"Ibsen: " + "BB_%"+DoubleToString(O_BB.BB_Posicao_Percent())+" | Candle_x_BB_out: " + DoubleToString(Candle_x_BB_out()));

   delete(opera);
 }

}



void Ibsen::Timer()
{


}

BB O_BB(TimeFrame,NULL,p_bb);
Ibsen Ibsen_o ;
