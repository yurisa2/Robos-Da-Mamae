﻿/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Fuzzy entre BB e RSI."
#property link      "http://www.sa2.com.br"

#property version   "1.0" //Low Profit Scalping

#include <basico.mqh>

#include <FuncoesGerais.mqh>

#include <Inputs_Vars.mqh>
#include <Indicadores\RSI_OO.mqh>
#include <Indicadores\BB.mqh>

#include <Xavier\Xavier_Fuzzy.mqh>
#include <Xavier\Xavier_Funcoes.mqh>
#include <Xavier\Xavier_Inputs.mqh>
#include <Xavier\Xavier_Init.mqh>

#include <Stops_OO.mqh>
#include <MontarRequisicao.mqh>
//#include <Bucareste\InitBucareste.mqh>
#include <VerificaInit.mqh>

int OnInit()
{
  Init_Padrao();

   Init_Xavier();

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
  IniciaDia();

  Comentario();
  
  Operacoes_No_Timer();

 // ZerarODia();
  
  Operacoes_No_Timer();
  Xavier *Xav = new Xavier;
  Xav.Xavier_Timer();
  Xav.Xavier_Avalia();
  delete(Xav);
}

void OnTick()
{

  Operacoes_No_tick();
}

double OnTester()
{
  //return Liquidez_Teste_fim - Liquidez_Teste_inicio -  OperacoesFeitasGlobais * custo_operacao * Lotes;
  
  double resultado;
  
  Totalizador *totalizator = new Totalizador();
  resultado = totalizator.ganho_liquido();
  delete(totalizator);
  
  return resultado;
}

void OnNewBar()
{

}
