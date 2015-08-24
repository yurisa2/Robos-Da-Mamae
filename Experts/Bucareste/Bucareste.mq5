//+------------------------------------------------------------------+
//|                                            BenderDefinitivo1.mq5 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br/"
#property version   "1.08"

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
        

        Print("Bom dia! Bucareste às ordens, segura o coração pq o rolê é monstro!!!");
        SendMail("Indicio das operações Bucareste","Bom dia! Bucareste às ordens, segura o coração pq o rolê é monstro!!!");
        SendNotification("Bom dia! Bucareste às ordens, segura o coração pq o rolê é monstro!!!");
        HiLo();
        

        
        
        }
        


/////////////////////////////////////////////////////////
/////////////////////// Funções de STOP

         StopLossCompra();
         StopLossVenda();
         TakeProfitCompra();
         TakeProfitVenda ();

/////////////////////////////////////////////////

/////////////// Começo do dia


if(OperacaoLogoDeCara==true &&  JaZerou==true && TaDentroDoHorario(HorarioInicio,HorarioFim)==true) PrimeiraOperacao();

////////////////// Fim 


if(ZerarFinalDoDia == true) ZerarODia();
   else
   {
   
   if(Operacoes>1) Print("Finalização do Dia. Finalizamos o dia COMPRADOS");
   if(Operacoes<1) Print("Finalização do Dia. Finalizamos o dia VENDIDOS");   
   
   }

}