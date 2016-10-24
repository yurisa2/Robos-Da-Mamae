//+------------------------------------------------------------------+
//|                                             FuncoesBenderDef.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

//////////////////////////////////// Funcoes


bool Saldo_Dia_Permite ()
{
   if(conta.Equity() == liquidez_inicio) return true;
   if(
   (conta.Equity() > liquidez_inicio && lucro_dia >= Saldo_Dia_Valor())
   ||
   (conta.Equity() < liquidez_inicio && (-1 * preju_dia) <= Saldo_Dia_Valor())
   ) return true;

return false;
}

double Saldo_Dia_Valor ()
{

return conta.Equity() - liquidez_inicio -  OperacoesFeitas*custo_operacao;

}

double Saldo_Operacao_Atual ()
{
  double Retorno_Saldo = 0;

  if(Operacoes > 0)
  {
    Retorno_Saldo =   daotick() - PrecoCompra;
   }

   if(Operacoes < 0)
   {
     Retorno_Saldo =   PrecoVenda - daotick();
    }


return Retorno_Saldo;


}
