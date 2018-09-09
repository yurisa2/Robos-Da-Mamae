/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class WPR
{
  public:
  void WPR();
  double Valor(int barra = 0);
  double Cx(int barra = 0,int periods = 7);
  double Normalizado(int barra = 0,int periods = 7);

  private:
  int HandleWPR;

};

void WPR::WPR()
{
  HandleWPR = 0;
  HandleWPR = iWPR(Symbol(),TimeFrame,14) ;
  // ChartIndicatorAdd(0,0,HandleMA);

  // Print("Handle Stoch: " + IntegerToString(HandleMA));

  if(HandleWPR == 0)
  {
    ExpertRemove();
  }
}

double WPR::Valor(int barra = 0)
{
     double _WPR[];
     double retorno = NULL;

     ArraySetAsSeries(_WPR,true);
     int WPR_copied = CopyBuffer(HandleWPR,0,0,barra+5,_WPR);

     retorno = _WPR[barra];
     // Print("WPR Barra: " + barra); //DEBUG
     // Print("_WPR[barra]: " + _WPR[barra]); //DEBUG
     // Print("_WPR[0]: " + _WPR[0]); //DEBUG
     // Print("HandleWPR: " + HandleWPR); //DEBUG

     return(retorno);
}


double WPR::Cx(int barra = 0,int periods = 7)
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

double WPR::Normalizado(int barra = 0,int periods = 7)
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
