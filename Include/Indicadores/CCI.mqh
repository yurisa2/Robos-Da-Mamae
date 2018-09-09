/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class CCI
{
  public:
  void CCI();
  double Valor(int barra = 0);
  double Cx(int barra = 0,int periods = 7);
  double Normalizado(int barra = 0,int periods = 7);

  private:
  int HandleCCI;

};

void CCI::CCI()
{
  HandleCCI = 0;
  HandleCCI = iCCI(Symbol(),TimeFrame,20,PRICE_CLOSE) ;
  // ChartIndicatorAdd(0,0,HandleMA);

  // Print("Handle Stoch: " + IntegerToString(HandleMA));

  if(HandleCCI == 0)
  {
    ExpertRemove();
  }
}

double CCI::Valor(int barra = 0)
{
     double _CCI[];
     double retorno = NULL;

     ArraySetAsSeries(_CCI,true);
     int CCI_copied = CopyBuffer(HandleCCI,0,0,barra+5,_CCI);

     retorno = _CCI[barra];
     // Print("CCI Barra: " + barra); //DEBUG
     // Print("_CCI[barra]: " + _CCI[barra]); //DEBUG
     // Print("_CCI[0]: " + _CCI[0]); //DEBUG
     // Print("HandleCCI: " + HandleCCI); //DEBUG

     return(retorno);
}


double CCI::Cx(int barra = 0,int periods = 7)
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

double CCI::Normalizado(int barra = 0,int periods = 7)
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
