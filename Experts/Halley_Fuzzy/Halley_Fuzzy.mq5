/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Halley, Shooting Star e Martelos!"
#property link      "http://www.sa2.com.br"

#property version   "2.0" //Usando posicoes
string Nome_Robo = "Halley_Fuzzy"; 

#include <Inputs_Vars.mqh>
#include <basico.mqh>

#include <FuncoesGerais.mqh>


#include <Halley_Fuzzy\halley_fuzzy_inputs.mqh>
#include <Halley_Fuzzy\halley_fuzzy_funcoes.mqh>


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

  if(!Otimizacao) Comentario();

 // ZerarODia();
  
  Operacoes_No_Timer();

  
}

void OnTick()
{
   Operacoes_No_tick();

}

void OnNewBar()
{


  Halley_Fuzzy *halley = new Halley_Fuzzy;
  halley.Avalia();
  delete(halley);




}
