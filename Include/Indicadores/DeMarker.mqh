/* -*- C++ -*- */
#property copyright "PetroSa, Robï¿½s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class DeMarker
{
  public:
  void DeMarker();
  double Valor(int barra = 0);
  double Cx(int barra = 0,int periods = 7);
  double Normalizado(int barra = 0,int periods = 7);

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


double DeMarker::Cx(int barra = 0,int periods = 7)
{
  double retorno = NULL;

  double vetor_norm[];
  ArrayResize(vetor_norm,periods);

  for(int i = 0; i < periods; i++) {
    vetor_norm[i] = Valor(barra+i);
  }

  Normalizacao *mat = new Normalizacao(vetor_norm);
  retorno = mat.Coeficiente_Angular;
  delete(mat);

  return(retorno);
}

double DeMarker::Normalizado(int barra = 0,int periods = 7)
{
  double retorno = NULL;

  double vetor_norm[];
  ArrayResize(vetor_norm,periods);

  for(int i = 0; i < periods; i++) {
    vetor_norm[i] = Valor(barra+i);
  }

  Normalizacao *mat = new Normalizacao(vetor_norm);
  retorno = mat.Valor_Normalizado;
  delete(mat);


  return(retorno);
}
