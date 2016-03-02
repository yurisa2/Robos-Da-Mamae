//+------------------------------------------------------------------+
//|                                            Bucareste, o fodao... |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

#property version   "1.29"

#include <basico.mqh>
#include <OnTrade.mqh>
#include <FuncoesBucaresteIndicador.mqh>
#include <Inputs_Vars.mqh>
#include <HiLo.mqh>
#include <PSAR.mqh>
#include <Ozy.mqh>
#include <BSI.mqh>
#include <Seccao.mqh>
#include <Fractals.mqh>
#include <Stops.mqh>
#include <Graficos.mqh>
#include <MontarRequisicao.mqh>
#include <VerificaInit.mqh>
#include <Operacoes.mqh>

//int Segundos = PeriodSeconds(TimeFrame);

int OnInit()
  {
   ObjectsDeleteAll(0,0,-1);
   EventSetMillisecondTimer(333);

   TimeMagic =MathRand();

   Print("Descri��o: "+Descricao_Robo+" "+IntegerToString(TimeMagic));
   Print("Liquidez da conta: ",conta.Equity());
   
   
   
   Inicializa_Funcs();
   
   return(VerificaInit());

}

void OnTimer()
{
IniciaDia();

if(OperacaoLogoDeCara==true &&  JaZerou==true && TaDentroDoHorario(HorarioInicio,HorarioFim)==true) PrimeiraOperacao();

Comentario(Operacoes);
Escalpelador_Maluco();


   if(ZerarFinalDoDia == true) ZerarODia();
/* ---- Deprecado pois estava dando pau em tudo, isso n�o � vantagem e n�o ser� usado por enquanto
   else
   {
   
   if(Operacoes>1) Print("Finaliza�ao do Dia. Finalizamos o dia COMPRADOS");
   if(Operacoes<1) Print("Finaliza�ao do Dia. Finalizamos o dia VENDIDOS");   

   if(Operacoes>1) Print("Finaliza�ao do Dia. Finalizamos o dia COMPRADOS");
   if(Operacoes<1) Print("Finaliza�ao do Dia. Finalizamos o dia VENDIDOS");   

   }
*/

//ZerarODia();


 }

void OnTick()
{


/////////////////////// Fun�oes de STOP
         if(Usa_Fixos == true) 
         {
         TS();         
         SLMovel();
         }
        
         if(Usa_Prop == true) 
         {
         Prop_TS();
         Prop_SLMovel();
         }
         
         StopLossCompra();
         StopLossVenda();
         TakeProfitCompra();
         TakeProfitVenda();
         
/////////////////////////////////////////////////

DetectaNovaBarra();

   if(IndicadorTempoReal == true && Usa_Hilo == true)      HiLo();
   if(IndicadorTempoReal == true && Usa_PSar == true)      PSar();

}

