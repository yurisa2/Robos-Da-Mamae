/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Fuzzificando."
#property link      "http://www.sa2.com.br"

#property version   "1.0" //Low Profit Scalping

#include <basico.mqh>

#include <FuncoesGerais.mqh>

#include <Inputs_Vars.mqh>
#include <Indicadores\Stoch.mqh>
#include <Indicadores\MA.mqh>
#include <Indicadores\RSI_OO.mqh>
#include <Indicadores\MACD.mqh>

#include <Zenilton\Zenilton_Fuzzy.mqh>
#include <Zenilton\Zenilton_Funcoes.mqh>
#include <Zenilton\Zenilton_Inputs.mqh>
#include <Zenilton\Zenilton_Init.mqh>
#include <Zenilton\Zenilton_Comments.mqh>
#include <Zenilton\Zenilton_OO.mqh>

#include <Seccao.mqh>
#include <Stops.mqh>
#include <Graficos.mqh>
#include <MontarRequisicao.mqh>
#include <VerificaInit.mqh>
#include <Operacoes.mqh>



int OnInit()
{
  Init_Padrao();

  Init_Zenilton();

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

  ZerarODia();

  Operacoes_No_Timer();

}

void OnTick()
{
  Zenilton_No_Tick();
  Operacoes_No_tick();
}

double OnTester()
{
  //return Liquidez_Teste_fim - Liquidez_Teste_inicio -  OperacoesFeitasGlobais * custo_operacao * Lotes;

  double resultado;



  resultado = totalizator.ganho_liquido();



  return resultado;
}

void OnNewBar()
{

}
