/* -*- C++ -*- */

class Xus
{

  public:
  void Xus_Comentario();
  void Avalia();
  int xus_diff();
  double xus_close_yest();
  double xus_open_tod();
  static double fire_event();
  double vendetta_mode(CDealInfo &myDealInfo);

};


void Xus::Xus_Comentario()
{

}

void Xus::Avalia()
{
  int dir = 0;

  double Ativacao_superior = this.xus_close_yest() + (xus_delta_ativacao * Tick_Size);
  double Ativacao_inferior = this.xus_open_tod() - (xus_delta_ativacao * Tick_Size);

  if(this.xus_diff() > 0 &&
     this.xus_open_tod() > Ativacao_superior &&
     PrecoAtual().close <= Ativacao_superior &&
      Condicoes_Basicas.Condicao()) {
        Opera_Mercado *opera = new Opera_Mercado;
        opera.AbrePosicao(1,"Ativacao_superior: " + DoubleToString(Ativacao_superior,Digits()));
        delete(opera);
      }

  if(this.xus_diff() > 0 &&
     this.xus_open_tod() < Ativacao_superior &&
     PrecoAtual().close >= Ativacao_superior &&
      Condicoes_Basicas.Condicao()) {
        Opera_Mercado *opera = new Opera_Mercado;
        opera.AbrePosicao(1,"Ativacao_superior: " + DoubleToString(Ativacao_superior,Digits()));
        delete(opera);
      }


  if(this.xus_diff() < 0 &&
     this.xus_open_tod() < Ativacao_inferior &&
     PrecoAtual().close >= Ativacao_inferior &&
     Condicoes_Basicas.Condicao()) {
       Opera_Mercado *opera = new Opera_Mercado;
       opera.AbrePosicao(-1,"Ativacao_inferior: " + DoubleToString(Ativacao_inferior,Digits()));
       delete(opera);
     }
  if(this.xus_diff() < 0 &&
     this.xus_open_tod() > Ativacao_inferior &&
     PrecoAtual().close <= Ativacao_inferior &&
      Condicoes_Basicas.Condicao()) {
        Opera_Mercado *opera = new Opera_Mercado;
        opera.AbrePosicao(-1,"Ativacao_inferior: " + DoubleToString(Ativacao_inferior,Digits()));
        delete(opera);
      }
}

int Xus::xus_diff()
{
  MqlRates BarData[];
  ArraySetAsSeries(BarData,true);

  int copiado = CopyRates(Symbol(), PERIOD_D1, 0, 3, BarData); // Copy the data of last incomplete BAR

  int delta = ((BarData[1].close - BarData[0].open)/Tick_Size);

  // Print("Delta: " + delta); // DEBUG

  return delta;
}

double Xus::xus_close_yest()
{
  MqlRates BarData[];
  ArraySetAsSeries(BarData,true);

  int copiado = CopyRates(Symbol(), PERIOD_D1, 0, 3, BarData); // Copy the data of last incomplete BAR

  return BarData[1].close;
}

double Xus::xus_open_tod()
{
  MqlRates BarData[];
  ArraySetAsSeries(BarData,true);

  int copiado = CopyRates(Symbol(), PERIOD_D1, 0, 3, BarData); // Copy the data of last incomplete BAR

  return BarData[0].open;
}

static double Xus::fire_event()
{
  string time_now_full = TimeToString(TimeCurrent(),TIME_DATE|TIME_SECONDS);
  string time_now_date = TimeToString(TimeCurrent(),TIME_DATE); // YYYY.MM.DD
  string time_now_secs = TimeToString(TimeCurrent(),TIME_SECONDS); // 00:00:00

  string hora_isolada = StringSubstr(time_now_secs,0,2);
  string minuto_isolado = StringSubstr(time_now_secs,3,2);
  string dia_isolado = StringSubstr(time_now_date,9,2);

  if(StringToInteger(hora_isolada) == HoraDeInicio &&
     StringToInteger(minuto_isolado) == MinutoDeInicio  &&
     StringToInteger(dia_isolado) != last_day_integer
    )  {
        Print(time_now_full);
        last_day_integer = dia_isolado;
      }
return StringToDouble(time_now_full);
}

double Xus::vendetta_mode(CDealInfo &myDealInfo)
{
  Print(myDealInfo.Profit());

   int nova_direcao = 0;
   if(myDealInfo.DealType() == DEAL_TYPE_BUY) nova_direcao = 1;
   if(myDealInfo.DealType() == DEAL_TYPE_SELL) nova_direcao = -1;

   if(myDealInfo.Profit() < 0 && Condicoes_Basicas.Condicao())  {
     Opera_Mercado *opera = new Opera_Mercado;
     opera.novo_volume = xus_valor_vendetta;
     opera.AbrePosicao(nova_direcao,"VENDETTA MODE ON: ");
     delete(opera);
   }


return 0;
}
