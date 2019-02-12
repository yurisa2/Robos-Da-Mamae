/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Holodeck V2, Scalpes Curtos."
#property link      "http://www.sa2.com.br"

#include <ML_stub.mqh>
#include <dados_nn_stub.mqh>
#include <Inputs_ML_stub.mqh>

#property version   "2.0" //Usando posicoes
string Nome_Robo = "Holodeck";
#include <Inputs_Vars.mqh>
#include <basico.mqh>

#include <FuncoesGerais.mqh>



#include <Stops_OO.mqh>
#include <MontarRequisicao.mqh>
//#include <Bucareste\InitBucareste.mqh>
#include <VerificaInit.mqh>

#include <Holodeck_V2\holodeck_inputs.mqh>
#include <Holodeck_V2\holodeck_funcoes.mqh>

#include <File_Writer.mqh>

int OnInit()
{
  Init_Padrao();

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

//  Holodeck *holo = new Holodeck;
//  holo.Timer();
//  delete(holo);
}

void OnTick()
{

  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  if(Condicoes.Horario())
  {

 Operacoes_No_tick();

  Holodeck *holo = new Holodeck;
  holo.Avalia();
  delete(holo);


  }
    delete(Condicoes);
}


void OnNewBar()
{


}


void OnTradeOut(CDealInfo &myDealInfo)
{

}
