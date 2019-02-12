/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
string Nome_Robo = "Zwift";
#property copyright "Operador de igor."
#property link      "http://www.sa2.com.br"

#property version   "1.0" //Low Profit Scalping

#include <Inputs_Vars.mqh>

#include <basico.mqh>

#include <FuncoesGerais.mqh>



#include <Stops_OO.mqh>
#include <MontarRequisicao.mqh>
#include <VerificaInit.mqh>

#include <Zwift\zwift_funcoes.mqh>
#include <Zwift\zwift_inputs.mqh>




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
  // IniciaDia();

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

void OnNewBar()
{
  Zwift *Zwift_oo = new Zwift;

  Zwift_oo.Avalia();
  Zwift_oo.Comentario();

  delete Zwift_oo;

  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;
    Opera_Mercado *opera = new Opera_Mercado;

  if(!Condicoes.Horario())
  {
if(O_Stops.Tipo_Posicao() != 0)        opera.FechaPosicao() ;
  }

      delete opera;
  delete(Condicoes);


}
