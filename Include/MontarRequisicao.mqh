/* -*- C++ -*- */
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
     CTrade *requisicao_montar = new CTrade;
     requisicao_montar.PositionOpen(Symbol(),order_type,Lotes,0,0,0,comentario_req);
     O_Stops.Setar_Ordens_Vars_Static();
     delete(requisicao_montar);

   }
   /////////////////////////////////////////// Final da req.
