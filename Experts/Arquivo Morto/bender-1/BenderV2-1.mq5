//+------------------------------------------------------------------+
//|                                                     BenderV2.mq5 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <funcoesbender-1.mqh>

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
      if(MinPrecoAte930>StringToDouble(daotick("preco"))) MinPrecoAte930=StringToDouble(daotick("preco"));
   }

//////////////////////////////////////////////


//////////// ROTINA DO DIA //////////////

if(TaDentroDoHorario("09:30","17:30")==true)
   {
     if(MinPrecoAte930<StringToDouble(daotick("preco")))
     {
     Venda(lotes,"WDO$N","VENDA - ROMPIMENTO NEGATIVO - ");
     }
      
      if(StringToDouble(daotick("preco"))<=PrecoVenda-stoploss)
      {
      Compra(lotes,"WDO$N","Compra - STOPGAIN");
      }
      
      
      if(StringToDouble(daotick("preco"))>=PrecoVenda+stopgain)
      {
      Compra(lotes,"WDO$N","Compra - STOPLOSS");
      }
      
      
   }


/////////////////////////////////////////


//////////// Finaliza o Dia (Zerar Posição) ///////////////

if(TaDentroDoHorario("17:31","17:35")==true)

{

Compra(lotes,"WDO$N","Compra - FIM DO DIA");

   MinPrecoAte930 = 0;
   PrecoVenda = 0;
   JaComprou = false;
   JaVendeu = false;

}


///////////////////////////////////////////////////////////

   
  }
  
//+------------------------------------------------------------------+
