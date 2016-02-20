//+------------------------------------------------------------------+
//|                                             FuncoesBenderDef.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

//////////////////////////////////// Funcoes
/*
void CalculaHiLo ()
{
if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true)
   {
   
   double _ma1[];
   double NMax[];
   double NMin[];
   double ValorHilo[];

   ArraySetAsSeries(_ma1, true);
   ArraySetAsSeries(NMax, true);
   ArraySetAsSeries(NMin, true);   
   ArraySetAsSeries(ValorHilo, true);

   int copied=CopyBuffer(HandleGHL,4,0,100,_ma1);
   int copiadoNmax=CopyBuffer(HandleGHL,2,0,100,NMax);
   int copiadoNmin=CopyBuffer(HandleGHL,3,0,100,NMin);
   int copiadoValorHilo=CopyBuffer(HandleGHL,0,0,100,ValorHilo);

                    if(Mudanca!=_ma1[0]) 
                    {
                    //Print("Mudou Hein");
                    DeuStopLoss = false;
                    DeuTakeProfit = false;                   
                    Ordem = false;
                    }
   Mudanca = _ma1[0];
   Mudou = 0;
   }   //FIM DO IF TaDentroDoHorario
}

void HiLo ()
{

if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true)
   {
   
   double _ma1[];
   double NMax[];
   double NMin[];
   double ValorHilo[];
   
   ArraySetAsSeries(_ma1, true);
   ArraySetAsSeries(NMax, true);
   ArraySetAsSeries(NMin, true);   
   ArraySetAsSeries(ValorHilo, true);

   int copied=CopyBuffer(HandleGHL,4,0,100,_ma1);
   int copiadoNmax=CopyBuffer(HandleGHL,2,0,100,NMax);
   int copiadoNmin=CopyBuffer(HandleGHL,3,0,100,NMin);
   int copiadoValorHilo=CopyBuffer(HandleGHL,0,0,100,ValorHilo);
                    
                    if(Mudanca!=_ma1[0]) 
                    {
                    //Print("Mudou Hein");
                    DeuStopLoss = false;
                    DeuTakeProfit = false;                   
                    Ordem = false;
                      
                      
                    if(Mudanca==1 && Ordem==false)
                    {
                    Print("Operações Antes da venda: ",Operacoes," VENDE! ");
                    //Print("Periodo: ",ChartPeriod()," Estranho", PeriodSeconds());
                    VendaIndicador("Venda por HiLo");
                    Ordem = true;
                    }
                    
                    if(Mudanca==-1 && Ordem==false) 
                    {
                    Print("Operações Antes da compra: ",Operacoes," COMPRA! ");
                    CompraIndicador("Compra por HiLo");
                    Ordem = true;
                    }
                    }

   Mudanca = _ma1[0];
   Mudou = 0;

   }   //FIM DO IF TaDentroDoHorario

}

*/
//////////////////////////////////////////////////////

///////////////////VALORES DO PSAR
void CalculaPSar ()
{

if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true)
   {
   double PSar_Array[];
   ArraySetAsSeries(PSar_Array, true);
   int copiedPSar=CopyBuffer(HandlePSar,0,0,100,PSar_Array);

  //--- Dá uns prints só pra ver //--- Print("Valor do PSAR: ",PSar_Array[0]," Preço: ",daotick());
    if(PSar_Array[0] >daotick())     CondicaoPsar = -1;
    if(PSar_Array[0] <daotick())     CondicaoPsar = 1;

                    if(Mudanca!=CondicaoPsar) 
                    {
                    //Print("Mudou Hein");
                    DeuStopLoss = false;
                    DeuTakeProfit = false;                   
                    Ordem = false;
                      
                    }
                    
//   Print("Operacoes: ",Operacoes);
   Mudanca = CondicaoPsar;
   Mudou = 0;

   }   //FIM DO IF TaDentroDoHorario
}

void PSar ()
{
if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true)
   {
   double PSar_Array[];
   ArraySetAsSeries(PSar_Array, true);
   int copiedPSar=CopyBuffer(HandlePSar,0,0,100,PSar_Array);

  //--- Dá uns prints só pra ver //--- Print("Valor do PSAR: ",PSar_Array[0]," Preço: ",daotick());
    if(PSar_Array[0] >daotick())     CondicaoPsar = -1;
    if(PSar_Array[0] <daotick())     CondicaoPsar = 1;

                    if(Mudanca!=CondicaoPsar) 
                    {
                    //Print("Mudou Hein");
                    DeuStopLoss = false;
                    DeuTakeProfit = false;                   
                    Ordem = false;
                      
                    if(Mudanca==1 && Ordem==false)  
                    {
                    Print("Operações Antes da venda: ",Operacoes," VENDE! ");
                    VendaIndicador("Venda por Inversão de PSAR");
                    Ordem = true;
                    }
                    
                    if(Mudanca==-1 && Ordem==false)
                    {
                    Print("Operações Antes da compra: ",Operacoes," COMPRA! ");
                    CompraIndicador("Compra por Inversão de PSAR");
                    Ordem = true;
                    }
                      
                    }
   Mudanca = CondicaoPsar;
   Mudou = 0;

   }   //FIM DO IF TaDentroDoHorario

}

//////////////////Calcula Fractals


void CalculaFractal ()
{
if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true)
   {
   
   double _Fractal1[];
   double _Fractal2[];

   ArraySetAsSeries(_Fractal1, true);
   ArraySetAsSeries(_Fractal2, true);

   int copied=CopyBuffer(HandleFrac,0,0,100,_Fractal1);
   int copied2=CopyBuffer(HandleFrac,1,0,100,_Fractal2);


for(int x=0;x<3;x++)
       {
           double A1 = _Fractal1[x];
           if (A1!=EMPTY_VALUE) Print("Venda ["+IntegerToString(x)+"] = " + DoubleToString(A1));
            //else Print("A1 ["+IntegerToString(x)+"] = EMPTY_VALUE");
       }

for(int x=0;x<3;x++)
       {
           double A1 = _Fractal2[x];
           if (A1!=EMPTY_VALUE) Print("Compra ["+IntegerToString(x)+"] = " + DoubleToString(A1));
            //else Print("A1 ["+IntegerToString(x)+"] = EMPTY_VALUE");
       }

/*
                    if(Mudanca!=_Fractal1[0]) 
                    {
                    //Print("Mudou Hein");
                    DeuStopLoss = false;
                    DeuTakeProfit = false;                   
                    Ordem = false;
                    }
   Mudanca = _Fractal[0];
   Mudou = 0;
   
*/


   }   //FIM DO IF TaDentroDoHorario
}

//////////////////////


//////////////////////////////////
////////////////////////// Calcula STOPS



//////////////////////////// Primeira Operaçao

   
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
 
////////////// Avaliação do TS

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
   if(IndicadorTempoReal == false && Usa_Ozy == true)      Print("Ozy0: ",Ozy(0)," | Ozy1: ",Ozy(1)," | Ozy2: ",Ozy(2));
   if(IndicadorTempoReal == false && Usa_Ozy == true)     Ozy_Opera();
   
//   if(IndicadorTempoReal == false && Usa_Fractal == true)      CalculaFractal();   

//Print("Tendencia HiLo: ",DevolveHiLo());
//DevolveHiLo();


}

void IniciaDia ()
{
        if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && JaZerou==false)
        {
        
        CalculaHiLo();
        CalculaPSar();
        
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
   Sleep(1000);
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
