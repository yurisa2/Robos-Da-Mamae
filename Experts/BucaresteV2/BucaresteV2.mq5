/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Bucareste V2, Sistema de posicoes."
#property link      "http://www.sa2.com.br"

#property version   "2.0" //Usando posicoes

string Nome_Robo = "Bucareste"; 

#include <Inputs_Vars.mqh>
#include <basico.mqh>
//#include <TradeControl.mqh>


#include <FuncoesGerais.mqh>



#include <BucaresteV2\funcoes_bucaresteV2.mqh>
#include <BucaresteV2\bucaresteV2_inputs.mqh>


#include <Stops_OO.mqh>
#include <MontarRequisicao.mqh>
//#include <Bucareste\InitBucareste.mqh>
#include <VerificaInit.mqh>

#include <File_Writer.mqh>


int OnInit()
{

  Init_Padrao();

  

HiLo_OO *hilo = new HiLo_OO(BucaresteV2_HiLo_Periodos);
hilo.Mudanca();
delete(hilo);

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
  //IniciaDia();

  if(!Otimizacao) Comentario();

 // ZerarODia();
  
  Operacoes_No_Timer();
}

void OnTick()
{

  Bucareste *Buca = new Bucareste;
  Buca.Bucareste_Comentario();
  delete(Buca);
  
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
  Bucareste *Buca = new Bucareste;
  Buca.Avalia();
  delete(Buca);
}

void on_trade_robo::on_trade_robo(int es=0, double lucro = 0) //in = 1 |  out = -1
{
  io = es;
  if(io == -1) dados_nn.Saida(lucro);
  if(io == 1) dados_nn.Dados_Entrada();
};

void OnDeinit(const int reason)
       {
         //Print(" numero_linhas " + machine_learning.numero_linhas);
         
         if(rna_on && rna_on_treino) machine_learning.Treino();
         if(rna_on && rna_Salva_Arquivo_hist) machine_learning.ML_Save(rna_nome_arquivo_hist);
       }