
/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
string Nome_Robo = "Zefero";
#property copyright "This a whole new fucking world."
#property link      "http://www.sa2.com.br"

#property version   "1.0" //Low Profit Scalping

#include <Inputs_Vars.mqh>

#include <basico.mqh>

#include <FuncoesGerais.mqh>



#include <Stops_OO.mqh>
#include <MontarRequisicao.mqh>
#include <VerificaInit.mqh>

#include <Zefero\zefero_funcoes.mqh>
#include <Zefero\zefero_inputs.mqh>

#include <BucaresteV2\bucaresteV2_inputs.mqh>
#include <BucaresteV2\funcoes_bucaresteV2.mqh>

int OnInit()
{
   int nNeuronEntra = 14;
   int nNeuronCapa1 = 60;
   int nNeuronCapa2 = 60;
   int nNeuronSal = 2;
 // machine_learning.Levanta(rede_network,"zefero14-10-6-2",14,10,6,2);


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
  Zefero *Zefero_oo = new Zefero;
  Zefero_oo.Comentario();
  delete Zefero_oo;
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

  //Print("Negocios: " + totalizator.negocios);
  //  Print("SaldoLiquido: " + totalizator.ganho_liquido());
  delete(totalizator);

  return resultado;

}

void OnNewBar()
{

  Bucareste *Buca = new Bucareste;
  Buca.Avalia();
  delete(Buca);
}




void OnDeinit(const int reason)
  {
          machine_learning.ML_Save("Zefero_Bucareste.hist");
  }