/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             MontarRequisicao.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class posicao : public CPositionInfo
{
  public:
  // ~posicao();
  posicao();
  bool PosicaoExiste();
  long Ticket; //Meh
  long TicketPosicao();

  private:

};

  long posicao::TicketPosicao()
  {
    long return_pos_ticket;
    Select(Symbol());
    InfoInteger(POSITION_TICKET,return_pos_ticket);

  return return_pos_ticket;
  }

  bool posicao::PosicaoExiste()
  {

    return   Select(Symbol());

  }

 void  posicao::posicao()
  {
  }
