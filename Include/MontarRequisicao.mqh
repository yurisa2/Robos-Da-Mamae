/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             MontarRequisicao.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"


//////////////////////////// Req de Opera�ao

void MontarRequisicao (ENUM_ORDER_TYPE order_type, string comentario_req)
   {
         if(order_type==ORDER_TYPE_SELL)
         {
            PrecoVenda = daotick(-1);
            Operacoes = Operacoes - 1;
            Print("Valor da VENDA: ",PrecoVenda);
         }
         if(order_type==ORDER_TYPE_BUY)
         {
            PrecoCompra = daotick(1);
            Operacoes = Operacoes + 1;
            Print("Valor da Compra: ",PrecoCompra);
         }

         StopLossValorCompra =   -999999999;
         TakeProfitValorCompra =  999999999;
         StopLossValorVenda =     999999999;
         TakeProfitValorVenda =  -999999999;
         TS_ValorVenda =          999999999;
         TS_ValorCompra = 0;
         OperacoesFeitas++;
         OperacoesFeitasGlobais++;
         Contador_SLMOVEL = 0;

         if(Usa_Fixos == true) CalculaStops();
         if(Usa_Prop == true)
         {
            Stops_Proporcional();
            Print("Delta do Proporcional: ",Prop_Delta());
         }

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

        //  if(!multi_op)
        //  {
        //    if(Operacoes > 0)
        //    {
        //      Req.sl = StopLossValorCompra;
        //      Req.tp = TakeProfitValorCompra;
        //    }
         //
        //    if(Operacoes < 0)
        //    {
        //      Req.sl = 50;
        //      Req.tp = 50;
        //    }
        //  }

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

         Sleep(300);
   Apaga_Graficos();
   if(Operacoes!=0)
   {
      CriaLinhaTS(0);
      Cria_Botao_Abortar();
      CriaLinhas();
      AtualizaLinhas();
   }
   if(Operacoes==0)
   {
      Apaga_Graficos();
      Comment(Descricao_Robo+" - Nenhuma trade ativa | DELTA: "+DoubleToString(Prop_Delta(),0));
      Cria_Botao_Operar();
   }
   Print("Operacoes no fim da req: ",Operacoes);
   Print("Saldo do Dia ate o momento: ",conta.Equity() - liquidez_inicio -  OperacoesFeitas*custo_operacao);
//   Print("Funcao Saldo: ",Saldo_Dia_Permite());


   Liquidez_Teste_fim = conta.Equity();
//   Print("Liquides Ini - Equi: ",liquidez_inicio - conta.Equity());
//   Print("Ops Feitas: ",OperacoesFeitas);
//   Print("CustoOps: ",custo_operacao);
   }
   /////////////////////////////////////////// Final da req.
/*
void MontarPosicao(ENUM_ORDER_TYPE order_type,string comentario_req)
{

  double sl = 0;
  double tp = 0;
  double price = 0;

  if(order_type == ORDER_TYPE_SELL)
  {
     PrecoVenda = daotick(-1);
     sl = PrecoVenda + (StopLoss * Tick_Size);
     tp = PrecoVenda - (TakeProfit * Tick_Size);
     price = PrecoVenda;
     Operacoes = Operacoes - 1;

     Print("Valor da VENDA: ",PrecoVenda);
  }
  if(order_type == ORDER_TYPE_BUY)
  {
     PrecoCompra = daotick(1);
     sl = PrecoCompra - (StopLoss * Tick_Size);
     tp = PrecoCompra + (TakeProfit * Tick_Size);
     price = PrecoCompra;
     Operacoes = Operacoes + 1;
     Print("Valor da Compra: ",PrecoCompra);
  }

  opera.PositionOpen(Symbol(),         // symbol
   order_type,     // order type to open position
   Lotes,         // position volume
  price,          // execution price
  sl,             // Stop Loss price
  tp,             // Take Profit price
   comentario_req      // comment
 );

 Sleep(300);

 PositionSelect(Symbol());
 double Ultimo_Preco = opera.ResultPrice();

 Print("Ultimo_Preco: " + Ultimo_Preco); //DEBUG

 if(order_type == ORDER_TYPE_SELL)
 {
    PrecoVenda = daotick(-1);
    sl = Ultimo_Preco + (StopLoss * Tick_Size);
    tp = Ultimo_Preco - (TakeProfit * Tick_Size);
 }
 if(order_type == ORDER_TYPE_BUY)
 {
    PrecoCompra = daotick(1);
    sl = Ultimo_Preco - (StopLoss * Tick_Size);
    tp = Ultimo_Preco + (TakeProfit * Tick_Size);
 }

 opera.PositionModify(
    Symbol(),     // symbol
    sl,         // Stop Loss price
    tp          // Take Profit price
  );

// Print("SL: " + sl); //DEBUG
// Print("TP: " + tp); //DEBUG

}
*/
