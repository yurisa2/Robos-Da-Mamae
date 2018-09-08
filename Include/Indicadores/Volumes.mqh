/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class Volumes
{
  public:
  void Volumes(string symbol = NULL, ENUM_TIMEFRAMES period = PERIOD_CURRENT, ENUM_APPLIED_VOLUME  applied_volume = VOLUME_TICK);
  double Valor(int barra = 0);
  double Cx(int barra = 0);
  double Normalizado(int barra = 0,int periods = 7);

  private:
  int HandleVolumes;

};

void Volumes::Volumes(string symbol = NULL, ENUM_TIMEFRAMES period = PERIOD_CURRENT, ENUM_APPLIED_VOLUME  applied_volume = VOLUME_TICK)
{
  HandleVolumes = 0;
  HandleVolumes = iVolumes(symbol,period,applied_volume) ;
  // ChartIndicatorAdd(0,1,HandleVolumes);

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
     int Volumes_copied = CopyBuffer(HandleVolumes,0,0,barra+5,_Volumes);

     retorno = _Volumes[barra];

     return(retorno);
}


double Volumes::Cx(int barra = 0)
{
  double retorno = NULL;

  double y1 = Valor(barra+6);
  double y2 = Valor(barra+5);
  double y3 = Valor(barra+4);
  double y4 = Valor(barra+3);
  double y5 = Valor(barra+2);
  double y6 = Valor(barra+1);
  double y7 = Valor(barra);

  Normalizacao *mat = new Normalizacao(y1,y2,y3,y4,y5,y6,y7);
  retorno = mat.Coeficiente_Angular;
  delete(mat);


  return(retorno);
}

double Volumes::Normalizado(int barra = 0,int periods = 7)
{
  double retorno = NULL;

  double y1 = Valor(barra+6);
  double y2 = Valor(barra+5);
  double y3 = Valor(barra+4);
  double y4 = Valor(barra+3);
  double y5 = Valor(barra+2);
  double y6 = Valor(barra+1);
  double y7 = Valor(barra);

  Normalizacao *mat = new Normalizacao(y1,y2,y3,y4,y5,y6,y7);
  retorno = mat.Valor_Normalizado;
  delete(mat);


  return(retorno);
}
