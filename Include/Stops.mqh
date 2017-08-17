/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                                  |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

void Inicializa_Prop ()
{

   Prop_Limite_Minimo =  Prop_Limite_Minimo_Tick_Size * Tick_Size;
   Print("Tamanho do Tick: ",Tick_Size," Delta Minimo: ",Prop_Limite_Minimo);

// Delta com duas médias
   if(Prop_Metodo == 534)
   {
      Handle_Prop_Media_Alta = iMA(_Symbol,TimeFrame,Prop_Periodos,0,MODE_SMA,PRICE_HIGH);
      Handle_Prop_Media_Baixa = iMA(_Symbol,TimeFrame,Prop_Periodos,0,MODE_SMA,PRICE_LOW);

      ChartIndicatorAdd(0,0,Handle_Prop_Media_Alta);
      ChartIndicatorAdd(0,0,Handle_Prop_Media_Baixa);
   }
   // Delta com BB
   if(Prop_Metodo == 88)
   {
      Handle_Prop_BB = iBands(_Symbol,TimeFrame,Prop_Periodos,0,2,PRICE_CLOSE);
            ChartIndicatorAdd(0,0,Handle_Prop_BB);
   }

   if(Handle_Prop_Media_Alta + Handle_Prop_Media_Baixa + Handle_Prop_BB == 0 )
     {
       ExpertRemove();
     }
}

double Prop_Delta ()
   {
      double retorno_Prop_Delta =0;
      if(Prop_Metodo == 534) retorno_Prop_Delta =  Prop_Delta_Media();
      if(Prop_Metodo == 88) retorno_Prop_Delta =  Prop_Delta_BB();

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


//TS e TSP
void TS ()
   {
     double Tick_Spread_Compra = daotick(-1);
     double Tick_Spread_Venda = daotick(1);

    //  if(FX)
    //  {
    //    Tick_Spread_Compra = daotick() - Calcula_Spread();
    //    Tick_Spread_Venda = daotick() + Calcula_Spread();
    //  }

      if(Operacoes>0 && Trailing_stop >0 && Tick_Spread_Compra > PrecoCompra + (Trailing_stop * Tick_Size) + (Trailing_stop_start * Tick_Size))
        {
        TS_ValorCompra_atual = Tick_Spread_Compra - (Trailing_stop * Tick_Size);
         if(TS_ValorCompra<TS_ValorCompra_atual)
           {
            TS_ValorCompra = TS_ValorCompra_atual;
            AtualizaLinhaTS(TS_ValorCompra);
           }
        }

      if(Operacoes<0 && Trailing_stop >0&& Tick_Spread_Venda < PrecoVenda - (Trailing_stop * Tick_Size) - (Trailing_stop_start * Tick_Size))
        {
        TS_ValorVenda_atual = Tick_Spread_Venda + (Trailing_stop * Tick_Size);
         if(TS_ValorVenda > TS_ValorVenda_atual)
           {
            TS_ValorVenda = TS_ValorVenda_atual;
            AtualizaLinhaTS(TS_ValorVenda);
           }
        }

      if(Operacoes>0 && Trailing_stop > 0 && Tick_Spread_Compra <= TS_ValorCompra)
        {
         VendaImediata("Venda TrailingStop");
         Print(Descricao_Robo+" TrailingStopCompra Ativado, Valor daotick: ",daotick());
         ObjectDelete(0,"TS");
        }

      if(Operacoes<0 && Trailing_stop >0 && Tick_Spread_Venda>= TS_ValorVenda)
        {
         CompraImediata("Compra TrailingStop");
         Print(Descricao_Robo+" TrailingStopVenda Ativado, Valor daotick: ",daotick());
         ObjectDelete(0,"TS");
        }
   }
//////////////////////////////////////////////////////////////////////////
void Prop_TS ()
   {
     double Tick_Spread_Compra = daotick(-1);
     double Tick_Spread_Venda = daotick(1);


    //  if(FX)
    //  {
    //    Tick_Spread_Compra = daotick() - Calcula_Spread();
    //    Tick_Spread_Venda = daotick() + Calcula_Spread();
    //  }

      if(Operacoes > 0 && Prop_Trailing_Stop_Valor > 0 &&Tick_Spread_Compra > PrecoCompra + Prop_Trailing_Stop_Valor + Prop_Trailing_stop_start_Valor)
        {
        TS_ValorCompra_atual = Tick_Spread_Compra - Prop_Trailing_Stop_Valor;
         if(TS_ValorCompra < TS_ValorCompra_atual)
           {
            TS_ValorCompra = TS_ValorCompra_atual;
            AtualizaLinhaTS(TS_ValorCompra);
           }
        }
      if(Operacoes<0 && Prop_Trailing_Stop_Valor  >0 && Tick_Spread_Venda < PrecoVenda - Prop_Trailing_Stop_Valor - Prop_Trailing_stop_start_Valor)
        {
        TS_ValorVenda_atual = Tick_Spread_Venda + Prop_Trailing_Stop_Valor;
         if(TS_ValorVenda > TS_ValorVenda_atual)
           {
            TS_ValorVenda = TS_ValorVenda_atual;
            AtualizaLinhaTS(TS_ValorVenda);
           }
        }

      if(Operacoes>0 && Prop_Trailing_Stop_Valor >0 && Tick_Spread_Compra <= TS_ValorCompra)
        {
         VendaImediata("Venda TrailingStop (P)");
         Print(Descricao_Robo+" (P) TrailingStopCompra Ativado, Valor daotick: ",daotick());
         ObjectDelete(0,"TS");
        }

      if(Operacoes < 0 && Prop_Trailing_Stop_Valor > 0 && Tick_Spread_Venda >= TS_ValorVenda)
        {
         CompraImediata("Compra TrailingStop (P)");
         Print(Descricao_Robo + " (P) TrailingStopVenda Ativado, Valor daotick: ",daotick());
         ObjectDelete(0,"TS");
        }
        }


void Prop_SLMovel ()
{
  double Tick_Spread_Compra = daotick(-1);
  double Tick_Spread_Venda = daotick(1);


  // if(FX)
  // {
  //   Tick_Spread_Compra = daotick() - Calcula_Spread();
  //   Tick_Spread_Venda = daotick() + Calcula_Spread();
  // }

if(Prop_MoverSL !=0 && Tick_Spread_Compra >= PrecoCompra + Prop_MoverSL_Valor &&  Operacoes > 0 && Contador_SLMOVEL==0)
  {
   StopLossValorCompra = PrecoCompra + Prop_PontoDeMudancaSL;
   Contador_SLMOVEL++;
   Print(Descricao_Robo+" | StopLoss Movido com sucesso, SL: "+DoubleToString(StopLossValorCompra));
   ObjectMove(0,"StopLossCompra",0,0,StopLossValorCompra);
  }

if(Prop_MoverSL !=0 && Tick_Spread_Venda <= PrecoVenda - Prop_MoverSL_Valor &&  Operacoes < 0 && Contador_SLMOVEL==0)
  {
   StopLossValorVenda = PrecoVenda - Prop_PontoDeMudancaSL;
   Contador_SLMOVEL++;
Print(Descricao_Robo+" | StopLoss Movido com sucesso, SL: "+DoubleToString(StopLossValorVenda));
ObjectMove(0,"StopLossVenda",0,0,StopLossValorVenda);
  }


}


void SLMovel ()
{
  double Tick_Spread_Compra = daotick(-1);
  double Tick_Spread_Venda = daotick(1);

  // if(FX)
  // {
  //   Tick_Spread_Compra = daotick() - Calcula_Spread();
  //   Tick_Spread_Venda = daotick() + Calcula_Spread();
  // }

MoverSL  = RAW_MoverSL * Tick_Size;

if(MoverSL !=0 && Tick_Spread_Compra >= PrecoCompra + MoverSL &&  Operacoes > 0 && Contador_SLMOVEL==0)
  {
   StopLossValorCompra = PrecoCompra + (PontoDeMudancaSL * Tick_Size);
   Contador_SLMOVEL++;
   Print(Descricao_Robo+" | StopLoss Movido com sucesso, SL: "+DoubleToString(StopLossValorCompra));
   ObjectMove(0,"StopLossCompra",0,0,StopLossValorCompra);
  }

if(MoverSL !=0 && Tick_Spread_Venda <= PrecoVenda - MoverSL &&  Operacoes < 0 && Contador_SLMOVEL==0)
  {
   StopLossValorVenda = PrecoVenda - (PontoDeMudancaSL * Tick_Size);
   Contador_SLMOVEL++;
Print(Descricao_Robo+" | StopLoss Movido com sucesso, SL: "+DoubleToString(StopLossValorVenda));
ObjectMove(0,"StopLossVenda",0,0,StopLossValorVenda);
  }

}

void Stop_Global_Imediato ()
{

/////// FUNCAO PRECISA ADICIONAR PRECISAO, EM TERPOS DE MERCADO LOUCO E LUCRO MINIMO

   if(conta.Equity() > liquidez_inicio
   &&
   lucro_dia > conta.Equity() - liquidez_inicio -  OperacoesFeitas*custo_operacao)
   {
   if(Operacoes > 0) VendaImediata("Encerramento limite Global");
   if(Operacoes < 0) CompraImediata("Encerramento limite Global");
   }

   if(conta.Equity() < liquidez_inicio
   && (-1 * preju_dia) < conta.Equity() - liquidez_inicio -  OperacoesFeitas*custo_operacao)
   {

   if(Operacoes > 0) VendaImediata("Encerramento limite Global");
   if(Operacoes < 0) CompraImediata("Encerramento limite Global");

   }
}
