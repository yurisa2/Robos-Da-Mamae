 /* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Xasmus , Sistema de posicoes."
#property link      "http://www.sa2.com.br"

#include <Math\Alglib\alglib.mqh>
#include <ML.mqh>
#include <dados_nn_raiz.mqh>
#include <Inputs_ML.mqh>


#property version   "2.0" //Usando posicoes

string Nome_Robo = "Xasmus";

#include <Inputs_Vars.mqh>
#include <basico.mqh>
//#include <TradeControl.mqh>

#include <FuncoesGerais.mqh>

#include <Xasmus\funcoes_xasmus.mqh>
#include <Xasmus\xasmus_inputs.mqh>

#include <Stops_OO.mqh>
#include <MontarRequisicao.mqh>
//#include <Xasmus\InitXasmus.mqh>
#include <VerificaInit.mqh>

#include <File_Writer.mqh>

int OnInit()
{


Print(TimeFrame);
  Init_Padrao();

HiLo_OO *hilo = new HiLo_OO(4);
hilo.Mudanca();
delete(hilo);

  Filtro_Fuzzy_Arquivo_Fisico = true;

  Print(" File_Gen OPEN");
  File_Gen *xasmus_file = new File_Gen("."+Symbol()+".csv","CREATE");

  string xasmus_line =
                    "time" + "," +
                    "Symbol()"  + "," +
                    "Price" + "," +
                    "Direction" + "," +
                    "DeltaPrice"  + "," +
                    "rsi_m1_var" + "," +
                    "rsi_m5_var" + "," +
                    "rsi_m10_var" + "," +
                    "rsi_m15_var" + "," +
                    "rsi_m30_var" + "," +
                    "rsi_h1_var" + "," +
                    "rsi_h4_var" + "," +
                    "bbpp_m1_var" + "," +
                    "bbpp_m5_var" + "," +
                    "bbpp_m10_var" + "," +
                    "bbpp_m15_var" + "," +
                    "bbpp_m30_var" + "," +
                    "bbpp_h1_var" + "," +
                    "bbpp_h4_var"
                    ;

  xasmus_file.Linha(xasmus_line);

  delete(xasmus_file);
  Print(xasmus_line);



  if(VerificaInit() == INIT_PARAMETERS_INCORRECT )
  {
    return(INIT_PARAMETERS_INCORRECT);
  }
  else
  {
    return INIT_SUCCEEDED;
  }
  //Fim do Especifico Xasmus

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

  Operacoes_No_tick();


}

void OnNewBar()
{
  Xasmus *xap = new Xasmus;
  xap.Avalia();
  delete(xap);
}
