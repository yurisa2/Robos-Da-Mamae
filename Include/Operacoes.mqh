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
      if(Operacoes==0 && OperacoesFeitas < (Limite_Operacoes*2) && conta.Equity() < liquidez_inicio + lucro_dia)
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
      if(Operacoes==0 && OperacoesFeitas < (Limite_Operacoes*2) && conta.Equity() < liquidez_inicio + lucro_dia) 
         {
         MontarRequisicao(ORDER_TYPE_SELL,Desc);
         }
      }




