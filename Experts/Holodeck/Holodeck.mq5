﻿/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                          Holodeck, TUDO É VIRTUAL|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Escalpelando com confiança e consistencia."
#property link      "http://www.sa2.com.br"

#property version   "1.0" //Low Profit Scalping

#include <basico.mqh>
#include <OnTrade.mqh>
#include <FuncoesGerais.mqh>

#include <Inputs_Vars.mqh>

// #include <Bucareste\FuncoesBucareste.mqh>
// #include <Bucareste\inputs_bucareste.mqh>


#include <Holodeck\Inputs_Holodeck.mqh>
#include <Holodeck\Funcoes_Holodeck.mqh>
#include <Holodeck\Init_Holodeck.mqh>

#include <Indicadores\BB.mqh>

#include <Seccao.mqh>
#include <Stops.mqh>
#include <Graficos.mqh>
#include <MontarRequisicao.mqh>
//#include <Bucareste\InitBucareste.mqh>
#include <VerificaInit.mqh>
#include <Operacoes.mqh>



int OnInit()
{
  Init_Padrao();

  Init_Holo();

  if(VerificaInit() == INIT_PARAMETERS_INCORRECT ||  Verifica_Init_Holo()  == INIT_PARAMETERS_INCORRECT )
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
}

void OnTick()
{
  Holo_No_Tick();
  Operacoes_No_tick();
}

double OnTester()
{
  return Liquidez_Teste_fim - Liquidez_Teste_inicio -  OperacoesFeitasGlobais * custo_operacao * Lotes;
}

void OnNewBar()
{
Holo_Acao_Barra();

}
