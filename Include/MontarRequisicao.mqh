/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             MontarRequisicao.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"


//////////////////////////// Req de Operaçao

class Opera_Mercado
{
  public:
  void AbrePosicao(ENUM_ORDER_TYPE order_type, string comentario_req);
  void AbrePosicao(int order_type, string comentario_req);
  void FechaPosicao();
  void ZeraOrdensP();

  private:
  void Posicao_Mercado(ENUM_ORDER_TYPE order_type, string comentario_req);
};

void Opera_Mercado::AbrePosicao(ENUM_ORDER_TYPE order_type, string comentario_req)
   {
     Posicao_Mercado(order_type,comentario_req);
   }

void Opera_Mercado::AbrePosicao(int order_type, string comentario_req)
   {
     if(order_type == 1) Posicao_Mercado(ORDER_TYPE_BUY, comentario_req);
     if(order_type == -1) Posicao_Mercado(ORDER_TYPE_SELL, comentario_req);
   }

   void Opera_Mercado::ZeraOrdensP()
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

   /////////////////////////////////////////// Final da req.
void Opera_Mercado::Posicao_Mercado(ENUM_ORDER_TYPE order_type, string comentario_req)
   {

     ZeraOrdensP();
     CTrade *requisicao_montar = new CTrade;
     if(Condicoes_Basicas.Condicao())
     {
     requisicao_montar.PositionOpen(Symbol(),order_type,Lotes,0,0,0,comentario_req);

     if(Tipo_Limite == 55) O_Stops.Setar_Ordens_Vars_Static();
     if(Tipo_Limite == 471) O_Stops.Setar_Ordens_Vars_Proporcional();

     }
     delete(requisicao_montar);

   }
   /////////////////////////////////////////// Final da req.

   /////////////////////////////////////////// Fechar Posicao.
void Opera_Mercado::FechaPosicao()
   {
     CTrade *requisicao_montar = new CTrade;
     requisicao_montar.PositionClose(Symbol());

     delete(requisicao_montar);
   }
   /////////////////////////////////////////// Fechar Posicao
