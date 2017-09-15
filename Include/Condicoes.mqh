/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class Condicoes_Basicas_OO
{
  public:
  bool Condicao();
  bool Horario();

  private:
  bool Banda_Permite();
  bool Operacao_Em_Curso();


};

bool Condicoes_Basicas_OO::Horario()
{
  string DiaHoraInicio;
  string DiaHoraFim;
  bool RetornoHorario =false;

  Agora = TimeCurrent();

  DiaHoje = TimeToString(TimeCurrent(),TIME_DATE);

  DiaHoraInicio = DiaHoje + " " + HorarioInicio;
  DiaHoraFim = DiaHoje + " " + HorarioFim;

  // Se Agora > String Dia + String Hora OK.
  //   Print("DiaHoje ",DiaHoje);
  if(Agora>=StringToTime(DiaHoraInicio) && Agora<=StringToTime(DiaHoraFim))
  {

      RetornoHorario = true;
  }
  return(RetornoHorario);
}

bool Condicoes_Basicas_OO::Operacao_Em_Curso()
{
  if(O_Stops.Tipo_Posicao() == 0) return false;
  else return true;
}

bool  Condicoes_Basicas_OO::Banda_Permite()
{
  bool retorno = false;
  double delta = 0;
  double delta_media_candle = 0;

  BB *Banda = new BB;

  //Pega O historico
  MqlRates rates[];
  ArraySetAsSeries(rates,true);
  int copied=CopyRates(Symbol(),0,0,200,rates);
  // delta_media_candle = (((rates[1].high + rates[2].high + rates[3].high) / 3 ) - ((rates[1].low + rates[2].low + rates[3].low) / 3 )/Tick_Size);
  delta_media_candle = (rates[1].high - rates[1].low);

  delta = (Banda.BB_Delta_Bruto()/delta_media_candle) * 100 ;

  // Print("delta: " + delta);

  if(delta > Limite_Minimo_Tick_Size && delta < Limite_Maximo_Tick_Size) retorno = true;

  delete(Banda);
  return retorno;
}

bool Condicoes_Basicas_OO::Condicao()
{
  if(!Operacao_Em_Curso() && Horario() && Banda_Permite()) return true;
  else return false;
}



Condicoes_Basicas_OO Condicoes_Basicas;
