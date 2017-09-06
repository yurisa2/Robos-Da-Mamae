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
#include <Indicadores\RSI.mqh>


#include <Xavier\Xavier_Fuzzy.mqh>
#include <Xavier\Xavier_Funcoes.mqh>
#include <Xavier\Xavier_Inputs.mqh>
#include <Xavier\Xavier_Init.mqh>

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

  Init_Xav();

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
  
  Xav_No_Timer();
}

void OnTick()
{
  Xav_No_Tick();
  Operacoes_No_tick();
}

double OnTester()
{
  //return Liquidez_Teste_fim - Liquidez_Teste_inicio -  OperacoesFeitasGlobais * custo_operacao * Lotes;
  
  double resultado;
  
  Totalizador *totalizator = new Totalizador;
  
  resultado = totalizator.ganho_liquido();
  
  delete(totalizator);
  
  return resultado;
}

void OnNewBar()
{

}
