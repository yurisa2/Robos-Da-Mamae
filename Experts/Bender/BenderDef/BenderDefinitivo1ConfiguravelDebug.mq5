//+------------------------------------------------------------------+
//|                                            BenderDefinitivo1.mq5 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"
#property version   "2.00"

#include <basico.mqh>
#include <BenderDef\FuncoesBenderDef.mqh>

input int Lotes =1;
input bool ModoPositivo = true;
input double StopLossPositivo =9;
input double StopGainPositivo = 9;
input bool ModoNegativo = true;
input double StopLossNegativo = 9;
input double StopGainNegativo = 9;
input double   MinReferencia;
input double   MaxReferencia;


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
  if(JaZerou==false)
    {
        if(TaDentroDoHorario("09:00","09:01")==true)
        {
        JaZerou = true;
        JaPegouHistorico = false;
        PosicaoAberta = false;
        JaDeuFinal = false;
        Print("Bom dia! Vamos fazer um dinheiro!!!");
        SendNotification("Bom dia! Bender Iniciando Operação!");
        
        }

    }



EntregaDados();  // Entra o Max e Min do dia.




//////// Abre Posicao Positiva

   


if(TaDentroDoHorario("09:30","17:30")==true)
   {
 
   
   if(StringToDouble(daotick("preco")) >= MaxReferencia)
     {
        if(PosicaoAberta==false)
         {
            PosicaoAberta=true;
            trade.PositionOpen(_Symbol,ORDER_TYPE_BUY,Lotes,StringToDouble(daotick("preco")),StringToDouble(daotick("preco"))-StopLossPositivo,StringToDouble(daotick("preco"))+StopGainPositivo,"Posição Modo Positivo");
            Print("Compra - Modo Positivo - Hora da Compra: ",daotick("hora")," | Preco Compra: ",daotick("preco"));
         }
   }


   }



//////////////////////



//////// Abre Posicao Negativa

   


if(TaDentroDoHorario("09:30","17:30")==true)
   {
 
   
   if(StringToDouble(daotick("preco")) <= MinReferencia)
     {
        if(PosicaoAberta==false)
         {
            PosicaoAberta=true;
            trade.PositionOpen(_Symbol,ORDER_TYPE_SELL,Lotes,StringToDouble(daotick("preco")),StringToDouble(daotick("preco"))+StopLossNegativo,StringToDouble(daotick("preco"))-StopGainNegativo,"Posição Modo Negativo");
            Print("Venda - Modo Negativo - Hora da Venda: ",daotick("hora")," | Preco Venda: ",daotick("preco"));
         }
   }







   }



//////////////////////






//////////////////// FInal Do Dia

 if(TaDentroDoHorario("17:36","17:40")==true && JaDeuFinal==false)
   {
      JaDeuFinal = true;
      JaZerou = false; 
      trade.PositionClose(_Symbol,-1);
      Print("Final do Dia!");
      
 /*     
      if(PosicaoAberta==true)
            {
            Print("Fechou o Dia e não deu nem SL nem TP");
            }
  */          
   
   }
      
      
      
/////////////////////////////      
      


   
  }
//+------------------------------------------------------------------+
