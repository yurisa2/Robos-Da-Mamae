/* -*- C++ -*- */
#property copyright "PetroSa, Robï¿½s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class BullsPower
{
  public:
  void BullsPower();
  double Valor(int barra = 0);
  double Cx(int barra = 0,int periods = 7);
  double Normalizado(int barra = 0,int periods = 7);

  private:
  int HandleBullsPower;

};

void BullsPower::BullsPower()
{
  HandleBullsPower = 0;
  HandleBullsPower = iBullsPower(Symbol(),TimeFrame,13) ;
  // ChartIndicatorAdd(0,0,HandleMA);

  // Print("Handle Stoch: " + IntegerToString(HandleMA));

  if(HandleBullsPower == 0)
  {
    ExpertRemove();
  }
}

double BullsPower::Valor(int barra = 0)
{
     double _BullsPower[];
     double retorno = NULL;

     ArraySetAsSeries(_BullsPower,true);
     int BullsPower_copied = CopyBuffer(HandleBullsPower,0,0,barra+5,_BullsPower);

     retorno = _BullsPower[barra];
     // Print("BullsPower Barra: " + barra); //DEBUG
     // Print("_BullsPower[barra]: " + _BullsPower[barra]); //DEBUG
     // Print("_BullsPower[0]: " + _BullsPower[0]); //DEBUG
     // Print("HandleBullsPower: " + HandleBullsPower); //DEBUG

     return(retorno);
}


double BullsPower::Cx(int barra = 0,int periods = 7)
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


double BullsPower::Normalizado(int barra = 0,int periods = 7)
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
