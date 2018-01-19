/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Holodeck V2, Scalpes Curtos."
#property link      "http://www.sa2.com.br"

#property version   "2.0" //Usando posicoes

#include <basico.mqh>

#include <FuncoesGerais.mqh>

#include <Inputs_Vars.mqh>



#include <Indicadores\BB.mqh>

#include <Indicadores\ADX.mqh>
#include <Indicadores\MA.mqh>
#include <Indicadores\RSI_OO.mqh>
#include <Indicadores\HiLo_OO.mqh>
#include <Indicadores\MFI.mqh>
#include <Indicadores\Stoch.mqh>
#include <Indicadores\Volumes.mqh>
#include <Indicadores\MACD.mqh>

#include <Stops_OO.mqh>
#include <MontarRequisicao.mqh>
//#include <Bucareste\InitBucareste.mqh>
#include <VerificaInit.mqh>

#include <Holodeck_V2\holodeck_inputs.mqh>
#include <Holodeck_V2\holodeck_funcoes.mqh>

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
}

void OnTimer()
{
  IniciaDia();

  if(!Otimizacao) Comentario();

  Operacoes_No_Timer();

//  Holodeck *holo = new Holodeck;
//  holo.Timer();
//  delete(holo);
}

void OnTick()
{
  Operacoes_No_tick();

  Holodeck *holo = new Holodeck;
  holo.Avalia();
  delete(holo);
}

double OnTester()
{
  double resultado;

  Totalizador *totalizator = new Totalizador();
  resultado = totalizator.ganho_liquido();
 // resultado = totalizator.negocios;
  delete(totalizator);
  return resultado;
}

void OnNewBar()
{


}
