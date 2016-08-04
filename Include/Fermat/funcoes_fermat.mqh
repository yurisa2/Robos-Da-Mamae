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

  if(HandleMA1== 0 || HandleMA2 == 0 || HandleMA3 == 0)
  {
    ExpertRemove();
  }

    ChartIndicatorAdd(0,0,HandleMA1);
    ChartIndicatorAdd(0,0,HandleMA2);
    ChartIndicatorAdd(0,0,HandleMA3);

}
