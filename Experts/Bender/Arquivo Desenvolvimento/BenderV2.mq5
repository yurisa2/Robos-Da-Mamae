//+------------------------------------------------------------------+
//|                                                     BenderV2.mq5 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <funcoesbender.mqh>

////////////////////// INPUTS
input double stoploss;
input double stopgain;
input int lotes;
//////////////////////////////


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   iniciaconexao();
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
/* Estrutura de TESTE 
bool jafez = false;
string data;
string valor;
void OnTick()
  {
 if(jafez==false)
     {
      Print(daotick("hora"));
      jafez=true;
     }

   
  }
  
  */
  
  void OnTick()
  {
///////////// GATHERING DE DADOS /////////////

if(TaDentroDoHorario("09:00","09:30")==true)
   {
      if(MaxPrecoAte930<StringToDouble(daotick("preco"))) MaxPrecoAte930=StringToDouble(daotick("preco"));
   }

//////////////////////////////////////////////


//////////// ROTINA DO DIA //////////////

if(TaDentroDoHorario("09:30","17:30")==true)
   {
     if(MaxPrecoAte930<StringToDouble(daotick("preco")))
     {
     Compra(lotes,"WDO$N","COMPRA - ROMPIMENTO POSITIVO");
     }
      
      if(StringToDouble(daotick("preco"))<=PrecoCompra-stoploss)
      {
      Venda(lotes,"WDO$N","VENDA - STOPLOSS");
      }
      
      
      if(StringToDouble(daotick("preco"))>=PrecoCompra+stopgain)
      {
      Venda(lotes,"WDO$N","VENDA - STOPGAIN");
      }
      
      
   }


/////////////////////////////////////////


//////////// Finaliza o Dia (Zerar Posição) ///////////////

if(TaDentroDoHorario("17:31","17:35")==true)

{

Venda(lotes,"WDO$N","VENDA - FIM DO DIA");

   MaxPrecoAte930 = 0;
   PrecoCompra = 0;
   JaComprou = false;
   JaVendeu = false;

}


///////////////////////////////////////////////////////////

   
  }
  
//+------------------------------------------------------------------+
