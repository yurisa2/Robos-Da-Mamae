//+------------------------------------------------------------------+
//|                                             FuncoesBenderDef.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

//////////////////////////////////// Funcoes


bool Saldo_Dia ()
{
   if(conta.Equity() == liquidez_inicio) return true;
   if(
   (conta.Equity() > liquidez_inicio && lucro_dia >= conta.Equity() - liquidez_inicio -  OperacoesFeitas*custo_operacao)
   ||
   (conta.Equity() < liquidez_inicio && (-1 * preju_dia) <= conta.Equity() - liquidez_inicio -  OperacoesFeitas*custo_operacao)
   ) return true;

return false;


}
