/* -*- C++ -*- */
#property copyright "PetroSa, Robï¿½s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class ATR
{
  public:
  void ATR();
  double Valor(int barra = 0);
  double Cx(int barra = 0,int periods = 7);
  double Normalizado(int barra = 0,int periods = 7);

  private:
  int HandleATR;

};

void ATR::ATR()
{
  HandleATR = 0;
  HandleATR = iATR(Symbol(),TimeFrame,14) ;
  // ChartIndicatorAdd(0,0,HandleMA);

  // Print("Handle Stoch: " + IntegerToString(HandleMA));

  if(HandleATR == 0)
  {
    ExpertRemove();
  }
}

double ATR::Valor(int barra = 0)
{
     double _ATR[];
     double retorno = NULL;

     ArraySetAsSeries(_ATR,true);
     int ATR_copied = CopyBuffer(HandleATR,0,0,barra+5,_ATR);

     retorno = _ATR[barra];
     // Print("ATR Barra: " + barra); //DEBUG
     // Print("_ATR[barra]: " + _ATR[barra]); //DEBUG
     // Print("_ATR[0]: " + _ATR[0]); //DEBUG
     // Print("HandleATR: " + HandleATR); //DEBUG

     return(retorno);
}


double ATR::Cx(int barra = 0,int periods = 7)
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


double ATR::Normalizado(int barra = 0,int periods = 7)
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
