/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class Normalizacao
{
  public:
  Normalizacao(double y1, double y2, double y3,  double y4, double y5,  double y6,  double y7);
  double Coeficiente_Angular;
  double Valor_Normalizado;

  private:
  double Normalizacao::Coeficiente_Angular_3();
  double normalizado_1;
  double normalizado_2;
  double normalizado_3;


};

double Normalizacao::Coeficiente_Angular_3()
{
  double retorno = 0;

  return retorno;
}


Normalizacao::Normalizacao(double y1, double y2, double y3,  double y4, double y5,  double y6,  double y7)
{
  Coeficiente_Angular = Coeficiente_Angular_3();

  double Valor[7];
  Valor[6] = y1;
  Valor[5] = y2;
  Valor[4] = y3;
  Valor[3] = y4;
  Valor[2] = y5;
  Valor[1] = y6;
  Valor[0] = y7;

  double Z_min = Valor[ArrayMinimum(Valor)];
  double Z_max = Valor[ArrayMaximum(Valor)];

  Valor_Normalizado = (Valor[0] - Z_min) / (Z_max - Z_min);

  normalizado_1 = (Valor[2] - Z_min) / (Z_max - Z_min);
  normalizado_2 = (Valor[1] - Z_min) / (Z_max - Z_min);
  normalizado_3 = (Valor[3] - Z_min) / (Z_max - Z_min);
}
