﻿/* -*- C++ -*- */
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

#include <Xeno\xeno_inputs.mqh>
#include <Xeno\xeno_funcoes.mqh>

#include <Indicadores\BB.mqh>

#include <Indicadores\IXP.mqh>
#include <Stops_OO.mqh>
#include <MontarRequisicao.mqh>
//#include <Bucareste\InitBucareste.mqh>
#include <VerificaInit.mqh>

int OnInit()
{
  Init_Padrao();

IXP *ixp = new IXP(IXP_Periodos,IXP_Shift,IXP_Desvios);

Print("Inicial: " + DoubleToString(ixp.Valor()));
delete(ixp);


Print("Distribuidor_Parcial(0): " + DoubleToString(O_Stops.Distribuidor_Parcial(0)));
Print("Distribuidor_Parcial(1): " + DoubleToString(O_Stops.Distribuidor_Parcial(1)));
Print("Distribuidor_Parcial(2): " + DoubleToString(O_Stops.Distribuidor_Parcial(2)));
Print("Distribuidor_Parcial(3): " + DoubleToString(O_Stops.Distribuidor_Parcial(3)));


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
  
  Xeno *xeno = new Xeno;
  xeno.Timer();
  delete(xeno);
  
  
}

void OnTick()
{
   Xeno *xeno = new Xeno;
  xeno.Xeno_Comentario();
  delete(xeno);
  
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

/* DEBUG
IXP *ixp = new IXP(IXP_Periodos,IXP_Shift,IXP_Desvios);
Print("onNewBar: " + DoubleToString(ixp.Valor(1)));
delete(ixp);
*/

Xeno *xeno = new Xeno;
xeno.Avalia();
delete(xeno);


}
