/* -*- C++ -*- */
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class BearsPower
{
  public:
  void BearsPower();
  double Valor(int barra = 0);

  private:
  int HandleBearsPower;

};

void BearsPower::BearsPower()
{
  HandleBearsPower = 0;
  HandleBearsPower = iBearsPower(Symbol(),TimeFrame,13) ;
  // ChartIndicatorAdd(0,0,HandleMA);

  // Print("Handle Stoch: " + IntegerToString(HandleMA));

  if(HandleBearsPower == 0)
  {
    ExpertRemove();
  }
}

double BearsPower::Valor(int barra = 0)
{
     double _BearsPower[];
     double retorno = NULL;

     ArraySetAsSeries(_BearsPower true);
     if(HandleBearsPower == 0)
     int BearsPower_copied = CopyBuffer(HandleBearsPower,0,0,barra+5,_BearsPower);

     retorno = _BearsPower[barra];
     // Print("BearsPower Barra: " + barra); //DEBUG
     // Print("_BearsPower[barra]: " + _BearsPower[barra]); //DEBUG
     // Print("_BearsPower[0]: " + _BearsPower[0]); //DEBUG
     // Print("HandleBearsPower: " + HandleBearsPower); //DEBUG

     return(retorno);
}
