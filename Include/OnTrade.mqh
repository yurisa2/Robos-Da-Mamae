//+------------------------------------------------------------------+
//|                                                      OnTrade.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

void OnTradeTransaction(const MqlTradeTransaction& trans,
                        const MqlTradeRequest& request,
                        const MqlTradeResult& result)
  {
 /*  
   
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
  
    PARA DESLIGAR O SISTEMA DE E_MAILS */
  }