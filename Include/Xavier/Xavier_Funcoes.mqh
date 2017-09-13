/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             SA2 - Investment soft|
//+------------------------------------------------------------------+

int   Xavier_Handle_BB = iBands(NULL,PERIOD_CURRENT,20,0,2,PRICE_CLOSE);


void Xav_No_Tick()
{

}

void Xav_No_Timer()
{
  //
  // Banda = Xavier_BB_Tamanho_Porcent();
  // Rsi = CalculaRSI();
  Comentario_Robo = "\n Xavier_BB_Tamanho_Porcent BB: " + DoubleToString(Xavier_BB_Tamanho_Porcent(),2);
  Comentario_Robo = Comentario_Robo + "\n CalculaRSI: " + DoubleToString(CalculaRSI(),2);
  Comentario_Robo = Comentario_Robo + "\n Fuzzy_Respo(): " + DoubleToString(Fuzzy_Respo(Xavier_BB_Tamanho_Porcent(),CalculaRSI()),2);
Xavier_Avalia();

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
  trans_size = daotick_geral - Xavier_BB_Low();
  retorno = trans_size/delta_BB*100;

  return retorno;
}

void Xavier_Avalia()
{
  double Valor_Fuzzy = 0;

  if(TaDentroDoHorario_RT) Valor_Fuzzy = Fuzzy_Respo(Xavier_BB_Tamanho_Porcent(),CalculaRSI());
  if(Valor_Fuzzy == 0) Xavier_Autorizado = 0;


  if(Valor_Fuzzy > Xavier_Valor_Venda && Operacoes == 0)  Xavier_Venda("Xavier Venda, Fuzzy: " + DoubleToString(Valor_Fuzzy) ) ;
  if(Valor_Fuzzy < Xavier_Valor_Compra && Operacoes == 0) Xavier_Compra("Xavier Compra, Fuzzy: " + DoubleToString(Valor_Fuzzy) ) ;

  // if(Valor_Fuzzy > Xavier_Valor_Venda && Operacoes == 0)  Xavier_Autorizado = -1 ;
  // if(Valor_Fuzzy < Xavier_Valor_Compra && Operacoes == 0)  Xavier_Autorizado = 1 ;
  //
  // if(Xavier_Autorizado < 0 && Xavier_BB_Tamanho_Porcent() <= 100) Xavier_Venda("Xavier Venda, Fuzzy: " + DoubleToString(Valor_Fuzzy) ) ;
  // if(Xavier_Autorizado > 0 && Xavier_BB_Tamanho_Porcent() >= 0) Xavier_Compra("Xavier Compra, Fuzzy: " + DoubleToString(Valor_Fuzzy) ) ;


}

void Xavier_Compra(string Desc,string IO = "Neutro")
{
  Xavier_Autorizado = 0;
  if(TaDentroDoHorario_RT==true && JaZerou)
  {
    if(IO == "Entrada") EM_Contador_Picote = 0;

    Print(Descricao_Robo+" "+Desc);

    if(Operacoes==0 && OperacoesFeitas < (Limite_Operacoes*2) && Saldo_Dia_Permite() == true )
    {
      DeuStopLoss = false;
      DeuTakeProfit = false;
      Ordem = false;
      Direcao = 0;
      MontarRequisicao(ORDER_TYPE_BUY,Desc);
    }
  }
}

void Xavier_Venda(string Desc,string IO = "Neutro")
{
   Xavier_Autorizado = 0;
  if(TaDentroDoHorario_RT==true && JaZerou)
  {
    if(IO == "Entrada") EM_Contador_Picote = 0;

    Print(Descricao_Robo+" "+Desc);

    if(Operacoes==0 && OperacoesFeitas < (Limite_Operacoes*2) && Saldo_Dia_Permite() == true )
    {
      DeuStopLoss = false;
      DeuTakeProfit = false;
      Ordem = false;
      Direcao = 0;
      MontarRequisicao(ORDER_TYPE_SELL,Desc);
    }
  }
}
