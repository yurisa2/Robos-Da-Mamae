/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Xaptur , Sistema de posicoes."
#property link      "http://www.sa2.com.br"

#include <Math\Alglib\alglib.mqh>
#include <ML.mqh>
#include <dados_nn_raiz.mqh>
#include <Inputs_ML.mqh>


#property version   "2.0" //Usando posicoes

string Nome_Robo = "Xaptur";

#include <Inputs_Vars.mqh>
#include <basico.mqh>
//#include <TradeControl.mqh>

#include <FuncoesGerais.mqh>

#include <Xaptur\funcoes_xaptur.mqh>
#include <Xaptur\xaptur_inputs.mqh>

#include <Stops_OO.mqh>
#include <MontarRequisicao.mqh>
//#include <Xaptur\InitXaptur.mqh>
#include <VerificaInit.mqh>

#include <File_Writer.mqh>

int OnInit()
{
Print(TimeFrame);
  Init_Padrao();

HiLo_OO *hilo = new HiLo_OO(4);
hilo.Mudanca();
delete(hilo);

  if(VerificaInit() == INIT_PARAMETERS_INCORRECT )
  {
    return(INIT_PARAMETERS_INCORRECT);
  }
  else
  {
    return INIT_SUCCEEDED;
  }
  //Fim do Especifico Xaptur
}

void OnTimer()
{
  //IniciaDia();

  if(!Otimizacao) Comentario();

 // ZerarODia();

  Operacoes_No_Timer();
}

void OnTick()
{
  Xaptur *xap = new Xaptur;
  delete(xap);

  Operacoes_No_tick();


}

void OnNewBar()
{




  Xaptur *xap = new Xaptur;
  xap.Avalia();
  delete(xap);
}
