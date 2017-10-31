/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                      OnTrade.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

void OnTradeTransaction(const MqlTradeTransaction& trans,
  const MqlTradeRequest& request,
  const MqlTradeResult& result)
  {

    posicao *Verifica_Posicao  = new posicao;

 ulong posicao_ticket = request.position;

if(posicao_ticket == Verifica_Posicao.Ticket)    Alert("Ticket" + IntegerToString(Verifica_Posicao.Ticket));

delete(Verifica_Posicao);

  }
