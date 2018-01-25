/* -*- C++ -*- */
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class BullsPower
{
  public:
  void BullsPower();
  double Valor(int barra = 0);

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

     ArraySetAsSeries(_BullsPower true);
     if(HandleBullsPower == 0)
     int BullsPower_copied = CopyBuffer(HandleBullsPower,0,0,barra+5,_BullsPower);

     retorno = _BullsPower[barra];
     // Print("BullsPower Barra: " + barra); //DEBUG
     // Print("_BullsPower[barra]: " + _BullsPower[barra]); //DEBUG
     // Print("_BullsPower[0]: " + _BullsPower[0]); //DEBUG
     // Print("HandleBullsPower: " + HandleBullsPower); //DEBUG

     return(retorno);
}
