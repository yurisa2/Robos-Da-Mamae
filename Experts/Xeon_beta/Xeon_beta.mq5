/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                        Copyright 2019, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

// #include <ML_stub.mqh>
// #include <dados_nn_stub.mqh>
// #include <Inputs_ML_stub.mqh>

#include <ANN.mqh>

#property copyright "Xeon_beta - Da Fuzzynator"
#property link      "http://www.sa2.com.br"

#property version   "1.0" //Usando posicoes
string Nome_Robo = "Xeon_beta";
#include <Inputs_Vars.mqh>
#include <basico.mqh>

#include <FuncoesGerais.mqh>

#include <Stops_OO.mqh>

#include <MontarRequisicao.mqh>
//#include <Bucareste\InitBucareste.mqh>
#include <VerificaInit.mqh>

#include <Xeon_beta\xeon_inputs_beta.mqh>
#include <Xeon_beta\xeon_funcoes_beta.mqh>

#include <Math\Fuzzy\MamdaniFuzzySystem.mqh>

#include <File_Writer.mqh>


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
