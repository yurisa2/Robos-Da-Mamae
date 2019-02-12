/* -*- C++ -*- */

class Bender
{
  public:
  Bender();
  void Comentario();
  void Avalia();
  double Distancia();
  void Max_Min(double &min_dia,double &max_dia);
  int Micro_tendencia();
  void Max_Min_diario(double &min_dia,double &max_dia);

  private:

};

void Bender::Bender()
{


}

void Bender::Comentario()
{
  if(Tipo_Comentario > 0)
  {
    Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;
    bool Condicao = Condicoes.Condicao();
  }
}

void Bender::Max_Min(double &min_dia,double &max_dia)
{

  string bender_horario_inicio_hora_ = IntegerToString(bender_horario_inicio_hora);
  string bender_horario_inicio_minuto_ = IntegerToString(bender_horario_inicio_minuto);
  string bender_horario_fim_hora_ = IntegerToString(bender_horario_fim_hora);
  string bender_horario_fim_minuto_ = IntegerToString(bender_horario_fim_minuto);


  datetime Data_Inicio_hoje = StringToTime(TimeToString(TimeCurrent(),TIME_DATE)+" "+bender_horario_inicio_hora_+":"+bender_horario_inicio_minuto_);
  datetime Data_Fim_hoje = StringToTime(TimeToString(TimeCurrent(),TIME_DATE)+" "+bender_horario_fim_hora_+":"+bender_horario_fim_minuto_);
  // Print("Data_Inicio_hoje " + Data_Inicio_hoje);
  // Print("Data_Fim_hoje " + Data_Fim_hoje);
  // Print(Symbol());

  MqlRates rates[];
  // ArraySetAsSeries(rates,false);
  // int copied=CopyRates(Symbol(),PERIOD_M1,Data_Fim_hoje,bender_minutos_a_tras,rates);
  // int copied=CopyRates(Symbol(),PERIOD_M1,Data_Fim_hoje,bender_minutos_a_tras,rates);
  int copied=CopyRates(Symbol(),PERIOD_H1,Data_Inicio_hoje,1,rates);

  // int metade = int(MathRound(bender_minutos_a_tras/2));

  double minimos[];
  double maximos[];
  ArrayResize(maximos,copied);
  ArrayResize(minimos,copied);
  // ArrayInitialize(maximos,rates[metade].close);
  // ArrayInitialize(minimos,rates[metade].close);


  for(int i=0;i<copied;i++)
  {
    if(TimeToString(TimeCurrent(),TIME_DATE) == TimeToString(rates[i].time,TIME_DATE)) maximos[i] = rates[i].high;
    if(TimeToString(TimeCurrent(),TIME_DATE) == TimeToString(rates[i].time,TIME_DATE)) minimos[i] = rates[i].low;
  }

  // Print("copied " + copied);

  int Max = ArrayMaximum(maximos);
  int Min = ArrayMinimum(minimos);

  min_dia = minimos[Min];
  max_dia = maximos[Max];
}

void Bender::Max_Min_diario(double &min_dia,double &max_dia)
{
  MqlRates rates[];
  ArraySetAsSeries(rates,false);
  // int copied=CopyRates(Symbol(),PERIOD_M1,Data_Fim_hoje,bender_minutos_a_tras,rates);
  int copied=CopyRates(Symbol(),PERIOD_M1,0,500,rates);
  // int copied=CopyRates(Symbol(),PERIOD_M1,Data_Inicio_hoje,Data_Fim_hoje,rates);


  double minimos[];
  double maximos[];
  // ArrayResize(maximos,copied);
  // ArrayResize(minimos,copied);
  // ArrayInitialize(maximos,rates[0].close);
  // ArrayInitialize(minimos,rates[0].close);


  for(int i=0;i<copied;i++)
  {
    if(TimeToString(TimeCurrent(),TIME_DATE) == TimeToString(rates[i].time,TIME_DATE))
    {
      ArrayResize(maximos,ArraySize(maximos)+1);
      maximos[ArraySize(maximos)-1] = rates[i].high;
    }
    if(TimeToString(TimeCurrent(),TIME_DATE) == TimeToString(rates[i].time,TIME_DATE))
    {
      ArrayResize(minimos,ArraySize(minimos)+1);
      minimos[ArraySize(minimos)-1] = rates[i].low;
    }
  }



  int Max = ArrayMaximum(maximos);
  int Min = ArrayMinimum(minimos);

  min_dia = minimos[Min];
  max_dia = maximos[Max];
  // Print("min_dia " + min_dia);
  // Print("max_dia " + max_dia);
}


void Bender::Avalia()
{
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  double avalia_min;
  double avalia_max;

  double min_dia;
  double max_dia;

  Max_Min(avalia_min,avalia_max);
  Max_Min_diario(min_dia,max_dia);

  // Print("avalia_max " + avalia_max + " avalia_min " + avalia_min);
  // Print("min_dia " + min_dia + " max_dia " + max_dia);


  if(O_Stops.Tipo_Posicao() == 0 && Condicoes.Horario())
  {
    if(max_dia > avalia_max)
    {
      if(Micro_tendencia() == -1)
      {
        Opera_Mercado *opera = new Opera_Mercado;
        opera.AbrePosicao(-1,"BenderV2");
        delete(opera);
      }
    }

    if(min_dia < avalia_min)
    {
      if(Micro_tendencia() == 1)
      {
        Opera_Mercado *opera = new Opera_Mercado;
        opera.AbrePosicao(1,"BenderV2");
        delete(opera);
      }
    }
  }


  delete Condicoes;
}

int Bender::Micro_tendencia()
{
  int retorno = 0;
  MqlRates rates[];
  ArraySetAsSeries(rates,true);

  int copied=CopyRates(Symbol(),TimeFrame,0,200,rates);
  if(rates[1].close > rates[2].close) retorno = 1;
  if(rates[1].close < rates[2].close) retorno = -1;

  return retorno;
}
