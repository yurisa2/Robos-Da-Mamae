/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                      OnTrade.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

void OnTradeTransaction(const MqlTradeTransaction& trans,
  const MqlTradeRequest& request,
  const MqlTradeResult& result)
  {

    posicao *Verifica_Posicao  = new posicao;

 ulong posicao_ticket = request.position;

//if(posicao_ticket == Verifica_Posicao.Ticket)    Alert("Ticket: " + IntegerToString(Verifica_Posicao.Ticket)); // Acho que aqui s�o todos os eventso

delete(Verifica_Posicao);


if(Zerar_SL_TP == 1)
{
  PositionSelect(_Symbol);
  if(Lotes != PositionGetDouble(POSITION_VOLUME))
  {

    // double tp = daotick_geral + (100 * Tick_Size * O_Stops.Tipo_Posicao());
    double tp = 0;
    double sl = O_Stops.Valor_Negocio() + Tick_Size;

    CTrade *tradionices = new CTrade;
    tradionices.PositionModify(Symbol(),sl,tp);
    delete(tradionices);

  }

}

/////// Inicio Apagar ordens pendentes
if(O_Stops.Tipo_Posicao() == 0)
{
  int ord_total=OrdersTotal();
  if(ord_total > 0)
  {
    for(int i=ord_total-1;i>=0;i--)
    {
      ulong ticket=OrderGetTicket(i);
      if(OrderSelect(ticket) && OrderGetString(ORDER_SYMBOL)==Symbol())
      {
        CTrade *trade=new CTrade();
        trade.OrderDelete(ticket);
        delete trade;
      }
    }
  }
}
/////// FIM Apagar ordens pendentes

  }
