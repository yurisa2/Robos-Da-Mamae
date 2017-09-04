/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             FuncoesBenderDef.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

//////////////////////////////////// Funcoes


bool Saldo_Dia_Permite()
{
   if(conta.Equity() == liquidez_inicio) return true;
   if(
   (conta.Equity() > liquidez_inicio && lucro_dia >= Saldo_Do_Dia_RT)
   ||
   (conta.Equity() < liquidez_inicio && (-1 * preju_dia) <= Saldo_Do_Dia_RT)
   ) return true;

return false;
}

double Saldo_Dia_Valor()
{

return conta.Equity() - liquidez_inicio -  (OperacoesFeitas * custo_operacao * Lotes);

}

double Saldo_Operacao_Atual ()
{
  double Retorno_Saldo = 0;

  if(Operacoes > 0)
  {
    Retorno_Saldo =   daotick_venda - PrecoCompra;
   }

   if(Operacoes < 0)
   {
     Retorno_Saldo =   PrecoVenda - daotick_compra;
    }

return Retorno_Saldo;
}

void Pega_Valor()
{
      Data_Hoje = StringToTime(TimeToString(TimeCurrent(),TIME_DATE)+" "+HorarioInicio+":00");
      HistorySelect(Data_Hoje,TimeCurrent());

      uint     total=HistoryDealsTotal();
      ulong    ticket=0;

      for(uint i = 0; i < total; i++)
      {
        ticket=HistoryDealGetTicket(i);
        negocio.Ticket(ticket);

        if(negocio.Magic() == TimeMagic)
        {
          num_ordem_tiquete=i;
        }
      }

    if((ticket == HistoryDealGetTicket(num_ordem_tiquete)) > 0 && DaResultado == true)
      {
        negocio.Ticket(ticket);

        if(negocio.Magic() == TimeMagic)
        {
          DaResultado = false;
          PrecoNegocio = DoubleToString(negocio.Price());

          if(negocio.DealType() == DEAL_TYPE_BUY)
          {
            num_ordem_tiquete=0;
          }

          if(negocio.DealType() == DEAL_TYPE_SELL)
          {
            num_ordem_tiquete=0;
          }
        }
      }
      //      }  //Bracket do FOR
      // PARA DESLIGAR O SISTEMA DE E_MAILS
}

double Calcula_Spread()
{
  double retorno = SymbolInfoInteger(_Symbol,SYMBOL_SPREAD) * SymbolInfoDouble(_Symbol,SYMBOL_POINT);
 return  retorno;
  // return  0; // DEBUG
}
