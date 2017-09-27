/* -*- C++ -*- */
#property copyright "PetroSa, Robs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class Totalizador
{
  private:

  public:
  Totalizador();
  int negocios;
  double custo_total;
  double ganho_total;
  double ganho_calculado;
  double ganho_liquido();
  double custo_ate_momento();
  double lucro_ate_momento();
  void calcula_financeiro();
};

void Totalizador::Totalizador()
{
  negocios = 0;
  calcula_financeiro();
}

double Totalizador::lucro_ate_momento()
{
  HistorySelect(data_inicio_execucao,TimeCurrent());
  int num_negocios = 0;
  long deal_magic = 0;

  uint     total = HistoryDealsTotal();
  ulong    ticket = 0;
  double profit_somado = 0;

  // Alert(HistoryDealsTotal());

  for(uint i = 0;i<total;i++)
      {
       //--- try to get deals ticket
       if((ticket = HistoryDealGetTicket(i))>0) //Colocar aqui pesquisação de MAGIC
         {
          //--- get deals properties
          ulong type  = HistoryDealGetInteger(ticket,DEAL_TYPE);
          deal_magic  = HistoryDealGetInteger(ticket,DEAL_MAGIC);
          double profit = HistoryDealGetDouble(ticket,DEAL_PROFIT);

          // Alert("deal_magic: " + deal_magic);

          CTrade *opera = new CTrade;

          if(deal_magic == opera.RequestMagic())
          {
          profit_somado = profit_somado + profit;
          ganho_total = profit_somado;
          num_negocios++;
          negocios = num_negocios-1;
          }

          delete(opera);
          // Alert("type: " + EnumToString(type)); //DEBUG
          }
        }
        // Alert("profit_somado: " + DoubleToString(profit_somado,_Digits)); //DEBUG

        // Print("deal_magic: " + deal_magic); //DEBUG
  return profit_somado;
}

double Totalizador::custo_ate_momento()
{
  double valor =  negocios * custo_operacao * Lotes;

  custo_total = valor;
  return valor;
}

double Totalizador::ganho_liquido()
{
  ganho_calculado = ganho_total-custo_total;

  return ganho_total-custo_total;
}

void Totalizador::calcula_financeiro()
{
lucro_ate_momento();
custo_ate_momento();
ganho_liquido();

  // Print("custo_ate_momento: " + DoubleToString(custo_ate_momento()));

}

// Totalizador totalizator;
