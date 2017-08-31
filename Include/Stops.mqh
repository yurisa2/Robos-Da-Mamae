/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                                  |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

#include <Stops_Moveis.mqh>
#include <Stops_Fixos.mqh>

void Inicializa_Prop ()
{

   Prop_Limite_Minimo =  Prop_Limite_Minimo_Tick_Size * Tick_Size;
   Print("Tamanho do Tick: ",Tick_Size," Delta Minimo: ",Prop_Limite_Minimo);

// Delta com duas m�dias
   if(Prop_Metodo == 534)
   {
      Handle_Prop_Media_Alta = iMA(_Symbol,TimeFrame,Prop_Periodos,0,MODE_SMA,PRICE_HIGH);
      Handle_Prop_Media_Baixa = iMA(_Symbol,TimeFrame,Prop_Periodos,0,MODE_SMA,PRICE_LOW);

      ChartIndicatorAdd(0,0,Handle_Prop_Media_Alta);
      ChartIndicatorAdd(0,0,Handle_Prop_Media_Baixa);
   }
   // Delta com BB
   if(Prop_Metodo == 88)
   {
      Handle_Prop_BB = iBands(_Symbol,TimeFrame,Prop_Periodos,0,2,PRICE_CLOSE);
            ChartIndicatorAdd(0,0,Handle_Prop_BB);
   }

   if(Handle_Prop_Media_Alta + Handle_Prop_Media_Baixa + Handle_Prop_BB == 0 )
     {
       ExpertRemove();
     }
}
