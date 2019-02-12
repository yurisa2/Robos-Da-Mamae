/* -*- C++ -*- */
#property copyright "PetroSa, Robï¿½s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class AC
{
  public:
  void AC();
  double Valor(int barra = 0);
  double Cx(int barra = 0,int periods = 7);
  double Normalizado(int barra = 0,int periods = 7);

  private:
  int HandleAC;

};

void AC::AC()
{
  HandleAC = 0;
  HandleAC = iAC(Symbol(),TimeFrame) ;
  // ChartIndicatorAdd(0,0,HandleMA);

  // Print("Handle Stoch: " + IntegerToString(HandleMA));

  if(HandleAC == 0)
  {
    ExpertRemove();
  }
}

double AC::Valor(int barra = 0)
{
     double _AC[];
     double retorno = NULL;

     ArraySetAsSeries(_AC,true);
     int AC_copied = CopyBuffer(HandleAC,0,0,barra+5,_AC);

     retorno = _AC[barra];
     // Print("AC Barra: " + barra); //DEBUG
     // Print("_AC[barra]: " + _AC[barra]); //DEBUG
     // Print("_AC[0]: " + _AC[0]); //DEBUG
     // Print("HandleAC: " + HandleAC); //DEBUG

     return(retorno);
}


double AC::Cx(int barra = 0,int periods = 7)
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

double AC::Normalizado(int barra = 0,int periods = 7)
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
