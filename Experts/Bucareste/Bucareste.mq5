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
#include <VerificaInit.mqh>
#include <Operacoes.mqh>

//int Segundos = PeriodSeconds(TimeFrame);

int OnInit()
  {
   ObjectsDeleteAll(0,0,-1);
   EventSetMillisecondTimer(500);

   TimeMagic =MathRand();

   Print("Descrição: "+Descricao_Robo+" "+IntegerToString(TimeMagic));
   Print("Liquidez da conta: ",conta.Equity());

    Liquidez_Teste_inicio = conta.Equity();

   Inicializa_Funcs();

   return(VerificaInit());

}

void OnTimer()
{
IniciaDia();

if(OperacaoLogoDeCara==true &&  JaZerou==true && TaDentroDoHorario(HorarioInicio,HorarioFim)==true) PrimeiraOperacao();

Comentario(Operacoes);


/*
   if(ZerarFinalDoDia == true) ZerarODia();
// ---- Deprecado pois estava dando pau em tudo, isso não é vantagem e não será usado por enquanto
   else
   {

   if(Operacoes>1 && Msg_Fim == false)
   {
   Print("Finalizaçao do Dia. Finalizamos o dia COMPRADOS");
   Msg_Fim = true;
   }
   if(Operacoes<1 && Msg_Fim == false)
   {
   Print("Finalizaçao do Dia. Finalizamos o dia VENDIDOS");
   Msg_Fim = true;
   }


   }
//*/

ZerarODia();


 }

void OnTick()
{
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

   Escalpelador_Maluco();

if(interrompe_durante) Stop_Global_Imediato();  // NAO FUNCIONAL, VERIFICAR!

}


double OnTester()
{

return Liquidez_Teste_fim - Liquidez_Teste_inicio -  OperacoesFeitasGlobais*custo_operacao;

}
