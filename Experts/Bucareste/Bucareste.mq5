//+------------------------------------------------------------------+
//|                                            Bucareste, o fodao... |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

#property version   "1.36"

#include <basico.mqh>
#include <OnTrade.mqh>
#include <FuncoesGerais.mqh>

#include <Bucareste\FuncoesBucareste.mqh>
#include <Bucareste\inputs_bucareste.mqh>

#include <Inputs_Vars.mqh>

#include <Indicadores\HiLo.mqh>
#include <Indicadores\PSAR.mqh>
#include <Indicadores\Ozy.mqh>
#include <Indicadores\BSI.mqh>
#include <Indicadores\Fractals.mqh>

#include <Seccao.mqh>
#include <Stops.mqh>
#include <Graficos.mqh>
#include <MontarRequisicao.mqh>
#include <Bucareste\InitBucareste.mqh>
#include <VerificaInit.mqh>
#include <Operacoes.mqh>

int OnInit()
{
  Init_Padrao();
  Inicializa_Geral();


  //Especifico Bucareste Mezzo Mezzo
  Inicializa_Funcs();

  if(VerificaInit() == INIT_PARAMETERS_INCORRECT ||
  InitBucareste() == INIT_PARAMETERS_INCORRECT)
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

  Comentario(Operacoes);

  //Especifico Bucareste
  if(OperacaoLogoDeCara==true &&  JaZerou==true && TaDentroDoHorario(HorarioInicio,HorarioFim)==true) PrimeiraOperacao();
  //Fim do Especifico Bucareste

  ZerarODia();
}

void OnTick()
{
  Operacoes_No_tick();

  //Especifico Bucareste
  if(IndicadorTempoReal == true && Usa_Hilo == true)      HiLo();
  if(IndicadorTempoReal == true && Usa_PSar == true)      PSar();
  //Fim do Especifico Bucareste
}

double OnTester()
{
  return Liquidez_Teste_fim - Liquidez_Teste_inicio -  OperacoesFeitasGlobais * custo_operacao;
}

void OnNewBar()
{
  //Especifico Bucareste
  if(IndicadorTempoReal == false && Usa_Hilo == true)      HiLo();
  if(IndicadorTempoReal == false && Usa_PSar == true)      PSar();
  if(IndicadorTempoReal == false && Usa_Ozy == true)       Ozy_Opera();
  if(IndicadorTempoReal == false && Usa_Fractal == true)   Fractal();
  if(IndicadorTempoReal == false && Usa_BSI == true)       BSI();
  //Fim do Especifico Bucareste
}
