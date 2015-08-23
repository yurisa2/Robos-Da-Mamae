//+------------------------------------------------------------------+
//|                                                 TesteFuncoes.mq5 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
string imprime;

string                       // return value type
funcaoteste () // function name and parameter list
  {
//    2015.07.24 17:31:58.342	2015.07.22 10:20:30   alguma coisa deu errado

 //  if(TimeToString(TimeTradeServer(),TIME_MINUTES)>StringToTime("yyyy.mm.dd hh:mi")
  if(TimeTradeServer()>StringToTime("2015.07.22 10:40"))
     {
      imprime="é, é maior";
     }
   else
     {
      imprime="alguma coisa deu errado";
     }   
   
   Print(imprime) ;       // return value
   return("0");
  }




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

bool jafez = false;
void OnTick()
  {
//---
   if(jafez==false)
     {
      funcaoteste();
      jafez=true;
     }
   
   
   
  }
//+------------------------------------------------------------------+
