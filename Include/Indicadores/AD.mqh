/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class AD
{
  public:
  void AD();
  double Valor(int barra = 0);
  double Cx(int barra = 0);
  double Normalizado(int barra = 0);

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

  double y1 = Valor(barra+6);
  double y2 = Valor(barra+5);
  double y3 = Valor(barra+4);
  double y4 = Valor(barra+3);
  double y5 = Valor(barra+2);
  double y6 = Valor(barra+1);
  double y7 = Valor(barra);

  Normalizacao *mat = new Normalizacao(y1,y2,y3,y4,y5,y6,y7);
  retorno = mat.Coeficiente_Angular;
  delete(mat);


  return(retorno);
}


double AD::Normalizado(int barra = 0)
{
  double retorno = NULL;

  double y1 = Valor(barra+6);
  double y2 = Valor(barra+5);
  double y3 = Valor(barra+4);
  double y4 = Valor(barra+3);
  double y5 = Valor(barra+2);
  double y6 = Valor(barra+1);
  double y7 = Valor(barra);

  Normalizacao *mat = new Normalizacao(y1,y2,y3,y4,y5,y6,y7);
  retorno = mat.Valor_Normalizado;
  delete(mat);


  return(retorno);
}
