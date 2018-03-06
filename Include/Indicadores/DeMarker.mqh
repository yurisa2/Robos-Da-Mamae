/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class DeMarker
{
  public:
  void DeMarker();
  double Valor(int barra = 0);
  double Cx(int barra = 0);
  double Normalizado(int barra = 0);

  private:
  int HandleDeMarker;

};

void DeMarker::DeMarker()
{
  HandleDeMarker = 0;
  HandleDeMarker = iDeMarker(Symbol(),TimeFrame,14) ;
  // ChartIndicatorAdd(0,0,HandleMA);

  // Print("Handle Stoch: " + IntegerToString(HandleMA));

  if(HandleDeMarker == 0)
  {
    ExpertRemove();
  }
}

double DeMarker::Valor(int barra = 0)
{
     double _DeMarker[];
     double retorno = NULL;

     ArraySetAsSeries(_DeMarker,true);
     int DeMarker_copied = CopyBuffer(HandleDeMarker,0,0,barra+5,_DeMarker);

     retorno = _DeMarker[barra];
     // Print("DeMarker Barra: " + barra); //DEBUG
     // Print("_DeMarker[barra]: " + _DeMarker[barra]); //DEBUG
     // Print("_DeMarker[0]: " + _DeMarker[0]); //DEBUG
     // Print("HandleDeMarker: " + HandleDeMarker); //DEBUG

     return(retorno);
}


double DeMarker::Cx(int barra = 0)
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

double DeMarker::Normalizado(int barra = 0)
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
