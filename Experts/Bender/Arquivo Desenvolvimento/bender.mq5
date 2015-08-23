//+------------------------------------------------------------------+
//|                                                       bender.mq5 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <Trade\Trade.mqh>
#include <Trade\AccountInfo.mqh>

#include
//--- object for performing trade operations
CTrade  trade;
//--- input parameters
//+------------------------------------------------------------------+
//| Inputs                                                           |
//+------------------------------------------------------------------+
//--- inputs for expert
input int stoploss;
input int stopgain;
input int lotes;


//Primeiro passo - Primeira meia hora, pega valor minimo, ao longo do dia se tiver abaixo, vende.
//Se do ponto que eu vendi eu colocou 9 pontos pra baixo e compro

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
 {
//--- object for working with the account
   CAccountInfo account;
//--- receiving the account number, the Expert Advisor is launched at
   long login=account.Login();
   Print("Login=",login);
//--- clarifying account type
   ENUM_ACCOUNT_TRADE_MODE account_type=account.TradeMode();
//--- if the account is real, the Expert Advisor is stopped immediately!
   if(account_type==ACCOUNT_TRADE_MODE_REAL)
     {
      MessageBox("Trading on a real account is forbidden, disabling","The Expert Advisor has been launched on a real account!");
      return(-1);
     }
//--- displaying the account type    
   Print("Account type: ",EnumToString(account_type));
//--- clarifying if we can trade on this account
   if(account.TradeAllowed())
      Print("Trading on this account is allowed");
   else
      Print("Trading on this account is forbidden: you may have entered using the Investor password");
//--- clarifying if we can use an Expert Advisor on this account
   if(account.TradeExpert())
      Print("Automated trading on this account is allowed");
   else
      Print("Automated trading using Expert Advisors and scripts on this account is forbidden");
//--- clarifying if the permissible number of orders has been set
   int orders_limit=account.LimitOrders();
   if(orders_limit!=0)Print("Maximum permissible amount of active pending orders: ",orders_limit);
//--- displaying company and server names
   Print(account.Company(),": server ",account.Server());
//--- displaying balance and current profit on the account in the end
   Print("Balance=",account.Balance(),"  Profit=",account.Profit(),"   Equity=",account.Equity());
   Print(__FUNCTION__,"  completed"); //---
   return(0);
   
   //--- object for receiving symbol settings
   CSymbolInfo symbol_info;
//--- set the name for the appropriate symbol
   symbol_info.Name(_Symbol);
//--- receive current rates and display
   symbol_info.RefreshRates();
   Print(symbol_info.Name()," (",symbol_info.Description(),")",
         "  Bid=",symbol_info.Bid(),"   Ask=",symbol_info.Ask());
//--- receive minimum freeze levels for trade operations
   Print("StopsLevel=",symbol_info.StopsLevel()," pips, FreezeLevel=",
         symbol_info.FreezeLevel()," pips");
//--- receive the number of decimal places and point size
   Print("Digits=",symbol_info.Digits(),
         ", Point=",DoubleToString(symbol_info.Point(),symbol_info.Digits()));
//--- spread info
   Print("SpreadFloat=",symbol_info.SpreadFloat(),", Spread(current)=",
         symbol_info.Spread()," pips");
//--- request order execution type for limitations
   Print("Limitations for trade operations: ",EnumToString(symbol_info.TradeMode()),
         " (",symbol_info.TradeModeDescription(),")");
//--- clarifying trades execution mode
   Print("Trades execution mode: ",EnumToString(symbol_info.TradeExecution()),
         " (",symbol_info.TradeExecutionDescription(),")");
//--- clarifying contracts price calculation method
   Print("Contract price calculation: ",EnumToString(symbol_info.TradeCalcMode()),
         " (",symbol_info.TradeCalcModeDescription(),")");
//--- sizes of contracts
   Print("Standard contract size: ",symbol_info.ContractSize(),
         " (",symbol_info.CurrencyBase(),")");
//--- minimum and maximum volumes in trade operations
   Print("Volume info: LotsMin=",symbol_info.LotsMin(),"  LotsMax=",symbol_info.LotsMax(),
         "  LotsStep=",symbol_info.LotsStep());
//--- 
   Print(__FUNCTION__,"  completed");
//---
//--- set MagicNumber for your orders identification
   int MagicNumber=123456;
   trade.SetExpertMagicNumber(MagicNumber);
//--- set available slippage in points when buying/selling
   int deviation=10;
   trade.SetDeviationInPoints(deviation);
//--- order filling mode, the mode allowed by the server should be used
   trade.SetTypeFilling(ORDER_FILLING_RETURN);
//--- logging mode: it would be better not to declare this method at all, the class will set the best mode on its own
   trade.LogLevel(1); 
//--- what function is to be used for trading: true - OrderSendAsync(), false - OrderSend()
   trade.SetAsyncMode(true);
//---

   return(0);

  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
      
  }
  
  
  
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+

double precoate930 = 0;
double precocompra = 0;
bool jacomprou = false;
bool javendeu = false;
string hora11;
int minuto;
int hora;

  


void OnTick()
  {
  

   MqlTick last_tick;
//---
 //  if(SymbolInfoTick(Symbol(),last_tick))
 if(SymbolInfoTick("WDO$N",last_tick))
     {
     // Print(last_tick.time,": Bid = ",last_tick.bid,
          //  " Ask = ",last_tick.ask,"  Volume = ",last_tick.volume); //total e completo
 
 hora11 = TimeToString(TimeCurrent(),TIME_MINUTES);
 minuto = StringToInteger(StringSubstr(hora11,3,2));
 hora = StringToInteger(StringSubstr(hora11,0,2));     
 // Manda rodar antes de 17:30
 if(hora<=17) 
   {
   
   if(minuto<30)
   {
  //    Print("Antes da 17:30");
  // Começa gathering de dados da primeira meia hora
 if(hora==09) 
   {
   
   if(minuto<30)
   {
   
   if(precoate930<last_tick.ask)
     {
      precoate930=last_tick.ask;  
      
     // Print("era menor - ");
     // Print(precoate930);
     }
     else
       {
       // Print("era maior - ");
      //  Print(precoate930);
       }
   
   }
   
   
   
 
   }
   
   //Fim do primeiro Gathering de dados da primeira meia hora
   
   
   // Inicio do Resto do dia
   
   if(jacomprou==false)
     {
      
    
   if(hora>=09) 
   {
   
   if(minuto>=30)
   {
   
 // Aqui vai ter que ser igual ao else melhor fazer outro if com hora maior de 10  ---  Compra a porra
 
      if(precoate930<last_tick.ask)
            {
        
         jacomprou = true;
         Print("COMPRA - ROMPIMENTO - Apos 09:30");
         precocompra=last_tick.ask;
         if(!trade.Buy(lotes,"WDO$N"))
     {
      //--- failure message
      Print("Buy() method failed. Return code=",trade.ResultRetcode(),
            ". Descrição do código: ",trade.ResultRetcodeDescription());
     }
   else
     {
//      Print("Buy() method executed successfully. Return code=",trade.ResultRetcode(),
//            " (",trade.ResultRetcodeDescription(),")");
     }
         
         
         
         
        }
 
 
 
     }
     else
       {
       }
   
   }
   
   if(hora>=10) 
   {
   
 //Compra a 
 
   if(precoate930<last_tick.ask)
          { 
          
         jacomprou = true;
         Print("COMPRA - ROMPIMENTO APOS AS 10");
         precocompra=last_tick.ask;
         if(!trade.Buy(lotes,"WDO$N"))
     {
      //--- failure message
      Print("Buy() method failed. Return code=",trade.ResultRetcode(),
            ". Descrição do código: ",trade.ResultRetcodeDescription());
     }
   else
     {
  //    Print("Buy() method executed successfully. Return code=",trade.ResultRetcode(),
  //          " (",trade.ResultRetcodeDescription(),")");
     }
         
         
         
         
        }
   
 
   }
 } 
     // Fim da tentativa ja comprou
    
// VENDA
 if(jacomprou==true)
   {
       if(javendeu==false)
         {
            if(last_tick.ask>=precocompra+stopgain)
               {
                    Print("VENDA - STOP GAIN");
                    javendeu = true;
                    if(!trade.Sell(lotes,"WDO$N"))
     {
      //--- failure message
      Print("Sell() method failed. Return code=",trade.ResultRetcode(),
            ". Descrição do código: ",trade.ResultRetcodeDescription());
     }
   else
     {
//      Print("Sell() method executed successfully. Return code=",trade.ResultRetcode(),
//            " (",trade.ResultRetcodeDescription(),")");
     }
               }
               //Colocar Aqui uma condição de horário para fechar o dia.
               
               if(last_tick.ask<=precocompra-stoploss)
               {
                    Print("VENDA - STOP LOSS");
                    javendeu = true;
                    if(!trade.Sell(lotes,"WDO$N"))
     {
      //--- failure message
      Print("Sell() method failed. Return code=",trade.ResultRetcode(),
            ". Descrição do código: ",trade.ResultRetcodeDescription());
     }
   else
     {
 //     Print("Sell() method executed successfully. Return code=",trade.ResultRetcode(),
 //        " (",trade.ResultRetcodeDescription(),")");
     }
               }
         }
   }


// FIM DA VENDA


}
}//Bracket do IF das 17 horas Seja o que for roda fora daqui

//fim do dia

if(hora==17) 
   {
   
   if(minuto>=30)
   {

if(jacomprou==true)
   {
       if(javendeu==false)
         {
            
                    Print("VENDA - FINAL DO DIA");
                    javendeu = true;
                    if(!trade.Sell(lotes,"WDO$N"))
     {
      //--- failure message
      Print("Sell() method failed. Return code=",trade.ResultRetcode(),
          ". Descrição do código: ",trade.ResultRetcodeDescription());
     }
   else
     {
 //     Print("Sell() method executed successfully. Return code=",trade.ResultRetcode(),
 //           " (",trade.ResultRetcodeDescription(),")");
     }
               
            
         }
   }
precoate930 = 0;
precocompra = 0;
jacomprou = false;
javendeu = false;

}
}

   // FECHA FIM DO DIA
   // Fim do resto do dia

//Encerramento do dia.



  
   
//  Print(minuto);
//  Print(hora);      
            
 //da o ultimo preco
     
      //      Print(last_tick.ask);
      //     Print(preco);    //manda pro log
            
           
//Fazer avaliações com IF de horário e maior valor usando  last_tick.time        
          
    //      Print(jacomprou);
            
     }
   else Print("SymbolInfoTick() failed, error = ",GetLastError());
//---
  }
  
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   $
  }
//+------------------------------------------------------------------+
