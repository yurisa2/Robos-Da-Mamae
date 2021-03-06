﻿/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Xus, versão de homologação. Aprove e mate duvidas."
#property link      "http://www.sa2.com.br"

#include <ML_stub.mqh>
#include <dados_nn_stub.mqh>
#include <Inputs_ML_stub.mqh>

#property version   "1.0" //Usando posicoes

string Nome_Robo = "Xus";

#include <Inputs_Vars.mqh>
#include <basico.mqh>
//#include <TradeControl.mqh>

#include <FuncoesGerais.mqh>

#include <Xus\xus_funcoes.mqh>
#include <Xus\xus_inputs.mqh>

#include <Stops_OO.mqh>
#include <MontarRequisicao.mqh>
//#include <Bucareste\InitBucareste.mqh>
#include <VerificaInit.mqh>

#include <File_Writer.mqh>

int OnInit()
{
Print(TimeFrame);
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
  //IniciaDia();

  if(!Otimizacao) Comentario();
  
  Xus *xus = new Xus;
  xus.fire_event();
  delete(xus);



 // ZerarODia();

  Operacoes_No_Timer();
}

void OnTick()
{


  Operacoes_No_tick();


}

void OnNewBar()
{

  Xus *xus = new Xus;
  xus.Avalia();
  delete(xus);

}

void OnTradeOut(CDealInfo &myDealInfo)
{
  Xus *xus = new Xus;
  xus.vendetta_mode(myDealInfo);
  delete(xus);
}