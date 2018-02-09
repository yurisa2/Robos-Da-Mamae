/* -*- C++ -*- */
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class AD
{
  public:
  void AD();
  double Valor(int barra = 0);
  double Cx(int barra = 0);

  private:
  int HandleAD;

};

void AD::AD()
{
  HandleAD = 0;
  HandleAD = iAD(Symbol(),TimeFrame,VOLUME_TICK) ;
  // ChartIndicatorAdd(0,0,HandleMA);

  // Print("Handle Stoch: " + IntegerToString(HandleMA));

  if(HandleAD == 0)
  {
    ExpertRemove();
  }
}

double AD::Valor(int barra = 0)
{
     double _AD[];
     double retorno = NULL;

     ArraySetAsSeries(_AD,true);
     int AD_copied = CopyBuffer(HandleAD,0,0,barra+5,_AD);

     retorno = _AD[barra];
     // Print("AD Barra: " + barra); //DEBUG
     // Print("_AD[barra]: " + _AD[barra]); //DEBUG
     // Print("_AD[0]: " + _AD[0]); //DEBUG
     // Print("HandleAD: " + HandleAD); //DEBUG

     return(retorno);
}


double AD::Cx(int barra = 0)
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
