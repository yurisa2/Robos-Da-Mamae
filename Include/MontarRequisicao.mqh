//+------------------------------------------------------------------+
//|                                             MontarRequisicao.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"


//////////////////////////// Req de Operaçao

void MontarRequisicao (ENUM_ORDER_TYPE order_type, string comentario_req)
   {
         if(order_type==ORDER_TYPE_SELL) 
         {
            PrecoVenda = daotick();
            Operacoes = Operacoes -1;
         }
         if(order_type==ORDER_TYPE_BUY)  
         {
            PrecoCompra = daotick();   
            Operacoes = Operacoes +1;
         }   
            
         StopLossValorCompra =-9999999999;
         TakeProfitValorCompra = 999999999;
         StopLossValorVenda =99999999999;
         TakeProfitValorVenda = -999999999;
         TS_ValorVenda = 99999999;
         TS_ValorCompra = 0;
         OperacoesFeitas++;
         
         if(Usa_Fixos == true) CalculaStops();
         if(Usa_Prop == true) Stops_Proporcional();

         MqlTradeRequest Req;     
         MqlTradeResult Res;     
         ZeroMemory(Req);     
         ZeroMemory(Res);     
         Req.symbol       = Symbol();
         Req.volume       = Lotes;
         Req.magic = TimeMagic;
         Req.type_filling = TipoDeOrdem;                 
         Req.action=TRADE_ACTION_DEAL; 
         Req.type=order_type; 
         Req.comment=Descricao_Robo+" "+comentario_req;     
         Req.tp=0;
         Req.sl=0;
         
               if(OrderSend(Req,Res)) Print(Descricao_Robo," - Ordem Enviada |",comentario_req); 
               else 
                  {
                  Print(Descricao_Robo+" Deu Pau, Verifique com pressao");
                  SendNotification("ERRO GRAVE, VERIFIQUE: "+IntegerToString(GetLastError()));
                  ExpertRemove();
                  }

         DaResultado = true;
   ObjectsDeleteAll(0,0,-1);
   CriaLinhaTS(0);
   Cria_Botao_Abortar();
   CriaLinhas();
   AtualizaLinhas();
   Print("Operacoes no fim da req: ",Operacoes);
   }
   /////////////////////////////////////////// Final da req.