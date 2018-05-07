/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class Preco
{
  public:
  Preco(ENUM_TIMEFRAMES tf = PERIOD_CURRENT);
  double Valor(int barra = 0);
  double Cx(int barra = 0);
  double Normalizado(int barra = 0);

  private:
  int HandleMA;
  int HandleMA_high;
  int HandleMA_low;

};
