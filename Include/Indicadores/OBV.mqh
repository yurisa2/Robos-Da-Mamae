/* -*- C++ -*- */
#property copyright "PetroSa, Robï¿½s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class OBV
{
  public:
  void OBV(ENUM_TIMEFRAMES periodo = PERIOD_CURRENT);
  double Valor(int barra = 0);
  double Cx(int barra = 0,int periods = 7);
  double Normalizado(int barra = 0,int periods = 7);

  private:
  int HandleOBV;

};

void OBV::OBV(ENUM_TIMEFRAMES periodo = PERIOD_CURRENT)
{
  periodo = TimeFrame;

  HandleOBV = 0;
  HandleOBV = iOBV(Symbol(),periodo,VOLUME_TICK) ;
  // ChartIndicatorAdd(0,0,HandleMA);

  // Print("Handle Stoch: " + IntegerToString(HandleMA));

  if(HandleOBV == 0)
  {
    ExpertRemove();
  }
}

double OBV::Valor(int barra = 0)
{
     double _OBV[];
     double retorno = NULL;

     ArraySetAsSeries(_OBV,true);
     int OBV_copied = CopyBuffer(HandleOBV,0,0,barra+5,_OBV);

     retorno = _OBV[barra];
     // Print("OBV Barra: " + barra); //DEBUG
     // Print("_OBV[barra]: " + _OBV[barra]); //DEBUG
     // Print("_OBV[0]: " + _OBV[0]); //DEBUG
     // Print("HandleOBV: " + HandleOBV); //DEBUG

     return(retorno);
}


double OBV::Cx(int barra = 0,int periods = 7)
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

double OBV::Normalizado(int barra = 0,int periods = 7)
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
