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
  if(!Otimizacao) Comentario_Robo = "\n Candle / Banda ABSOLUTO: " + DoubleToString(Candle_x_BB_abs());
  if(!Otimizacao) Comentario_Robo += "\n Candle / Banda FORA DA BANDA: " + DoubleToString(Candle_x_BB_out());
  // if(!Otimizacao) Comentario_Robo += "\n tamanho_candle: " + DoubleToString(PrecoAtual().high - PrecoAtual().low); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n BB_Posicao_Percent: " + DoubleToString(O_BB.BB_Posicao_Percent()); //DEBUG
}

double Ibsen::Candle_x_BB_abs()
{
  double retorno = 0;
  double tamanho_candle = (PrecoAtual().high - PrecoAtual().low) / Tick_Size;
  double proporcao = tamanho_candle / O_BB.BB_Delta_Bruto() * 100;

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

  retorno = tamanho_fora / BB_delta_absoluto * 100;

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