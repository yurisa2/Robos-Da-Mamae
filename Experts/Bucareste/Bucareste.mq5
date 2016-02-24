//+------------------------------------------------------------------+
//|                                            Bucareste, o fodao... |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

#property version   "1.29"

#include <basico.mqh>
#include <OnTrade.mqh>
#include <Inputs_Vars.mqh>
#include <FuncoesBucaresteIndicador.mqh>
#include <HiLo.mqh>
#include <PSAR.mqh>
#include <Ozy.mqh>
#include <BSI.mqh>
#include <Fractals.mqh>
#include <Stops.mqh>
#include <Graficos.mqh>
#include <MontarRequisicao.mqh>
#include <VerificaInit.mqh>
#include <Operacoes.mqh>

//int Segundos = PeriodSeconds(TimeFrame);

int OnInit()
  {
  expert.Init(_Symbol,TimeFrame,1,TimeMagic);
   ObjectsDeleteAll(0,0,-1);
  
   EventSetTimer(5);

   TimeMagic =MathRand();
   Print("Descrição: "+Descricao_Robo+" "+IntegerToString(TimeMagic));


   Print("Liquidez da conta: ",conta.Equity());
   
   Inicializa_Funcs();
   expert.Init(_Symbol,TimeFrame,true,TimeMagic);
   return(VerificaInit());
   

}

void OnTimer()
{
IniciaDia();


   
//Botao_Abortar(); Acho que é cagada
if(OperacaoLogoDeCara==true &&  JaZerou==true && TaDentroDoHorario(HorarioInicio,HorarioFim)==true) PrimeiraOperacao();




////////////////// Fim 

/////////////////////////////////////////////////////////
/////////////////////// Funçoes de STOP
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
Comentario(Operacoes);
expert.EveryTick(true);


}

