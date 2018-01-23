/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Halley, Shooting Star e Martelos!"
#property link      "http://www.sa2.com.br"

#property version   "2.0" //Usando posicoes

#include <basico.mqh>

#include <FuncoesGerais.mqh>

#include <Inputs_Vars.mqh>

#include <Halley\halley_inputs.mqh>
#include <Halley\halley_funcoes.mqh>

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

#include <File_Writer.mqh>

int OnInit()
{
  Init_Padrao();

  Halley *halley = new Halley;
  halley.Direcao(0);
  halley.Formato(0);
  delete(halley);

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

 // ZerarODia();
  
  Operacoes_No_Timer();
  
  Halley *halley = new Halley;
  halley.Timer();
  delete(halley);
  
  
}

void OnTick()
{
  Halley *halley = new Halley;
  if(!Otimizacao) halley.Halley_Comentario();
  
  halley.Avalia();
  delete(halley);
  
   Operacoes_No_tick();
   


   
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

/*
  Halley *halley = new Halley;
  halley.Formato(0);
  delete(halley);
*/

}
