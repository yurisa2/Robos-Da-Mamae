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
  double retorno = -1;

  int Niveis_Preenchidos = 0;
  int Niveis_Por_Steps = 0;
  int Niveis_Calculados = 0;



  int TP1_Steps = 0;
  int TP2_Steps = 0;
  int TP3_Steps = 0;

  double Steps_por_TPL = 0;

  if(Volume_Step == 0) Volume_Step = 1;


  double Lotes_Steps = MathFloor(Lotes / Volume_Step);

  if(Lotes_Steps < 0)
  {
    Alert("Volume abaixo do Volume step (Minimo para operar) ");
    ExpertRemove();
  }

  Print("Lotes_Steps: " + Lotes_Steps); //DEBUG

  //Seletor_Volume = 0 - Retorna Quantos Niveis de STOP 1,2 ou 3
  //Seletor_Volume = 1..3 - Retorna o VOLUME do nivel 1..3 de STOP

  if(TakeProfit > 0) Niveis_Preenchidos = 1;
  if(TakeProfit2 > 0) Niveis_Preenchidos = 2;
  if(TakeProfit3 > 0) Niveis_Preenchidos = 3;

  //Print("Niveis_Preenchidos: " + Niveis_Preenchidos); //DEBUG

  Steps_por_TPL = (Lotes_Steps / Niveis_Preenchidos);  //Isso aqui retorna quantos Steps por Nível (Divisao Simples)
  Print("Steps_por_TPL: " + Steps_por_TPL); //DEBUG

  int Sobra_Lotes_Niveis = Lotes_Steps % Niveis_Preenchidos;

  if(Sobra_Lotes_Niveis == 1 && Steps_por_TPL < 1) Niveis_Por_Steps = 1;
  if(Sobra_Lotes_Niveis == 2 && Steps_por_TPL < 1) Niveis_Por_Steps = 2;

  if(Sobra_Lotes_Niveis == 1 && Steps_por_TPL > 1) Niveis_Por_Steps = 1 + MathFloor(Steps_por_TPL);
  if(Sobra_Lotes_Niveis == 2 && Steps_por_TPL > 1) Niveis_Por_Steps = 2 + MathFloor(Steps_por_TPL);


  //orrigir o volume (Acho que é VOLUME_STEPS * VOlume_Step)

  return retorno;
}

// double Stops::Distribuidor_Parcial(int Seletor_Volume)
// {
//   int Num_Stops_Configurados = 0;
//   double vol_tp1 = 1;
//   double vol_tp2 = 0;
//   double vol_tp3 = 0;
//   double div_bruta = 0;
//   double mod_bruto = 0;
//   double inteiro = 0;
//   double retorno = NULL;
//
//   if(TakeProfit > 0) Num_Stops_Configurados = 1;
//   if(TakeProfit2 > 0 ) Num_Stops_Configurados = 2;
//   if(TakeProfit3 > 0) Num_Stops_Configurados = 3;
//   // Print("Num_Stops_Configurados: " + DoubleToString(Num_Stops_Configurados)); //DEBUG
//
//   div_bruta = Lotes / Num_Stops_Configurados;
//
//   mod_bruto = MathMod(Lotes,Num_Stops_Configurados);
//   inteiro = MathFloor(div_bruta);
//
//   Print("Stops_OO Inteiro: " + DoubleToString(inteiro)); //DEBUG
//
//   if(inteiro > 1) vol_tp1 = inteiro;
//   vol_tp2 = inteiro;
//   vol_tp3 = inteiro;
//
//   if(mod_bruto == 1) vol_tp1++;
//   if(mod_bruto == 2)
//   {
//   vol_tp1++;
//   vol_tp2++;
//   }
//
//   if(Seletor_Volume == 0)
//   {
//   if(vol_tp3 > 0) retorno = 3;
//   if(vol_tp3 == 0) retorno = 2;
//   if(vol_tp2 == 0) retorno = 1;
//   // Print("Num Stops: " + DoubleToString(retorno)); //DEBUG
//   }
//
//   if(Seletor_Volume == 1) retorno = vol_tp1;
//   if(Seletor_Volume == 2) retorno = vol_tp2;
//   if(Seletor_Volume == 3) retorno = vol_tp3;
//
//   return retorno;
// }

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


  tpc1 = (TakeProfit * delta_bb)/Tick_Size;
  tpc1 = MathFloor(tpc1) * Tick_Size;
  tpc1 = valor + (tpc1 * (Tipo_Posicao() * Tick_Size));

  tpc2 = (TakeProfit2 * delta_bb)/Tick_Size;
  tpc2 = MathFloor(tpc2) * Tick_Size;
  tpc2 = valor + (tpc2 * (Tipo_Posicao() * Tick_Size));

  tpc3 = (TakeProfit3 * delta_bb)/Tick_Size;
  tpc3 = MathFloor(tpc3) * Tick_Size;
  tpc3 = valor + (tpc3 * (Tipo_Posicao() * Tick_Size));

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
  double sl = valor - (StopLoss * (Tipo_Posicao() * Tick_Size));
  double tp1 = valor + (TakeProfit * (Tipo_Posicao() * Tick_Size));
  double tp2 = valor + (TakeProfit2 * (Tipo_Posicao() * Tick_Size));
  //double tp3 = valor + (TakeProfit3 * (Tipo_Posicao() * Tick_Size) *100); //Tem que arrumar depois
  double tp3 = 0; //Tem que arrumar depois

  // if(TakeProfit == 0) tp3 = valor + Tipo_Posicao() * Tick_Size * 100;


  //Print("StopLoss Fixo: " + DoubleToString(sl) + " | " + "StopLoss Fixo: " + DoubleToString(sl)); //DEBUG

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


  StopLoss_Proporcional = (StopLoss * delta_bb); //Aqui Ja Sai em Tick_Size
  //Print("StopLoss_Proporcional: " + StopLoss_Proporcional + " Ticks"); //DEBUG
  StopLoss_Proporcional = MathFloor(StopLoss_Proporcional) * Tick_Size;
  //Print("StopLoss_Proporcional MathFloor * Tick_Size: " + StopLoss_Proporcional); //DEBUG

  if(TakeProfit == 0) tp = valor + Tipo_Posicao() * Tick_Size * 100;

  double sl = valor - (StopLoss_Proporcional * (Tipo_Posicao()));

  Print("Delta BB: " + DoubleToString(delta_bb)); //DEBUG
  Print("StopLoss Prop: " + DoubleToString(sl)); //DEBUG

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

  delete(posiciones);
  return valor;
}

Stops O_Stops;
