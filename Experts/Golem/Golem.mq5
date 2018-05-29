#property copyright "Golem - Avaliador de DOM (Depth of Market)."
#property link      "http://www.sa2.com.br"

#property version   "1.38" //Trabalhando para o FOREX funcionar

#include <basico.mqh>
#include <OnTrade.mqh>
#include <FuncoesGerais.mqh>

#include <Trade\Trade.mqh>
CTrade opera;


#include <Inputs_Vars.mqh>

#include <Golem\Funcoes_Golem.mqh>
#include <Golem\Inputs_Golem.mqh>
#include <Golem\Init_Golem.mqh>

#include <Seccao.mqh>
#include <Stops.mqh>
#include <Graficos.mqh>
#include <MontarRequisicao.mqh>
#include <VerificaInit.mqh>
#include <Operacoes.mqh>




int OnInit()
{
  Init_Padrao();

  //Especifico Golem  Mezzo Mezzo
  Inicializa_Funcs();

  if(VerificaInit() == INIT_PARAMETERS_INCORRECT ||
  Init_Golem() == INIT_PARAMETERS_INCORRECT)
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

  Comentario();
  
  Operacoes_No_Timer();

  ZerarODia();
}

void OnTick()
{
  Operacoes_No_tick();


}

double OnTester()
{
  return Liquidez_Teste_fim - Liquidez_inicio -  OperacoesFeitasGlobais * custo_operacao * Lotes;
}

void OnNewBar()
{


}

void OnBookEvent(const string &symbol)
  {
//---
   Evento_Book(); 
  }
//+---------