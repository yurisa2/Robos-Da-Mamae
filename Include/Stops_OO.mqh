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

void Stops::Setar_Ordens_Vars_Static()
{
  CTrade *tradionices = new CTrade;
  double valor = Valor_Negocio();
  double sl = valor - (StopLoss * (Tipo_Posicao() * Tick_Size));
  double tp1 = valor + (TakeProfit * (Tipo_Posicao() * Tick_Size));
  double tp2 = valor + (TakeProfit2 * (Tipo_Posicao() * Tick_Size));
  double tp3 = valor + (TakeProfit3 * (Tipo_Posicao() * Tick_Size));

  if(TakeProfit == 0) tp3 = valor + Tipo_Posicao() * Tick_Size * 100;


  string DiaHojeStop = TimeToString(TimeCurrent(),TIME_DATE) + " 23:59";

  datetime dtHoje;
  dtHoje = StringToTime(DiaHojeStop);

  Print("Data: " + dtHoje);

  //TP1
  tradionices.OrderOpen(Symbol(),ORDER_TYPE_SELL_LIMIT,1,0,tp1,0,0,ORDER_TIME_DAY,dtHoje); //Hard Coded
  tradionices.OrderOpen(Symbol(),ORDER_TYPE_SELL_LIMIT,1,0,tp2,0,0,ORDER_TIME_DAY,dtHoje); //Hard Coded



  Print("StopLoss Fixo: " + DoubleToString(sl) + " | " + "StopLoss Fixo: " + DoubleToString(sl)); //DEBUG

  tradionices.PositionModify(Symbol(),sl,tp3);




  delete(tradionices);
}

void Stops::Setar_Ordens_Vars_Proporcional()
{
  CTrade *tradionices = new CTrade;
  double valor = Valor_Negocio();
  double delta_bb = 0;
  double StopLoss_Proporcional = 0;
  double TakeProfit_Proporcional = 0;

  BB *Banda_BB = new BB();
  delta_bb = Banda_BB.BB_High(0) - Banda_BB.BB_Low(0);
  delete(Banda_BB);

  StopLoss_Proporcional = StopLoss * delta_bb;
  TakeProfit_Proporcional = TakeProfit * delta_bb;

  double sl = MathRound(valor - (StopLoss_Proporcional * (Tipo_Posicao())));
  double tp = MathRound(valor + (TakeProfit_Proporcional * (Tipo_Posicao())));

  if(TakeProfit == 0) tp = valor + Tipo_Posicao() * Tick_Size * 100;
  if(TakeProfit > 0) tp = valor + Tipo_Posicao() * Tick_Size * 100;
  if(TakeProfit > 0) tp = valor + Tipo_Posicao() * Tick_Size * 100;

  Print("Delta BB: " + DoubleToString(delta_bb)); //DEBUG
  Print("StopLoss Prop: " + DoubleToString(sl) + " | " + "TakeProfit Prop: " + DoubleToString(tp)); //DEBUG


  tradionices.PositionModify(Symbol(),sl,tp);

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

  delete(posiciones);
  return valor;
}

Stops O_Stops;
