/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                funcoesbender.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

#include <Trade\Trade.mqh>
#include <Trade\AccountInfo.mqh>
//#include <Charts\Chart.mqh>

#include <OnTrade.mqh>
#include <Posicao.mqh>
#include <Totalizador.mqh>

#include <Lib_CisNewBar.mqh>
#include <Operacoes_No_tick.mqh>
#include <Stops_OO.mqh>
#include <Condicoes.mqh>
#include <Comentario.mqh>

//#include <Expert\Expert.mqh>

//--- object for performing trade operations
//CExpert expert;
// CTrade  trade;
//CTrade  CObject;
//CSymbolInfo simbolo;
// CPositionInfo posicao;
// CDealInfo negocio;
//CChart grafico;
CAccountInfo conta;
CisNewBar grafico_atual; // instance of the CisNewBar class: current chart

////////////////////  TaDentroDoHorario //////////////
bool TaDentroDoHorario(string HoraInicio, string HoraFim)
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
////////////////////////////////////////////

//////////////////////// DAOTICK ///////////
////// Função Pega Tick e devolve a hora e o valor da porra do ativo
double daotick(int tipo = 0)
{
  double retornoTick = 0;
  MqlTick last_tick;
  if(SymbolInfoTick(_Symbol,last_tick))
  {
    // Print(last_tick.time,": Bid = ",last_tick.bid,
    //  " Ask = ",last_tick.ask,"  Volume = ",last_tick.volume); //total e completo
  }
  else Print("SymbolInfoTick() failed, error = ",GetLastError());

  retornoTick = last_tick.ask; // ASK eh bom pra compra, pra venda é bid

  if(tipo == -1)
  {
  retornoTick = last_tick.bid;
  // MessageBox("Pegou o bid","bid",MB_OK); //DEBUG
  }
  if(tipo == 1)  retornoTick = last_tick.ask;

  return(retornoTick);
}
////////////////// Fecha o PEGA O TICK

string Segundos_Fim_Barra()
{
  int period_seconds=PeriodSeconds(TimeFrame);                     // Number of seconds in current chart period
  datetime new_time=TimeCurrent()/period_seconds*period_seconds; // Time of bar opening on current chart
  //if(grafico_atual.isNewBar(new_time)) Segundos_Contados=0;
  return DoubleToString(PeriodSeconds(TimeFrame)-(TimeCurrent()-new_time),0)+"s";
}

////////////////// Zerar o dia
// void ZerarODia()
// {
//   if(JaDeuFinal == false)
//   {
//     if(TaDentroDoHorario(HorarioFim,HorarioFimMais1) == true)
//     {
//       Sleep(5000);
//       JaDeuFinal = true;
//       JaZerou = false;
//       PrimeiraOp = false;
//       Print(Descricao_Robo+"Final do Dia! Operacoes: ",Operacoes);
//       // SendNotification(Descricao_Robo+" encerrando");
//
//       if(Operacoes<0)
//       {
//         MontarRequisicao(ORDER_TYPE_BUY,"Compra para zerar o dia | Ops: "+IntegerToString(Operacoes));
//         Sleep(1000);
//       }
//       if(Operacoes>0)
//       {
//         MontarRequisicao(ORDER_TYPE_SELL,"Venda para zerar o dia | Ops: "+IntegerToString(Operacoes));
//         Sleep(1000);
//         SendMail(Descricao_Robo+"Venda para zerar o dia","Finalizando o dia com uma venda, e tal...");
//       }
//       Print(Descricao_Robo+"Depois da Ultima Operação: ",IntegerToString(Operacoes));
//       Sleep(5000);
//     } // Fim do ta dentro do horario
//   } // Fim do JaDeuFinal
// }

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

void Comentario ()
{

  if(Operacoes > 0)
  {
    Comentario_Simples =
    " COMPRADO | SL: "+
    " | TP: "+
    " TS: "+" - "+
     "Delta op Atual:"

    ;
  }

  if(Operacoes < 0)
  {
    Comentario_Simples =
    " VENDIDO | SL: "+
    " | TP: "+
    " TS: "+" - "+
    "Delta op Atual: "

    ;
  }

  if(Operacoes == 0)
  {
    Comentario_Simples =
    "Nenhuma trade ativa |  | "+
    " | daotick: "+DoubleToString(daotick_geral,_Digits);
  }

  Comentario_Avancado =
  Descricao_Robo()+" | \n"+Descricao_Robo+

  Comentario_Simples+   //AQUI EH O ESPECIFICO DA ORDEM

  " | Picotes: "+IntegerToString(EM_Contador_Picote)+" | "+

  Segundos_Fim_Barra() +
  " | Saldo exec: " + DoubleToString(Saldo_Do_Dia_RT,2) +
  " | Operacoes: " + IntegerToString(OperacoesFeitas) + "\n" +

  Comentario_Robo
  ;

Comentario_Debug_funcao();

if(Tipo_Comentario == 0) Comment(Comentario_Simples);
if(Tipo_Comentario == 1) Comment(Comentario_Avancado);
if(Tipo_Comentario == 2) Comment(Comentario_Debug);

}


string Descricao_Robo()
{
  string Desc_Robo = "";

  Desc_Robo = Desc_Robo + EnumToString(TimeFrame);
  Desc_Robo = Desc_Robo + "-";
  Desc_Robo = Desc_Robo + _Symbol;
  Desc_Robo = Desc_Robo + "-";
  //Indicadores -- Falta Os Parametros de Cada

  Desc_Robo = Desc_Robo + " | ";
  // Fixos

  return Desc_Robo;
}

/////////////////////////////////
void DetectaNovaBarra()
{
  //---
  int period_seconds=PeriodSeconds(TimeFrame);                     // Number of seconds in current chart period
  datetime new_time=TimeCurrent()/period_seconds*period_seconds; // Time of bar opening on current chart
  if(grafico_atual.isNewBar(new_time)) OnNewBar();
}

void Operacoes_No_Timer()
{

    TaDentroDoHorario_RT = TaDentroDoHorario(HorarioInicio,HorarioFim);


}

void Init_Padrao ()
{
  ObjectsDeleteAll(0,0,-1);
  EventSetMillisecondTimer(500);
  TimeMagic =MathRand();

  data_inicio_execucao = TimeCurrent();


  Print("Descrição: "+Descricao_Robo+" "+IntegerToString(TimeMagic));
  Print("Liquidez da conta: ",conta.Equity());
  Print("TimeMagic: ",IntegerToString(TimeMagic));

  Liquidez_Teste_inicio = conta.Equity();
  Tick_Size = SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_SIZE);

  ArrumaMinutos();

}

void IniciaDia ()
{
  if(JaZerou==false)
  {
    if(TaDentroDoHorario_RT==true && JaZerou==false)
    {
      OperacoesFeitas = 0;

      JaZerou = true;
      JaDeuFinal = false;
      Operacoes = 0;
      Ordem = false;      //Bucareste
      PrimeiraOp = false;
      DeuTakeProfit = true;
      DeuStopLoss = true;

      // Print("Bom dia! Robo as ordens, segura o coraï¿½ao pq o role ï¿½ monstro!!!");
      // SendMail(Descricao_Robo + "Inicio das operaï¿½oes Bucareste","Bom dia! Bucareste: "+Descricao_Robo+" ï¿½s ordens, segura o coraï¿½ao pq o role ï¿½ monstro!!!");
      // SendNotification("Bom dia! Bucareste: "+Descricao_Robo+" ï¿½s ordens, segura o coraï¿½ao pq o role ï¿½ monstro!!!");

      liquidez_inicio = conta.Equity();
      Sleep(1000);
    } //If do Horario
  } //If do Ja zerou
}

bool Condicoes_Basicas_Gerais()
{
  double retorno = true;
  double Operacoes_Feitas_Permite = false;

  if(OperacoesFeitas < (Limite_Operacoes*2)) Operacoes_Feitas_Permite = true;

  if(!JaZerou || !Operacoes_Feitas_Permite || !TaDentroDoHorario_RT || ! Saldo_Dia_Permite_RT) retorno = false;

return retorno;
}
