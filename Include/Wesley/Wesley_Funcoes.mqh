/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             SA2 - Investment soft|
//+------------------------------------------------------------------+

// int   Wesley_Handle_BB = iBands(NULL,PERIOD_CURRENT,20,0,2,PRICE_CLOSE);



//Inicio do Joguete BB
//
// void Avalia()
// {
//   double Valor_Fuzzy = 0;
//
//   BB *Banda_BB = new BB;
//   RSI *RSI_OO = new RSI();
//   // MACD *MACD_OO = new MACD;
//   Stoch *Stoch_OO = new Stoch();
//   MFI *MFI_OO = new MFI();
//
//   if(TaDentroDoHorario_RT) Valor_Fuzzy = Fuzzy_Respo(Banda_BB.BB_Posicao_Percent(),RSI_OO.Valor(),Stoch_OO.Valor(),MFI_OO.Valor());
//
//   delete(RSI_OO);
//   // delete(MACD_OO);
//   delete(Banda_BB);
//   delete(Stoch_OO);
//   delete(MFI_OO);
//
//   if(Valor_Fuzzy > Wesley_Valor_Venda)
//   {
//     Opera_Mercado *opera = new Opera_Mercado;
//     opera.AbrePosicao(ORDER_TYPE_SELL,"Wesley Venda, Fuzzy: " + DoubleToString(Valor_Fuzzy) ) ;
//     delete(opera);
//   }
//
//   if(Valor_Fuzzy < Wesley_Valor_Compra)
//   {
//     Opera_Mercado *opera = new Opera_Mercado;
//
//     opera.AbrePosicao(ORDER_TYPE_BUY,"Wesley Compra, Fuzzy: " + DoubleToString(Valor_Fuzzy) ) ;
//     delete(opera);
//   }
//
//   if(O_Stops.Tipo_Posicao() < 0 && Valor_Fuzzy <= 0 && Wesley_Sai_Em_Zero)
//   {
//     Opera_Mercado *opera = new Opera_Mercado;
//
//     opera.FechaPosicao() ;
//     delete(opera);
//   }
//
//   if(O_Stops.Tipo_Posicao() > 0 && Valor_Fuzzy >= 0 && Wesley_Sai_Em_Zero)
//   {
//     Opera_Mercado *opera = new Opera_Mercado;
//
//     opera.FechaPosicao() ;
//     delete(opera);
//   }
//
// }
