//+------------------------------------------------------------------+
//|                                            Fermat , o antigo ... |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
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

double MA1 ()
{
  double ValorMA[];
  ArraySetAsSeries(ValorMA, true);
  int copied=CopyBuffer(HandleMA1,0,0,100,ValorMA);
  return ValorMA[0];
}

double MA2 ()
{
  double ValorMA[];
  ArraySetAsSeries(ValorMA, true);
  int copied=CopyBuffer(HandleMA2,0,0,100,ValorMA);
  return ValorMA[0];
}

double MA3 ()
{
  double ValorMA[];
  ArraySetAsSeries(ValorMA, true);
  int copied=CopyBuffer(HandleMA3,0,0,100,ValorMA);
  return ValorMA[0];
}

int Avalia_MAs () //True se cumpre os quesitos de maior menor e distancia e da o sentido, ZERO (0) e igual a nao cumpre
{
if(MA3() < MA1() && MA2() < MA1() && MA1()-MA3() >= Tick_Size*Distancia_m1_m3)
{
Direcao = 1;
return 1;
}
else
if(MA3() > MA1() && MA2() > MA1() && MA3()-MA1() >= Tick_Size*Distancia_m1_m3)
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
" | Direcao: "+IntegerToString(Avalia_MAs())
;
}
