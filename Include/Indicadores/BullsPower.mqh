/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class BullsPower
{
  public:
  void BullsPower();
  double Valor(int barra = 0);
  double Cx(int barra = 0);

  private:
  int HandleBullsPower;

};

void BullsPower::BullsPower()
{
  HandleBullsPower = 0;
  HandleBullsPower = iBullsPower(Symbol(),TimeFrame,13) ;
  // ChartIndicatorAdd(0,0,HandleMA);

  // Print("Handle Stoch: " + IntegerToString(HandleMA));

  if(HandleBullsPower == 0)
  {
    ExpertRemove();
  }
}

double BullsPower::Valor(int barra = 0)
{
     double _BullsPower[];
     double retorno = NULL;

     ArraySetAsSeries(_BullsPower,true);
     int BullsPower_copied = CopyBuffer(HandleBullsPower,0,0,barra+5,_BullsPower);

     retorno = _BullsPower[barra];
     // Print("BullsPower Barra: " + barra); //DEBUG
     // Print("_BullsPower[barra]: " + _BullsPower[barra]); //DEBUG
     // Print("_BullsPower[0]: " + _BullsPower[0]); //DEBUG
     // Print("HandleBullsPower: " + HandleBullsPower); //DEBUG

     return(retorno);
}


double BullsPower::Cx(int barra = 0)
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
