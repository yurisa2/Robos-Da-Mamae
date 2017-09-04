/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             SA2 - Investment soft|
//+------------------------------------------------------------------+
#property copyright "Sa2, pq saum soh dois na empresa agora."
#property link      "http://www.sa2.com.br"


int   Handle_Holo_BB = iBands(NULL,TimeFrame,Holo_Periodos_BB,0,2,PRICE_CLOSE);
double Holo_Valor_Rompimento = 0;
double Holo_Vlr_Min = 0;
double Holo_Vlr_Max = 0;
double Holo_BB_Mediana_Var = 0;
double Holo_BB_High_Var = 0;
double Holo_BB_Low_Var = 0;
double Holo_daotick = 0;
double Holo_BB_Delta = 0;
int   Holo_Contador_De_Barra = 0;


void Holo_Var_Banda ()
{
  Holo_BB_Mediana_Var = Holo_BB_Mediana();
  Holo_BB_High_Var = Holo_BB_High();
  Holo_BB_Low_Var = Holo_BB_Low();
  Holo_daotick = daotick_geral;
  Holo_BB_Delta = (Holo_BB_High_Var - Holo_BB_Low_Var)/Tick_Size;

}

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
  if(Holo_BB_Mediana_Var >= Holo_daotick - Tick_Size && Holo_BB_Mediana_Var <= Holo_daotick + Tick_Size) retorno = true;
  // Direcao = 0; // FAZER DIREITO (PENSA SE VAI PRECISAR)
  return retorno;
}

void Holo_Direcao ()
{
  if(Holo_daotick >= Holo_BB_High_Var)
  {
    if(Holo_daotick > Holo_Valor_Rompimento) Holo_Valor_Rompimento = Holo_daotick;
    Direcao = -1;
    Holo_Contador_De_Barra = 0;
  }
  if(Holo_daotick <= Holo_BB_Low_Var)
  {
    if(Holo_daotick < Holo_Valor_Rompimento) Holo_Valor_Rompimento = Holo_daotick;
    Direcao = 1;
    Holo_Contador_De_Barra = 0;
  }
}

void Holo_Venda (string Desc,string IO = "Neutro")
{
  if(TaDentroDoHorario_RT==true && JaZerou)
  {
    if(IO == "Entrada") EM_Contador_Picote = 0;

    if(EM_Picote_Tipo==55) Valor_Escalpe = Tick_Size * Tamanho_Picote;    //Para fazer funcionar o EM   - fixo
    if(EM_Picote_Tipo==471) Valor_Escalpe = Prop_Delta() * Tamanho_Picote;  //Para fazer funcionar o EM - proporcional

    Print(Descricao_Robo+" "+Desc);

    if(Operacoes==0 && OperacoesFeitas < (Limite_Operacoes * 2) && Saldo_Dia_Permite() == true &&  (  (Usa_Prop == true && Prop_Delta() > Prop_Limite_Minimo) || Usa_Fixos == true ) )
    {
      DeuStopLoss = false;
      DeuTakeProfit = false;
      Ordem = false;
      Direcao = 0;
      MontarRequisicao(ORDER_TYPE_SELL,Desc);
    }
  }
}

void Holo_Compra (string Desc,string IO = "Neutro")
{
  if(TaDentroDoHorario_RT==true && JaZerou)
  {
    if(IO == "Entrada") EM_Contador_Picote = 0;

    if(EM_Picote_Tipo==55) Valor_Escalpe = Tick_Size * Tamanho_Picote;    //Para fazer funcionar o EM   - fixo
    if(EM_Picote_Tipo==471) Valor_Escalpe = Prop_Delta() * Tamanho_Picote;  //Para fazer funcionar o EM - proporcional

    Print(Descricao_Robo+" "+Desc);

    if(Operacoes==0 && OperacoesFeitas < (Limite_Operacoes*2) && Saldo_Dia_Permite() == true &&  (  (Usa_Prop == true && Prop_Delta() > Prop_Limite_Minimo) || Usa_Fixos == true ) )
    {
      DeuStopLoss = false;
      DeuTakeProfit = false;
      Ordem = false;
      Direcao = 0;
      MontarRequisicao(ORDER_TYPE_BUY,Desc);
    }
  }
}

void Holo_Avalia ()
{
  double Holo_Nova_Direcao = Direcao;

  if(Holo_Inverte) Holo_Nova_Direcao = Direcao * -1;

  if(Holo_Nova_Direcao > 0 && Holo_Condicoes()) Holo_Compra("Compra HOLO");
  if(Holo_Nova_Direcao < 0 && Holo_Condicoes()) Holo_Venda("Venda HOLO");

  if(Holo_Distancia > 0)
  {
    if(Holo_Nova_Direcao > 0 && Holo_daotick >= Holo_Valor_Rompimento + Holo_Distancia && Holo_BB_Delta_Permite() && Operacoes == 0) Holo_Compra("Compra HOLO");
    if(Holo_Nova_Direcao < 0 && Holo_daotick <= Holo_Valor_Rompimento - Holo_Distancia && Holo_BB_Delta_Permite() && Operacoes == 0) Holo_Venda("Venda HOLO");
  }
}

bool Holo_Condicoes ()
{
  //Ver se nao precisa de uma subfuncao, so esta o metodo de entrada modificando
  if(Holo_Mediana &&
    Holo_Toque_Mediana() &&
    Holo_BB_Delta_Permite() &&
    Holo_Contador_De_Barra <= Holo_Max_Contador_Barras &&
    Operacoes == 0)
  {
    return true;
  }

return false;

}

bool Holo_BB_Delta_Permite ()
{
  if(Holo_BB_Delta < Holo_Delta_Menor_q && Holo_BB_Delta > Holo_Delta_Maior_q) return true;
  else return false;
}

void Holo_No_Tick ()
{
  Holo_Var_Banda();
  Holo_Direcao();
  Holo_Avalia();

  //Passar os coment�rios para um objeto elegante
  Comentario_Robo = "\n Linha Superior da BB: " + DoubleToString(Holo_BB_High_Var,_Digits);
  if(Holo_Mediana) Comentario_Robo = Comentario_Robo + "\n Linha Mediana da BB: " + DoubleToString(Holo_BB_Mediana_Var,_Digits);
  Comentario_Robo = Comentario_Robo + "\n Linha Inferior da BB: " + DoubleToString(Holo_BB_Low_Var,_Digits);
  Comentario_Robo = Comentario_Robo + "\n Delta da BB: " + DoubleToString(Holo_BB_Delta,_Digits);
  Comentario_Robo = Comentario_Robo + "\n DeltaPermite: " + DoubleToString(Holo_BB_Delta_Permite(),0) ;
  Comentario_Robo = Comentario_Robo + "\n Holo_Contador_De_Barra: " + IntegerToString(Holo_Contador_De_Barra) ;

  if(Holo_Mediana) Comentario_Robo = Comentario_Robo + "\n Tocou: " + DoubleToString(Holo_Toque_Mediana(),0);
  Comentario_Robo = Comentario_Robo + "\n\n Valor Rompimento: " + DoubleToString(Holo_Valor_Rompimento,_Digits);
  Comentario_Robo = Comentario_Robo + "\n\n\n";

  //Avalia��es de END Movel
  Holo_TP_Movel();
  Holo_SL_Movel();
  //Fim do EN MOVEL
}

void Holo_TP_Movel ()
{
  if(Holo_Menor_TP && Operacoes != 0) {    //Feito assim para tentar diminuir memoria
    if(Operacoes > 0)
    {
      TakeProfitValorCompra = MathMin(Holo_BB_High(),TakeProfitValorCompra);
      AtualizaLinhaTP(TakeProfitValorCompra);
    }
    if(Operacoes < 0)
    {
      TakeProfitValorVenda = MathMax(Holo_BB_Low(),TakeProfitValorVenda);
      AtualizaLinhaTP(TakeProfitValorVenda);
    }
  }
}

void Holo_SL_Movel ()
{
  if(Holo_Menor_SL && Operacoes != 0) {    //Feito assim para tentar diminuir memoria
    if(Operacoes > 0)
    {
      StopLossValorCompra = MathMax(Holo_BB_Low_Var,StopLossValorCompra);
      AtualizaLinhaSL(StopLossValorCompra);
    }
    if(Operacoes < 0)
    {
      StopLossValorVenda = MathMin(Holo_BB_High_Var,StopLossValorVenda);
      AtualizaLinhaSL(StopLossValorVenda);
    }
  }
}

void Holo_Acao_Barra ()
{
  Holo_Contador_De_Barra = Holo_Contador_De_Barra + 1;



}
