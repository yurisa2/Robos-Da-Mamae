/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class ATR
{
  public:
  void ATR();
  double Valor(int barra = 0);
  double Cx(int barra = 0);
  double Normalizado(int barra = 0);

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


double ATR::Cx(int barra = 0)
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


double ATR::Normalizado(int barra = 0)
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
