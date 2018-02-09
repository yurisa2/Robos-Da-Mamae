/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class CCI
{
  public:
  void CCI();
  double Valor(int barra = 0);
  double Cx(int barra = 0);

  private:
  int HandleCCI;

};

void CCI::CCI()
{
  HandleCCI = 0;
  HandleCCI = iCCI(Symbol(),TimeFrame,20,PRICE_CLOSE) ;
  // ChartIndicatorAdd(0,0,HandleMA);

  // Print("Handle Stoch: " + IntegerToString(HandleMA));

  if(HandleCCI == 0)
  {
    ExpertRemove();
  }
}

double CCI::Valor(int barra = 0)
{
     double _CCI[];
     double retorno = NULL;

     ArraySetAsSeries(_CCI,true);
     int CCI_copied = CopyBuffer(HandleCCI,0,0,barra+5,_CCI);

     retorno = _CCI[barra];
     // Print("CCI Barra: " + barra); //DEBUG
     // Print("_CCI[barra]: " + _CCI[barra]); //DEBUG
     // Print("_CCI[0]: " + _CCI[0]); //DEBUG
     // Print("HandleCCI: " + HandleCCI); //DEBUG

     return(retorno);
}


double CCI::Cx(int barra = 0)
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
