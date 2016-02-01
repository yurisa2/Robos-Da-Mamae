//+------------------------------------------------------------------+
//|                                                 Proporcional.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"

int Handle_Prop_Media_Alta = iMA(_Symbol,TimeFrame,Prop_Periodos,0,MODE_SMA,PRICE_HIGH);
int Handle_Prop_Media_Baixa = iMA(_Symbol,TimeFrame,Prop_Periodos,0,MODE_SMA,PRICE_LOW);


double Prop_Delta ()
{

    double Prop_Media_Alta[];
    double Prop_Media_Baixa[];
   
    ArraySetAsSeries(Prop_Media_Alta, true);
    ArraySetAsSeries(Prop_Media_Baixa, true);

    int copied_Prop_Media_Alta =   CopyBuffer(Handle_Prop_Media_Alta,0,0,1,Prop_Media_Alta);
    int copied_Prop_Media_Baixa =  CopyBuffer(Handle_Prop_Media_Baixa,0,0,1,Prop_Media_Baixa);

   double Retorno_Prop_Delta = Prop_Media_Alta[0] - Prop_Media_Baixa[0];
   
   Print("Delta do Proporcional: ",Retorno_Prop_Delta);
   return Retorno_Prop_Delta;

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

           if(StopLoss==0)
              {
              StopLossValorCompra = NULL;
              StopLossValorVenda = NULL;
              }
           else
             {
              StopLossValorVenda = PrecoVenda+Prop_Calc_SL;
              StopLossValorCompra = PrecoCompra-Prop_Calc_SL;
              //Print(Descricao_Robo+" "+"SL Compra: ",StopLossValorCompra," SL Venda: ",StopLossValorVenda);
              if(Operacoes>1) DeclaraStops = DeclaraStops +" "+"SL Compra (P): "+DoubleToString(StopLossValorCompra);
              if(Operacoes<1) DeclaraStops = DeclaraStops +" "+"SL Venda (P): "+DoubleToString(StopLossValorVenda);                
             }
           if(TakeProfit==0)
              {
              TakeProfitValorVenda = NULL;
              TakeProfitValorCompra = NULL;
              }
           else
             {
              TakeProfitValorVenda = PrecoVenda-Prop_Calc_TP;
              TakeProfitValorCompra = PrecoCompra+Prop_Calc_TP;
              //Print(Descricao_Robo+" "+"TP Compra: ",TakeProfitValorCompra," TP Venda: ",TakeProfitValorVenda);   
              if(Operacoes>1) DeclaraStops = DeclaraStops +" "+"TP Compra (P): "+DoubleToString(TakeProfitValorCompra);
              if(Operacoes<1) DeclaraStops = DeclaraStops +" "+"TP Venda (P): "+DoubleToString(TakeProfitValorVenda);           
             }             
             Print(DeclaraStops);
}

void CalculaStops ()
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
              StopLossValorVenda = PrecoVenda+StopLoss;
              StopLossValorCompra = PrecoCompra-StopLoss;
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
              TakeProfitValorVenda = PrecoVenda-TakeProfit;
              TakeProfitValorCompra = PrecoCompra+TakeProfit;
              //Print(Descricao_Robo+" "+"TP Compra: ",TakeProfitValorCompra," TP Venda: ",TakeProfitValorVenda);   
              if(Operacoes>1) DeclaraStops = DeclaraStops +" "+"TP Compra: "+DoubleToString(TakeProfitValorCompra);
              if(Operacoes<1) DeclaraStops = DeclaraStops +" "+"TP Venda: "+DoubleToString(TakeProfitValorVenda);           
             }             
             Print(DeclaraStops);

}
//////////////////////////////////////////////////////////////////////////