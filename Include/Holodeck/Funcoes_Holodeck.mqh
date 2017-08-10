/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             SA2 - Investment soft|
//+------------------------------------------------------------------+
#property copyright "Sa2, pq são só dois na empresa agora."
#property link      "http://www.sa2.com.br"


int   Handle_Holo_BB = iBands(NULL,TimeFrame,Holo_Periodos_BB,0,2,PRICE_CLOSE);
double Holo_Valor_Rompimento = 0;

double Holo_BB_Mediana ()
{
  double _BB_base[];
  ArraySetAsSeries(_BB_base, true);
  CopyBuffer(Handle_Holo_BB,0,0,3,_BB_base);

  return(_BB_base[0]);
}

double Holo_BB_Low ()
{
  double _BB_base[];
  ArraySetAsSeries(_BB_base, true);
  CopyBuffer(Handle_Holo_BB,2,0,3,_BB_base);

  return(_BB_base[0]);
}

double Holo_BB_High ()
{
  double _BB_base[];
  ArraySetAsSeries(_BB_base, true);
  CopyBuffer(Handle_Holo_BB,1,0,3,_BB_base);

  return(_BB_base[0]);
}

bool Holo_Toque_Mediana ()
{
  bool retorno = false;
  if(Holo_BB_Mediana() >= daotick() - Tick_Size && Holo_BB_Mediana() <= daotick() + Tick_Size) retorno = true;
  return retorno;
}

void Holo_Direcao ()
{
  if(daotick() >= Holo_BB_High())
  {
    Holo_Valor_Rompimento = daotick();
    Direcao = -1;
  }
  if(daotick() <= Holo_BB_Low())
  {
    Holo_Valor_Rompimento = daotick();
    Direcao = 1;
  }
}

void Holo_Venda (string Desc,string IO = "Neutro")
{
  if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && JaZerou)
  {
    if(IO == "Entrada") EM_Contador_Picote = 0;

    if(EM_Picote_Tipo==55) Valor_Escalpe = Tick_Size * Tamanho_Picote;    //Para fazer funcionar o EM   - fixo
    if(EM_Picote_Tipo==471) Valor_Escalpe = Prop_Delta() * Tamanho_Picote;  //Para fazer funcionar o EM - proporcional

    Print(Descricao_Robo+" "+Desc);
    // if(Operacoes>0 && SaiPeloIndicador==true)
    // {
    //   MontarRequisicao(ORDER_TYPE_SELL,Desc);
    // }
    if(Operacoes==0 && OperacoesFeitas < (Limite_Operacoes*2) && Saldo_Dia_Permite() == true &&  (  (Usa_Prop == true && Prop_Delta() > Prop_Limite_Minimo) || Usa_Fixos == true ) )
    {
      DeuStopLoss = false;
      DeuTakeProfit = false;
      Ordem = false;
      MontarRequisicao(ORDER_TYPE_SELL,Desc);
    }
  }
}
void Holo_Compra (string Desc,string IO = "Neutro")
{
  if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && JaZerou)
  {
    if(IO == "Entrada") EM_Contador_Picote = 0;

    if(EM_Picote_Tipo==55) Valor_Escalpe = Tick_Size * Tamanho_Picote;    //Para fazer funcionar o EM   - fixo
    if(EM_Picote_Tipo==471) Valor_Escalpe = Prop_Delta() * Tamanho_Picote;  //Para fazer funcionar o EM - proporcional

    Print(Descricao_Robo+" "+Desc);
    //
    // if(Operacoes<0 && SaiPeloIndicador==true)
    // {
    //   MontarRequisicao(ORDER_TYPE_BUY,Desc);
    // }
    if(Operacoes==0 && OperacoesFeitas < (Limite_Operacoes*2) && Saldo_Dia_Permite() == true &&  (  (Usa_Prop == true && Prop_Delta() > Prop_Limite_Minimo) || Usa_Fixos == true ) )
    {
      DeuStopLoss = false;
      DeuTakeProfit = false;
      Ordem = false;
      MontarRequisicao(ORDER_TYPE_BUY,Desc);
    }
  }
}

void Holo_No_Tick ()
{
  Holo_Direcao();

  if(Holo_Toque_Mediana() && Direcao > 0 && Operacoes == 0) Holo_Compra("Compra HOLO");
  if(Holo_Toque_Mediana() && Direcao < 0 && Operacoes == 0) Holo_Venda("Venda HOLO");

  Comentario_Robo = "\n Linha Mediana da BB: " + DoubleToString(Holo_BB_Mediana(),_Digits);
  Comentario_Robo = Comentario_Robo + "\n Tocou: " + DoubleToString(Holo_Toque_Mediana());
}

void Init_Holo ()
{

  ChartIndicatorAdd(0,0,Handle_Holo_BB);

}
