/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

#property copyright "Operador de igor."
#property link      "http://www.sa2.com.br"

#property version   "1.0" //Low Profit Scalping

#include <basico.mqh>

#include <FuncoesGerais.mqh>

#include <Inputs_Vars.mqh>

#include <Stops_OO.mqh>
#include <MontarRequisicao.mqh>
#include <VerificaInit.mqh>

#include <Xorg\xorg_funcoes.mqh>
#include <Xorg\xorg_inputs.mqh>




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
}

void OnTimer()
{
  IniciaDia();

  Comentario();

  Operacoes_No_Timer();

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
  Xorg *Xorg_oo = new Xorg;

  Xorg_oo.Avalia();
  Xorg_oo.Comentario();

  delete Xorg_oo;


//   Print("Nova Barra Xorg");

}