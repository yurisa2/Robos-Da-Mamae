/* -*- C++ -*- */
#property copyright "PetroSa, Robï¿½s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class BearsPower
{
  public:
  void BearsPower();
  double Valor(int barra = 0);
  double Cx(int barra = 0,int periods = 7);
  double Normalizado(int barra = 0,int periods = 7);

  private:
  int HandleBearsPower;

};

void BearsPower::BearsPower()
{
  HandleBearsPower = 0;
  HandleBearsPower = iBearsPower(Symbol(),TimeFrame,13) ;
  // ChartIndicatorAdd(0,0,HandleMA);

  // Print("Handle Stoch: " + IntegerToString(HandleMA));

  if(HandleBearsPower == 0)
  {
    ExpertRemove();
  }
}

double BearsPower::Valor(int barra = 0)
{
     double _BearsPower[];
     double retorno = NULL;

     ArraySetAsSeries(_BearsPower,true);
     int BearsPower_copied = CopyBuffer(HandleBearsPower,0,0,barra+5,_BearsPower);

     retorno = _BearsPower[barra];
     // Print("BearsPower Barra: " + barra); //DEBUG
     // Print("_BearsPower[barra]: " + _BearsPower[barra]); //DEBUG
     // Print("_BearsPower[0]: " + _BearsPower[0]); //DEBUG
     // Print("HandleBearsPower: " + HandleBearsPower); //DEBUG

     return(retorno);
}


double BearsPower::Cx(int barra = 0,int periods = 7)
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


double BearsPower::Normalizado(int barra = 0,int periods = 7)
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
