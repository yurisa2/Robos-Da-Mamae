﻿/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Bucareste V2, Sistema de posicoes."
#property link      "http://www.sa2.com.br"

#include <ML_stub.mqh>
#include <dados_nn_stub.mqh>
#include <Inputs_ML_stub.mqh>

#property version   "2.0" //Usando posicoes

string Nome_Robo = "Bucareste"; 

#include <Inputs_Vars.mqh>
#include <basico.mqh>
//#include <TradeControl.mqh>

#include <FuncoesGerais.mqh>

#include <BucaresteV2\funcoes_bucaresteV2.mqh>
#include <BucaresteV2\bucaresteV2_inputs.mqh>

#include <Stops_OO.mqh>
#include <MontarRequisicao.mqh>
//#include <Bucareste\InitBucareste.mqh>
#include <VerificaInit.mqh>

#include <File_Writer.mqh>

int OnInit()
{
Print(TimeFrame);
  Init_Padrao();

HiLo_OO *hilo = new HiLo_OO(BucaresteV2_HiLo_Periodos);
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
  //Fim do Especifico Bucareste
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
  Bucareste *Buca = new Bucareste;
  Buca.Bucareste_Comentario();
  delete(Buca);
  
  Operacoes_No_tick();


}

void OnNewBar()
{




  Bucareste *Buca = new Bucareste;
  Buca.Avalia();
  delete(Buca);
}