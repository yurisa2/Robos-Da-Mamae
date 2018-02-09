/* -*- C++ -*- */
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class DeMarker
{
  public:
  void DeMarker();
  double Valor(int barra = 0);
  double Cx(int barra = 0);

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
  double y1 = 0;
  double y2 = 0;
  double y3 = 0;

  y1 = Valor(barra+2);
  y2 = Valor(barra+1);
  y3 = Valor(barra);

  Matematica *mat = new Matematica;
  retorno = mat.Coeficiente_Angular_3(y1,y2,y3);
  delete(mat);


  return(retorno);
}
