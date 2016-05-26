/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                funcoesbender.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"


#include <Trade\Trade.mqh>
#include <Trade\AccountInfo.mqh>
//#include <Charts\Chart.mqh>
#include <Lib_CisNewBar.mqh>
//#include <Expert\Expert.mqh>


//--- object for performing trade operations
//CExpert expert;
//CTrade  trade2;
//CTrade  CObject;
//CSymbolInfo simbolo;
//CPositionInfo posicao;
CDealInfo negocio;
//CChart grafico;
CAccountInfo conta;
CisNewBar grafico_atual; // instance of the CisNewBar class: current chart



////////////////////  TaDentroDoHorario //////////////
bool TaDentroDoHorario (string HoraInicio, string HoraFim)
   {
   string DiaHoraInicio;
   string DiaHoraFim;
   bool RetornoHorario =false;

   Agora = TimeCurrent();

   DiaHoje = TimeToString(TimeCurrent(),TIME_DATE);

   DiaHoraInicio = DiaHoje + " " + HoraInicio;
   DiaHoraFim = DiaHoje + " " + HoraFim;

   // Se Agora > String Dia + String Hora OK.
   //   Print("DiaHoje ",DiaHoje);
   if(Agora>=StringToTime(DiaHoraInicio))
     {
      if(Agora<=StringToTime(DiaHoraFim))
      {
      RetornoHorario = true;
      }
     }

   return(RetornoHorario);


   }
////////////////////////////////////////////////////////////////


//////////////////////// DAOTICK ///////////
////// Fun�ao Pega Tick e devolve a hora e o valor da porra do ativo
double daotick ()
{

double retornoTick;

   MqlTick last_tick;

if(SymbolInfoTick(_Symbol,last_tick))
     {
     // Print(last_tick.time,": Bid = ",last_tick.bid,
          //  " Ask = ",last_tick.ask,"  Volume = ",last_tick.volume); //total e completo

     }
     else Print("SymbolInfoTick() failed, error = ",GetLastError());

     retornoTick = last_tick.ask;

     return(retornoTick);

}


////////////////// Fecha o PEGA O TICK



string Segundos_Fim_Barra ()
{

   int period_seconds=PeriodSeconds(TimeFrame);                     // Number of seconds in current chart period
   datetime new_time=TimeCurrent()/period_seconds*period_seconds; // Time of bar opening on current chart
   //if(grafico_atual.isNewBar(new_time)) Segundos_Contados=0;
   return DoubleToString(PeriodSeconds(TimeFrame)-(TimeCurrent()-new_time),0)+"s";

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

        Print("Bom dia! Bucareste as ordens, segura o cora�ao pq o role � monstro!!!");
        SendMail(Descricao_Robo + "Inicio das opera�oes Bucareste","Bom dia! Bucareste: "+Descricao_Robo+" �s ordens, segura o cora�ao pq o role � monstro!!!");
        SendNotification("Bom dia! Bucareste: "+Descricao_Robo+" �s ordens, segura o cora�ao pq o role � monstro!!!");

        if(Usa_Hilo == true) Print("Indicador HiLo inicio do dia: ",Mudanca);
        if(Usa_PSar == true) Print("Indicador PSAR inicio do dia: ",Mudanca);
        liquidez_inicio = conta.Equity();
        Sleep(1000);
        }

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
            Print(Descricao_Robo+"Final do Dia! Opera�oes: ",Operacoes);
            SendNotification(Descricao_Robo+" encerrando");

                   if(Operacoes<0)
                      {
                      MontarRequisicao(ORDER_TYPE_BUY,"Compra para zerar o dia | Ops: "+Operacoes);
                      Sleep(1000);
                      }
                   if(Operacoes>0)
                     {
                     MontarRequisicao(ORDER_TYPE_SELL,"Venda para zerar o dia | Ops: "+Operacoes);
                     Sleep(1000);
                     SendMail(Descricao_Robo+"Bucareste: Venda para zerar o dia","Finalizando o dia com uma venda, e tal...");
                     }
               Print(Descricao_Robo+"Depois da Ultima Opera�ao: ",Operacoes);
                  Sleep(5000);
         }

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
   Print("Horario inicio: ", HorarioInicio," Horario fim: ",HorarioFim, " Horario de fim mais 1: ",HorarioFimMais1 );
}



void Comentario (int ops)
{

if(ops > 0)
{
Comment(
Descricao_Robo()+"|"+
Desc_Se_Vazio()+"\n"+
Descricao_Robo+
" COMPRADO - SL: "+
DoubleToString(StopLossValorCompra,_Digits)+
" - TP: "+DoubleToString(TakeProfitValorCompra,_Digits)+
" TS: "+DoubleToString(TS_ValorCompra,_Digits)+" - "+
Segundos_Fim_Barra()+
" - EM_Contador: "+

EM_Contador_Picote

);


}

if(ops < 0) Comment(Descricao_Robo()+"|"+Desc_Se_Vazio()+"\n"+Descricao_Robo+" VENDIDO- SL: "+DoubleToString(StopLossValorVenda,_Digits)+" - TP: "+DoubleToString(TakeProfitValorVenda,_Digits)+" TS: "+DoubleToString(TS_ValorVenda,_Digits)+" - "+Segundos_Fim_Barra()+" - EM_Contador: "+EM_Contador_Picote);
if(ops == 0)   Comment(Descricao_Robo()+"|"+Desc_Se_Vazio()+"\n Nenhuma trade ativa | DELTA: "+DoubleToString(Prop_Delta(),_Digits)+" - "+Segundos_Fim_Barra()+" - daotick: "+daotick());


}

string Descricao_Robo ()
{
string Desc_Robo = "";

Desc_Robo = Desc_Robo + EnumToString(TimeFrame);
Desc_Robo = Desc_Robo + "-";
Desc_Robo = Desc_Robo + _Symbol;
Desc_Robo = Desc_Robo + "-";
//Indicadores -- Falta Os Parametros de Cada

if(Usa_Hilo) Desc_Robo = Desc_Robo+"HiLo"+IntegerToString(Periodos);
if(Usa_Ozy) Desc_Robo = Desc_Robo+"Ozy"+IntegerToString(Ozy_MM)+";"+IntegerToString(Ozy_Shift)+"."+IntegerToString(Ozy_length);
if(Usa_PSar) Desc_Robo = Desc_Robo+"PSAR"+DoubleToString(PSAR_Step,2)+";"+DoubleToString(PSAR_Max_Step,1);
if(Usa_Fractal) Desc_Robo = Desc_Robo+"Frac"+IntegerToString(Frac_Candles_Espera);
if(Usa_BSI) Desc_Robo = Desc_Robo+"BSI"+IntegerToString(BSI_RangePeriod)+";"+IntegerToString(BSI_Slowing)+"."+IntegerToString(BSI_Avg_Period);


Desc_Robo = Desc_Robo + "-";
// Fixos

   if(Usa_Fixos)
   {
   Desc_Robo = Desc_Robo+"Fix-";
   if(StopLoss>0) Desc_Robo = Desc_Robo+"SL"+DoubleToString(StopLoss,2);
   if(MoverSL>0) Desc_Robo = Desc_Robo+"MSL"+DoubleToString(MoverSL,2);
   if(PontoDeMudancaSL>0) Desc_Robo = Desc_Robo+"PMSL"+DoubleToString(PontoDeMudancaSL,2);
   if(TakeProfit>0) Desc_Robo = Desc_Robo+"TP"+DoubleToString(TakeProfit,2);
   if(Trailing_stop>0) Desc_Robo = Desc_Robo+"TP"+DoubleToString(Trailing_stop,2);
   if(Trailing_stop_start>0) Desc_Robo = Desc_Robo+"TP"+DoubleToString(Trailing_stop_start,2);
   }

// Prop

   if(Usa_Prop)
   {
   Desc_Robo = Desc_Robo+"Pro-";
   if(Prop_StopLoss>0) Desc_Robo = Desc_Robo+"SL"+DoubleToString(Prop_StopLoss,2);
   if(Prop_Metodo==534) Desc_Robo = Desc_Robo+"SMA"+DoubleToString(Prop_Periodos,2);
   if(Prop_Metodo==88) Desc_Robo = Desc_Robo+"BB"+DoubleToString(Prop_Periodos,2);
   if(Prop_MoverSL>0) Desc_Robo = Desc_Robo+"MSL"+DoubleToString(Prop_MoverSL,2);
   if(Prop_PontoDeMudancaSL>0) Desc_Robo = Desc_Robo+"PMSL"+DoubleToString(Prop_PontoDeMudancaSL,2);
   if(Prop_TakeProfit>0) Desc_Robo = Desc_Robo+"TP"+DoubleToString(Prop_TakeProfit,2);
   if(Prop_Trailing_stop>0) Desc_Robo = Desc_Robo+"TP"+DoubleToString(Prop_Trailing_stop,2);
   if(Prop_Trailing_stop_start>0) Desc_Robo = Desc_Robo+"TP"+DoubleToString(Prop_Trailing_stop_start,2);
   if(Prop_Limite_Minimo_Tick_Size>0) Desc_Robo = Desc_Robo+"MT"+DoubleToString(Prop_Limite_Minimo_Tick_Size,2);
   }



return Desc_Robo;

}




//////////////////////////////// Primeira Opera�ao

   void PrimeiraOperacao ()
{
       if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && PrimeiraOp==false)
       {
       Print(Descricao_Robo+" Horario Setup: ",HorarioInicio);
       Print(Descricao_Robo+" Mudanca Inicio dia: ",Mudanca);

       PrimeiraOp = true;

         if(Mudanca<0)
         {
         VendaImediata("OperaLogoDeCara","Entrada");
         DeuStopLoss = false;
         DeuTakeProfit = false;
         }
         if(Mudanca>0)
         {
         CompraImediata("OperaLogoDeCara","Entrada");
         DeuStopLoss = false;
         DeuTakeProfit = false;
         }


       }




 }
//////////////// Fim Primeira Opera�ao

/////////////////////////////////
void DetectaNovaBarra ()
{
//---
   int period_seconds=PeriodSeconds(TimeFrame);                     // Number of seconds in current chart period
   datetime new_time=TimeCurrent()/period_seconds*period_seconds; // Time of bar opening on current chart
   if(grafico_atual.isNewBar(new_time)) OnNewBar();
}
