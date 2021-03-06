﻿/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                funcoesbender.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

int Rand_Geral = MathRand();
#include <Trade\Trade.mqh>
#include <Trade\AccountInfo.mqh>
#include <Trade\SymbolInfo.mqh>
//#include <Charts\Chart.mqh>

#include <VerificaInit.mqh>


#include <Posicao.mqh>
#include <JAson.mqh>
#include <OnTrade.mqh>
#include <Totalizador.mqh>
#include <Normalizacao.mqh>
// #include <Graficos.mqh>
#include <Interruptor.mqh>
#include <InTradeControl.mqh>

#include <FuncoesGerais.mqh>
#include <MontarRequisicao.mqh>

#include <Lib_CisNewBar.mqh>
#include <Operacoes_No_tick.mqh>
#include <Stops_OO.mqh>
#include <Condicoes.mqh>
#include <Comentario.mqh>
#include <Afis.mqh>
// #include <ExpandGrid.mqh>
#include <Math\Stat\Math.mqh>
#include <Deal_Matrix.mqh>


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
#include <Indicadores\Preco.mqh>
#include <Indicadores\RSI_OO.mqh>
#include <Indicadores\Stoch.mqh>
#include <Indicadores\Volumes.mqh>
#include <Indicadores\WPR.mqh>
#include <Indicadores\XING.mqh>
#include <aquisicao.mqh>

//#include <File_Writer.mqh> //Programa de Emagrecimento do YurÃ£o
#include <File_Writer_Gen.mqh>
// #include <File_Writer_Filtro.mqh> //Programa de Emagrecimento do YurÃ£o
#include <File_Reader.mqh>
#include <File_Reader_Gen.mqh>

   #include <Expert\ExpertBase.mqh>
   #include <Expert\ExpertTrailing.mqh>
    #include <Expert\Trailing\TrailingFixedPips.mqh>
    #include <Expert\Trailing\TrailingNone.mqh>
//--- object for performing trade operations
// CExpertBase expert;
// CTrade  trade;
//CTrade  CObject;
// CSymbolInfo simbolo;
// CTrailingFixedPips trailing;

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
////// Funï¿½ï¿½o Pega Tick e devolve a hora e o valor da porra do ativo
double daotick(int tipo = 0)
{
  double retornoTick = 0;

  retornoTick = SymbolInfoDouble(Symbol(),SYMBOL_ASK); // ASK eh bom pra compra, pra venda ï¿½ bid

  if(tipo == -1)
  {
  retornoTick = SymbolInfoDouble(Symbol(),SYMBOL_BID);
  // MessageBox("Pegou o bid","bid",MB_OK); //DEBUG
  }
  if(tipo == 1)  retornoTick = SymbolInfoDouble(Symbol(),SYMBOL_ASK);

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


double Segundos_Fim_Barra_num()
{
  int period_seconds=PeriodSeconds(TimeFrame);                     // Number of seconds in current chart period
  datetime new_time=TimeCurrent()/period_seconds*period_seconds; // Time of bar opening on current chart
  //if(grafico_atual.isNewBar(new_time)) Segundos_Contados=0;
  return NormalizeDouble(PeriodSeconds(TimeFrame)-(TimeCurrent()-new_time),0);
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
//       Print(Descricao_Robo+"Depois da Ultima Operaï¿½ï¿½o: ",IntegerToString(Operacoes));
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
  if(grafico_atual.isNewBar(new_time))
  {
    int Espera = MathRand()/30;
    Sleep(Espera);
    OnNewBar();
    interruptor.Interrompe_Ganho();
  }
}

void Operacoes_No_Timer()
{
  //Encerra_Ops_Dia();

  //  TaDentroDoHorario_RT = TaDentroDoHorario(HorarioInicio,HorarioFim);


}

void Encerra_Ops_Dia()
{
  string hrmn[2];
  StringSplit(TimeToString(TimeCurrent(),TIME_MINUTES),StringGetCharacter(":",0),hrmn);

if(hrmn[1] != minuto_passado)
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
  minuto_passado = hrmn[1];
  }
}
void Init_Padrao()
{
  Print("Init_Padrao");

  TesterHideIndicators(mocosa_indicadores);

  ObjectsDeleteAll(0,0,-1);
  EventSetMillisecondTimer(500);
  TimeMagic = MathRand();

 // CSymbolInfo *simbolo2 = new CSymbolInfo;
 //  simbolo2.Name("WINQ18");
 //
 //  expert.Init(simbolo2,TimeFrame,4);
  // expert.Magic(TimeMagic);


  tipo_margem_conta = AccountInfoInteger(ACCOUNT_MARGIN_MODE); //0 NETT, 1 EXCHANGE, 2 HEDGING
  Print("Tipo de Margem: " + IntegerToString(tipo_margem_conta));

  string data_inicio_execucao_string = TimeToString(TimeCurrent(),TIME_DATE) + " " + "00:01";

  // data_inicio_execucao = TimeCurrent();
  data_inicio_execucao = StringToTime(data_inicio_execucao_string);

  Print("DescriÃ§Ã£o: "+Descricao_Robo+" "+IntegerToString(TimeMagic));
  Print("Liquidez da conta: ",conta.Equity());
  Print("TimeMagic: ",IntegerToString(TimeMagic));

  Liquidez_inicio = conta.Equity();
  Print("Liquidez_inicio: " + DoubleToString(Liquidez_inicio));
  Tick_Size = SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_SIZE);
  Volume_Step = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);

  string _primeiras = StringSubstr(Symbol(),0,3);

  if(_primeiras == "win" || _primeiras == "WIN") Tick_Size = 5;
  if(_primeiras == "wdo" || _primeiras == "WDO") Tick_Size = 0.5;

  ArrumaMinutos();

  Print("Tick_Size: ",DoubleToString(Tick_Size));
  if(Tick_Size == 0) Alert("Tick_Size ZERO!");

  //if(!Otimizacao) File_Init();
  // if(!Otimizacao) File_Filtro_Init();

}

MqlRates Preco(int barra = 0)
{
  // barra = barra + 1;
  MqlRates rates_Preco[];
  ArraySetAsSeries(rates_Preco,true);
  int copied=CopyRates(Symbol(),0,0,barra+1,rates_Preco);

  return rates_Preco[barra];
}

MqlRates PrecoAtual()
{
  // Rates Structure for the data of the Last incomplete BAR
  MqlRates BarData[1];
  CopyRates(Symbol(), Period(), 0, 1, BarData); // Copy the data of last incomplete BAR

  // Copy latest close prijs.
  return BarData[0];
}

double n_(double valor, double min, double max)
{
  double retorno = NULL;
  retorno = valor;

  if(valor <= min ) retorno = min;
  if(valor >= max ) retorno = max;

  return retorno;
}

double OnTester()
{
  double resultado;

  Totalizador *totalizator = new Totalizador();
  resultado = totalizator.ganho_liquido();
 // resultado = totalizator.negocios;
  delete(totalizator);

  return resultado;
}

double Normaliza_Hora(datetime TimeInput)
{
  string hrmn[2];
  StringSplit(TimeToString(TimeInput,TIME_MINUTES),StringGetCharacter(":",0),hrmn);

  double horas = StringToInteger(hrmn[0]) * 0.04166666666;
  double minutos = StringToInteger(hrmn[1]) * 0.00069444444;

  return horas+minutos;
}

void Normaliza_Array(double& array_entrada[], double& array_saida[], int start_point = 0) {
  ArrayResize(array_saida,ArrayRange(array_entrada,0));

  double Z_min = array_entrada[ArrayMinimum(array_entrada,start_point)];
  double Z_max = array_entrada[ArrayMaximum(array_entrada,start_point)];

  double Z_max_Zmin = Z_max - Z_min;
  if(Z_max_Zmin == 0 ) Z_max_Zmin = 0.000000000000000000001;


  for (int i = start_point; i < ArrayRange(array_entrada,0); i++) {
    array_saida[i] = (array_entrada[i] - Z_min) / (Z_max_Zmin);
  }
}

void Normalizacao_Manual(double& array_entrada[], double& array_saida[], int start_point = 0, double min = 0, double max = 100) {
  ArrayResize(array_saida,ArrayRange(array_entrada,0));

  double Z_min =min;
  double Z_max = max;

  double Z_max_Zmin = Z_max - Z_min;
  if(Z_max_Zmin == 0 ) Z_max_Zmin = 0.000000000000000000001;


  for (int i = start_point; i < ArrayRange(array_entrada,0); i++) {
    array_saida[i] = (array_entrada[i] - Z_min) / (Z_max_Zmin);
  }
}

double divisao(double cima,double baixo) {
  double retorno = 0;
  if(baixo > 0 || baixo == NULL)  {
    // Print("baixo ZERO: " + baixo); //DEBUG
    retorno = cima/baixo;
  }
  // Print("cima: " + cima); //DEBUG
  // Print("baixo: " + baixo); //DEBUG

  return retorno;
}
