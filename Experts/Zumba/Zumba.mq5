/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
string Nome_Robo = "Zumba";
#property copyright "Operador de igor."
#property link      "http://www.sa2.com.br"

#property version   "1.0" //Low Profit Scalping

#include <Inputs_Vars.mqh>

#include <basico.mqh>

#include <FuncoesGerais.mqh>



#include <Stops_OO.mqh>
#include <MontarRequisicao.mqh>
#include <VerificaInit.mqh>

#include <Zumba\Zumba_funcoes.mqh>
#include <Zumba\Zumba_inputs.mqh>




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
  if(Tipo_Comentario == 2)
  {
  Zumba *Zumba_oo = new Zumba;
  Zumba_oo.Comentario();
  delete Zumba_oo;
   }

   
}

void OnTick()
{
if(Zumba_Tempo_real)
{
  Zumba *Zumba_oo = new Zumba;

  Zumba_oo.Avalia();
  Zumba_oo.Comentario();

  delete Zumba_oo;
}
Operacoes_No_tick();


}

double OnTester()
{
  //return Liquidez_Teste_fim - Liquidez_Teste_inicio -  OperacoesFeitasGlobais * custo_operacao * Lotes;

  double resultado;

  Totalizador *totalizator = new Totalizador();
  resultado = totalizator.ganho_liquido();
  
  //Print("Negocios: " + totalizator.negocios);
  //  Print("SaldoLiquido: " + totalizator.ganho_liquido());
  delete(totalizator);

  return resultado;

}

void OnNewBar()
{
if(!Zumba_Tempo_real)
{
  Zumba *Zumba_oo = new Zumba;

  Zumba_oo.Avalia();
  Zumba_oo.Comentario();

  delete Zumba_oo;
}

}
