//+------------------------------------------------------------------+
//|                                            BenderDefinitivo1.mq5 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"
#property version   "2.04"


#include <FuncoesBenderDef.mqh>

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  iniciaconexao();
//---
   //--- set MagicNumber for your orders identification
   int MagicNumber=646572;
   trade.SetExpertMagicNumber(MagicNumber);

//---

   
   return(INIT_SUCCEEDED);
   
   
   
  }
  
void OnTimer()
{


 }
 
 void OnTradeTransaction(const MqlTradeTransaction& trans,
                              const MqlTradeRequest& request,
                              const MqlTradeResult& result)
        {
        
   
             
        /*
                 
          if(trans.order_state==ORDER_STATE_STARTED && trans.price_sl == 0 && trans.price_tp ==0 && trans.volume>0 && trans.type == TRADE_TRANSACTION_DEAL_ADD)
            {

             
             Print("Modificando Stops | Ticket Deal # : ",trans.deal);
             
             Mod_Req_sl = trans.price - StopLossPositivo;
             Mod_Req_tp = trans.price + StopGainPositivo;
             

             
             
             ModificaRequisicao();






          
            }  // Fim do if
        

       /*
         
         //--- displays information on every transaction
      Print("\n---===Transaction===---");
      PrintFormat("Ticket of the deal: %d",trans.deal);
      PrintFormat("Type of the deal: %s",EnumToString(trans.deal_type));
      PrintFormat("Ticket of the order: %d",trans.order);
      PrintFormat("Status of the order: %s",EnumToString(trans.order_state));
      PrintFormat("Type of the order: %s",EnumToString(trans.order_type));
      PrintFormat("Price: %0."+IntegerToString(_Digits)+"f",trans.price);
      PrintFormat("Level of Stop Loss: %0."+IntegerToString(_Digits)+"f",trans.price_sl);
      PrintFormat("Level of Take Profit: %0."+IntegerToString(_Digits)+"f",trans.price_tp);
      PrintFormat("Price that triggers the Stop Limit order: %0."+IntegerToString(_Digits)+"f",trans.price_trigger);
      PrintFormat("Trade symbol: %s",trans.symbol);
      PrintFormat("Pending order expiration time: %s",TimeToString(trans.time_expiration));
      PrintFormat("Order expiration type: %s",EnumToString(trans.time_type));
      PrintFormat("Type of the trade transaction: %s",EnumToString(trans.type));
      PrintFormat("Volume in lots: %0.2f",trans.volume);

      //--- if a request was sent
      if(trans.type==TRADE_TRANSACTION_REQUEST)
        {
         //--- displays information on the request
         Print("\n---===Request===---");
         PrintFormat("Type of the trade operation: %s",EnumToString(request.action));
         PrintFormat("Comment to the order: %s",request.comment);
         PrintFormat("Deviation from the requested price: %d",request.deviation);
         PrintFormat("Order expiration time: %s",TimeToString(request.expiration));
         PrintFormat("Magic number of the EA: %d",request.magic);
         PrintFormat("Ticket of the order: %d",request.order);
         PrintFormat("Price: %0."+IntegerToString(_Digits)+"f",request.price);
         PrintFormat("Stop Loss level of the order: %0."+IntegerToString(_Digits)+"f",request.sl);
         PrintFormat("Take Profit level of the order: %0."+IntegerToString(_Digits)+"f",request.tp);
         PrintFormat("StopLimit level of the order: %0."+IntegerToString(_Digits)+"f",request.stoplimit);
         PrintFormat("Trade symbol: %s",request.symbol);
         PrintFormat("Type of the order: %s",EnumToString(request.type));
         PrintFormat("Order execution type: %s",EnumToString(request.type_filling));
         PrintFormat("Order expiration type: %s",EnumToString(request.type_time));
         PrintFormat("Volume in lots: %0.2f",request.volume);

         //--- displays information about result
         Print("\n---===Result===---");
         PrintFormat("Code of the operation result: %d",result.retcode);
         PrintFormat("Ticket of the deal: %d",result.deal);
         PrintFormat("Ticket of the order: %d",result.order);
         PrintFormat("Volume of the deal: %0.2f",result.volume);
         PrintFormat("Price of the deal: %0."+IntegerToString(_Digits)+"f",result.price);
         PrintFormat("Bid: %0."+IntegerToString(_Digits)+"f",result.bid);
         PrintFormat("Ask: %0."+IntegerToString(_Digits)+"f",result.ask);
         PrintFormat("Comment to the operation: %s",result.comment);
         PrintFormat("Request ID: %d",result.request_id);

        
        }
                */
     } // Fim do ontradetransaction
         
         
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
  
InicioDoDia();


EntregaDados();  // Entra o Max e Min do dia.

PosicaoPositiva();
PosicaoNegativa();
StopLoss();
StopGain();



//////////////////// FInal Do Dia

 if(TaDentroDoHorario("17:36","17:40")==true && JaDeuFinal==false)
   {
      JaDeuFinal = true;
      JaZerou = false; 
      Print("Final do Dia!");
      

      if(Operacoes>0) 
      {
         TipoOp = ORDER_TYPE_SELL;
         ValorStopLoss = 0;
         ValorStopGain = 0;
         MontarRequisicao();  
         Operacoes = Operacoes -1;
      }
      
      if(Operacoes<0) 
      {
         TipoOp = ORDER_TYPE_BUY;
         ValorStopLoss = 0;
         ValorStopGain = 0;
         MontarRequisicao(); 
         Operacoes = Operacoes +1;  
      
      }
      
   Print("Operações no final do dia: ", Operacoes);
   
    ObjectsDeleteAll(ChartID(),-1,-1);
   }
      
    
      
/////////////////////////////      
      


   
  }
//+------------------------------------------------------------------+
