//+------------------------------------------------------------------+
//|                                             FuncoesBenderDef.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

//////////////////////////////////// Funcoes

//////////////////////////////// Primeira Operaçao
   
   void PrimeiraOperacao ()
{
       if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && PrimeiraOp==false)
       {
       Print(Descricao_Robo+" Horario Setup: ",HorarioInicio);
       Print(Descricao_Robo+" Mudanca Inicio dia: ",Mudanca);
       
       PrimeiraOp = true;
       
       if(Mudanca>0) CompraStop("Compra OperaLogoDeCara");
       if(Mudanca<0) VendaStop("Venda OperaLogoDeCara");
       }
 }
//////////////// Fim Primeira Operaçao

/////////////////////////////////
void DetectaNovaBarra ()
{
//---
   int period_seconds=PeriodSeconds(TimeFrame);                     // Number of seconds in current chart period
   datetime new_time=TimeCurrent()/period_seconds*period_seconds; // Time of bar opening on current chart
   if(grafico_atual.isNewBar(new_time)) OnNewBar();
}
void OnNewBar()
{
   if(IndicadorTempoReal == false && Usa_Hilo == true)      HiLo();
   if(IndicadorTempoReal == false && Usa_PSar == true)      PSar();
   if(IndicadorTempoReal == false && Usa_Ozy == true)       Ozy_Opera();
   if(IndicadorTempoReal == false && Usa_Fractal == true)   Fractal();
   if(IndicadorTempoReal == false && Usa_BSI == true)       BSI();   
   

}


string Segundos_Fim_Barra ()
{

   int period_seconds=PeriodSeconds(TimeFrame);                     // Number of seconds in current chart period
   datetime new_time=TimeCurrent()/period_seconds*period_seconds; // Time of bar opening on current chart
   //if(grafico_atual.isNewBar(new_time)) Segundos_Contados=0;
   return DoubleToString(60-(TimeCurrent()-new_time),0);

}




void IniciaDia ()
{
        if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && JaZerou==false)
        {
        
   if(Usa_Hilo == true) CalculaHiLo();
   if(Usa_PSar == true) CalculaPSar();
        
        PrecoCompra =0;
        PrecoVenda =0;
        
        OperacoesFeitas =0;
        
        StopLossValorCompra =-9999999999;
        TakeProfitValorCompra = 999999999;
        StopLossValorVenda =99999999999;
        TakeProfitValorVenda = -999999999;
                 
        JaZerou = true;
        JaDeuFinal = false;
        Operacoes = 0;
        Ordem = false;
        PrimeiraOp = false;
        DeuTakeProfit = true;
        DeuStopLoss = true;

        Print("Bom dia! Bucareste as ordens, segura o coraçao pq o role é monstro!!!");
        SendMail(Descricao_Robo + "Inicio das operaçoes Bucareste","Bom dia! Bucareste: "+Descricao_Robo+" às ordens, segura o coraçao pq o role é monstro!!!");
        SendNotification("Bom dia! Bucareste: "+Descricao_Robo+" às ordens, segura o coraçao pq o role é monstro!!!");
        
        if(Usa_Hilo == true) Print("Indicador HiLo inicio do dia: ",Mudanca);
        if(Usa_PSar == true) Print("Indicador PSAR inicio do dia: ",Mudanca);    
        liquidez_inicio = conta.Equity();
        }
Sleep(1000);
}



////////////////// Zerar o dia 
void ZerarODia ()
{
       if(TaDentroDoHorario(HorarioFim,HorarioFimMais1)==true && JaDeuFinal==false)
         {
            Sleep(5000);
            JaDeuFinal = true;
            JaZerou = false;
            PrimeiraOp = false;
            Print(Descricao_Robo+"Final do Dia! Operaçoes: ",Operacoes);
            SendNotification(Descricao_Robo+" encerrando");
          
                   if(Operacoes<0) 
                      {
                      MontarRequisicao(ORDER_TYPE_BUY,"Compra para zerar o dia");  
                      Sleep(1000);
                      }
                   if(Operacoes>0) 
                     {
                     MontarRequisicao(ORDER_TYPE_SELL,"Venda para zerar o dia");
                     Sleep(1000);
                     SendMail(Descricao_Robo+"Bucareste: Venda para zerar o dia","Finalizando o dia com uma venda, e tal...");
                     }
               Print(Descricao_Robo+"Depois da Ultima Operaçao: ",Operacoes);
         }
   Sleep(5000);
  }  


void ArrumaMinutos ()
{
   if(MinutoDeFim == 59) 
   {
   MinutoDeFimMenos1 = 58;
   }
    else 
    {
    MinutoDeFimMenos1 = MinutoDeFim; 
    } //Tentativa de sanar os erros de teste.
    
   HorarioFim = IntegerToString(HoraDeFim,2,'0') + ":" + IntegerToString(MinutoDeFimMenos1,2,'0');
   HorarioFimMais1 = IntegerToString(HoraDeFim,2,'0') + ":" + IntegerToString(MinutoDeFim+1,2,'0');
   Print("Horario inicio: ", HorarioInicio," Horario fim: ",HorarioFim, " Horario de fim mais 1:",HorarioFimMais1 );
}

void Inicializa_Funcs ()
{


   if(Usa_PSar == true) HandlePSar = iSAR(NULL,TimeFrame,PSAR_Step,PSAR_Max_Step);
   if(Usa_Ozy == true) HandleOzy = iCustom(NULL,TimeFrame,"ozymandias_lite",Ozy_length,Ozy_MM,Ozy_Shift);
   if(Usa_Fractal == true) HandleFrac = iFractals(NULL,TimeFrame);
   if(Usa_Prop == true) Inicializa_Prop();
   if(Usa_Hilo == true) Inicializa_HiLo();
   if(Usa_BSI == true)  Inicializa_BSI();

   if(Usa_Hilo == true) CalculaHiLo();
   if(Usa_PSar == true) CalculaPSar();
   if(Usa_BSI == true) CalculaBSI();   
   
   if(Usa_Fractal == true) CalculaFractal();


   if(Usa_PSar == true)  ChartIndicatorAdd(0,0,HandlePSar);
   if(Usa_Ozy == true) ChartIndicatorAdd(0,0,HandleOzy);
   if(Usa_Fractal == true) ChartIndicatorAdd(0,0,HandleFrac);   
   
   Cria_Botao_Operar();
   
   
   ArrumaMinutos();

}

void Comentario (int ops)
{

if(ops > 0) Comment(Descricao_Robo+" COMPRADO - SL: "+DoubleToString(StopLossValorCompra)+" - TP: "+DoubleToString(TakeProfitValorCompra)+" TS: "+DoubleToString(TS_ValorCompra)+" - "+Segundos_Fim_Barra());
if(ops < 0) Comment(Descricao_Robo+" VENDIDO- SL: "+DoubleToString(StopLossValorVenda)+" - TP: "+DoubleToString(TakeProfitValorVenda)+" TS: "+DoubleToString(TS_ValorVenda)+" - "+Segundos_Fim_Barra());
if(ops == 0)   Comment(Descricao_Robo+" - Nenhuma trade ativa | DELTA: "+DoubleToString(Prop_Delta(),0)+" - "+Segundos_Fim_Barra());


//Comment(Segundos_Fim_Barra());
   

}