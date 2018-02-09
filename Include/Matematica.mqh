/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class Matematica
{
  public:
  double Matematica::Coeficiente_Angular_3(double y1, double y2, double y3);

  private:

};
//
// double Matematica::Coeficiente_Angular_3(double y1, double y2, double y3)
// {
//   double retorno = 0;
//
//   double beta = 0;
//   double beta_dividendo = 0;
//   double beta_divisor = 2;
//   double y_media = 0;
//
//   double x1 = 1;
//   double x2 = 2;
//   double x3 = 3;
//   double x_media = 3;
//
//
//   y_media = (y1 + y2 + y3) /3;
//
//
//   beta_dividendo = (x1 - x_media) * (y1 - y_media);
//   beta_dividendo = beta_dividendo + ((x2 - x_media) * (y2 - y_media));
//   beta_dividendo = beta_dividendo + ((x3 - x_media) * (y3- y_media));
//
//   beta = beta_dividendo / beta_divisor;
//
//   retorno = beta;
//   // retorno = MathArctan(beta); //Tá na dissertação do Igor, mas.... né.
//
//
//
//   return retorno;
// }

double Matematica::Coeficiente_Angular_3(double y1, double y2, double y3)
{
  double retorno = 0;

  double cat_b = y3 - y1;
  double cat_c = 3;

  retorno = MathTan(cat_b/cat_c);




  return retorno;
}
