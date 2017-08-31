/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                                  |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"


//TS e TSP
void TS ()
   {
     double Tick_Spread_Compra = daotick_venda;
     double Tick_Spread_Venda = daotick_compra;

    //  if(FX)
    //  {
    //    Tick_Spread_Compra = daotick_geral - Calcula_Spread();
    //    Tick_Spread_Venda = daotick_geral + Calcula_Spread();
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
         Print(Descricao_Robo+" TrailingStopCompra Ativado, Valor daotick: ",daotick_geral);
         ObjectDelete(0,"TS");
        }

      if(Operacoes<0 && Trailing_stop >0 && Tick_Spread_Venda>= TS_ValorVenda)
        {
         CompraImediata("Compra TrailingStop");
         Print(Descricao_Robo+" TrailingStopVenda Ativado, Valor daotick: ",daotick_geral);
         ObjectDelete(0,"TS");
        }
   }
//////////////////////////////////////////////////////////////////////////
void Prop_TS ()
   {
     double Tick_Spread_Compra = daotick_venda;
     double Tick_Spread_Venda = daotick_compra;


    //  if(FX)
    //  {
    //    Tick_Spread_Compra = daotick_geral - Calcula_Spread();
    //    Tick_Spread_Venda = daotick_geral + Calcula_Spread();
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
         Print(Descricao_Robo+" (P) TrailingStopCompra Ativado, Valor daotick: ",daotick_geral);
         ObjectDelete(0,"TS");
        }

      if(Operacoes < 0 && Prop_Trailing_Stop_Valor > 0 && Tick_Spread_Venda >= TS_ValorVenda)
        {
         CompraImediata("Compra TrailingStop (P)");
         Print(Descricao_Robo + " (P) TrailingStopVenda Ativado, Valor daotick: ",daotick_geral);
         ObjectDelete(0,"TS");
        }
        }


void Prop_SLMovel ()
{
  double Tick_Spread_Compra = daotick_venda;
  double Tick_Spread_Venda = daotick_compra;


  // if(FX)
  // {
  //   Tick_Spread_Compra = daotick_geral - Calcula_Spread();
  //   Tick_Spread_Venda = daotick_geral + Calcula_Spread();
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
  double Tick_Spread_Compra = daotick_venda;
  double Tick_Spread_Venda = daotick_compra;

  // if(FX)
  // {
  //   Tick_Spread_Compra = daotick_geral - Calcula_Spread();
  //   Tick_Spread_Venda = daotick_geral + Calcula_Spread();
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
