/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             SA2 - Investment soft|
//+------------------------------------------------------------------+

int   Xavier_Handle_BB = iBands(NULL,PERIOD_CURRENT,20,0,2,PRICE_CLOSE);

class Xavier {
public:
// void Xavier();
void Xavier_Timer();
void Xavier_Avalia();
}
;

void Xavier::Xavier_Timer()
{
  BB *Banda_BB = new BB;
  RSI *RSI_OO = new RSI;
  //
  // Banda = Xavier_BB_Tamanho_Porcent();
  // Rsi = CalculaRSI();
  Comentario_Robo = "\n Xavier_BB_Tamanho_Porcent BB: " + DoubleToString(Banda_BB.BB_Posicao_Percent(),2);
  Comentario_Robo = Comentario_Robo + "\n CalculaRSI: " + DoubleToString(RSI_OO.Valor(),2);
  Comentario_Robo = Comentario_Robo + "\n Fuzzy_Respo(): " + DoubleToString(Fuzzy_Respo(Banda_BB.BB_Posicao_Percent(),RSI_OO.Valor()),2);
// Xavier_Avalia();
delete(RSI_OO);
delete(Banda_BB);
}

//Inicio do Joguete BB

void Xavier::Xavier_Avalia()
{
  double Valor_Fuzzy = 0;

  BB *Banda_BB = new BB;
  RSI *RSI_OO = new RSI;
  if(TaDentroDoHorario_RT) Valor_Fuzzy = Fuzzy_Respo(Banda_BB.BB_Posicao_Percent(),RSI_OO.Valor());
  delete(RSI_OO);
  delete(Banda_BB);

  if(Valor_Fuzzy > Xavier_Valor_Venda)
  {
  Opera_Mercado *opera = new Opera_Mercado;
  opera.AbrePosicao(ORDER_TYPE_SELL,"Xavier Venda, Fuzzy: " + DoubleToString(Valor_Fuzzy)) ;
  delete(opera);
  }

  if(Valor_Fuzzy < Xavier_Valor_Compra)
{
  Opera_Mercado *opera = new Opera_Mercado;
  opera.AbrePosicao(ORDER_TYPE_BUY,"Xavier Compra, Fuzzy: " + DoubleToString(Valor_Fuzzy)) ;
  delete(opera);

}
}
