/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Wesley, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Fuzzificando."
#property link      "http://www.sa2.com.br"

#property version   "1.0" //Low Profit Scalping

#include <basico.mqh>

#include <FuncoesGerais.mqh>

#include <Inputs_Vars.mqh>
#include <Indicadores\RSI_OO.mqh>
#include <Indicadores\BB.mqh>
#include <Indicadores\MACD.mqh>
#include <Indicadores\Stoch.mqh>
#include <Indicadores\MFI.mqh>

#include <Wesley\Wesley_Fuzzy.mqh>
#include <Wesley\Wesley_Funcoes.mqh>
#include <Wesley\Wesley_Inputs.mqh>
#include <Wesley\Wesley_Init.mqh>

#include <Stops_OO.mqh>
#include <MontarRequisicao.mqh>
//#include <Bucareste\InitBucareste.mqh>
#include <VerificaInit.mqh>

int OnInit()
{
  Init_Padrao();

   Init_Wesley();

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
  

}

void OnTick()
{
  Operacoes_No_Timer();
   

  Wesley *Wes = new Wesley();
  delete(Wes);
  
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
