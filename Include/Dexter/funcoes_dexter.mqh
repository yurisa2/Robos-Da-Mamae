/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             FuncoesBenderDef.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robï¿½s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"


void Inicializa_Funcs ()
{
  Comentario_Dexter();

  if(Usa_PSar == true) HandlePSar = iSAR(NULL,TimeFrame,PSAR_Step,PSAR_Max_Step);
  if(Usa_Ozy == true) HandleOzy = iCustom(NULL,TimeFrame,"ozymandias_lite",Ozy_length,Ozy_MM,Ozy_Shift);
  if(Usa_Fractal == true) HandleFrac = iFractals(NULL,TimeFrame);
  if(Usa_Hilo == true) Inicializa_HiLo();
  if(Usa_BSI == true)  Inicializa_BSI();
  if(Usa_RSI == true)  Inicializa_RSI();


  if(Usa_Hilo == true) CalculaHiLo();
  if(Usa_PSar == true) CalculaPSar();
  if(Usa_BSI == true) CalculaBSI();
  if(Usa_RSI == true) CalculaRSI();


  if(Usa_Fractal == true) CalculaFractal();

  if(Usa_PSar == true)  ChartIndicatorAdd(0,0,HandlePSar);
  if(Usa_Ozy == true) ChartIndicatorAdd(0,0,HandleOzy);
  if(Usa_Fractal == true) ChartIndicatorAdd(0,0,HandleFrac);

  if(Usa_Hilo == true) Print("Indicador HiLo inicio do dia: ",Direcao);
  if(Usa_PSar == true) Print("Indicador PSAR inicio do dia: ",Direcao);

}

//////////////////////////////// Primeira Operaï¿½ao

void PrimeiraOperacao ()
{
  if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && PrimeiraOp==false)
  {
    Print(Descricao_Robo+" Horario Setup: ",HorarioInicio);
    Print(Descricao_Robo+" Direcao Inicio dia: ",Direcao);

    PrimeiraOp = true;

    if(Direcao<0)
    {
      VendaImediata("OperaLogoDeCara","Entrada");
      DeuStopLoss = false;
      DeuTakeProfit = false;
    }
    if(Direcao>0)
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
  Print("RSI na virada" + DoubleToString(CalculaRSI()));
  if(Operacoes<0 && SaiPeloIndicador==true)
  {
    MontarRequisicao(ORDER_TYPE_BUY,Desc);
  }
  if(Operacoes==0 &&
    OperacoesFeitas < (Limite_Operacoes*2) &&
    Saldo_Dia_Permite() == true &&
    ((Usa_Prop == true && Prop_Delta() > Prop_Limite_Minimo) || Usa_Fixos == true)
    && CalculaRSI() < RSI_compra
    )
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
  Print("RSI na virada" + DoubleToString(CalculaRSI()));

  if(Operacoes>0 && SaiPeloIndicador==true)
  {
    MontarRequisicao(ORDER_TYPE_SELL,Desc);
  }
  if(Operacoes==0 &&
    OperacoesFeitas < (Limite_Operacoes*2) &&
    Saldo_Dia_Permite() == true &&
    ((Usa_Prop == true && Prop_Delta() > Prop_Limite_Minimo) || Usa_Fixos == true ) &&
    CalculaRSI() > RSI_venda
  )
  {
    MontarRequisicao(ORDER_TYPE_SELL,Desc);
  }
}

void Comentario_Dexter ()
{
  Comentario_Robo = ""; //Para não repetir a porra toda

if(Usa_Hilo) Comentario_Robo = Comentario_Robo+"HiLo - M"+EnumToString(TimeFrame)+"N"+IntegerToString(Periodos)+"\n";
if(Usa_Ozy) Comentario_Robo = Comentario_Robo+"Ozy"+IntegerToString(Ozy_MM)+";"+IntegerToString(Ozy_Shift)+"."+IntegerToString(Ozy_length);
if(Usa_PSar) Comentario_Robo = Comentario_Robo+"PSAR"+DoubleToString(PSAR_Step,2)+";"+DoubleToString(PSAR_Max_Step,1)+"\n";
if(Usa_Fractal) Comentario_Robo = Comentario_Robo+"Frac"+IntegerToString(Frac_Candles_Espera);
if(Usa_BSI) Comentario_Robo = Comentario_Robo+"BSI"+IntegerToString(BSI_RangePeriod)+";"+IntegerToString(BSI_Slowing)+"."+IntegerToString(BSI_Avg_Period)+"\n";
if(Usa_RSI) Comentario_Robo = Comentario_Robo+"RSI: (Compra: "+RSI_compra+" Venda: "+RSI_venda+") "+DoubleToString(CalculaRSI(),2)+"\n"; //Colocar Parametros


}

void Calcula_Direcao ()
{
  // if(Usa_Hilo) CalculaHiLo(); // Futuro com mais calma eu "refatoro"
  // if(Usa_PSar) CalculaPSar();
}

void Avalia_Dexter ()
{
  if(Usa_Hilo == true)      HiLo();
  if(Usa_PSar == true)      PSar();
  if(Usa_Ozy == true)       Ozy_Opera();
  if(Usa_Fractal == true)   Fractal();
  if(Usa_BSI == true)       BSI();

}
