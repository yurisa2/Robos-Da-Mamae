/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class Stops
{
  public:
  // Stops();
  // ~Stops() {};
  int Tipo_Posicao();
  void No_Tick();
  void Setar_Ordens_Vars_Static();
  void Setar_Ordens_Vars_Proporcional();
  double Valor_Negocio();
  void TS_();
  double Distribuidor_Parcial(int Seletor_Volume);
  void TakeProfit_Calcula();

  protected:
};

int Stops::Tipo_Posicao()
{
  CPositionInfo *posiciones = new CPositionInfo;

  if(!posiciones.Select(Symbol()))
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
}

double Stops::Distribuidor_Parcial(int Seletor_Volume)
{
  double retorno = 1;
  double TPLs = 0;

  if(TakeProfit > 0 && TakeProfit_Volume > 0 ) TPLs++;
  if(TakeProfit2 > 0 && TakeProfit_Volume2 > 0 ) TPLs++;
  if(TakeProfit3 > 0 && TakeProfit_Volume3 > 0 ) TPLs++;

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
  if(Tipo_Limite == 471)
  {
    BB *Banda_BB = new BB();
    //delta_bb = Banda_BB.BB_High(0) - Banda_BB.BB_Low(0);  //Antigo
    delta_bb = Banda_BB.BB_Delta_Bruto(0);
    delete(Banda_BB);
  }

  if(Tipo_Limite == 55) delta_bb = 1;
  //FIM DA DEFINICAO MULTIPLICADOR DA BANDA

  //Aqui da pau no proporcional pq nao se acerta com o Tick Size, o certo é pegar o valor d
  //do negócio, deixar o TPC em tick size e

  //Print("delta_bb: " + delta_bb);  //DEBUG

  tpc1 = (TakeProfit * delta_bb);
  tpc1 = MathFloor(tpc1) * Tick_Size;
  //Print("MathFloor(tpc1) * Tick_Size: " + tpc1); //DEBUG
  tpc1 = valor + (tpc1 * (Tipo_Posicao()));
  //Print("TPC1: " + tpc1); //DEBUG
  //Print("TickSize: " + Tick_Size); //DEBUG


  tpc2 = (TakeProfit2 * delta_bb);
  tpc2 = MathFloor(tpc2) * Tick_Size;
  tpc2 = valor + (tpc2 * (Tipo_Posicao()));
  //Print("TPC2: " + tpc2); //DEBUG

  tpc3 = (TakeProfit3 * delta_bb);
  tpc3 = MathFloor(tpc3) * Tick_Size;
  tpc3 = valor + (tpc3 * (Tipo_Posicao()));
  //Print("TPC3: " + tpc3); //DEBUG

  if(Tipo_Posicao() > 0) Tipo_Ordem_TP = ORDER_TYPE_SELL_LIMIT;
  if(Tipo_Posicao() < 0) Tipo_Ordem_TP = ORDER_TYPE_BUY_LIMIT;

  CTrade *tradionices = new CTrade;
  // Inicio das ordens efetivas
  if(Distribuidor_Parcial(0) == 1)
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
      dtHoje
    );

  }
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
      dtHoje
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
      dtHoje
    );
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
      dtHoje
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
      dtHoje
    );

    tradionices.OrderOpen(
      Symbol(),
      Tipo_Ordem_TP,
      Distribuidor_Parcial(3),
      0,
      tpc3,
      0,
      0,
      ORDER_TIME_DAY,
      dtHoje
    );
    delete(tradionices);
  }
  //Fim das ordens efetivas


}

void Stops::Setar_Ordens_Vars_Static()
{
  CTrade *tradionices = new CTrade;
  double valor = Valor_Negocio();
  int Tipo_Posicao_ = Tipo_Posicao();
  int loopes = 0;

  if(Tipo_Posicao_ == 0 && loopes <= 5) {
    Sleep(400);
    Tipo_Posicao_ = Tipo_Posicao();
    loopes++;
  }

  double sl = valor - (StopLoss * (Tipo_Posicao_ * Tick_Size));
  double tp1 = valor + (TakeProfit * (Tipo_Posicao_ * Tick_Size));
  double tp2 = valor + (TakeProfit2 * (Tipo_Posicao_ * Tick_Size));
  double tp3 = valor + (TakeProfit3 * (Tipo_Posicao_ * Tick_Size)); //Tem que arrumar depois
  // double tp3 = 0; //Tem que arrumar depois

  if(TakeProfit3 == 0 && TakeProfit2 == 0) tp3 = tp1 + (2 * Tick_Size * Tipo_Posicao_);
  if(TakeProfit3 == 0 && TakeProfit2 != 0) tp3 = tp2 + (2 * Tick_Size * Tipo_Posicao_);


  Print("StopLoss Fixo: " + DoubleToString(sl)); //DEBUG

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

  tradionices.PositionModify(Symbol(),sl,tp3);

  TakeProfit_Calcula();

  delete(tradionices);
}

void Stops::Setar_Ordens_Vars_Proporcional()
{
  CTrade *tradionices = new CTrade;
  double valor = Valor_Negocio();
  double delta_bb = 0;
  double StopLoss_Proporcional = 0;
  double tp = 0;

  BB *Banda_BB = new BB();
  //delta_bb = Banda_BB.BB_High(0) - Banda_BB.BB_Low(0);  //Antigo
  delta_bb = Banda_BB.BB_Delta_Bruto(0);
  delete(Banda_BB);

  //Print("delta_bb: " + delta_bb); //DEBUG
  int loopes = 0;

  if( Tipo_Posicao() == 0 && loopes <= 5) {
    Sleep(400);
    loopes++;
  }

  StopLoss_Proporcional = (StopLoss * delta_bb); //Aqui Ja Sai em Tick_Size
  //Print("StopLoss_Proporcional: " + StopLoss_Proporcional + " Ticks"); //DEBUG
  StopLoss_Proporcional = MathFloor(StopLoss_Proporcional) * Tick_Size;
  //Print("StopLoss_Proporcional MathFloor * Tick_Size: " + StopLoss_Proporcional); //DEBUG

  double sl_max = Limite_Maximo_SL_Tick_Size * Tick_Size;   //Pontos máximo

  StopLoss_Proporcional = MathMin(StopLoss_Proporcional, sl_max);

  if(TakeProfit == 0) tp = valor + Tipo_Posicao() * Tick_Size * 100;

  double sl = valor - (StopLoss_Proporcional * (Tipo_Posicao()));



  //Print("Delta BB: " + DoubleToString(delta_bb)); //DEBUG
  //Print("StopLoss Prop: " + DoubleToString(sl)); //DEBUG

  tradionices.PositionModify(Symbol(),sl,tp);
  TakeProfit_Calcula();

  delete(tradionices);
}

void Stops::TS_()
{
  CTrade *tradionices = new CTrade;
  double valor = Valor_Negocio();

  if(Tipo_Posicao() > 0 && daotick_geral > (valor + (Tick_Size * (Trailing_stop + Trailing_stop_start))))
  {
    double tp = valor + (TakeProfit * Tick_Size);
    double sl = valor - ((Tick_Size * (Trailing_stop + Trailing_stop_start)));

    if(TakeProfit == 0) tp = valor + (Tick_Size * 10); //Sério mano, apelando, APELANDO MONSTRO

    Print("TRAILING STOP COMPRA");

    tradionices.PositionModify(Symbol(),sl,tp);
  }
  //VERIFICAR JEITO MAIS INTELIGENTE DE FAZER AS ORDENS (TIPO USANDO Tipo_Posicao

  if(Tipo_Posicao() < 0 && daotick_geral < (valor - (Tick_Size * (Trailing_stop + Trailing_stop_start))))
  {
    double tp = valor - (TakeProfit * Tick_Size);
    double sl = valor + ((Tick_Size * (Trailing_stop + Trailing_stop_start)));

    if(TakeProfit == 0) tp = valor - (Tick_Size * 50); //Sério mano, apelando, APELANDO MONSTRO

    // Print("TRAILING STOP SL: " + sl + " TP: " + tp + " Tipo_Posicao(): " + Tipo_Posicao() + " Valor do Do Negocio: " + valor);

    tradionices.PositionModify(Symbol(),sl,tp);
  }
  delete(tradionices);
}

double Stops::Valor_Negocio()
{
  CPositionInfo *posiciones = new CPositionInfo;

  posiciones.Select(Symbol());
  double valor = posiciones.PriceOpen();
  // Print("Valor da Valor_Negocio() antes do IF: " + DoubleToString(valor));

  if(valor == 0 || valor == NULL) valor = daotick_geral;

  // Print("Valor da Valor_Negocio() depois do IF: " + DoubleToString(valor));

  delete(posiciones);
  return valor;
}

Stops O_Stops;
