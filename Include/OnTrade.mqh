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

if(posicao_ticket == Verifica_Posicao.Ticket)    Alert("Ticket: " + IntegerToString(Verifica_Posicao.Ticket));

delete(Verifica_Posicao);


if(Zerar_SL_TP == 1)
{
  PositionSelect(_Symbol);
  if(Lotes != PositionGetDouble(POSITION_VOLUME))
  {

    double tp = daotick_geral + (100 * Tick_Size * O_Stops.Tipo_Posicao());
    double sl = O_Stops.Valor_Negocio();

    CTrade *tradionices = new CTrade;
    tradionices.PositionModify(Symbol(),sl,tp);
    delete(tradionices);

  }

}



  }
