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
  datetime Data_Inicio_hoje = StringToTime(TimeToString(TimeCurrent(),TIME_DATE)+" "+bender_horario_inicio_hora+":"+bender_horario_inicio_minuto);
  datetime Data_Fim_hoje = StringToTime(TimeToString(TimeCurrent(),TIME_DATE)+" "+bender_horario_fim_hora+":"+bender_horario_fim_minuto);
  Print("Data_Inicio_hoje " + Data_Inicio_hoje);
  // Print("Data_Fim_hoje " + Data_Fim_hoje);

  MqlRates rates[];
  ArraySetAsSeries(rates,false);
  // int copied=CopyRates(Symbol(),PERIOD_M1,Data_Fim_hoje,bender_minutos_a_tras,rates);
  int copied=CopyRates(Symbol(),PERIOD_M1,Data_Fim_hoje,bender_minutos_a_tras,rates);
  // int copied=CopyRates(Symbol(),PERIOD_M1,Data_Inicio_hoje,Data_Fim_hoje,rates);

  double minimos[];
  double maximos[];
  ArrayResize(maximos,copied);
  ArrayResize(minimos,copied);

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


void Bender::Avalia()
{



  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  double avalia_min;
  double avalia_max;

  Max_Min(avalia_min,avalia_max);
  // Print(TimeCurrent());

  if(O_Stops.Tipo_Posicao() == 0 && Condicoes.Horario())
  {
    if(daotick() > avalia_max)
    {
      if(bender_micro_tendencia)
      {
        if(Micro_tendencia() == 1)
        {
          Opera_Mercado *opera = new Opera_Mercado;
          opera.AbrePosicao(1,"BenderV2 com Micro_tendencia");
          delete(opera);
        }
      }
      else{
        Opera_Mercado *opera = new Opera_Mercado;
        opera.AbrePosicao(1,"BenderV2 Sem Micro_tendencia");
        delete(opera);
      }
    }

    if(daotick() < avalia_min)
    {
      if(bender_micro_tendencia)
      {
        if(Micro_tendencia() == -1)
        {
          Opera_Mercado *opera = new Opera_Mercado;
          opera.AbrePosicao(-1,"BenderV2 com Micro_tendencia");
          delete(opera);
        }
      }
      else{
        Opera_Mercado *opera = new Opera_Mercado;
        opera.AbrePosicao(-1,"BenderV2 Sem Micro_tendencia");
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
  if(rates[0].close > rates[1].close) retorno = 1;
  if(rates[0].close < rates[1].close) retorno = -1;

  return retorno;
}
