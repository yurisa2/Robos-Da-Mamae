/* -*- C++ -*- */
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class OBV
{
  public:
  void OBV();
  double Valor(int barra = 0);
  double Cx(int barra = 0);

  private:
  int HandleOBV;

};

void OBV::OBV()
{
  HandleOBV = 0;
  HandleOBV = iOBV(Symbol(),TimeFrame,VOLUME_TICK) ;
  // ChartIndicatorAdd(0,0,HandleMA);

  // Print("Handle Stoch: " + IntegerToString(HandleMA));

  if(HandleOBV == 0)
  {
    ExpertRemove();
  }
}

double OBV::Valor(int barra = 0)
{
     double _OBV[];
     double retorno = NULL;

     ArraySetAsSeries(_OBV,true);
     int OBV_copied = CopyBuffer(HandleOBV,0,0,barra+5,_OBV);

     retorno = _OBV[barra];
     // Print("OBV Barra: " + barra); //DEBUG
     // Print("_OBV[barra]: " + _OBV[barra]); //DEBUG
     // Print("_OBV[0]: " + _OBV[0]); //DEBUG
     // Print("HandleOBV: " + HandleOBV); //DEBUG

     return(retorno);
}


double OBV::Cx(int barra = 0)
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
