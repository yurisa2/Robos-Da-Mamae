/* -*- C++ -*- */

class Xeno
{

  public:
  void Xeno_Comentario();
  void Avalia();
  void Timer();

};



void Xeno::Xeno_Comentario()
{

  IXP *ixp = new IXP(IXP_Periodos,IXP_Shift,IXP_Desvios);

  Comentario_Robo = "\n Valor Xeno: " + DoubleToString(ixp.Valor());
  delete(ixp);

}

void Xeno::Avalia()
{
  int mudanca = 0;
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  if(Condicoes.Horario())
  {

    IXP *ixp = new IXP(IXP_Periodos,IXP_Shift,IXP_Desvios);
    Valor_Xeno_atual = ixp.Valor(1);
    delete(ixp);


    Opera_Mercado *opera = new Opera_Mercado;
    if(O_Stops.Tipo_Posicao() == 0 && Valor_Xeno_atual < IXP_Limite_Op)   opera.AbrePosicao(1,"Xeno: " + DoubleToString(Valor_Xeno_atual));
    delete(opera);

  //  Print("Xeno: " + DoubleToString(Valor_Xeno_atual)); //DEBUG
  }

  delete(Condicoes);
}

void Xeno::Timer()
{

// if(O_Stops.Tipo_Posicao() == 0)
// {
//   CTrade *tradionices = new CTrade;
//
//   ulong Ticket_Order = tradionices.RequestOrder();
//
//   tradionices.OrderDelete(Ticket_Order);
//
//   delete(tradionices);
//
//
// }

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

}
