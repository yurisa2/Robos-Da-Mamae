/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class Stops
{
  public:
  Stops();
  // ~Stops() {};
  int Tipo_Posicao();
  void No_Tick();
  void Setar_Ordens_Vars_Static(int funcao = 0);
  double Valor_Negocio();
  void TS_();
  double Distribuidor_Parcial(int Seletor_Volume);
  void TakeProfit_Calcula();
  double Valor_SL();
  double TakeProfit_op;
  double TakeProfit2_op;
  double TakeProfit3_op;
  double StopLoss_Op;


  protected:
};

void Stops::Stops()
{
  if(Tipo_Limite == 471)
  {
    TakeProfit_op = MathRound(TakeProfit  * SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL));
    TakeProfit2_op = MathRound(TakeProfit2 * SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL));
    TakeProfit3_op = MathRound(TakeProfit3 * SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL));
    StopLoss_Op = MathRound(StopLoss * SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL));
  }
  else
  {
    TakeProfit_op = TakeProfit;
    TakeProfit2_op = TakeProfit2;
    TakeProfit3_op = TakeProfit3;
    StopLoss_Op = StopLoss;
  }
}

int Stops::Tipo_Posicao()
{
  CPositionInfo *posiciones = new CPositionInfo;

  if(!posiciones.SelectByMagic(Symbol(),TimeMagic))
  {
    Operacoes = 0;
    delete(posiciones);
    return 0;
  }
  else
  {
    if(posiciones.PositionType() == POSITION_TYPE_BUY)
    {
      Operacoes = 1;
      delete(posiciones);
      return 1;
    }
    if(posiciones.PositionType() == POSITION_TYPE_SELL)
    {
      Operacoes = -1;
      delete(posiciones);
      return -1;
    }
  }
  return Operacoes; //Remover quando tirar Vars Flutuantes
}

void Stops::No_Tick()
{
  if(Tipo_Posicao() != 0 && Trailing_stop > 0) TS_();

  if(StopLoss_cash_posicao > 0 || TakeProfit_cash_posicao > 0)
  {
    InTradeControl *in_trade = new InTradeControl;
    in_trade.StopLoss_cash();
    in_trade.TakeProfit_cash();
    delete in_trade;
  }


}

double Stops::Distribuidor_Parcial(int Seletor_Volume)
{
  double retorno = 1;
  double TPLs = 0;

  if(TakeProfit_op > 0 && TakeProfit_Volume > 0 ) TPLs++;
  if(TakeProfit2_op > 0 && TakeProfit_Volume2 > 0 ) TPLs++;
  if(TakeProfit3_op > 0 && TakeProfit_Volume3 > 0 ) TPLs++;

  if(Seletor_Volume == 0 )
  {
    retorno = TPLs;
    //Print("TPLs: " + DoubleToString(TPLs)); //DEBUG
    return retorno;
  }

  if(Seletor_Volume == 1 )
  {
    retorno = TakeProfit_Volume;
    return retorno;
  }

  if(Seletor_Volume == 2 )
  {
    retorno = TakeProfit_Volume2;
    return retorno;
  }

  if(Seletor_Volume == 3 )
  {
    retorno = TakeProfit_Volume3;
    return retorno;
  }
  return retorno;
}

void Stops::TakeProfit_Calcula()
{
  ENUM_ORDER_TYPE Tipo_Ordem_TP = ORDER_TYPE_SELL_LIMIT;
  double delta_bb = 0;
  double tpc1 = 0;
  double tpc2 = 0;
  double tpc3 = 0;
  double valor = Valor_Negocio();
  double Valor_tp = 0;

  datetime dtHoje;
  string DiaHojeStop = TimeToString(TimeCurrent(),TIME_DATE) + " 23:59";
  dtHoje = StringToTime(DiaHojeStop);
  //  Print("Data: " + dtHoje); //DEBUG

  //DEFINE O MULTIPLICADOR DA BANDA
  // if(Tipo_Limite == 471)
  // {
  //   BB *Banda_BB = new BB();
  //   //delta_bb = Banda_BB.BB_High(0) - Banda_BB.BB_Low(0);  //Antigo
  //   delta_bb = Banda_BB.BB_Delta_Bruto(0);
  //   delete(Banda_BB);
  // }
  //
  // if(Tipo_Limite == 55) delta_bb = 1;
  delta_bb = 1;
  //FIM DA DEFINICAO MULTIPLICADOR DA BANDA

  //Aqui da pau no proporcional pq nao se acerta com o Tick Size, o certo � pegar o valor d
  //do neg�cio, deixar o TPC em tick size e

  //Print("delta_bb: " + delta_bb);  //DEBUG

  tpc1 = (TakeProfit_op * delta_bb);
  tpc1 = MathFloor(tpc1) * Tick_Size;
  //Print("MathFloor(tpc1) * Tick_Size: " + tpc1); //DEBUG
  tpc1 = valor + (tpc1 * (Tipo_Posicao()));
  //Print("TPC1: " + tpc1); //DEBUG
  //Print("TickSize: " + Tick_Size); //DEBUG


  tpc2 = (TakeProfit2_op * delta_bb);
  tpc2 = MathFloor(tpc2) * Tick_Size;
  tpc2 = valor + (tpc2 * (Tipo_Posicao()));
  //Print("TPC2: " + tpc2); //DEBUG

  tpc3 = (TakeProfit3_op * delta_bb);
  tpc3 = MathFloor(tpc3) * Tick_Size;
  tpc3 = valor + (tpc3 * (Tipo_Posicao()));
  //Print("TPC3: " + tpc3); //DEBUG

  if(Tipo_Posicao() > 0) Tipo_Ordem_TP = ORDER_TYPE_SELL_LIMIT;
  if(Tipo_Posicao() < 0) Tipo_Ordem_TP = ORDER_TYPE_BUY_LIMIT;

  CTrade *tradionices = new CTrade;
  // Inicio das ordens efetivas
  // if(Distribuidor_Parcial(0) == 1)
  // {
  //   tradionices.OrderOpen(
  //     Symbol(),
  //     Tipo_Ordem_TP,
  //     Distribuidor_Parcial(1),
  //     0,
  //     tpc1,
  //     0,
  //     0,
  //     ORDER_TIME_DAY,
  //     dtHoje,
  //     IntegerToString(TimeMagic)
  //   );
  // }

  if(Distribuidor_Parcial(0) == 2)
  {
    tradionices.OrderOpen(
      Symbol(),
      Tipo_Ordem_TP,
      Distribuidor_Parcial(1),
      0,
      tpc1,
      0,
      0,
      ORDER_TIME_DAY,
      dtHoje,
      IntegerToString(TimeMagic)
    );
    // tradionices.OrderOpen(
    //   Symbol(),
    //   Tipo_Ordem_TP,
    //   Distribuidor_Parcial(2),
    //   0,
    //   tpc2,
    //   0,
    //   0,
    //   ORDER_TIME_DAY,
    //   dtHoje,
    //   IntegerToString(TimeMagic)
    // );
  }

  if(Distribuidor_Parcial(0) == 3)
  {
    tradionices.OrderOpen(
      Symbol(),
      Tipo_Ordem_TP,
      Distribuidor_Parcial(1),
      0,
      tpc1,
      0,
      0,
      ORDER_TIME_DAY,
      dtHoje,
      IntegerToString(TimeMagic)
    );

    tradionices.OrderOpen(
      Symbol(),
      Tipo_Ordem_TP,
      Distribuidor_Parcial(2),
      0,
      tpc2,
      0,
      0,
      ORDER_TIME_DAY,
      dtHoje,
      IntegerToString(TimeMagic)
    );

    // tradionices.OrderOpen(
    //   Symbol(),
    //   Tipo_Ordem_TP,
    //   Distribuidor_Parcial(3),
    //   0,
    //   tpc3,
    //   0,
    //   0,
    //   ORDER_TIME_DAY,
    //   dtHoje,
    //   IntegerToString(TimeMagic)
    // );
  }
  //Fim das ordens efetivas
  delete(tradionices);


}

void Stops::Setar_Ordens_Vars_Static(int funcao = 0)
{
  CTrade *tradionices = new CTrade;
  double valor = Valor_Negocio();
  int Tipo_Posicao_ = Tipo_Posicao();
  int loopes = 0;

  if(funcao == 0)
  {
    do
    {
      if(loopes != 0) Print("Posicao Zero, Tentativa #: " + IntegerToString(loopes));
      Sleep(400);
      Tipo_Posicao_ = Tipo_Posicao();
      loopes++;
    }
    while(Tipo_Posicao_ == 0 && loopes <= 20);

    if(Tipo_Posicao_ == 0)
    {
      Alert("Tipo de posicao nao está vindo, vou morrer agora");
    }
  }
  double sl = valor - (StopLoss_Op * (Tipo_Posicao_ * Tick_Size));
  if(funcao == 1) sl = this.Valor_Negocio();
  double tp1 = valor + (TakeProfit_op * (Tipo_Posicao_ * Tick_Size));
  double tp2 = valor + (TakeProfit2_op * (Tipo_Posicao_ * Tick_Size));
  double tp3 = valor + (TakeProfit3_op * (Tipo_Posicao_ * Tick_Size)); //Tem que arrumar depois
  // double tp3 = 0; //Tem que arrumar depois
  double tpMax = tp3;

  //Isso aqui é para colocar os TPs no alto, mas, obvio, tá dando errado.
  if(TakeProfit3_op == 0 && TakeProfit2 == 0)   // Nesse caso só tem TP1
  {
    tp3 = tp1 + (1000 * Tick_Size * Tipo_Posicao_);
    tpMax = tp1;
  }

  if(TakeProfit3_op == 0 && TakeProfit2 != 0) //Nesse caso tem TP2, mas não TP3
  {
    tp3 = tp2 + (1000 * Tick_Size * Tipo_Posicao_);
    tpMax = tp2;
  }

  // Print("StopLoss Fixo: " + DoubleToString(sl)); //DEBUG

  if(Aleta_Operacao && !Otimizacao)
  {
    string alerta_op = "sl: " + DoubleToString(sl);
    alerta_op += " | TP1: ";
    alerta_op += DoubleToString(tp1);
    alerta_op += " | TP2: ";
    alerta_op += DoubleToString(tp2);
    alerta_op += " | TP3: ";
    alerta_op += DoubleToString(tp3);
    Alert(alerta_op);
  }

  bool Result_Modify = tradionices.PositionModify(posicao_stops.TicketPosicao(),sl,tpMax);
  int cont_i = 0;

  if(!Result_Modify  && tradionices.ResultRetcode() == 10016) //Santa Gambiarra Batman!
  {
    do
    {
      sl = sl - Tick_Size;
      tpMax = tpMax + Tick_Size;
      Print("Erro modificando Stops, vamos mudar um poquinho os stops (um Tick_Size a mais para cada)! ln 304");
      Result_Modify = tradionices.PositionModify(posicao_stops.TicketPosicao(),sl,tpMax);
      cont_i++;
      Sleep(1000);
    }
    while(!Result_Modify && cont_i < 2);
  }

  if(!Result_Modify)
  {
    Print("Erro modificando Stops, solenemente, deixo esta memoria para entrar para a Historia! ln 313");
    tradionices.PositionClose(posicao_stops.TicketPosicao());
  }

  if(funcao == 0) TakeProfit_Calcula();

  delete(tradionices);
}

void Stops::TS_()
{
  CPositionInfo *posiciones = new CPositionInfo;
  posiciones.SelectByMagic(Symbol(),TimeMagic);

  MqlRates rates[];
  int copiou = CopyRates(Symbol(),TimeFrame,posiciones.Time(),TimeCurrent(),rates);
  ArraySetAsSeries(rates,true);

  double rates_maior[];
  double rates_menor[];

  ArrayResize(rates_maior,ArraySize(rates));
  ArrayResize(rates_menor,ArraySize(rates));

  for(int i = 0; i < ArraySize(rates); i++) rates_maior[i] = rates[i].high;
  for(int i = 0; i < ArraySize(rates); i++) rates_menor[i] = rates[i].low;

if(ArraySize(rates) > 0)  //As vezes tava dando out of range
{
  double maior_valor = rates_maior[ArrayMaximum(rates_maior)];
  double menor_valor = rates_menor[ArrayMinimum(rates_menor)];

  double numerico_Trailing_Stop = Trailing_stop * Tick_Size;
  double numerico_inicio_TS = Trailing_stop_start * Tick_Size;
  double pos_sl = posiciones.StopLoss();
  double pos_tp = posiciones.TakeProfit();
  double pos_vlr = this.Valor_Negocio();
  double valor_TS_compra = maior_valor - numerico_Trailing_Stop;
  double valor_TS_venda = menor_valor + numerico_Trailing_Stop;

  if(Trailing_stop != 0 &&
    this.Tipo_Posicao() > 0 &&
    maior_valor > (pos_vlr + numerico_Trailing_Stop + numerico_inicio_TS) &&
    pos_sl != valor_TS_compra)
  {
    CTrade *tradionices = new CTrade;
    tradionices.PositionModify(posicao_stops.TicketPosicao(),valor_TS_compra,pos_tp);

    delete tradionices;
  }

  if(Trailing_stop != 0 &&
    this.Tipo_Posicao() < 0 &&
    menor_valor < (pos_vlr - numerico_Trailing_Stop - numerico_inicio_TS) &&
    pos_sl != valor_TS_venda)
  {
    CTrade *tradionices = new CTrade;
    tradionices.PositionModify(posicao_stops.TicketPosicao(),valor_TS_venda,pos_tp);

    delete tradionices;
  }


  // Print("maior_valor " + maior_valor); //DEBUG
  // Print("pos_vlr " + (pos_vlr)); //DEBUG
  // Print("pos_vlr + numerico_Trailing_Stop + numerico_inicio_TS " + (pos_vlr + numerico_Trailing_Stop + numerico_inicio_TS)); //DEBUG
  // Print("rates_maior " + rates_menor[ArrayMinimum(rates_menor)]); //DEBUG
  // Print(posiciones.Time());

  delete posiciones;
}
}

double Stops::Valor_Negocio()
{
  CPositionInfo *posiciones = new CPositionInfo;

  posiciones.SelectByMagic(Symbol(),TimeMagic);
  double valor = posiciones.PriceOpen();
  // Print("Valor da Valor_Negocio() antes do IF: " + DoubleToString(valor));

  if(valor == 0 || valor == NULL) valor = daotick_geral;

  // Print("Valor da Valor_Negocio() depois do IF: " + DoubleToString(valor));

  delete(posiciones);
  return valor;
}

double Stops::Valor_SL()
{
  double retorno = 0;
  CPositionInfo *posiciones = new CPositionInfo;

  posiciones.SelectByMagic(Symbol(),TimeMagic);
  retorno = MathAbs(this.Valor_Negocio() - posiciones.StopLoss()) / Tick_Size;


  delete(posiciones);
  return retorno;
}

Stops O_Stops;
posicao posicao_stops;
