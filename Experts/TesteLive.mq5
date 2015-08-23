//+------------------------------------------------------------------+
//|                                             TesteComPosicoes.mq5 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"


#include <funcoesbender.mqh>
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//   EventSetTimer(60);
   
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
    EventKillTimer();
   
   
  }
  
  
void OnTimer()
{

Print("1 Minuto");
} 
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+

//---
bool jafez = false;

string data;
string valor;

int contador;
void OnTick()
  {
  
  if(contador<1)
    {
    contador++;
    jafez = true;
     

    }
    else
      {
      contador=0;
      jafez=false;
      }
  
  
  
 if(jafez==false)
     {

      double Tick;
      
      Tick = StringToDouble(daotick("preco"));


      jafez=true;
     Print("Função de contagem live: ",Tick,"Contador :",contador);
      contador=0;
      
     }

   
  }
  

   
  
//+------------------------------------------------------------------+
