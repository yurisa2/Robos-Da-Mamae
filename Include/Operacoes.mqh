//+------------------------------------------------------------------+
//|                                                    Operacoes.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

///////////////// COMPRA

void CompraIndicador (string Desc)
      {
      Print(Descricao_Robo+" "+Desc);
      if(Operacoes<0 && SaiPeloIndicador==true)
         {
         MontarRequisicao(ORDER_TYPE_BUY,Desc);
         }
      if(Operacoes==0 && OperacoesFeitas < (Limite_Operacoes*2) && conta.Equity() < liquidez_inicio + lucro_dia &&  (  (Usa_Prop == true && Prop_Delta() > Prop_Limite_Minimo) || Usa_Fixos == true ) )
         {
         MontarRequisicao(ORDER_TYPE_BUY,Desc);
         }
      }

//////////////////////////

///////////// Venda
void VendaIndicador (string Desc)
      {
      Print(Descricao_Robo+" "+Desc);
      if(Operacoes>0 && SaiPeloIndicador==true) 
         {
         MontarRequisicao(ORDER_TYPE_SELL,Desc);
         }
      if(Operacoes==0 && OperacoesFeitas < (Limite_Operacoes*2) && conta.Equity() < liquidez_inicio + lucro_dia &&  (  (Usa_Prop == true && Prop_Delta() > Prop_Limite_Minimo) || Usa_Fixos == true ) )
         {
         MontarRequisicao(ORDER_TYPE_SELL,Desc);
         }
      }



////////////////////////// StopLoss   - Teste Bazaar

void StopLossCompra ()
{
 if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && DeuStopLoss == false && Operacoes >0 && ((Usa_Fixos == true && StopLoss != 0) || (Usa_Prop == true && Prop_StopLoss !=0)))
   {
      if(daotick()<=StopLossValorCompra)
        {
            Print(Descricao_Robo+" Deu StopLoss COMPRADO | Venda: ",daotick()," Valor do StopLoss: ",StopLossValorCompra);
            Print(Descricao_Robo+" VENDA! ",Operacoes);
   
            VendaStop("Venda SL: "+DoubleToString(daotick(),2));
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

         CompraStop("Compra SL: "+DoubleToString(daotick(),2));
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
         VendaStop("Venda TP: "+DoubleToString(daotick(),2));
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
         CompraStop("Compra TP "+DoubleToString(daotick(),2));
         DeuTakeProfit = true;
        }
   }
}
//////////////////////////////////////////////
///////////// Venda Do Stop
void VendaStop (string Desc)
{
Print(Descricao_Robo+" "+Desc);
MontarRequisicao(ORDER_TYPE_SELL,Desc);
}
///////////////////////////////

/////////////////////////// Compra Hilo STOP
void CompraStop (string Desc)
{
Print(Descricao_Robo+" "+Desc);
MontarRequisicao(ORDER_TYPE_BUY,Desc);
}


