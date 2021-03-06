﻿//+------------------------------------------------------------------+
//|                                              Fermat, o antigo... |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

#property version   "1.00"

#include <basico.mqh>
#include <OnTrade.mqh>
#include <FuncoesGerais.mqh>
#include <Fermat\inputs_fermat.mqh>
#include <Inputs_Vars.mqh>
#include <Fermat\funcoes_fermat.mqh>

#include <Seccao.mqh>
#include <Stops.mqh>
#include <Graficos.mqh>
#include <MontarRequisicao.mqh>
#include <VerificaInit.mqh>
#include <Operacoes.mqh>

int OnInit()
{
  Init_Padrao();

  //Especifico Fermat Mezzo Mezzo
  Inicializa_iMAs();

  if(VerificaInit() == INIT_PARAMETERS_INCORRECT)
  {
    return(INIT_PARAMETERS_INCORRECT);
  }
  else
  {
    return INIT_SUCCEEDED;
  }
  //Fim do Especifico Fermat
}

void OnTimer()
{
  IniciaDia();

  Comentario();

  //Especifico Fermat
  Comentario_Fermat();

  //Fim do Especifico Fermat

  ZerarODia();
}

void OnTick()
{
  Operacoes_No_tick();

  //Especifico Fermat
  Operacoes_No_Timer();

  //Fim do Especifico Fermat
}

double OnTester()
{
  return Liquidez_Teste_fim - Liquidez_Teste_inicio -  OperacoesFeitasGlobais * custo_operacao;
}

void OnNewBar()
{
  //Especifico Fermat

  Operacoes_Fermat();

  //Fim do Especifico Fermat
}
