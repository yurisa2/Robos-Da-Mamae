/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             MontarRequisicao.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class posicao : public CPositionInfo
{
  public:
  // ~posicao();
  posicao();
  bool PosicaoExiste();
  long Ticket; //Meh
  long TicketPosicao();
  int  Tipo_Posicao();
  double LucroAtual();


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
  return 0;
}

void  posicao::posicao()
{
}


int  posicao::Tipo_Posicao()
{
    if(!this.Select(Symbol()))
    {
      Operacoes = 0;
      return 0;
    }
    else
    {
      if(this.PositionType() == POSITION_TYPE_BUY)
      {
        Operacoes = 1;
          return 1;
      }
      if(this.PositionType() == POSITION_TYPE_SELL)
      {
        Operacoes = -1;
          return -1;
      }
    }
    return Operacoes; //Remover quando tirar Vars Flutuantes
}



double posicao::LucroAtual()
{
  double retorno = 0;

  if(this.Tipo_Posicao() != 0)
  {
    this.Select(Symbol());
    retorno = this.Profit();
  }


  return retorno;
}
