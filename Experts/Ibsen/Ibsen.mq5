﻿/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Ibsen, Caçador de espetos."
#property link      "http://www.sa2.com.br"

#property version   "1.0" //Usando posicoes

#include <basico.mqh>

#include <FuncoesGerais.mqh>

#include <Inputs_Vars.mqh>

#include <Stops_OO.mqh>
#include <MontarRequisicao.mqh>
#include <VerificaInit.mqh>

#include <Ibsen\ibsen_inputs.mqh>
#include <Ibsen\ibsen_funcoes.mqh>

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

  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  if(Condicoes.Horario())
  {

 Operacoes_No_tick();

  Ibsen_o.Avalia();

  Ibsen_o.Comentario();

  }
    delete(Condicoes);
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
