/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             FuncoesBenderDef.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

//////////////////////////////////// Funcoes

double Saldo_Dia_Valor()
{

return conta.Equity() - liquidez_inicio -  (OperacoesFeitas * custo_operacao * Lotes);

}

double Calcula_Spread()
{
  double retorno = SymbolInfoInteger(_Symbol,SYMBOL_SPREAD) * SymbolInfoDouble(_Symbol,SYMBOL_POINT);
 return  retorno;
  // return  0; // DEBUG
}
