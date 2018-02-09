/* -*- C++ -*- */
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class WPR
{
  public:
  void WPR();
  double Valor(int barra = 0);
  double Cx(int barra = 0);

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
