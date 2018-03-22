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

#include <Zwift\zwift_funcoes.mqh>
#include <Zwift\zwift_inputs.mqh>




int OnInit()
{
   File_Read *file_read = new File_Read("teste2.txt");
   Print("file_read.str_array[0]: " + file_read.linha_str_array[0]);
   Print("file_read.num_linhas: " + file_read.num_linhas);
   delete(file_read);
   
   FiltroF *filtro_teste = new FiltroF;
   Print("Fuzzy(): " + DoubleToString(filtro_teste.Fuzzy()));

   delete(filtro_teste);
  
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
  if(Tipo_Comentario == 2)
  {
  Zwift *Zwift_oo = new Zwift;
  Zwift_oo.Comentario();
  delete Zwift_oo;
   }

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
  Zwift *Zwift_oo = new Zwift;

  Zwift_oo.Avalia();
  Zwift_oo.Comentario();

  delete Zwift_oo;


}
