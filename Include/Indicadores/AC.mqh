/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class AC
{
  public:
  void AC();
  double Valor(int barra = 0);
  double Cx(int barra = 0);

  private:
  int HandleAC;

};

void AC::AC()
{
  HandleAC = 0;
  HandleAC = iAC(Symbol(),TimeFrame) ;
  // ChartIndicatorAdd(0,0,HandleMA);

  // Print("Handle Stoch: " + IntegerToString(HandleMA));

  if(HandleAC == 0)
  {
    ExpertRemove();
  }
}

double AC::Valor(int barra = 0)
{
     double _AC[];
     double retorno = NULL;

     ArraySetAsSeries(_AC,true);
     int AC_copied = CopyBuffer(HandleAC,0,0,barra+5,_AC);

     retorno = _AC[barra];
     // Print("AC Barra: " + barra); //DEBUG
     // Print("_AC[barra]: " + _AC[barra]); //DEBUG
     // Print("_AC[0]: " + _AC[0]); //DEBUG
     // Print("HandleAC: " + HandleAC); //DEBUG

     return(retorno);
}


double AC::Cx(int barra = 0)
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
