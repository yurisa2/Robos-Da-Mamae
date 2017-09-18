/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             SA2 - Investment soft|
//+------------------------------------------------------------------+

int   Wesley_Handle_BB = iBands(NULL,PERIOD_CURRENT,20,0,2,PRICE_CLOSE);

class Wesley {
  public:
  // void Wesley();
  void Comment();
  void Avalia();
}
;

void Wesley::Comment()
{
  BB *Banda_BB = new BB;
  RSI *RSI_OO = new RSI;
  MACD *MACD_OO = new MACD;

  //
  // Banda = Wesley_BB_Tamanho_Porcent();
  // Rsi = CalculaRSI();
  Comentario_Robo = "\n Wesley_BB_Tamanho_Porcent BB: " + DoubleToString(Banda_BB.BB_Posicao_Percent(),2);
  Comentario_Robo = Comentario_Robo + "\n CalculaRSI: " + DoubleToString(RSI_OO.Valor(),2);
  Comentario_Robo = Comentario_Robo + "\n Macd: " + DoubleToString(MACD_OO.Valor(),2);
  Comentario_Robo = Comentario_Robo + "\n Fuzzy_Respo(): " + DoubleToString(Fuzzy_Respo(Banda_BB.BB_Posicao_Percent(),RSI_OO.Valor()),2);
  Avalia();
  delete(RSI_OO);
  delete(MACD_OO);
  delete(Banda_BB);
}

//Inicio do Joguete BB

void Wesley::Avalia()
{
  double Valor_Fuzzy = 0;

  BB *Banda_BB = new BB;
  RSI *RSI_OO = new RSI;
  MACD *MACD_OO = new MACD;


  if(TaDentroDoHorario_RT) Valor_Fuzzy = Fuzzy_Respo(Banda_BB.BB_Posicao_Percent(),RSI_OO.Valor(),MACD_OO.Valor());
  delete(RSI_OO);
  delete(Banda_BB);
  delete(MACD_OO);

  if(Valor_Fuzzy > Wesley_Valor_Venda && Operacoes == 0)
  {
    Opera_Mercado *opera = new Opera_Mercado;
    opera.AbrePosicao(ORDER_TYPE_SELL,"Wesley Venda, Fuzzy: " + DoubleToString(Valor_Fuzzy) ) ;
    delete(opera);
  }

  if(Valor_Fuzzy < Wesley_Valor_Compra && Operacoes == 0)
  {
    Opera_Mercado *opera = new Opera_Mercado;

    opera.AbrePosicao(ORDER_TYPE_BUY,"Wesley Compra, Fuzzy: " + DoubleToString(Valor_Fuzzy) ) ;
    delete(opera);

  }
}
