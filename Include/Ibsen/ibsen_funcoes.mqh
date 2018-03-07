/* -*- C++ -*- */

class Ibsen
{

  public:
  Ibsen();
  void Comentario();
  void Avalia();
  double LinMACD; //0 - Main line
  double LinSinal; //1 - Signal Line
  double m1; //Cx MACD
  double m2; //Cx Sinal
  double distancia; //distância do indicador Histograma MACD ao eixo zero;
  double alpha; //ângulo da reta obtido pela regressão linear dos três últimos
  double HIST; //HIST = Indicador Histograma MACD
  double MOMENTO; //HIST = Indicador Histograma MACD
  double SINAL;
  double MACD_Resultado; //Resultado da Tabela 1
  double Volume_Resultado; //Mais Ou Menos Fuzzy
  double Ibsen::Fuzzy_HIST(double HIST_distancia = NULL, double HIST_alpha = NULL);
  double Ibsen::Fuzzy_Momento();
  double Ibsen::Fuzzy_Sinal();


  private:
  void Ibsen::Dados();
  double Ibsen::Crisp_MACD();

};

void Ibsen::Ibsen()
{

  Dados();

}

void Ibsen::Dados()
{
  MACD *MACD_oo = new MACD;
  OBV *OBV_oo = new OBV;


  LinMACD = MACD_oo.Valor(0,0); //0 - Main line
  LinSinal = MACD_oo.Valor(1,0); //1 - Signal Line
  m1 = MACD_oo.Cx(0); //Cx MACD
  m2 = MACD_oo.Cx(1); //Cx Sinal
  distancia = MACD_oo.Distancia_Linha_Zero(); //distância do indicador Histograma MACD ao eixo zero;
  MACD_Resultado = Crisp_MACD();
  Volume_Resultado = OBV_oo.Cx();
  alpha =  MACD_oo.Cx(0); //Cx MACD
  delete(MACD_oo);
  delete(OBV_oo);

  HIST = Fuzzy_HIST(distancia,alpha);
  MOMENTO = Fuzzy_Momento();
  SINAL = Fuzzy_Sinal();

}

void Ibsen::Avalia()
{


}

void Ibsen::Comentario()
{
  //AQUI ESTA COMENTADO PARA PERFORMANCE DE OTIMIZACAO

  MACD *MACD_oo = new MACD;
  OBV *OBV_oo = new OBV;

  if(!Otimizacao) Comentario_Robo = "\n MACD Cx(0) : " + DoubleToString(MACD_oo.Cx(0)); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n MACD Cx(1) : " + DoubleToString(MACD_oo.Cx(1)); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n Normalizacao_Valores_MACD(0,0,0) : " + DoubleToString(MACD_oo.Normalizacao_Valores_MACD(0,0,0)); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n Normalizacao_Valores_MACD(0,-1,-1) : " + DoubleToString(MACD_oo.Normalizacao_Valores_MACD(0,-1,-1)); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n Distancia_Linha_Zero() : " + DoubleToString(MACD_oo.Distancia_Linha_Zero()); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n Distancia_Linha_Sinal() : " + DoubleToString(MACD_oo.Distancia_Linha_Sinal()); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n Diferenca_Angulo_Linha_Sinal() : " + DoubleToString(MACD_oo.Diferenca_Angulo_Linha_Sinal()); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n MACD_Resultado : " + DoubleToString(MACD_Resultado); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n HIST : " + DoubleToString(HIST); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n MOMENTO : " + DoubleToString(MOMENTO); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n VOLUME : " + DoubleToString(Volume_Resultado); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n SINAL : " + DoubleToString(SINAL); //DEBUG

  delete(OBV_oo);
  delete(MACD_oo);
}


#include <ibsen\ibsen_MACD.mqh>
#include <ibsen\ibsen_MOMENTO.mqh>
#include <ibsen\ibsen_SINAL.mqh>

BB O_BB(TimeFrame,NULL,p_bb);
//Ibsen Ibsen_o ;
