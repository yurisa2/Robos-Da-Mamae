//+------------------------------------------------------------------+
//|                                             FuncoesBenderDef.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"


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

  if(Usa_Hilo == true) Print("Indicador HiLo inicio do dia: ",Mudanca);
  if(Usa_PSar == true) Print("Indicador PSAR inicio do dia: ",Mudanca);

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
//////////////// Fim Primeira Operacao


///////////////// COMPRA

void CompraIndicador (string Desc,string IO = "Neutro")
{
  if(IO == "Entrada") EM_Contador_Picote = 0;

  if(EM_Picote_Tipo==55) Valor_Escalpe = Tick_Size * Tamanho_Picote;    //Para fazer funcionar o EM   - fixo
  if(EM_Picote_Tipo==471) Valor_Escalpe = Prop_Delta() * Tamanho_Picote;  //Para fazer funcionar o EM - proporcional

  Print(Descricao_Robo+" "+Desc);

  if(Operacoes<0 && SaiPeloIndicador==true)
  {
    MontarRequisicao(ORDER_TYPE_BUY,Desc);
  }
  if(Operacoes==0 && OperacoesFeitas < (Limite_Operacoes*2) && Saldo_Dia() == true &&  (  (Usa_Prop == true && Prop_Delta() > Prop_Limite_Minimo) || Usa_Fixos == true ) )
  {
    MontarRequisicao(ORDER_TYPE_BUY,Desc);
  }
}

//////////////////////////

///////////// Venda
void VendaIndicador (string Desc,string IO = "Neutro")
{
  if(IO == "Entrada") EM_Contador_Picote = 0;

  if(EM_Picote_Tipo==55) Valor_Escalpe = Tick_Size * Tamanho_Picote;    //Para fazer funcionar o EM   - fixo
  if(EM_Picote_Tipo==471) Valor_Escalpe = Prop_Delta() * Tamanho_Picote;  //Para fazer funcionar o EM - proporcional

  Print(Descricao_Robo+" "+Desc);
  if(Operacoes>0 && SaiPeloIndicador==true)
  {
    MontarRequisicao(ORDER_TYPE_SELL,Desc);
  }
  if(Operacoes==0 && OperacoesFeitas < (Limite_Operacoes*2) && Saldo_Dia() == true &&  (  (Usa_Prop == true && Prop_Delta() > Prop_Limite_Minimo) || Usa_Fixos == true ) )
  {
    MontarRequisicao(ORDER_TYPE_SELL,Desc);
  }
}
