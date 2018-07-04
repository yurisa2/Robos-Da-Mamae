/* -*- C++ -*- */
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

// Aqui da o lucro da posicao
// Armazena os Stops (tanto em qual que tá quanto )
// TicketDaposicao
// ordens abertas nessa posicao, abertas por esse magic


class InTradeControl
{
  public:
  void StopLoss_cash();
  void TakeProfit_cash();

  private:

};

void InTradeControl::StopLoss_cash()
{
  posicao *posicao_o = new posicao();
  Opera_Mercado *opera = new Opera_Mercado;
  double lucro_Atual = posicao_o.LucroAtual();

  if(NormalizeDouble(lucro_Atual,2) <= NormalizeDouble((StopLoss_cash_posicao * -1),2) && NormalizeDouble(lucro_Atual,2) != 0)
  {
    // Print("ITC LucroAtual SL" + DoubleToString(lucro_Atual,2));
    // Print("StopLoss_cash_posicao * -1:  " + DoubleToString(StopLoss_cash_posicao * -1),2);


    opera.FechaPosicao();
  }
  delete posicao_o;
  delete opera;
}

void InTradeControl::TakeProfit_cash()
{
  posicao *posicao_o = new posicao();
  Opera_Mercado *opera = new Opera_Mercado;
  double lucro_Atual = posicao_o.LucroAtual();

  if(NormalizeDouble(lucro_Atual,2) >= NormalizeDouble(TakeProfit_cash_posicao,2) && NormalizeDouble(lucro_Atual,2) != 0)
  {
    opera.FechaPosicao();

    // Print("ITC LucroAtual TP" + DoubleToString(lucro_Atual,2));
    // Print("TakeProfit_cash_posicao: " + DoubleToString(TakeProfit_cash_posicao,2));

  }

  delete posicao_o;
  delete opera;
}
