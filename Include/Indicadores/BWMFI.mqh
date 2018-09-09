/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class BWMFI
{
  public:
  void BWMFI();
  double Valor(int barra = 0);
  double Cx(int barra = 0,int periods = 7);
  double Normalizado(int barra = 0,int periods = 7);

  private:
  int HandleBWMFI;

};

void BWMFI::BWMFI()
{
  HandleBWMFI = 0;
  HandleBWMFI = iBWMFI(Symbol(),TimeFrame,VOLUME_TICK) ;
  // ChartIndicatorAdd(0,0,HandleMA);

  // Print("Handle Stoch: " + IntegerToString(HandleMA));

  if(HandleBWMFI == 0)
  {
    ExpertRemove();
  }
}

double BWMFI::Valor(int barra = 0)
{
     double _BWMFI[];
     double retorno = NULL;

     ArraySetAsSeries(_BWMFI,true);
     int BWMFI_copied = CopyBuffer(HandleBWMFI,0,0,barra+5,_BWMFI);

     retorno = _BWMFI[barra];
     // Print("BWMFI Barra: " + barra); //DEBUG
     // Print("_BWMFI[barra]: " + _BWMFI[barra]); //DEBUG
     // Print("_BWMFI[0]: " + _BWMFI[0]); //DEBUG
     // Print("HandleBWMFI: " + HandleBWMFI); //DEBUG

     return(retorno);
}


double BWMFI::Cx(int barra = 0,int periods = 7)
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


double BWMFI::Normalizado(int barra = 0,int periods = 7)
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
