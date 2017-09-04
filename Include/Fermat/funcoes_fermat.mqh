/* -*- C++ -*- */

//+------------------------------------------------------------------+
//|                                            Fermat , o antigo ... |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

void Inicializa_iMAs ()
{
  HandleMA1 = iMA(_Symbol,TimeFrame,N_Ma1,0,Metodo,Preco_Aplicado);
  HandleMA2 = iMA(_Symbol,TimeFrame,N_Ma2,0,Metodo,Preco_Aplicado);
  HandleMA3 = iMA(_Symbol,TimeFrame,N_Ma3,0,Metodo,Preco_Aplicado);

  if(HandleMA1 == 0 || HandleMA2 == 0 || HandleMA3 == 0)
  {
    ExpertRemove();
  }

  ChartIndicatorAdd(0,0,HandleMA1);
  ChartIndicatorAdd(0,0,HandleMA2);
  ChartIndicatorAdd(0,0,HandleMA3);

}

double MA1 (int candle = 0)
{
  double ValorMA[];
  ArraySetAsSeries(ValorMA, true);
  int copied=CopyBuffer(HandleMA1,0,0,100,ValorMA);
  return ValorMA[candle];
}

double MA2 (int candle = 0)
{
  double ValorMA[];
  ArraySetAsSeries(ValorMA, true);
  int copied=CopyBuffer(HandleMA2,0,0,100,ValorMA);
  return ValorMA[candle];
}

double MA3 (int candle = 0)
{
  double ValorMA[];
  ArraySetAsSeries(ValorMA, true);
  int copied=CopyBuffer(HandleMA3,0,0,100,ValorMA);
  return ValorMA[candle];
}

int Direcao_Fermat (int candle = 0) //True se cumpre os quesitos de maior menor e distancia e d� o sentido, ZERO (0) e igual a nao cumpre
{
  if(MA3(candle) < MA1(candle) && MA2(candle) < MA1(candle) && MA1(candle)-MA3(candle) >= Tick_Size*Distancia_m1_m3)
  {
    Direcao = 1;
    return 1;
  }
  else
  if(MA3(candle) && MA2(candle) > MA1(candle) && MA3(candle)-MA1(candle) >= Tick_Size*Distancia_m1_m3)
  {
    Direcao = -1;
    return -1;
  }
  else
  {
    Direcao = 0;
    return 0;
  }
}

void Comentario_Fermat ()
{
  Comentario_Robo =
  "MA1: "+DoubleToString(MA1(),_Digits)+
  " | MA2: "+DoubleToString(MA2(),_Digits)+
  " | MA3: "+DoubleToString(MA3(),_Digits)+
  " | Distancia M1 M3: "+DoubleToString(MathAbs(MA3()-MA1()))+
  " | Direcao: "+IntegerToString(Direcao_Fermat())
  ;
}

void Operacoes_Fermat ()
{
  if(Direcao_Fermat()<0 &&
  Operacoes==0 &&
  OperacoesFeitas < (Limite_Operacoes*2) &&
  Saldo_Dia_Permite() == true &&
  Direcao_Fermat(0)!= Direcao_Fermat(1) &&
  TaDentroDoHorario_RT &&

  ((Usa_Prop == true && Prop_Delta() > Prop_Limite_Minimo) ||
  Usa_Fixos == true ))
  {
    DeuStopLoss = false;
    DeuTakeProfit = false;
    VendaImediata("Entrada Fermat","Entrada");
  }

  if(Direcao_Fermat()>0 &&
  Operacoes==0 &&
  OperacoesFeitas < (Limite_Operacoes*2) &&
  Saldo_Dia_Permite() == true &&
  Direcao_Fermat(0)!= Direcao_Fermat(1) &&
  TaDentroDoHorario_RT &&

  ((Usa_Prop == true && Prop_Delta() > Prop_Limite_Minimo) ||
  Usa_Fixos == true ))
  {
    DeuStopLoss = false;
    DeuTakeProfit = false;
    CompraImediata("Entrada Fermat","Entrada");
  }

// Programando uma saida
  if(Direcao_Fermat(0)!= Direcao_Fermat(1) &&
  Operacoes!=0 &&
  TaDentroDoHorario_RT &&
  Saldo_Operacao_Atual() < 0)
  {
    DeuStopLoss = true;
    if(Operacoes>0) VendaImediata("Saida Fermat - sem direcao","Saida");
    if(Operacoes<0) CompraImediata("Saida Fermat - sem direcao","Saida");
  }

}
