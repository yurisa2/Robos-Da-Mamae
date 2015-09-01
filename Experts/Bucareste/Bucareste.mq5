//+------------------------------------------------------------------+
//|                                            BenderDefinitivo1.mq5 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Pe'troSa, Robôs feitos na hora, quentinhos, tragam vasilhas."

#property link      "http://www.sa2.com.br/"
#property version   "1.10"

#include <FuncoesBucaresteIndicador.mqh>

int Segundos = PeriodSeconds(TimeFrame);





int OnInit()
  {

   HandleGHL = iCustom(NULL,TimeFrame,"gann_hi_lo_activator_ssl",Periodos,MODE_SMA);

   TimeMagic =MathRand();
   Print("Descrição: "+Descricao_Robo+" "+IntegerToString(TimeMagic));
   
   ChartIndicatorAdd(0,0,HandleGHL);


   if(HoraDeInicio==9 && MinutoDeInicio==0) 
   {
   return(INIT_PARAMETERS_INCORRECT);
   Alert("Comece a partir de 09:01");
   }

   
   if(HoraDeInicio>HoraDeFim) 
   {
   return(INIT_PARAMETERS_INCORRECT);
   Alert("Hora de início depois da Hora de Fim");
   }
   if(HoraDeInicio==HoraDeFim && MinutoDeInicio >= MinutoDeFim) 
    {
   return(INIT_PARAMETERS_INCORRECT);
   Alert("Hora de início depois da Hora de Fim");
   }
   
   if(MinutoDeInicio >59 || MinutoDeFim > 59 || HoraDeInicio >17 || HoraDeFim >17 || HoraDeInicio <9 || HoraDeFim <9 ) 
    {
   return(INIT_PARAMETERS_INCORRECT);
   Alert("Coloca a Hora Direito, lerdo.");
   }
   
   
    if(StopLoss <0 || TakeProfit <0|| Lotes <= 0 || Periodos <=1 ) 
     {
   return(INIT_PARAMETERS_INCORRECT);
   Alert("Erro nos parametros de grana ou técnicos");
   }

   

   return(0);

   
}




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
         Acumulado = Acumulado + negocio.Profit();
         
         if(negocio.Magic() ==TimeMagic)
           {
               DaResultado = false;
               
               if(negocio.DealType() == DEAL_TYPE_BUY)
                  {
                  Print(Descricao_Robo+" É COMPRA");
                  PrecoCompra = negocio.Price();
                  CalculaStops(); 
                  }
               
               if(negocio.DealType() == DEAL_TYPE_SELL)
                  {
                  Print(Descricao_Robo+" É VENDA");
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
        
        EventKillTimer();
        EventSetTimer(Segundos);
        

        Print("Bom dia! Bucareste rs ordens, segura o coraçao pq o role é monstro!!!");
        SendMail(Descricao_Robo + "Inicio das operaçoes Bucareste","Bom dia! Bucareste: "+Descricao_Robo+" às ordens, segura o coraçao pq o role é monstro!!!");
        SendNotification("Bom dia! Bucareste: "+Descricao_Robo+" às ordens, segura o coraçao pq o role é monstro!!!");
        HiLo();
        

        
        }
        


/////////////////////////////////////////////////////////
/////////////////////// Funçoes de STOP

         StopLossCompra();
         StopLossVenda();
         TakeProfitCompra();
         TakeProfitVenda ();

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
