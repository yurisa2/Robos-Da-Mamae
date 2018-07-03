/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

#include <ML_stub.mqh>
#include <dados_nn_stub.mqh>
#include <Inputs_ML_stub.mqh>

#property copyright "Just. ME FAZ CHUTAS OS CLIENTES, PORRA!"
#property link      "http://www.sa2.com.br"

#property version   "1.0" //Usando posicoes
string Nome_Robo = "Just";
#include <Inputs_Vars.mqh>
#include <basico.mqh>

#include <FuncoesGerais.mqh>



#include <Stops_OO.mqh>
#include <MontarRequisicao.mqh>
//#include <Bucareste\InitBucareste.mqh>
#include <VerificaInit.mqh>

#include <Just\just_inputs.mqh>
#include <Just\just_funcoes.mqh>

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


}

void OnTick()
{
    Operacoes_No_tick();
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  if(just_tempo_real && Condicoes.Horario())
  {
  Just *just = new Just;
  just.Avalia();
  just.Comentario();
  delete(just);
  }
    delete(Condicoes);
}


void OnNewBar()
{
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;
  if(!just_tempo_real && Condicoes.Horario())
  {

 Operacoes_No_tick();

  Just *just = new Just;
  just.Avalia();
  just.Comentario();
  delete(just);


  }
    delete(Condicoes);
}
