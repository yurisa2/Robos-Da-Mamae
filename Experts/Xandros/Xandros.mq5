/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Xandros. ME FAZ GANHAR DINHEIRO PORRA"
#property link      "http://www.sa2.com.br"

#property version   "1.0" //Usando posicoes
string Nome_Robo = "Xandros";
#include <Inputs_Vars.mqh>
#include <basico.mqh>

#include <FuncoesGerais.mqh>



#include <Stops_OO.mqh>
#include <MontarRequisicao.mqh>
//#include <Bucareste\InitBucareste.mqh>
#include <VerificaInit.mqh>

#include <Xandros\xandros_inputs.mqh>
#include <Xandros\xandros_funcoes.mqh>

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
  if(!Otimizacao) Comentario();

  Operacoes_No_Timer();


}

void OnTick()
{
    Operacoes_No_tick();
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;



  if(xandros_tempo_real && Condicoes.Horario())
  {



  Xandros *xandros = new Xandros;
  xandros.Avalia();
  xandros.Comentario();
  delete(xandros);


  }
    delete(Condicoes);
}


void OnNewBar()
{
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;
  if(!xandros_tempo_real && Condicoes.Horario())
  {

 Operacoes_No_tick();

  Xandros *xandros = new Xandros;
  xandros.Avalia();
  xandros.Comentario();
  delete(xandros);


  }
    delete(Condicoes);
}
