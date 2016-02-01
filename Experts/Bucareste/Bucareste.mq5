//+------------------------------------------------------------------+
//|                                            Bucareste, o fodao... |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

#property version   "1.28"

#include <basico.mqh>
#include <OnTrade.mqh>
#include <Inputs_Vars.mqh>
#include <FuncoesBucaresteIndicador.mqh>
#include <HiLo.mqh>
#include <Stops.mqh>
#include <Graficos.mqh>
#include <MontarRequisicao.mqh>
#include <VerificaInit.mqh>
#include <Operacoes.mqh>


//int Segundos = PeriodSeconds(TimeFrame);


int OnInit()
  {
   if(Usa_Hilo == true) CalculaHiLo();
   if(Usa_PSar == true) CalculaPSar();
   Sleep(500);
   
   ObjectsDeleteAll(0,0,-1);
  
   EventSetMillisecondTimer(500);

   if(Usa_Hilo == true) HandleGHL = iCustom(NULL,TimeFrame,"gann_hi_lo_activator_ssl",Periodos,MODE_SMA);
   if(Usa_PSar == true) HandlePSar = iSAR(NULL,TimeFrame,PSAR_Step,PSAR_Max_Step);
//   if(Usa_Fractal == true) HandleFrac = iFractals(NULL,TimeFrame);


   TimeMagic =MathRand();
   Print("Descrição: "+Descricao_Robo+" "+IntegerToString(TimeMagic));
   

   if(Usa_Hilo == true)  ChartIndicatorAdd(0,0,HandleGHL);
   if(Usa_PSar == true)  ChartIndicatorAdd(0,0,HandlePSar);
//   if(Usa_Fractal == true) ChartIndicatorAdd(0,0,HandleFrac);   
   
   Print("Liquidez da conta: ",conta.Equity());
   

   if(Usa_Hilo == true)     Print("HiLo de início: ",Mudanca);
   if(Usa_PSar == true)     Print("PSAR de início: ",CondicaoPsar);
   
   Comment("Carregando...");

   ArrumaMinutos();

   return(VerificaInit());
}



void OnTimer()
{
IniciaDia();

if(Operacoes>1) Comment(Descricao_Robo+" - SL: "+DoubleToString(StopLossValorCompra)+" - TP: "+DoubleToString(TakeProfitValorCompra)+" TS: "+DoubleToString(TS_ValorCompra));
if(Operacoes<1)Comment(Descricao_Robo+" - SL: "+DoubleToString(StopLossValorVenda)+" - TP: "+DoubleToString(TakeProfitValorVenda)+" TS: "+DoubleToString(TS_ValorVenda));
if(Operacoes==0) 
   {
   Comment(Descricao_Robo+" - Nenhuma trade ativa");
   }
Botao_Abortar();
if(OperacaoLogoDeCara==true &&  JaZerou==true && TaDentroDoHorario(HorarioInicio,HorarioFim)==true) PrimeiraOperacao();

if(Operacoes == 0) ObjectsDeleteAll(0,0,-1);
CriaLinhas();
AtualizaLinhas();

////////////////// Fim 

/////////////////////////////////////////////////////////
/////////////////////// Funçoes de STOP
         SLMovel();
         StopLossCompra();
         StopLossVenda();
         TakeProfitCompra();
         TakeProfitVenda();
         TS();
         
/////////////////////////////////////////////////

DetectaNovaBarra();

   if(IndicadorTempoReal == true && Usa_Hilo == true)      HiLo();
   if(IndicadorTempoReal == true && Usa_PSar == true)      PSar();

if(ZerarFinalDoDia == true) ZerarODia();
/* ---- Deprecado pois estava dando pau em tudo, isso não é vantagem e não será usado por enquanto
   else
   {
   
   if(Operacoes>1) Print("Finalizaçao do Dia. Finalizamos o dia COMPRADOS");
   if(Operacoes<1) Print("Finalizaçao do Dia. Finalizamos o dia VENDIDOS");   

   if(Operacoes>1) Print("Finalizaçao do Dia. Finalizamos o dia COMPRADOS");
   if(Operacoes<1) Print("Finalizaçao do Dia. Finalizamos o dia VENDIDOS");   

   
   }
*/

//ZerarODia();


 }

void OnTick()
{


}
