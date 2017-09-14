/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Bucareste V2, Sistema de posicoes."
#property link      "http://www.sa2.com.br"

#property version   "2.0" //Usando posicoes

#include <basico.mqh>

#include <FuncoesGerais.mqh>

#include <Inputs_Vars.mqh>

#include <BucaresteV2\funcoes_bucaresteV2.mqh>
#include <BucaresteV2\bucaresteV2_inputs.mqh>

#include <Indicadores\BB.mqh>

#include <Indicadores\MA.mqh>
#include <Indicadores\HiLo_OO.mqh>
#include <Stops_OO.mqh>
#include <MontarRequisicao.mqh>
//#include <Bucareste\InitBucareste.mqh>
#include <VerificaInit.mqh>

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
  IniciaDia();

  Comentario();

 // ZerarODia();
  
  Operacoes_No_Timer();
}

void OnTick()
{
Bucareste_Comentario();
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
