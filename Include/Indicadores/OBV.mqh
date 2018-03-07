/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class OBV
{
  public:
  void OBV();
  double Valor(int barra = 0);
  double Cx(int barra = 0);
  double Normalizado(int barra = 0);

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

double OBV::Normalizado(int barra = 0)
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
