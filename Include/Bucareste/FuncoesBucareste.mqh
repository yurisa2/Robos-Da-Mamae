//+------------------------------------------------------------------+
//|                                             FuncoesBenderDef.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"


void Inicializa_Funcs ()
{
  Tick_Size = SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_SIZE);

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

    Print("Bom dia! Bucareste as ordens, segura o coraï¿½ao pq o role ï¿½ monstro!!!");
    SendMail(Descricao_Robo + "Inicio das operaï¿½oes Bucareste","Bom dia! Bucareste: "+Descricao_Robo+" ï¿½s ordens, segura o coraï¿½ao pq o role ï¿½ monstro!!!");
    SendNotification("Bom dia! Bucareste: "+Descricao_Robo+" ï¿½s ordens, segura o coraï¿½ao pq o role ï¿½ monstro!!!");

    if(Usa_Hilo == true) Print("Indicador HiLo inicio do dia: ",Mudanca);
    if(Usa_PSar == true) Print("Indicador PSAR inicio do dia: ",Mudanca);
    liquidez_inicio = conta.Equity();
    Sleep(1000);
  }

}

//////////////////////////////// Primeira Operaï¿½ao

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
//////////////// Fim Primeira Operaï¿½ao
