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
