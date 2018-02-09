/* -*- C++ -*- */
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
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
