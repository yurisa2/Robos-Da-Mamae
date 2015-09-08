//+------------------------------------------------------------------+
//|                                            BenderDefinitivo1.mq5 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."

#property link      "http://www.sa2.com.br/"
#property version   "1.15"

#include <FuncoesBucaresteIndicador.mqh>

int Segundos = PeriodSeconds(TimeFrame);


int OnInit()
  {

   HandleGHL = iCustom(NULL,TimeFrame,"gann_hi_lo_activator_ssl",Periodos,MODE_SMA);
   CalculaHiLo();

   TimeMagic =MathRand();
   Print("Descrição: "+Descricao_Robo+" "+IntegerToString(TimeMagic));
   
   ChartIndicatorAdd(0,0,HandleGHL);

   Print("Liquidez da conta: ",conta.Equity());
   
   if(HoraDeInicio==9 && MinutoDeInicio==0) 
   {
   Alert("Comece a partir de 09:01");
   return(INIT_PARAMETERS_INCORRECT);
   }

   
   if(HoraDeInicio>HoraDeFim) 
   {
   return(INIT_PARAMETERS_INCORRECT);
   Alert("Hora de início depois da Hora de Fim");
   }
   if(HoraDeInicio==HoraDeFim && MinutoDeInicio >= MinutoDeFim) 
    {
   Alert("Hora de início depois da Hora de Fim");    
   return(INIT_PARAMETERS_INCORRECT);

   }
   
   if(MinutoDeInicio >59 || MinutoDeFim > 59 || HoraDeInicio >17 || HoraDeFim >17 || HoraDeInicio <9 || HoraDeFim <9 ) 
    {
   Alert("Coloca a Hora Direito, lerdo.");
   return(INIT_PARAMETERS_INCORRECT);

   }
   
   
    if(StopLoss <0 || TakeProfit <0|| Lotes <= 0 || Periodos <=1 ) 
     {
   return(INIT_PARAMETERS_INCORRECT);
   Alert("Erro nos parametros de grana ou técnicos");
   }
   
   
    if(TakeProfit>0 && Trailing_stop>0) 
     {
   Alert("Não faz sentido você ter TakeProfit e Trailing Stop, filosoficamente falando");
   return(INIT_PARAMETERS_INCORRECT);
   }
   
   
   

   return(0);

   
}




void OnTradeTransaction(const MqlTradeTransaction& trans,
                        const MqlTradeRequest& request,
                        const MqlTradeResult& result)
  {
   
   
   Data_Hoje = StringToTime(TimeToString(TimeCurrent(),TIME_DATE)+" "+HorarioInicio+":00");
//   Print("Data Hoje: ",Data_Hoje);
   
   
   HistorySelect(Data_Hoje,TimeCurrent());
   
   
   
//--- create objects

   uint     total=HistoryDealsTotal();
   ulong    ticket=0;
//--- for all deals

for(uint i=0;i<total;i++)
     {
     ticket=HistoryDealGetTicket(i);
     negocio.Ticket(ticket);             
            
            if(negocio.Magic() ==TimeMagic)
             {
   
            num_ordem_tiquete=i;
//            Print(Descricao_Robo+" Debug Ticket: ",ticket);
         
//            Print(Descricao_Robo+" Magic: ",negocio.Magic());
              }
 
 
            
    }
   
      if((ticket=HistoryDealGetTicket(num_ordem_tiquete))>0 && DaResultado == true)
        {
         negocio.Ticket(ticket);
         
         if(negocio.Magic() ==TimeMagic)
           {
               DaResultado = false;
               
               if(negocio.DealType() == DEAL_TYPE_BUY)
                  {
                  Print(Descricao_Robo+" É COMPRA");
//                  PrecoCompra = negocio.Price();
//                  CalculaStops();
                  num_ordem_tiquete=0;
                  }
               
               if(negocio.DealType() == DEAL_TYPE_SELL)
                  {
                  Print(Descricao_Robo+" É VENDA");
//                  PrecoVenda = negocio.Price();
//                  CalculaStops(); 
                  num_ordem_tiquete=0;
                  }
                  
                
                Print(Descricao_Robo);
                Print(Descricao_Robo+" "+"Volume: ",negocio.Volume());
                Print(Descricao_Robo+" "+"Preço: ",negocio.Price());
                Print(Descricao_Robo+" "+"Time: ",negocio.Time());
                Print(Descricao_Robo+" "+"Symbol: ",negocio.Symbol());
                Print(Descricao_Robo+" "+"Type: ",EnumToString(negocio.DealType()));
                Print(Descricao_Robo+" "+"Entry: ",EnumToString(negocio.Entry()));
                Print(Descricao_Robo+" "+"Profit: ",negocio.Profit());
                Print(Descricao_Robo+" "+"Magic: ",negocio.Magic());
                Print(Descricao_Robo+" "+"Comentário: ", negocio.Comment());
                
                
        string  BodyEmail =
        
                 Descricao_Robo + 
                 + "\r\nVolume: " + DoubleToString(NormalizeDouble(negocio.Volume(),2)) + 
                 + "\r\nPreço: " + DoubleToString(NormalizeDouble(negocio.Price(),2)) + 
                 + "\r\nTime: " + TimeToString(negocio.Time(),TIME_MINUTES) + 
                 + "\r\nSimbolo: " + negocio.Symbol() + 
                 + "\r\nTipo: " + EnumToString(negocio.DealType()) + 
                 + "\r\nEntrada: " + EnumToString(negocio.Entry()) + 
                 + "\r\nLucro: " + DoubleToString(NormalizeDouble(negocio.Profit(),2)) + 
                 + "\r\nMagic: " + IntegerToString(negocio.Magic()) + 
                 + "\r\nComentário: " +  negocio.Comment();
                
                
                SendMail("Relatório: "+Descricao_Robo,BodyEmail);
                
                //Acumulado = Acumulado + negocio.Profit();
                //Print("\nAcumulado: ",Acumulado);

           }   
   
     }
//      }  //Bracket do FOR
  
   
  }




void OnTimer()
{

   HiLo();


 }

void OnTick()
{


/////////////////// Iniciar o Dia


        if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && JaZerou==false)
        {
        
        CalculaHiLo();
        
        PrecoCompra =0;
        PrecoVenda =0;
        
        StopLossValorCompra =-9999999999;
        TakeProfitValorCompra = 999999999;
        StopLossValorVenda =99999999999;
        TakeProfitValorVenda = -999999999;
                 
        JaZerou = true;
        JaDeuFinal = false;
        Operacoes = 0;
        TipoOp = 0;
        Ordem = false;
        PrimeiraOp = false;
        DeuTakeProfit = true;
        DeuStopLoss = true;
        
        EventKillTimer();
        EventSetTimer(Segundos);
        

        Print("Bom dia! Bucareste rs ordens, segura o coraçao pq o role é monstro!!!");
        SendMail(Descricao_Robo + "Inicio das operaçoes Bucareste","Bom dia! Bucareste: "+Descricao_Robo+" às ordens, segura o coraçao pq o role é monstro!!!");
        SendNotification("Bom dia! Bucareste: "+Descricao_Robo+" às ordens, segura o coraçao pq o role é monstro!!!");
        

        
        }
        


/////////////////////////////////////////////////////////
/////////////////////// Funçoes de STOP

         StopLossCompra();
         StopLossVenda();
         TakeProfitCompra();
         TakeProfitVenda();
         TS();
         
/////////////////////////////////////////////////

/////////////// Começo do dia - Verifica se opera logo de cara ou nem


if(OperacaoLogoDeCara==true &&  JaZerou==true && TaDentroDoHorario(HorarioInicio,HorarioFim)==true) PrimeiraOperacao();

////////////////// Fim 


if(ZerarFinalDoDia == true) ZerarODia();
   else
   {
   
   if(Operacoes>1) Print("Finalizaçao do Dia. Finalizamos o dia COMPRADOS");
   if(Operacoes<1) Print("Finalizaçao do Dia. Finalizamos o dia VENDIDOS");   

   if(Operacoes>1) Print("Finalizaçao do Dia. Finalizamos o dia COMPRADOS");
   if(Operacoes<1) Print("Finalizaçao do Dia. Finalizamos o dia VENDIDOS");   

   
   }

}
