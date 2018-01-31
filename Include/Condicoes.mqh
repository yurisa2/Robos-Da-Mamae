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
  bool Operacao_Em_Curso();

  private:
  bool Banda_Permite();
  bool Banda_Bruta_Permite();
  bool Volume_Permite();


};

bool Condicoes_Basicas_OO::Horario()
{
  string DiaHoraInicio;
  string DiaHoraFim;

  Agora = TimeCurrent();

  DiaHoje = TimeToString(TimeCurrent(),TIME_DATE);

  DiaHoraInicio = DiaHoje + " " + HorarioInicio;
  DiaHoraFim = DiaHoje + " " + HorarioFim;

  // Se Agora > String Dia + String Hora OK.
  //   Print("DiaHoje ",DiaHoje);
  if(Agora>=StringToTime(DiaHoraInicio) && Agora<=StringToTime(DiaHoraFim))
  {

      return true;
  }
  else return false;

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
  int copied=CopyRates(Symbol(),TimeFrame,0,200,rates);
  // delta_media_candle = (((rates[1].high + rates[2].high + rates[3].high) / 3 ) - ((rates[1].low + rates[2].low + rates[3].low) / 3 )/Tick_Size);
  delta_media_candle = (rates[1].high - rates[1].low);

  if(delta_media_candle == 0) delta_media_candle = 0.0000001;

  delta = (Banda.BB_Delta_Bruto()/delta_media_candle) * 100 ;

  //Print("Delta do Permite: " + DoubleToString(delta)); //DEBUG

  if(delta > Limite_Minimo_Tick_Size && delta < Limite_Maximo_Tick_Size) retorno = true;

  delete(Banda);
  return retorno;
}

bool Condicoes_Basicas_OO::Condicao()
{
  if(!Operacao_Em_Curso() && Horario() && Banda_Permite() && Volume_Permite() && Banda_Bruta_Permite()) return true;
  else return false;
}

bool  Condicoes_Basicas_OO::Volume_Permite()
{
  bool retorno = true;

  Volumes *Volumes_OO = new Volumes(NULL,TimeFrame);
  double Volume_FW = Volumes_OO.Valor(1) ;

  if(Volume_FW < Limite_Volume_Min || Volume_FW > Limite_Volume_Max) retorno = false;
  else retorno =  true;

  // if(retorno) Print("Volume_Permite() - ok"); //DEBUG


  delete(Volumes_OO);
  return retorno;
}

bool  Condicoes_Basicas_OO::Banda_Bruta_Permite()
{
  bool retorno = false;

  BB *Banda = new BB;

  if(Banda.BB_Delta_Bruto() < Limite_BB_Bruta_Min || Limite_BB_Bruta_Min > Limite_BB_Bruta_Max) retorno =  false;
  else retorno =  true;
  delete(Banda);

  // if(retorno) Print("Banda_Bruta_Permite() - ok"); //DEBUG

  return retorno;
}

Condicoes_Basicas_OO Condicoes_Basicas;
