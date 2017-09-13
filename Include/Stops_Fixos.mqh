/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                                  |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

double Prop_Delta ()
   {
      double retorno_Prop_Delta =0;
      // if(Prop_Metodo == 534) retorno_Prop_Delta =  Prop_Delta_Media();
      // if(Prop_Metodo == 88) retorno_Prop_Delta =  Prop_Delta_BB();

      return retorno_Prop_Delta;

   }

double Prop_Delta_Media ()
   {
       double Prop_Media_Alta[];
       double Prop_Media_Baixa[];

       ArraySetAsSeries(Prop_Media_Alta, true);
       ArraySetAsSeries(Prop_Media_Baixa, true);

       int copied_Prop_Media_Alta =   CopyBuffer(Handle_Prop_Media_Alta,0,0,1,Prop_Media_Alta);
       int copied_Prop_Media_Baixa =  CopyBuffer(Handle_Prop_Media_Baixa,0,0,1,Prop_Media_Baixa);

      double Retorno_Prop_Delta = Prop_Media_Alta[0] - Prop_Media_Baixa[0];

      //Print("Delta do Proporcional: ",Retorno_Prop_Delta);

      return Retorno_Prop_Delta;
   }

double Prop_Delta_BB ()

{
double retorno_BB = 0;
   double _BB_base[];
   ArraySetAsSeries(_BB_base, true);
   double _BB_up[];
   ArraySetAsSeries(_BB_up, true);
   double _BB_low[];
   ArraySetAsSeries(_BB_low, true);

   int BB_copied_base=CopyBuffer(Handle_Prop_BB,0,0,3,_BB_base);
   int BB_copied_up=CopyBuffer(Handle_Prop_BB,1,0,3,_BB_up);
   int BB_copied_low=CopyBuffer(Handle_Prop_BB,2,0,3,_BB_low);

   double BB_Range = _BB_up[0] - _BB_low[0];
   retorno_BB = BB_Range;

   //Print("BBL: ",_BB_low[0]," | BBU: ",_BB_up[0]," | BBB: ",_BB_base[0]," RBB: ",retorno_BB);
   return(retorno_BB);
}

void Stops_Proporcional ()
{

string DeclaraStops = "";
StopLossValorCompra =-9999999999;
TakeProfitValorCompra = 999999999;
StopLossValorVenda =99999999999;
TakeProfitValorVenda = -999999999;

double   Prop_Calc_SL = Prop_StopLoss * Prop_Delta();
double   Prop_Calc_TP = Prop_TakeProfit * Prop_Delta();

            Prop_MoverSL_Valor = Prop_MoverSL * Prop_Delta();
            Prop_Trailing_Stop_Valor = Prop_Trailing_stop * Prop_Delta();
            Prop_Trailing_stop_start_Valor = Prop_Trailing_stop_start * Prop_Delta();

           if(Prop_StopLoss==0)
              {
              StopLossValorCompra = NULL;
              StopLossValorVenda = NULL;
              }
           else
             {
              StopLossValorVenda = PrecoVenda + Prop_Calc_SL;
              StopLossValorCompra = PrecoCompra - Prop_Calc_SL;
              //Print(Descricao_Robo+" "+"SL Compra: ",StopLossValorCompra," SL Venda: ",StopLossValorVenda);
              if(Operacoes>1) DeclaraStops = DeclaraStops +" "+"SL Compra (P): "+DoubleToString(StopLossValorCompra);
              if(Operacoes<1) DeclaraStops = DeclaraStops +" "+"SL Venda (P): "+DoubleToString(StopLossValorVenda);
             }
           if(Prop_TakeProfit==0)
              {
              TakeProfitValorVenda = NULL;
              TakeProfitValorCompra = NULL;
              }
           else
             {
              TakeProfitValorVenda = PrecoVenda - Prop_Calc_TP;
              TakeProfitValorCompra = PrecoCompra + Prop_Calc_TP;
              //Print(Descricao_Robo+" "+"TP Compra: ",TakeProfitValorCompra," TP Venda: ",TakeProfitValorVenda);
              if(Operacoes>1) DeclaraStops = DeclaraStops +" "+"TP Compra (P): "+DoubleToString(TakeProfitValorCompra);
              if(Operacoes<1) DeclaraStops = DeclaraStops +" "+"TP Venda (P): "+DoubleToString(TakeProfitValorVenda);
             }
             Print(DeclaraStops);
             AtualizaLinhas();
}

void CalculaStops()
{

string DeclaraStops = "";
StopLossValorCompra =-9999999999;
TakeProfitValorCompra = 999999999;
StopLossValorVenda =99999999999;
TakeProfitValorVenda = -999999999;

           if(StopLoss==0)
              {
              StopLossValorCompra = NULL;
              StopLossValorVenda = NULL;
              }
           else
             {
              StopLossValorVenda = PrecoVenda + (StopLoss * Tick_Size);
              StopLossValorCompra = PrecoCompra - (StopLoss * Tick_Size);
              //Print(Descricao_Robo+" "+"SL Compra: ",StopLossValorCompra," SL Venda: ",StopLossValorVenda);
              if(Operacoes>1) DeclaraStops = DeclaraStops +" "+"SL Compra: "+DoubleToString(StopLossValorCompra);
              if(Operacoes<1) DeclaraStops = DeclaraStops +" "+"SL Venda: "+DoubleToString(StopLossValorVenda);
             }
           if(TakeProfit==0)
              {
              TakeProfitValorVenda = NULL;
              TakeProfitValorCompra = NULL;
              }
           else
             {
              TakeProfitValorVenda = PrecoVenda - (TakeProfit * Tick_Size);
              TakeProfitValorCompra = PrecoCompra + (TakeProfit * Tick_Size);
              //Print(Descricao_Robo+" "+"TP Compra: ",TakeProfitValorCompra," TP Venda: ",TakeProfitValorVenda);
              if(Operacoes>1) DeclaraStops = DeclaraStops +" "+"TP Compra: "+DoubleToString(TakeProfitValorCompra);
              if(Operacoes<1) DeclaraStops = DeclaraStops +" "+"TP Venda: "+DoubleToString(TakeProfitValorVenda);
             }
             Print(DeclaraStops);
             AtualizaLinhas();
}


void Stop_Global_Imediato ()
{
  /////// FUNCAO PRECISA ADICIONAR PRECISAO, EM TERPOS DE MERCADO LOUCO E LUCRO MINIMO

  if(conta.Equity() > liquidez_inicio
  &&
  // lucro_dia > (Saldo_Do_Dia_RT - (custo_operacao * Lotes)) )
  lucro_dia <= Saldo_Do_Dia_RT + (custo_operacao * Lotes) ) // O erro Ta Aqui seu burro
  {
    if(Operacoes > 0) VendaImediata("Encerramento limite Global - Lucro");
    if(Operacoes < 0) CompraImediata("Encerramento limite Global- Lucro");
  }

  if(conta.Equity() < liquidez_inicio
  &&
  (-1 * preju_dia) >= Saldo_Do_Dia_RT - (custo_operacao * Lotes) )
  // (-1 * preju_dia) < (Saldo_Do_Dia_RT - (custo_operacao * Lotes)) )
  {
    if(Operacoes > 0) VendaImediata("Encerramento limite Global - Preju");
    if(Operacoes < 0) CompraImediata("Encerramento limite Global- Preju");
  }
}

bool Prop_Permite ()
{
  bool retorno = false;

  if(Usa_Fixos == true) return true;
  else
  if(Usa_Prop == true)
  {
    if(Prop_Delta() > Prop_Limite_Minimo) retorno = true;
  }

  return retorno;

}
