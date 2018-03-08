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
  double retorno = NULL;

  double ya = normalizado_1;
  double yb = normalizado_2;
  double yc = normalizado_3;

  double y_media = (ya + yb + yc ) /3;

  double aF1 = -1;
  double bF1 = 0;
  double cF1 = 1;

  double aF2 = ya - y_media;
  double bF2 = yb - y_media;
  double cF2 = yc - y_media;

  double aF3 = aF1 * aF2;
  double bF3 = bF1 * bF2;
  double cF3 = cF1 * cF2;

  double aF4 = 1;
  double bF4 = 0;
  double cF4 = 1;

  double beta = (aF3 + bF3 + cF3) / (aF4 + bF4 + cF4);

  retorno = MathArctan(beta);

  return retorno;
}

Normalizacao::Normalizacao(double y1, double y2, double y3,  double y4, double y5,  double y6,  double y7)
{

  double Valor[7];
  Valor[0] = y1;
  Valor[1] = y2;
  Valor[2] = y3;
  Valor[3] = y4;
  Valor[4] = y5;
  Valor[5] = y6;
  Valor[6] = y7;

  double Z_min = Valor[ArrayMinimum(Valor)];
  double Z_max = Valor[ArrayMaximum(Valor)];

  double Z_max_Zmin = Z_max - Z_min;
  if(Z_max_Zmin == 0 ) Z_max_Zmin = 0.000000000000000000001;

  Valor_Normalizado = (y7 - Z_min) / (Z_max_Zmin);

  normalizado_1 = (y5 - Z_min) / (Z_max_Zmin);
  normalizado_2 = (y6 - Z_min) / (Z_max_Zmin);
  normalizado_3 = (y7 - Z_min) / (Z_max_Zmin);


  Coeficiente_Angular = Coeficiente_Angular_3();
}
