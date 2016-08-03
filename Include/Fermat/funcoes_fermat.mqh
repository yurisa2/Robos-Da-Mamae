//+------------------------------------------------------------------+
//|                                            Fermat , o antigo ... |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

int HandleMA1 = iMA(NULL,TimeFrame,N_Ma1,0,Metodo,Preco_Aplicado);
int HandleMA2 = iMA(NULL,TimeFrame,N_Ma2,0,Metodo,Preco_Aplicado);
int HandleMA3 = iMA(NULL,TimeFrame,N_Ma3,0,Metodo,Preco_Aplicado);

ChartIndicatorAdd(0,0,HandleMA1);
ChartIndicatorAdd(0,0,HandleMA2);
ChartIndicatorAdd(0,0,HandleMA3);


if(HandleMA1== 0 || HandleMA2 == 0 || HandleMA3 == 0)
{
  ExpertRemove();
}
