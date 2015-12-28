//+------------------------------------------------------------------+
//|                                            BenderDefinitivo1.mq5 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."

#property link      "http://www.sa2.com.br/"
#property version   "1.25"

#include <FuncoesBucaresteIndicador.mqh>

//int Segundos = PeriodSeconds(TimeFrame);


int OnInit()
  {
   CalculaHiLo();
   CalculaPSar();
   Sleep(500);
   
   ObjectsDeleteAll(0,0,-1);
  
   EventSetMillisecondTimer(500);

   HandleGHL = iCustom(NULL,TimeFrame,"gann_hi_lo_activator_ssl",Periodos,MODE_SMA);
   HandlePSar = iSAR(NULL,TimeFrame,PSAR_Step,PSAR_Max_Step);


   TimeMagic =MathRand();
   Print("Descrição: "+Descricao_Robo+" "+IntegerToString(TimeMagic));
   

   if(Usa_Hilo == true)  ChartIndicatorAdd(0,0,HandleGHL);
   if(Usa_PSar == true)  ChartIndicatorAdd(0,0,HandlePSar);   
   
   Print("Liquidez da conta: ",conta.Equity());
   
   if(HoraDeInicio==9 && MinutoDeInicio==0) 
   {
   MessageBox("Comece a partir de 09:01","Erro de Inicialização",MB_OK);
   Print("Comece a partir de 09:01","Erro de Inicialização");
   return(INIT_PARAMETERS_INCORRECT);
   }
   
   if(Trailing_stop > TakeProfit && TakeProfit>0)
   {
   MessageBox("Trailing Stop Maior que o TP... Pense nisso.","Erro de Inicialização",MB_OK);
   Print("Trailing Stop Maior que o TP... Pense nisso.","Erro de Inicialização");
   return(INIT_PARAMETERS_INCORRECT);  
   }
   
   if(HoraDeInicio>HoraDeFim) 
   {
   MessageBox("Hora de início depois da Hora de Fim","Erro de Inicialização",MB_OK);
   Print("Hora de início depois da Hora de Fim","Erro de Inicialização");
   return(INIT_PARAMETERS_INCORRECT);
   }
   
   if(Usa_PSar == true && Periodos>0) 
   {
   MessageBox("Psar Nao Usa Periodos","Erro de Inicialização",MB_OK);
   Print("Psar Nao Usa Periodos","Erro de Inicialização");
   return(INIT_PARAMETERS_INCORRECT);
   }
   
   if(Usa_Hilo == true && (PSAR_Max_Step > 0 || PSAR_Step >0))
   {
   MessageBox("HiLo Nao Usar Steps","Erro de Inicialização",MB_OK);
   Print("HiLo Nao Usar Steps","Erro de Inicialização");
   return(INIT_PARAMETERS_INCORRECT);
   }


   if(HoraDeInicio==HoraDeFim && MinutoDeInicio >= MinutoDeFim) 
    {
   MessageBox("Hora de início depois da Hora de Fim","Erro de Inicialização",MB_OK); 
   Print("Hora de início depois da Hora de Fim","Erro de Inicialização");
   return(INIT_PARAMETERS_INCORRECT);

   }
   
   if(SaiPeloIndicador==true && IndicadorTempoReal == true) 
    {
   MessageBox("Se o Indicador está em tempo real, não dá pra sair pelo mesmo, chuva de ordens","Erro de Inicialização",MB_OK);
   Print("Se o Indicador está em tempo real, não dá pra sair pelo mesmo, chuva de ordens","Erro de Inicialização");
   return(INIT_PARAMETERS_INCORRECT);
   }
   
   if(HoraDeInicio == HoraDeFim && (MinutoDeFim-MinutoDeInicio<10))
    {
   MessageBox("Nem vou operar menos que 10 minutos, falou","Erro de Inicialização",MB_OK);
   Print("Nem vou operar menos que 10 minutos, falou","Erro de Inicialização");
   return(INIT_PARAMETERS_INCORRECT);
   }
   if(Usa_PSar == false && Usa_Hilo == false)
    {
   MessageBox("Um dos indicadores c te que usar né amigão...","Erro de Inicialização",MB_OK);
   Print("Um dos indicadores c te que usar né amigão...","Erro de Inicialização");
   return(INIT_PARAMETERS_INCORRECT);
   }
    if(StopLoss <0 || TakeProfit <0|| Lotes <= 0 || (Usa_Hilo == true && Periodos <=1) ) 
     {
   MessageBox("Erro nos parametros de grana ou técnicos","Erro de Inicialização",MB_OK); 
   Print("Erro nos parametros de grana ou técnicos","Erro de Inicialização");
   return(INIT_PARAMETERS_INCORRECT);
   }
   
    if(Usa_Hilo == true && Usa_PSar == true) 
     {

   MessageBox("Ainda não fazemos 2 indicadores juntos","Erro de Inicialização",MB_OK);     
   Print("Ainda não fazemos 2 indicadores juntos","Erro de Inicialização");
      return(INIT_PARAMETERS_INCORRECT);
   }

   if(Usa_Hilo == true)     Print("HiLo de início: ",Mudanca);
   if(Usa_PSar == true)     Print("PSAR de início: ",CondicaoPsar);
   
   Comment("Carregando...");

   ArrumaMinutos();

   return(0);
}

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

void OnChartEvent(const int id, 
                  const long &lparam, 
                  const double &dparam, 
                  const string &sparam) 
  { 
//--- Verifique o evento pressionando um botão do mouse 
   if(id==CHARTEVENT_OBJECT_CLICK) 
     { 
      string clickedChartObject=sparam; 
      //--- Se você clicar sobre o objeto com o nome buttonID 
      if(clickedChartObject=="BTN_ABORTAR") 
        { 
         if(Operacoes>0)  VendaStop(" Abortado pelo botão");
         if(Operacoes<0)  CompraStop(" Abortado pelo botão");   
         //--- Estado do botão - pressionado ou não 
         bool selected=ObjectGetInteger(0,"BTN_ABORTAR",OBJPROP_STATE); 
         //--- registrar uma mensagem de depuração 
         //Print("Botão pressionado = ",selected);
         
          
         int customEventID; // Número do evento personalizado para enviar 
         string message;    // Mensagem a ser enviada no caso 
         //--- Se o botão for pressionado 
         if(selected) 
           { 
            message="Botão pressionado"; 
            customEventID=CHARTEVENT_CUSTOM+1; 
           } 
         else // Botão não está pressionado 
           { 
            message="Botão não está pressionado"; 
            customEventID=CHARTEVENT_CUSTOM+999; 
           } 
         //--- Enviar um evento personalizado "nosso" gráfico 
         //EventChartCustom(0,customEventID-CHARTEVENT_CUSTOM,0,0,message); 
         ///--- Envie uma mensagem para todos os gráficos abertos 
         //BroadcastEvent(ChartID(),0,"Transmissão de mensagem"); 
         //--- Depurar mensagem 
         //Print("Enviar um evento com ID = ",customEventID); 
        } 
      ChartRedraw();// Redesenho forçado de todos os objetos de gráfico 
     } 
  

  } 