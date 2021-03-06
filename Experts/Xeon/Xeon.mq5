﻿/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                        Copyright 2019, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

#include <ML_stub.mqh>
#include <dados_nn_stub.mqh>
#include <Inputs_ML_stub.mqh>

#property copyright "Xeon - Da Bridge"
#property link      "http://www.sa2.com.br"

#property version   "1.0" //Usando posicoes
string Nome_Robo = "Xeon";
#include <Inputs_Vars.mqh>
#include <basico.mqh>

#include <FuncoesGerais.mqh>

#include <Stops_OO.mqh>
#include <MontarRequisicao.mqh>
//#include <Bucareste\InitBucareste.mqh>
#include <VerificaInit.mqh>

#include <Xeon\xeon_inputs.mqh>
#include <Xeon\xeon_funcoes.mqh>

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
  
  
  
  Xeon *xeon_o = new Xeon;
  xeon_o.Exchange();
  delete(xeon_o);

  
}

void OnTimer()
{
  if(!Otimizacao) Comentario();

  Operacoes_No_Timer();

  Xeon *xeon_o = new Xeon;
  xeon_o.Comentario();

  delete(xeon_o);


}

void OnTick()
{
    Operacoes_No_tick();

}


void OnNewBar()
{

  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;


  Xeon *xeon_o = new Xeon;
  xeon_o.Avalia();

  delete(xeon_o);


    delete(Condicoes);
}

void OnTradeOut(CDealInfo &myDealInfo)
{

}
