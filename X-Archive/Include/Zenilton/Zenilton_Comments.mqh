/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             SA2 - Investment soft|
//+------------------------------------------------------------------+

class ZComments
{
  public:
  void ZComments();


};

void ZComments::ZComments()
{
  Stoch *estocastico_curto = new Stoch(10,3,3,TimeFrame);
  MA *ema5_curto = new MA(5,MODE_EMA,TimeFrame);
  MA *ema10_curto = new MA(10,MODE_EMA,TimeFrame);
  RSI *rsi_curto = new RSI(9,TimeFrame);

  Stoch *estocastico_longo = new Stoch(10,3,3,Zeni_Periodo_Longo);
  MA *ema5_longo = new MA(5,MODE_EMA,Zeni_Periodo_Longo);
  MA *ema10_longo = new MA(10,MODE_EMA,Zeni_Periodo_Longo);
  RSI *rsi_longo = new RSI(9,Zeni_Periodo_Longo);

  MACD *macd_curto = new MACD(12,26,9);

  Comentario_Robo = "\n Estocastico MainLine_Longa: " + DoubleToString(estocastico_longo.Valor(0));
  Comentario_Robo = Comentario_Robo + "\n Estocastico SignalLine_Longa: " + DoubleToString(estocastico_longo.Valor(1));
  Comentario_Robo = Comentario_Robo + "\n Estocastico MainLine_Longa(1): " + DoubleToString(estocastico_longo.Valor(0,1));
  Comentario_Robo = Comentario_Robo + "\n Estocastico SignalLine_Longa(1): " + DoubleToString(estocastico_longo.Valor(1,1));
  Comentario_Robo = Comentario_Robo + "\n EMA5_Longa: " + DoubleToString(ema5_longo.Valor(),2);
  Comentario_Robo = Comentario_Robo + "\n EMA10_Longa: " + DoubleToString(ema10_longo.Valor(),2);
  Comentario_Robo = Comentario_Robo + "\n RSI_Longa: " + DoubleToString(rsi_longo.Valor(),2);
  Comentario_Robo = Comentario_Robo + "\n\n ";
  Comentario_Robo = Comentario_Robo + "\n Estocastico MainLine_Curta: " + DoubleToString(estocastico_curto.Valor(0));
  Comentario_Robo = Comentario_Robo + "\n Estocastico SignalLine_Curta: " + DoubleToString(estocastico_curto.Valor(1));
  Comentario_Robo = Comentario_Robo + "\n Estocastico MainLine_Curta(1): " + DoubleToString(estocastico_curto.Valor(0,1));
  Comentario_Robo = Comentario_Robo + "\n Estocastico SignalLine_Curta(1): " + DoubleToString(estocastico_curto.Valor(1,1));
  Comentario_Robo = Comentario_Robo + "\n EMA5_Curta: " + DoubleToString(ema5_curto.Valor(),2);
  Comentario_Robo = Comentario_Robo + "\n EMA10_Curta: " + DoubleToString(ema10_curto.Valor(),2);
  Comentario_Robo = Comentario_Robo + "\n RSI_Curta: " + DoubleToString(rsi_curto.Valor(),2);
  Comentario_Robo = Comentario_Robo + "\n MACD Mainline_Curta(0): " + DoubleToString(macd_curto.Valor(0),2);
  Comentario_Robo = Comentario_Robo + "\n MACD SignalLIne_Curta(0): " + DoubleToString(macd_curto.Valor(1),2);
  Comentario_Robo = Comentario_Robo + "\n MACD Mainline_Curta(1): " + DoubleToString(macd_curto.Valor(0,1),2);
  Comentario_Robo = Comentario_Robo + "\n MACD SignalLIne_Curta(1): " + DoubleToString(macd_curto.Valor(1,1),2);
  Comentario_Robo = Comentario_Robo + "\n\n ";

  int emas_longas = 0;
  int rsi_longo_tendencia = 0;
  int estocastico_longo_tendencia = 0;

  int emas_curtas = 0;
  int rsi_curto_tendencia = 0;
  int estocastico_curto_tendencia = 0;
  int macd_curto_tendencia = 0;
  int tendencia_longa = 0;
  int tendencia_curta = 0;

  if(ema5_longo.Valor() > ema10_longo.Valor())  emas_longas = 1;
  if(ema5_longo.Valor() < ema10_longo.Valor())  emas_longas = -1;

  if(rsi_longo.Valor() > 50) rsi_longo_tendencia = 1;
  if(rsi_longo.Valor() < 50) rsi_longo_tendencia = -1;

  if(estocastico_longo.Valor(0) > estocastico_longo.Valor(0,1) && estocastico_longo.Valor(0) < 80) estocastico_longo_tendencia = -1;
  if(estocastico_longo.Valor(0) < estocastico_longo.Valor(0,1) && estocastico_longo.Valor(0) > 20) estocastico_longo_tendencia = 1;


  if(ema5_curto.Valor() > ema10_curto.Valor())  emas_curtas = 1;
  if(ema5_curto.Valor() < ema10_curto.Valor())  emas_curtas = -1;

  if(rsi_curto.Valor() > 50) rsi_curto_tendencia = 1;
  if(rsi_curto.Valor() < 50) rsi_curto_tendencia = -1;

  if(estocastico_curto.Valor(0) > estocastico_curto.Valor(0,1) && estocastico_curto.Valor(0) < 80) estocastico_curto_tendencia = -1;
  if(estocastico_curto.Valor(0) < estocastico_curto.Valor(0,1) && estocastico_curto.Valor(0) > 20) estocastico_curto_tendencia = 1;

  if(macd_curto.Valor(0) < 0 && (macd_curto.Valor(0) > macd_curto.Valor(1))) macd_curto_tendencia = 1;
  if(macd_curto.Valor(0) > 0 && (macd_curto.Valor(0) < macd_curto.Valor(1))) macd_curto_tendencia = -1;

  tendencia_longa = rsi_longo_tendencia + estocastico_longo_tendencia + emas_longas;
  tendencia_curta = macd_curto_tendencia + emas_curtas + rsi_curto_tendencia + estocastico_curto_tendencia;

  Comentario_Robo = Comentario_Robo + "\n emas_longas: " + IntegerToString(emas_longas);
  Comentario_Robo = Comentario_Robo + "\n rsi_longo_tendencia: " + IntegerToString(rsi_longo_tendencia);
  Comentario_Robo = Comentario_Robo + "\n estocastico_longo_tendencia: " + IntegerToString(estocastico_longo_tendencia);
  Comentario_Robo = Comentario_Robo + "\n tendencia_longa: " + IntegerToString(tendencia_longa);
  Comentario_Robo = Comentario_Robo + "\n\n ";
  Comentario_Robo = Comentario_Robo + "\n emas_curtas: " + IntegerToString(emas_curtas);
  Comentario_Robo = Comentario_Robo + "\n rsi_curto_tendencia: " + IntegerToString(rsi_curto_tendencia);
  Comentario_Robo = Comentario_Robo + "\n estocastico_curto_tendencia: " + IntegerToString(estocastico_curto_tendencia);
  Comentario_Robo = Comentario_Robo + "\n macd_curto_tendencia: " + IntegerToString(macd_curto_tendencia);
  Comentario_Robo = Comentario_Robo + "\n tendencia_curta: " + IntegerToString(tendencia_curta);

  if(tendencia_longa == 3 && tendencia_curta == 4) Print("COMPRA");
  if(tendencia_longa == -3 && tendencia_curta == -4) Print("VENDA");

  delete(estocastico_longo);
  delete(ema5_longo);
  delete(ema10_longo);
  delete(rsi_longo);
  delete(estocastico_curto);
  delete(ema5_curto);
  delete(ema10_curto);
  delete(rsi_curto);
  delete(macd_curto);
}
