/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

#include <ML_stub.mqh>
#include <dados_nn_stub.mqh>
#include <Inputs_ML_stub.mqh>

#property copyright "BenderV2, Another Time, Another Place!"
#property link      "http://www.sa2.com.br"

#property version   "1.0" //Usando posicoes
string Nome_Robo = "BenderV2";
#include <Inputs_Vars.mqh>
#include <basico.mqh>

#include <FuncoesGerais.mqh>



#include <Stops_OO.mqh>
#include <MontarRequisicao.mqh>
//#include <Bucareste\InitBucareste.mqh>
#include <VerificaInit.mqh>

#include <BenderV2\bender_inputs.mqh>
#include <BenderV2\bender_funcoes.mqh>

#include <File_Writer.mqh>

int OnInit()
{
  Init_Padrao();

  double min_dia_;
  double max_dia_;

  Bender *bender_o = new Bender;
  bender_o.Max_Min(min_dia_,max_dia_);
  delete bender_o;

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
  if(!Otimizacao) Comentario();

  Operacoes_No_Timer();
}

void OnTick()
{
  Operacoes_No_tick();
}

void OnNewBar()
{

  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  if(O_Stops.Tipo_Posicao() == 0 && Condicoes.Horario())
  {
    double min_di;
    double max_di;

    Bender *bender_o = new Bender;
    bender_o.Max_Min(min_di,max_di);
    // Print(bender_o.Micro_tendencia());
    // Print("Min "+min_di+" Max "+max_di);
    bender_o.Avalia();
    delete bender_o;
  }
  delete Condicoes;
  Operacoes_No_tick();
}
