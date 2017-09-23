/* -*- C++ -*- */
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class Volumes
{
  public:
  void Volumes(string symbol = NULL, ENUM_TIMEFRAMES period = PERIOD_CURRENT, ENUM_APPLIED_VOLUME  applied_volume = VOLUME_TICK);
  double Valor(int barra = 0);

  private:
  int HandleVolumes;

};

void Volumes::Volumes(string symbol = NULL, ENUM_TIMEFRAMES period = PERIOD_CURRENT, ENUM_APPLIED_VOLUME  applied_volume = VOLUME_TICK)
{
  HandleVolumes = 0;
  HandleVolumes = iVolumes(symbol,period,applied_volume) ;
  ChartIndicatorAdd(0,1,HandleVolumes);

  // Print("Handle Stoch: " + IntegerToString(HandleVolumes));

  if(HandleVolumes == 0)
  {
    ExpertRemove();
  }
}

double Volumes::Valor(int barra = 0)
{
     double _Volumes[];
     double retorno = NULL;

     ArraySetAsSeries(_Volumes, true);
     int Volumes_copied = CopyBuffer(HandleVolumes,0,0,100,_Volumes);

     retorno = _Volumes[barra];

     return(retorno);
}
