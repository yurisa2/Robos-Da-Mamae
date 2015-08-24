//+------------------------------------------------------------------+
//|                                            BenderDefinitivo1.mq5 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
<<<<<<< Updated upstream
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
=======
#property copyright "PetroSa, Robï¿½s feitos na hora, quentinhos, tragam vasilhas."
>>>>>>> Stashed changes
#property link      "http://www.sa2.com.br/"
#property version   "1.08"

#include <FuncoesBucaresteIndicador.mqh>

int Segundos = PeriodSeconds(TimeFrame);


<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes
int OnInit()
  {

   HandleGHL = iCustom(NULL,TimeFrame,"gann_hi_lo_activator_ssl",Periodos,MODE_SMA);
<<<<<<< Updated upstream
=======
   TimeMagic =MathRand();
>>>>>>> Stashed changes
   
 //  Print(TimeCurrent());

 //  return(0);
   
   if(HoraDeInicio>HoraDeFim) return(INIT_PARAMETERS_INCORRECT);
   if(HoraDeInicio==HoraDeFim && MinutoDeInicio >= MinutoDeFim) return(INIT_PARAMETERS_INCORRECT);
   if(MinutoDeInicio >59 || MinutoDeFim > 59 || HoraDeInicio >17 || HoraDeFim >17 || HoraDeInicio <9 || HoraDeFim <9 ) return(INIT_PARAMETERS_INCORRECT);
   if(StopLoss <0 || TakeProfit <0|| Lotes <= 0 || Periodos <=1 ) return(INIT_PARAMETERS_INCORRECT);


<<<<<<< Updated upstream
=======



   
>>>>>>> Stashed changes
   return(0);

   
}


<<<<<<< Updated upstream
=======

void OnTradeTransaction(const MqlTradeTransaction& trans,
                        const MqlTradeRequest& request,
                        const MqlTradeResult& result)
  {
   
   
   
   HistorySelect(0,TimeCurrent());
//--- create objects

   uint     total=HistoryDealsTotal();
   ulong    ticket=0;
//--- for all deals
   
      if((ticket=HistoryDealGetTicket(total-1))>0 && DaResultado == true)
        {
         negocio.Ticket(ticket);
         
         
         if(negocio.Magic() ==TimeMagic)
           {
               DaResultado = false;
               
               if(negocio.DealType() == DEAL_TYPE_BUY)
                  {
                  Print("É COMPRA");
                  PrecoCompra = negocio.Price();
                  CalculaStops(); 
                  }
               
               if(negocio.DealType() == DEAL_TYPE_SELL)
                  {
                  Print("É VENDA");
                  PrecoVenda = negocio.Price();
                  CalculaStops(); 
                  }
                  
                  

                
                Print(Descricao_Robo);
                Print("Volume: ",negocio.Volume());
                Print("Preço: ",negocio.Price());
                Print("Time: ",negocio.Time());
                Print("Symbol: ",negocio.Symbol());
                Print("Type: ",EnumToString(negocio.DealType()));
                Print("Entry: ",EnumToString(negocio.Entry()));
                Print("Profit: ",negocio.Profit());
                Print("Magic: ",negocio.Magic());
                Print("Comentário: ", negocio.Comment());
                
                
        string  BodyEmail =
        
                 Descricao_Robo + 
                 + "Volume: " + DoubleToString(negocio.Volume()) + 
                 + "Preço: " + DoubleToString(negocio.Price()) + 
                 + "<BR>Time: " + TimeToString(negocio.Time(),TIME_MINUTES) + 
                 + "<BR>Symbol: " + negocio.Symbol() + 
                 + "<BR>Type: " + EnumToString(negocio.DealType()) + 
                 + "<BR>Entry: " + EnumToString(negocio.Entry()) + 
                 + "<BR>Profit: " + DoubleToString(negocio.Profit()) + 
                 + "<BR>Magic: " + IntegerToString(negocio.Magic()) + 
                 + "<BR>Comentário: " +  negocio.Comment();
                
                
                SendMail("Relatório: "+Descricao_Robo,BodyEmail);
                
                Acumulado = Acumulado + negocio.Profit();
                Print("\nAcumulado: ",Acumulado);
               
                
                
           }   
         

         
         
         
   
     }

  
   
  }



>>>>>>> Stashed changes
void OnTimer()
{

HiLo();
<<<<<<< Updated upstream
CalculaStops();

=======
//CalculaStops();
//Print(TimeCurrent());
//Print("Operaï¿½ï¿½es: ",Operacoes);

//Print("zrou ",JaZerou);


//Print("StopLoss Valor Venda: ",StopLossValorVenda);
>>>>>>> Stashed changes

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
   
<<<<<<< Updated upstream
   if(Operacoes>1) Print("Finalização do Dia. Finalizamos o dia COMPRADOS");
   if(Operacoes<1) Print("Finalização do Dia. Finalizamos o dia VENDIDOS");   
=======
   if(Operacoes>1) Print("Finalizaï¿½ï¿½o do Dia. Finalizamos o dia COMPRADOS");
   if(Operacoes<1) Print("Finalizaï¿½ï¿½o do Dia. Finalizamos o dia VENDIDOS");   
>>>>>>> Stashed changes
   
   }

}