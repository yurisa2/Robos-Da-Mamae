/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Xolodeck V2, Scalpes Curtos."
#property link      "http://www.sa2.com.br"

#include <Math\Fuzzy\MamdaniFuzzySystem.mqh>



#property version   "2.0" //Usando posicoes
string Nome_Robo = "Xolodeck";
#include <Inputs_Vars.mqh>
#include <basico.mqh>


#include <Filtro_Afis.mqh>

#include <Xolodeck_V2\xolodeck_inputs.mqh>
#include <Xolodeck_V2\xolodeck_funcoes.mqh>

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

  //  Xolodeck *xolo = new Xolodeck;
  //  xolo.Timer();
  //  delete(xolo);
}

void OnTick()
{

  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  if(Condicoes.Horario())
  {

    Operacoes_No_tick();

    Xolodeck *xolo = new Xolodeck;
    xolo.Avalia();
    delete(xolo);
  }
  delete(Condicoes);
}


void OnNewBar()
{


}


void OnTradeOut(CDealInfo &myDealInfo)
{

}
