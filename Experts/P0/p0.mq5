/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                         Xavier, Unstable MOFucker|
//|                        Copyright 2017, Sa2 INVESTMENT            |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PZERO."
#property link      "http://www.sa2.com.br"

#property version   "1.0" //Low Profit Scalping

// #include <Inputs_Vars.mqh>
#include <Lib_CisNewBar.mqh>
   CisNewBar grafico_atual; // instance of the CisNewBar class: current chart
// #include <basico.mqh>
#include <Trade\AccountInfo.mqh>
CAccountInfo conta;

// #include <FuncoesGerais.mqh>

   #include <Trade\Trade.mqh>
   CTrade trade;

//
// #include <Stops_OO.mqh>
// #include <MontarRequisicao.mqh>
// #include <VerificaInit.mqh>
//
// #include <Zumba\Zumba_funcoes.mqh>
// #include <Zumba\Zumba_inputs.mqh>


input int Hora_Entrada = 10; //Hora de Entrada
input int Minuto_Entrada = 15; //Minuto de Entrada
input string Ativo_Compra; //Ativo Para Compra
input double QT_Compra; //Volume da Compra
input string Ativo_Venda; //Ativo de Venda
input double QT_Venda; //Volume da Venda
input int Hora_Saida = 16; //Hora de Saida Maxima
input int Minuto_Saida = 0; //Minuto de Saida Maximo

input double Stop_Loss = 250; //Stop loss em grana Global
input double Take_Profit = 250;  //Stop Gain em grana Global

double Equity_Entrada = 0;

void OnInit()
{




}

void OnTimer()
{

}

void OnTick()
{
  int period_seconds=PeriodSeconds(PERIOD_M1);                     // Number of seconds in current chart period

  datetime new_time=TimeCurrent()/period_seconds*period_seconds; // Time of bar opening on current chart

  if(grafico_atual.isNewBar(new_time)) OnNewBar();

}

double OnTester()
{
  return 0;
}

void OnNewBar()
{
  string hrmn[2];
  StringSplit(TimeToString(TimeCurrent(),TIME_MINUTES),StringGetCharacter(":",0),hrmn);


  if(Hora_Entrada == StringToInteger(hrmn[0]) && Minuto_Entrada == StringToInteger(hrmn[1]) )
  {
    // Print("Hr: " + hrmn[0]);
    // Print("Mn: " + hrmn[1]);
    // Print("Equity: " + DoubleToString(conta.Equity()));
    Entrada();
  }

  if(Hora_Saida == StringToInteger(hrmn[0]) && Minuto_Saida == StringToInteger(hrmn[1]) )
  {
    // Print("Hr: " + hrmn[0]);
    // Print("Mn: " + hrmn[1]);
    // Print("Equity: " + DoubleToString(conta.Equity()));
    Saida();
  }

  if(conta.Equity() > Equity_Entrada + Take_Profit ) Saida();
  if(conta.Equity() < Equity_Entrada - Stop_Loss ) Saida();

}


void Entrada()
{
  Equity_Entrada = conta.Equity();
  trade.Buy(QT_Compra,Ativo_Compra);
  trade.Sell(QT_Venda,Ativo_Venda);
}
void Saida()
{
  trade.PositionClose(Ativo_Compra);
  trade.PositionClose(Ativo_Venda);
}
