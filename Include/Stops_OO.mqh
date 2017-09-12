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
  double Valor_Negocio();
  void TS();

  protected:
  void Atuador_Stops();
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
  if(!Usar_Posicoes) Atuador_Stops();
  if(Usar_Posicoes) O_Stops.TS();
}

void Stops::Setar_Ordens_Vars_Static()
{
  CTrade *tradionices = new CTrade;
  double valor = Valor_Negocio();
  double sl = valor - (StopLoss * (Tipo_Posicao() * Tick_Size));
  double tp = valor + (TakeProfit * (Tipo_Posicao() * Tick_Size));

  tradionices.PositionModify(Symbol(),sl,tp);

  delete(tradionices);
}

void Stops::TS()
{
  CTrade *tradionices = new CTrade;
  double valor = Valor_Negocio();

  if(Tipo_Posicao() > 0 && daotick_geral > valor + (Tick_Size * (Trailing_stop + Trailing_stop_start)))
  {
    double tp = valor + (TakeProfit * (Tipo_Posicao() * Tick_Size));
    double sl = valor + (valor + (Tick_Size * (Trailing_stop + Trailing_stop_start)));

    tradionices.PositionModify(Symbol(),sl,tp);
  }
  delete(tradionices);
}


void Stops::Atuador_Stops()
{
  if(Usa_Fixos == true)
  {
    if(Trailing_stop > 0) TS();
    if(RAW_MoverSL > 0) SLMovel();
  }

  if(Usa_Prop == true)
  {
    if(Prop_Trailing_stop > 0) Prop_TS();
    if(Prop_MoverSL > 0) Prop_SLMovel();
  }

  if(Prop_StopLoss > 0 || StopLoss > 0) StopLossCompra();
  if(Prop_StopLoss > 0 || StopLoss > 0) StopLossVenda();
  if(TakeProfit > 0 || Prop_TakeProfit > 0) TakeProfitCompra();
  if(TakeProfit > 0 || Prop_TakeProfit > 0) TakeProfitVenda();
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
