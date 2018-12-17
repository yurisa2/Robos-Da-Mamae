/* -*- C++ -*- */

class Xus
{

  public:
  void Xus_Comentario();
  void Avalia();
  int xus_diff();
  double xus_close_yest();
  double xus_open_tod();

};


void Xus::Xus_Comentario()
{

}

void Xus::Avalia()
{
  int dir = 0;

  if(this.xus_diff() > 0) dir = 1;
  if(this.xus_diff() < 0) dir = -1;

  // double
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
