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
  void SetaSL(double sl);

  private:
  void Posicao_Mercado(ENUM_ORDER_TYPE order_type, string comentario_req);
  string mensagem_op;
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
        Print("Deletando Ordens Pendentes");
      }
    }
  }
}

/////////////////////////////////////////// Final da req.
void Opera_Mercado::Posicao_Mercado(ENUM_ORDER_TYPE order_type, string comentario_req)
{
  Sleep(200);
  if(Aleta_Operacao && !Otimizacao)
  {
    string alerta_op = Nome_Robo;
    alerta_op += ": ";
    alerta_op += EnumToString(order_type);
    alerta_op += " - Volume: ";
    alerta_op += DoubleToString(Lotes);
    alerta_op += " - ";
    alerta_op += comentario_req;

    Alert(alerta_op);
  }

  //Print("Posicao_Mercado"); //DEBUG
  CTrade *requisicao_montar = new CTrade;
  if(Condicoes_Basicas.Condicao())
  {
    do
    ZeraOrdensP();
    while(OrdersTotal() > 0);

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

/////////////////////////////////////////// Fechar Posicao.
void Opera_Mercado::SetaSL(double sl)
{
  if(O_Stops.Tipo_Posicao() != 0)
  {
    CTrade *tradionices = new CTrade;
    tradionices.PositionModify(Symbol(),sl,0);
    delete(tradionices);
  }
}
/////////////////////////////////////////// Fechar Posicao
