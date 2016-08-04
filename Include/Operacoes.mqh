//+------------------------------------------------------------------+
//|                                                    Operacoes.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

////////////////////////// StopLoss

void StopLossCompra ()
{
  if(
  TaDentroDoHorario(HorarioInicio,HorarioFim)==true &&
  DeuStopLoss == false &&
  Operacoes >0 &&
  ((Usa_Fixos == true && StopLoss != 0) ||
  (Usa_Prop == true && Prop_StopLoss != 0)))
  {
    if(daotick() <= StopLossValorCompra)
    {
      Print(Descricao_Robo+" Deu StopLoss COMPRADO | Venda: ",daotick()," Valor do StopLoss: ",StopLossValorCompra);
      Print(Descricao_Robo+" VENDA! ",Operacoes);

      VendaImediata("Venda SL: "+DoubleToString(daotick(),2));
      DeuStopLoss = true;
    }
  }
}


/////////////////////////////////////////////////

/////////////////// STOP LOSS VENDA

void StopLossVenda ()
{
  if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && DeuStopLoss == false && Operacoes!=0 && Operacoes <0 && ((Usa_Fixos == true && StopLoss != 0) || (Usa_Prop == true && Prop_StopLoss !=0)))
  {
    if(daotick()>=StopLossValorVenda)
    {
      Print(Descricao_Robo+" Deu StopLoss VENDIDO | Compra r: ",daotick()," Valor do Stop: ",StopLossValorVenda);
      Print(Descricao_Robo+" COMPRA! ",Operacoes);

      CompraImediata("Compra SL: "+DoubleToString(daotick(),2));
      DeuStopLoss = true;
    }
  }
}
//////////////////////////////////////////////

/////////////////// Take Profit Compra

void TakeProfitCompra ()
{
  if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && DeuTakeProfit == false && Operacoes!=0 && Operacoes >0 && ((Usa_Fixos == true && TakeProfit != 0) || (Usa_Prop == true && Prop_TakeProfit !=0)))
  {
    if(daotick()>TakeProfitValorCompra)
    {
      Print(Descricao_Robo+" Deu TakeProfit COMPRADO | VENDA: ",daotick()," Valor do TakeProfit: ",TakeProfitValorCompra);
      VendaImediata("Venda TP: "+DoubleToString(daotick(),2));
      DeuTakeProfit = true;
    }
  }
}
//////////////////////////////////////////////

/////////////////// Take Profit Venda

void TakeProfitVenda ()
{
  if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true  && DeuTakeProfit == false && Operacoes!=0 && Operacoes <0 && ((Usa_Fixos == true && TakeProfit != 0) || (Usa_Prop == true && Prop_TakeProfit !=0)))
  {
    if(daotick()<TakeProfitValorVenda)
    {
      Print(Descricao_Robo+" Deu TakeProfit VENDIDO | Compra: ",daotick()," Valor do TakeProfit: ",TakeProfitValorVenda);
      CompraImediata("Compra TP "+DoubleToString(daotick(),2));
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
