﻿/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Halley, Shooting Star e Martelos!"
#property link      "http://www.sa2.com.br"

#include <ML_stub.mqh>
#include <dados_nn_stub.mqh>
#include <Inputs_ML_stub.mqh>

#property version   "2.0" //Sharp Razor
string Nome_Robo = "Halley"; 

#include <Inputs_Vars.mqh>
#include <basico.mqh>

#include <FuncoesGerais.mqh>


#include <Halley\halley_inputs.mqh>
#include <Halley\halley_funcoes.mqh>


#include <Stops_OO.mqh>
#include <MontarRequisicao.mqh>
//#include <Bucareste\InitBucareste.mqh>
#include <VerificaInit.mqh>



int OnInit()
{
   Print("Nome: " + Nome_Robo);
  Init_Padrao();


  //halley.Direcao(0);
  //halley.Formato(0);


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
  

}

void OnTick()
{
  if(!Otimizacao) Comentario();
   Operacoes_No_tick();


if(MathMod(Segundos_Fim_Barra_num(),5) == 0)
{
  Halley *halley = new Halley;
  halley.Avalia();
  delete(halley);
 }
   
}

void OnNewBar()
{


/*
  Halley *halley = new Halley;
  halley.Formato(0);
  delete(halley);
*/

}
