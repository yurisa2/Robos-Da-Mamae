/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class WPR
{
  public:
  void WPR();
  double Valor(int barra = 0);
  double Cx(int barra = 0);
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


double WPR::Cx(int barra = 0)
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

double WPR::Normalizado(int barra = 0,int periods = 7)
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
