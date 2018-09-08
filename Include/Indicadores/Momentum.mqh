/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class Momentum
{
  public:
  void Momentum();
  double Valor(int barra = 0);
  double Cx(int barra = 0);
  double Normalizado(int barra = 0,int periods = 7);

  private:
  int HandleMomentum;

};

void Momentum::Momentum()
{
  HandleMomentum = 0;
  HandleMomentum = iMomentum(Symbol(),TimeFrame,14,PRICE_CLOSE) ;
  // ChartIndicatorAdd(0,0,HandleMA);

  // Print("Handle Stoch: " + IntegerToString(HandleMA));

  if(HandleMomentum == 0)
  {
    ExpertRemove();
  }
}

double Momentum::Valor(int barra = 0)
{
     double _Momentum[];
     double retorno = NULL;

     ArraySetAsSeries(_Momentum,true);
     int Momentum_copied = CopyBuffer(HandleMomentum,0,0,barra+5,_Momentum);

     retorno = _Momentum[barra];
     // Print("Momentum Barra: " + barra); //DEBUG
     // Print("_Momentum[barra]: " + _Momentum[barra]); //DEBUG
     // Print("_Momentum[0]: " + _Momentum[0]); //DEBUG
     // Print("HandleMomentum: " + HandleMomentum); //DEBUG

     return(retorno);
}


double Momentum::Cx(int barra = 0)
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

double Momentum::Normalizado(int barra = 0,int periods = 7)
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
