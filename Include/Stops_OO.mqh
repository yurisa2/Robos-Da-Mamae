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
  double tp = valor + (TakeProfit * (Tipo_Posicao() * Tick_Size));

  if(TakeProfit == 0) tp = valor + Tipo_Posicao() * Tick_Size * 100;

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

    Print("TRAILING STOP SL: " + sl + " TP: " + tp + " Tipo_Posicao(): " + Tipo_Posicao() + " Valor do Do Negocio: " + valor);

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
