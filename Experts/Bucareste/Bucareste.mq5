<<<<<<< HEAD
//+------------------------------------------------------------------+
//|                                            BenderDefinitivo1.mq5 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robï¿½s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br/"
#property version   "1.07"

#include <FuncoesBucaresteIndicador.mqh>

int Segundos = PeriodSeconds(TimeFrame);


int OnInit()
  {

   HandleGHL = iCustom(NULL,TimeFrame,"gann_hi_lo_activator_ssl",Periodos,MODE_SMA);
   

   
 //  Print(TimeCurrent());

 //  return(0);
   
   if(HoraDeInicio>HoraDeFim) return(INIT_PARAMETERS_INCORRECT);
   if(HoraDeInicio==HoraDeFim && MinutoDeInicio >= MinutoDeFim) return(INIT_PARAMETERS_INCORRECT);
   if(MinutoDeInicio >59 || MinutoDeFim > 59 || HoraDeInicio >17 || HoraDeFim >17 || HoraDeInicio <9 || HoraDeFim <9 ) return(INIT_PARAMETERS_INCORRECT);
   if(StopLoss <0 || TakeProfit <0|| Lotes <= 0 || Periodos <=1 ) return(INIT_PARAMETERS_INCORRECT);





   
   return(0);

   
}


void OnTimer()
{

HiLo();
CalculaStops();
//Print(TimeCurrent());
//Print("Operaï¿½ï¿½es: ",Operacoes);

//Print("zrou ",JaZerou);


//Print("StopLoss Valor Venda: ",StopLossValorVenda);

 }

void OnTick()
{


/////////////////// Iniciar o Dia


        if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && JaZerou==false)
        {
        
        //Print("Horario configurado ",HorarioInicio);
        
        JaZerou = true;
        JaDeuFinal = false;
        Operacoes = 0;
        TipoOp = 0;
        
        EventKillTimer();
        EventSetTimer(Segundos);
        

        Print("Bom dia! Bucareste ï¿½s ordens, segura o coraï¿½ï¿½o pq o rolï¿½ ï¿½ monstro!!!");
        SendMail("Indicio das operaï¿½ï¿½es Bucareste","Bom dia! Bucareste ï¿½s ordens, segura o coraï¿½ï¿½o pq o rolï¿½ ï¿½ monstro!!!");
        SendNotification("Bom dia! Bucareste ï¿½s ordens, segura o coraï¿½ï¿½o pq o rolï¿½ ï¿½ monstro!!!");
        HiLo();
        

        
        
        }
        


/////////////////////////////////////////////////////////
/////////////////////// Funï¿½ï¿½es de STOP

         StopLossCompra();
         StopLossVenda();
         TakeProfitCompra();
         TakeProfitVenda ();

/////////////////////////////////////////////////

/////////////// Comeï¿½o do dia


if(OperacaoLogoDeCara==true &&  JaZerou==true && TaDentroDoHorario(HorarioInicio,HorarioFim)==true) PrimeiraOperacao();

////////////////// Fim 


if(ZerarFinalDoDia == true) ZerarODia();
   else
   {
   
   if(Operacoes>1) Print("Finalizaï¿½ï¿½o do Dia. Finalizamos o dia COMPRADOS");
   if(Operacoes<1) Print("Finalizaï¿½ï¿½o do Dia. Finalizamos o dia VENDIDOS");   
   
   }

}
=======
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
>>>>>>> Bucareste
