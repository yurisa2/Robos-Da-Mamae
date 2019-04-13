/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                      OnTrade.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robï¿½s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

void OnTradeTransaction(const MqlTradeTransaction& trans,
  const MqlTradeRequest& request,
  const MqlTradeResult& result)
  {
    ulong posicao_ticket = request.position;


    if(Zerar_SL_TP > 0 && !ja_zerou_sl_temp && O_Stops.Tipo_Posicao() != 0)
    {
      PositionSelect(_Symbol);
      double Lotes_Original = NormalizeDouble(Lotes,8);
      double Lotes_Alvo = 0;
      if(Zerar_SL_TP == 1) Lotes_Alvo = Lotes_Original - TakeProfit_Volume;
      if(Zerar_SL_TP == 2) Lotes_Alvo = Lotes_Original - TakeProfit_Volume - TakeProfit_Volume2;

      if(Lotes_Alvo == NormalizeDouble(PositionGetDouble(POSITION_VOLUME),8))
      {
        Print("Volume da Posicao: " + DoubleToString(PositionGetDouble(POSITION_VOLUME)));
        Print("Lotes: " + DoubleToString(Lotes));
        O_Stops.Setar_Ordens_Vars_Static(1);
        ja_zerou_sl_temp = true;
      }
    }

    /////// Inicio Apagar ordens pendentes
    if(O_Stops.Tipo_Posicao() == 0)
    {
      Opera_Mercado *opera = new Opera_Mercado;
      opera.ZeraOrdensP();
      delete(opera);
    }
    /////// FIM Apagar ordens pendentes

    //Inicio de TradeProcessor

    uint InpTradePause=150; // Pause between trades, ms  //Era INputs
    bool InpIsLogging=true; // Display information?  //Era INputs

    uint gTransCnt=0;

    //+------------------------------------------------------------------+
    enum ENUM_TRADE_OBJ
    {
      TRADE_OBJ_NULL=0,// not specified
      //---
      TRADE_OBJ_POSITION=1,   // position
      TRADE_OBJ_ORDER=2,      // order
      TRADE_OBJ_DEAL=3,       // deal
      TRADE_OBJ_HIST_ORDER=4, // historical order
    };

    //--- pause
    Sleep(InpTradePause);

    //--- if
    if(InpIsLogging)
    {
      //--- displays information on every transaction
      // Print("\n---===Transaction===---");
      // PrintFormat("Ticket of the deal: %d",trans.deal);
      // PrintFormat("Type of the deal: %s",EnumToString(trans.deal_type));
      // PrintFormat("Ticket of the order: %d",trans.order);
      // PrintFormat("Status of the order: %s",EnumToString(trans.order_state));
      // PrintFormat("Type of the order: %s",EnumToString(trans.order_type));
      // PrintFormat("Price: %0."+IntegerToString(_Digits)+"f",trans.price);
      // PrintFormat("Level of Stop Loss: %0."+IntegerToString(_Digits)+"f",trans.price_sl);
      // PrintFormat("Level of Take Profit: %0."+IntegerToString(_Digits)+"f",trans.price_tp);
      // PrintFormat("Price that triggers the Stop Limit order: %0."+IntegerToString(_Digits)+"f",trans.price_trigger);
      // PrintFormat("Trade symbol: %s",trans.symbol);
      // PrintFormat("Pending order expiration time: %s",TimeToString(trans.time_expiration));
      // PrintFormat("Order expiration type: %s",EnumToString(trans.time_type));
      // PrintFormat("Type of the trade transaction: %s",EnumToString(trans.type));
      // PrintFormat("Volume in lots: %0.2f",trans.volume);

      //--- if a request was sent
      if(trans.type==TRADE_TRANSACTION_REQUEST)
      {
        //--- displays information on the request
        // Print("\n---===Request===---");
        // PrintFormat("Type of the trade operation: %s",EnumToString(request.action));
        // PrintFormat("Comment to the order: %s",request.comment);
        // PrintFormat("Deviation from the requested price: %d",request.deviation);
        // PrintFormat("Order expiration time: %s",TimeToString(request.expiration));
        // PrintFormat("Magic number of the EA: %d",request.magic);
        // PrintFormat("Ticket of the order: %d",request.order);
        // PrintFormat("Price: %0."+IntegerToString(_Digits)+"f",request.price);
        // PrintFormat("Stop Loss level of the order: %0."+IntegerToString(_Digits)+"f",request.sl);
        // PrintFormat("Take Profit level of the order: %0."+IntegerToString(_Digits)+"f",request.tp);
        // PrintFormat("StopLimit level of the order: %0."+IntegerToString(_Digits)+"f",request.stoplimit);
        // PrintFormat("Trade symbol: %s",request.symbol);
        // PrintFormat("Type of the order: %s",EnumToString(request.type));
        // PrintFormat("Order execution type: %s",EnumToString(request.type_filling));
        // PrintFormat("Order expiration type: %s",EnumToString(request.type_time));
        // PrintFormat("Volume in lots: %0.2f",request.volume);
        //
        // //--- displays information about result
        // Print("\n---===Result===---");
        // PrintFormat("Code of the operation result: %d",result.retcode);
        // PrintFormat("Ticket of the deal: %d",result.deal);
        // PrintFormat("Ticket of the order: %d",result.order);
        // PrintFormat("Volume of the deal: %0.2f",result.volume);
        // PrintFormat("Price of the deal: %0."+IntegerToString(_Digits)+"f",result.price);
        // PrintFormat("Bid: %0."+IntegerToString(_Digits)+"f",result.bid);
        // PrintFormat("Ask: %0."+IntegerToString(_Digits)+"f",result.ask);
        // PrintFormat("Comment to the operation: %s",result.comment);
        // PrintFormat("Request ID: %d",result.request_id);
      }
    }
    //---

    static ENUM_TRADE_OBJ trade_obj;               // specifies the trade object at the first pass
    static ENUM_TRADE_REQUEST_ACTIONS last_action; // market operation at the first pass

    //---
    bool is_to_reset_cnt=false;
    string deal_symbol=trans.symbol;

    //---
    if(InpIsLogging)
    //PrintFormat("\nPass : #%d",gTransCnt+1);

    //--- ========== Types of transactions [START]
    switch(trans.type)
    {
      //--- 1) if it is a request
      case TRADE_TRANSACTION_REQUEST:
      {
        //---
        last_action=request.action;
        string action_str;

        //--- what is the request for?
        switch(last_action)
        {
          //--- ?) on market
          case TRADE_ACTION_DEAL:
          {
            action_str="place a market order";
            trade_obj=TRADE_OBJ_POSITION;
            break;
          }
          //--- ?) place a pending order
          case TRADE_ACTION_PENDING:
          {
            action_str="place a pending order";
            trade_obj=TRADE_OBJ_ORDER;
            break;
          }
          //--- ?) modify position
          case TRADE_ACTION_SLTP:
          {
            trade_obj=TRADE_OBJ_POSITION;
            //---
            StringConcatenate(action_str,request.symbol,": modify the levels of Stop Loss",
            " and Take Profit");

            //---
            break;
          }
          //--- ?) modify the order
          case TRADE_ACTION_MODIFY:
          {
            action_str="modify parameters of the pending order";
            trade_obj=TRADE_OBJ_ORDER;
            break;
          }
          //--- ?) delete the order
          case TRADE_ACTION_REMOVE:
          {
            action_str="delete the pending order";
            trade_obj=TRADE_OBJ_ORDER;
            break;
          }
        }
        //---
        if(InpIsLogging)
        //Print("Request received: "+action_str);

        //---
        break;
      }
      //--- 2) if it is an addition of a new open order
      case TRADE_TRANSACTION_ORDER_ADD:
      {
        if(InpIsLogging)
        {
          // if(trade_obj==TRADE_OBJ_POSITION)
          // Print("Open a new market order: "+
          // EnumToString(trans.order_type));
          // //---
          // else if(trade_obj==TRADE_OBJ_ORDER)
          // Print("Place a new pending order: "+
          // EnumToString(trans.order_type));
        }
        //---
        break;
      }
      //--- 3) if it is a deletion of an order from the list of open ones
      case TRADE_TRANSACTION_ORDER_DELETE:
      {
        //   if(InpIsLogging)
        // //  PrintFormat("Deleted from the list of open orders: #%d, "+
        //   EnumToString(trans.order_type),trans.order);
        //---
        break;
      }
      //--- 4) if it is an addition of a new order to the history
      case TRADE_TRANSACTION_HISTORY_ADD:
      {
        if(InpIsLogging)
        //PrintFormat("Order added to the history: #%d, "+
        //EnumToString(trans.order_type),trans.order);

        //--- if a pending order is being processed
        if(trade_obj==TRADE_OBJ_ORDER)
        {
          //--- if it is the third pass
          if(gTransCnt==2)
          {
            //--- if the order was canceled, check the deals
            datetime now=TimeCurrent();

            //--- request the history of orders and deals
            HistorySelect(now-PeriodSeconds(PERIOD_H1),now);

            //--- attempt to find a deal for the order
            CDealInfo myDealInfo;
            int all_deals=HistoryDealsTotal();
            //---
            bool is_found=false;
            for(int deal_idx=all_deals;deal_idx>=0;deal_idx--)
            if(myDealInfo.SelectByIndex(deal_idx))
            if(myDealInfo.Order()==trans.order)
            is_found=true;

            //--- if a deal was not found
            if(!is_found)
            {
              is_to_reset_cnt=true;
              //---
              // PrintFormat("#### CANCELOU Order canceled: #%d",trans.order);
            }
          }
          //--- if it is the fourth pass
          if(gTransCnt==3)
          {
            is_to_reset_cnt=true;
            //PrintFormat("Order deleted: #%d",trans.order);
          }
        }
        //---
        break;
      }
      //--- 5) if it is an addition of a deal to history
      case TRADE_TRANSACTION_DEAL_ADD:
      {
        is_to_reset_cnt=true;
        //---
        ulong deal_ticket=trans.deal;
        ENUM_DEAL_TYPE deal_type=trans.deal_type;
        //---
        if(InpIsLogging)
        //  PrintFormat("Deal added to history: #%d, "+EnumToString(deal_type),deal_ticket);

        if(deal_ticket>0)
        {
          datetime now=TimeCurrent();

          //--- request the history of orders and deals
          HistorySelect(now-PeriodSeconds(PERIOD_H1),now);

          //--- select a deal by the ticket
          if(HistoryDealSelect(deal_ticket))
          {
            //--- check the deal
            CDealInfo myDealInfo;
            myDealInfo.Ticket(deal_ticket);
            long order=myDealInfo.Order();

            //--- parameters of the deal
            ENUM_DEAL_ENTRY  deal_entry=myDealInfo.Entry();
            double deal_vol=0.;
            //---
            if(myDealInfo.InfoDouble(DEAL_VOLUME,deal_vol))
            if(myDealInfo.InfoString(DEAL_SYMBOL,deal_symbol))
            {
              //--- position
              CPositionInfo myPos;
              double pos_vol=WRONG_VALUE;
              //---
              if(myPos.Select(deal_symbol))
              pos_vol=myPos.Volume();

              //--- if the market was entered
              if(deal_entry==DEAL_ENTRY_IN)
              {
                //--- 1) opening of a position
                //    if(deal_vol==pos_vol)
                //  PrintFormat("\n%s: new position opened",deal_symbol);

                //--- 2) addition of lots to the open position
                //else if(deal_vol<pos_vol)   PrintFormat("\n%s: addition to the current position",deal_symbol);
                //Print("Entrou");
                //Print("Entrou myDealInfo.PositionId() " + myDealInfo.PositionId());
                if(!Otimizacao)
                {
                  //---File *arquivo = new File();
                  // FiltroF *filtro_fuzzy = new FiltroF;

                  //arquivo.Escreve(IntegerToString(myDealInfo.PositionId()),EnumToString(myDealInfo.DealType()),0,DEAL_ENTRY_IN);
                  // filtro_ind.Dados();
                  // filtro_fuzzy_arquivo = filtro_fuzzy.Fuzzy();
          //        delete(arquivo);
                  // delete(filtro_fuzzy);

                }

                deal_matrix.addDeal(myDealInfo);
                aquisicao_entrada.Dados();
              }

              //--- if the market was exited
              else if(deal_entry==DEAL_ENTRY_OUT)
              {
                OnTradeOut(myDealInfo);

                double lucro = myDealInfo.Profit();

                // MATRIX DEALS
                double line[];
                ArrayResize(line,(ArrayRange(aquisicao_entrada.todosDados,0)+1));

                line[0] = lucro;

                for (int i = 1; i < ArrayRange(line,0); i++) {
                  line[i] = aquisicao_entrada.todosDados[i-1];
                }

                ArrayResize(line,(ArrayRange(line,0)+1));
                line[ArrayRange(line,0)-1] = Normaliza_Hora(myDealInfo.Time());

                // ArrayPrint(line); //DEBUG

                deal_matrix.addLine(line);
                // deal_matrix.addDeal(myDealInfo);
                aquisicao_entrada.Zerar();
                // MATRIX DEALS

                // Print("Saiu deal_ticket" + deal_ticket);
                // Print("Saiu myDealInfo.Profit() " + myDealInfo.Profit());
                // Print("myPos.Profit() " + myPos.Profit());
                //Print("Saiu myDealInfo.PositionId() " + myDealInfo.PositionId());
                if(!Otimizacao)
                {
                  //FiltroF *filtro_teste = new FiltroF;
                  //File *arquivo = new File();
                  //File_Filtro *arquivo_filtro = new File_Filtro();
                  //arquivo.Escreve(IntegerToString(myDealInfo.PositionId()),EnumToString(myDealInfo.DealType()), myDealInfo.Profit(),DEAL_ENTRY_OUT);
                  //arquivo_filtro.Escreve(IntegerToString(myDealInfo.PositionId()),EnumToString(myDealInfo.DealType()), myDealInfo.Profit(),DEAL_ENTRY_OUT);
                  //filtro_teste.Escreve_Medias_Filtro();
                  //delete(filtro_teste);
                  //delete(arquivo);
                  //  delete(arquivo_filtro);
                  // Print(myDealInfo.Profit());
                }
                // Print(myDealInfo.Profit());


                if(deal_vol>0.0)
                {
                  //--- 1) closure of a position
                  //if(pos_vol==WRONG_VALUE)
                  //PrintFormat("\n%s: position closed",deal_symbol);
                  // PrintFormat("\n%s: Posicao Encerrada",deal_symbol);
                  // Print(myDealInfo.Profit());

                  // Print("Deal Profit:" + myDealInfo.Profit());

                  //--- 2) partial closure of the open position
                  //else if(pos_vol>0.0)
                  // PrintFormat("\n%s: partial closure of the current position",deal_symbol);
                  //PrintFormat("\n%s: Reduï¿½ï¿½o da Posiï¿½ï¿½o (Realizaï¿½ï¿½o Parcial)",deal_symbol);
                }
              }

              //--- if position was reversed
              else if(deal_entry==DEAL_ENTRY_INOUT)
              {
                // if(deal_vol>0.0)
                // if(pos_vol>0.0)
                // PrintFormat("\n%s: position reversal",deal_symbol);
              }
            }

            //--- activation of an order
            // if(trade_obj==TRADE_OBJ_ORDER) PrintFormat("Activation of a pending order: %d",order);
          }
        }

        //---
        break;
      }
      //--- 6) if it is a modification of a position
      case TRADE_TRANSACTION_POSITION:
      {
        is_to_reset_cnt=true;
        //---
        //PrintFormat("Modification of a position: %s",deal_symbol);
        //---
        if(InpIsLogging)
        {
          // PrintFormat("New price of the stop loss order: %0."+
          // IntegerToString(_Digits)+"f",trans.price_sl);
          // PrintFormat("New price of the take profit order: %0."+
          // IntegerToString(_Digits)+"f",trans.price_tp);
        }

        //---
        break;
      }
      //--- 7) if it is a modification of an open order
      case TRADE_TRANSACTION_ORDER_UPDATE:
      {

        //--- if it was the first pass
        if(gTransCnt==0)
        {
          trade_obj=TRADE_OBJ_ORDER;
          // PrintFormat("CANCELOU 2 Cancel the order: #%d",trans.order);
        }
        //--- if it was the second pass
        if(gTransCnt==1)
        {
          //--- if it is a modification of an order
          if(last_action==TRADE_ACTION_MODIFY)
          {
            //PrintFormat("Pending order modified: #%d",trans.order);
            //--- clear counter
            is_to_reset_cnt=true;
          }
          //--- if it is a deletion of an order
          if(last_action==TRADE_ACTION_REMOVE)
          {
            //PrintFormat("Delete pending order: #%d",trans.order);

          }
        }
        //--- if it was the third pass
        if(gTransCnt==2)
        {
          //PrintFormat("A new pending order was placed: #%d, "+
          //EnumToString(trans.order_type),trans.order);
          //--- clear counter
          is_to_reset_cnt=true;
        }

        //---
        break;
      }
    }
    //--- ========== Transaction types [END]

    //--- pass counter
    if(is_to_reset_cnt)
    {
      gTransCnt=0;
      trade_obj=0;
      last_action=-1;
    }
    else
    gTransCnt++;

  }
