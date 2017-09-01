/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             SA2 - Investment soft|
//+------------------------------------------------------------------+

int   Xavier_Handle_BB = iBands(NULL,PERIOD_CURRENT,20,0,2,PRICE_CLOSE);


void Xav_No_Tick()
{
  //
  // Banda = Xavier_BB_Tamanho_Porcent();
  // Rsi = CalculaRSI();
  Comentario_Robo = "\n Xavier_BB_Tamanho_Porcent BB: " + DoubleToString(Xavier_BB_Tamanho_Porcent(),2);
  Comentario_Robo = Comentario_Robo + "\n CalculaRSI: " + DoubleToString(CalculaRSI(),2);
  Comentario_Robo = Comentario_Robo + "\n Fuzzy_Respo(): " + DoubleToString(Fuzzy_Respo(Xavier_BB_Tamanho_Porcent(),CalculaRSI()),2);


}

//Inicio do Joguete BB

double Xavier_BB_Low()
{
  double _BB_base[];
  ArraySetAsSeries(_BB_base, true);
  CopyBuffer(Xavier_Handle_BB,2,0,3,_BB_base);

  return(_BB_base[0]);
}

double Xavier_BB_High()
{
  double _BB_base[];
  ArraySetAsSeries(_BB_base, true);
  CopyBuffer(Xavier_Handle_BB,1,0,3,_BB_base);

  return(_BB_base[0]);
}

double Xavier_BB_Bruto_TickSize()
{
  double retorno = 0;
  double delta_BB = 0;

  delta_BB = Xavier_BB_High() - Xavier_BB_Low();
  retorno = delta_BB / Tick_Size;


  return retorno;
}

double Xavier_BB_Tamanho_Porcent()
{
  double retorno = 0;
  double delta_BB = 0;
  double trans_size = 0;

  delta_BB = Xavier_BB_High() - Xavier_BB_Low();
  trans_size = daotick_compra - Xavier_BB_Low();
  retorno = trans_size/delta_BB*100;

  return retorno;
}
