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

#include <Posicao.mqh>
#include <OnTrade.mqh>
#include <Totalizador.mqh>
#include <Normalizacao.mqh>
#include <Graficos.mqh>

#include <Math\Fuzzy\MamdaniFuzzySystem.mqh>

#include <Lib_CisNewBar.mqh>
#include <Operacoes_No_tick.mqh>
#include <Stops_OO.mqh>
#include <Condicoes.mqh>
#include <Comentario.mqh>

#include <Indicadores\AC.mqh>
#include <Indicadores\AD.mqh>
#include <Indicadores\ADX.mqh>
#include <Indicadores\ATR.mqh>
#include <Indicadores\BB.mqh>
#include <Indicadores\BearsPower.mqh>
#include <Indicadores\BullsPower.mqh>
#include <Indicadores\BWMFI.mqh>
#include <Indicadores\CCI.mqh>
#include <Indicadores\DeMarker.mqh>
#include <Indicadores\DP.mqh>
#include <Indicadores\HiLo_OO.mqh>
#include <Indicadores\Igor.mqh>
#include <Indicadores\MA.mqh>
#include <Indicadores\MACD.mqh>
#include <Indicadores\MFI.mqh>
#include <Indicadores\Momentum.mqh>
#include <Indicadores\OBV.mqh>
#include <Indicadores\RSI_OO.mqh>
#include <Indicadores\Stoch.mqh>
#include <Indicadores\Volumes.mqh>
#include <Indicadores\WPR.mqh>
#include <aquisicao.mqh>
#include <Filtro_Fuzzy.mqh>

#include <File_Writer.mqh>
#include <File_Reader.mqh>

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
////// Fun��o Pega Tick e devolve a hora e o valor da porra do ativo
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

  retornoTick = last_tick.ask; // ASK eh bom pra compra, pra venda � bid

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
//       Print(Descricao_Robo+"Depois da Ultima Opera��o: ",IntegerToString(Operacoes));
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

  " | "+

  Segundos_Fim_Barra() +
  " | Saldo exec: " + DoubleToString(Saldo_Do_Dia_RT,2) +
  " | Operacoes: " + IntegerToString(OperacoesFeitas) + "\n" +

  Comentario_Robo
  ;

Comentario_Debug_funcao();

if(Tipo_Comentario == 0 && !Otimizacao) Comment(Comentario_Simples);
if(Tipo_Comentario == 1 && !Otimizacao) Comment(Comentario_Avancado);
if(Tipo_Comentario == 2 && !Otimizacao) Comment(Comentario_Debug);

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
  Encerra_Ops_Dia();

  //  TaDentroDoHorario_RT = TaDentroDoHorario(HorarioInicio,HorarioFim);


}

void Encerra_Ops_Dia()
{

  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  if(!Condicoes.Horario() && ZerarFinalDoDia)
  {
    if(O_Stops.Tipo_Posicao() != 0)
    {
      Opera_Mercado *opera = new Opera_Mercado;
      opera.FechaPosicao() ;
      delete(opera);

    }

  }

  delete(Condicoes);

}

void Init_Padrao ()
{
  ObjectsDeleteAll(0,0,-1);
  EventSetMillisecondTimer(500);
  TimeMagic =MathRand();

  data_inicio_execucao = TimeCurrent();


  Print("Descri��o: "+Descricao_Robo+" "+IntegerToString(TimeMagic));
  Print("Liquidez da conta: ",conta.Equity());
  Print("TimeMagic: ",IntegerToString(TimeMagic));

  Liquidez_Teste_inicio = conta.Equity();
  Tick_Size = SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_SIZE);
  Volume_Step = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);

  ArrumaMinutos();


  File_Init();
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

      // Print("Bom dia! Robo as ordens, segura o cora�ao pq o role � monstro!!!");
      // SendMail(Descricao_Robo + "Inicio das opera�oes Bucareste","Bom dia! Bucareste: "+Descricao_Robo+" �s ordens, segura o cora�ao pq o role � monstro!!!");
      // SendNotification("Bom dia! Bucareste: "+Descricao_Robo+" �s ordens, segura o cora�ao pq o role � monstro!!!");

      liquidez_inicio = conta.Equity();
      Sleep(1000);
    } //If do Horario
  } //If do Ja zerou
}


MqlRates Preco(int barra = 0)
{
  barra = barra + 1;
    MqlRates rates[];
    ArraySetAsSeries(rates,true);
    int copied=CopyRates(Symbol(),TimeFrame,0,200,rates);

    return rates[barra];
}

MqlRates PrecoAtual()
{
  // Rates Structure for the data of the Last incomplete BAR
     MqlRates BarData[1];
     CopyRates(Symbol(), Period(), 0, 1, BarData); // Copy the data of last incomplete BAR

  // Copy latest close prijs.
     return BarData[0];
}
