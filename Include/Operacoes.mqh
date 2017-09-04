/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                    Operacoes.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

////////////////////////// StopLoss

void StopLossCompra ()
{
  if(
  TaDentroDoHorario_RT==true &&
  DeuStopLoss == false &&
  Operacoes >0 &&
  ((Usa_Fixos == true && StopLoss != 0) ||
  (Usa_Prop == true && Prop_StopLoss != 0)))
  {
    if(daotick_venda <= StopLossValorCompra)
    {
      Print(Descricao_Robo+" Deu StopLoss COMPRADO | Venda: ",daotick_venda," Valor do StopLoss: ",StopLossValorCompra);
      Print(Descricao_Robo+" VENDA! ",Operacoes);

      VendaImediata("Venda SL: "+DoubleToString(daotick_venda,_Digits));
      DeuStopLoss = true;
    }
  }
}


/////////////////////////////////////////////////

/////////////////// STOP LOSS VENDA

void StopLossVenda ()
{
  if(TaDentroDoHorario_RT==true && DeuStopLoss == false && Operacoes!=0 && Operacoes <0 && ((Usa_Fixos == true && StopLoss != 0) || (Usa_Prop == true && Prop_StopLoss !=0)))
  {
    if(daotick(1)>=StopLossValorVenda)
    {
      Print(Descricao_Robo+" Deu StopLoss VENDIDO | Compra r: ",daotick(1)," Valor do Stop: ",StopLossValorVenda);
      Print(Descricao_Robo+" COMPRA! ",Operacoes);

      CompraImediata("Compra SL: "+DoubleToString(daotick(1),_Digits));
      DeuStopLoss = true;
    }
  }
}
//////////////////////////////////////////////

/////////////////// Take Profit Compra

void TakeProfitCompra ()
{
  if(TaDentroDoHorario_RT==true && DeuTakeProfit == false && Operacoes!=0 && Operacoes >0 && ((Usa_Fixos == true && TakeProfit != 0) || (Usa_Prop == true && Prop_TakeProfit !=0)))
  {
    if(daotick_venda>TakeProfitValorCompra)
    {
      Print(Descricao_Robo+" Deu TakeProfit COMPRADO | VENDA: ",daotick_venda," Valor do TakeProfit: ",TakeProfitValorCompra);
      VendaImediata("Venda TP: "+DoubleToString(daotick_venda,_Digits));
      DeuTakeProfit = true;
    }
  }
}
//////////////////////////////////////////////

/////////////////// Take Profit Venda

void TakeProfitVenda ()
{
  if(TaDentroDoHorario_RT==true  && DeuTakeProfit == false && Operacoes!=0 && Operacoes <0 && ((Usa_Fixos == true && TakeProfit != 0) || (Usa_Prop == true && Prop_TakeProfit !=0)))
  {
    if(daotick(1)<TakeProfitValorVenda)
    {
      Print(Descricao_Robo+" Deu TakeProfit VENDIDO | Compra: ",daotick(1)," Valor do TakeProfit: ",TakeProfitValorVenda);
      CompraImediata("Compra TP "+DoubleToString(daotick(1),_Digits));
      DeuTakeProfit = true;
    }
  }
}
//////////////////////////////////////////////
///////////// Venda Do Stop
void VendaImediata (string Desc,string IO = "Neutro")
{
  if(IO == "Entrada") EM_Contador_Picote = 0;

  if(EM_Picote_Tipo==55) Valor_Escalpe = Tick_Size * Tamanho_Picote;    //Para fazer funcionar o EM   - fixo
  if(EM_Picote_Tipo==471) Valor_Escalpe = Prop_Delta() * Tamanho_Picote;  //Para fazer funcionar o EM - proporcional

  Print(Descricao_Robo+" "+Desc);
  MontarRequisicao(ORDER_TYPE_SELL,Desc);
}
///////////////////////////////

/////////////////////////// Compra Hilo STOP
void CompraImediata (string Desc,string IO = "Neutro")
{
  if(IO == "Entrada") EM_Contador_Picote = 0;

  if(EM_Picote_Tipo==55) Valor_Escalpe = Tick_Size * Tamanho_Picote;    //Para fazer funcionar o EM   - fixo
  if(EM_Picote_Tipo==471) Valor_Escalpe = Prop_Delta() * Tamanho_Picote;  //Para fazer funcionar o EM - proporcional

  Print(Descricao_Robo+" "+Desc);
  MontarRequisicao(ORDER_TYPE_BUY,Desc);
}
