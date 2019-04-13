/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                        Copyright 2019, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

#property copyright "Xeon_beta - Da Fuzzynator"
#property link      "http://www.sa2.com.br"

#property version   "1.0" //Usando posicoes
string Nome_Robo = "Xeon_beta";
#include <Math\Fuzzy\MamdaniFuzzySystem.mqh>
#include <Inputs_Vars.mqh>
#include <basico.mqh>

#include <Xeon_beta\xeon_inputs_beta.mqh>
#include <Xeon_beta\xeon_funcoes_beta.mqh>

#include <ANN.mqh>
#include <Filtro_Afis.mqh>


int OnInit()
{
  Init_Padrao();

    Xeon_beta *xeon_o = new Xeon_beta;
 // xeon_o.Avalia();
  delete(xeon_o);

  if(VerificaInit() == INIT_PARAMETERS_INCORRECT )
  {
    return(INIT_PARAMETERS_INCORRECT);
  }
  else
  {
    return INIT_SUCCEEDED;
  }

  //Fim do Especifico Bucareste




}

void OnTimer()
{
  if(!Otimizacao) Comentario();

  Operacoes_No_Timer();
}

void OnTick() {
    Operacoes_No_tick();
}


void OnNewBar() {
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;
  delete(Condicoes);

  Xeon_beta *xeon_o = new Xeon_beta;
  xeon_o.Avalia();
  delete(xeon_o);
}

void OnTradeOut(CDealInfo &myDealInfo)
{

}
