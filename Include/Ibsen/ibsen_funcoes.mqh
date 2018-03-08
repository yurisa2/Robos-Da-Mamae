/* -*- C++ -*- */

class Ibsen
{

  public:
  Ibsen();
  void Comentario();
  void Avalia();
  double alpha; //ângulo da reta obtido pela regressão linear dos três últimos
  double HIST; //HIST = Indicador Histograma MACD
  double MOMENTO; //HIST = Indicador Histograma MACD
  double SINAL;
  double MACD_Resultado; //Resultado da Tabela 1
  double Volume_Resultado; //Mais Ou Menos Fuzzy
  double Entrada_fvHIST_M; //Mais Ou Menos Fuzzy
  double Entrada_fvMACD_M; //Mais Ou Menos Fuzzy
  double Ibsen::Fuzzy_HIST(double HIST_distancia = NULL, double HIST_alpha = NULL);
  double Ibsen::Fuzzy_Momento();
  double Ibsen::Fuzzy_Sinal();
  double Ibsen::Fuzzy_CEV(); //Tabela 4 pag 103   |  -2 a 2 (Muito baixo a muito alto)


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
  OBV *OBV_oo = new OBV;
  MACD *MACD_oo = new MACD;


  MACD_Resultado = Crisp_MACD();
  Volume_Resultado = OBV_oo.Cx(1);


  HIST = Fuzzy_HIST(MACD_oo.Distancia_Linha_Zero(),MACD_oo.Distancia_Linha_Zero());
  MOMENTO = Fuzzy_Momento();
  SINAL = Fuzzy_Sinal();

  delete(OBV_oo);
  delete(MACD_oo);
}

void Ibsen::Avalia()
{


}

void Ibsen::Comentario()
{
  //AQUI ESTA COMENTADO PARA PERFORMANCE DE OTIMIZACAO
  //alpha = MACD_oo.Cx(0)


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
  if(!Otimizacao) Comentario_Robo += "\n VOLUME DIRETO : " + DoubleToString(OBV_oo.Cx()); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n VOLUME Normalizado : " + DoubleToString(OBV_oo.Normalizado()); //DEBUG

  if(!Otimizacao) Comentario_Robo += "\n Crisp_MACD() : " + DoubleToString(Crisp_MACD()); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n Fuzzy_HIST(distancia,alpha) : " + DoubleToString(Fuzzy_HIST(MACD_oo.Distancia_Linha_Zero(),MACD_oo.Cx(0))); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n SINAL : " + DoubleToString(SINAL); //DEBUG
  if(!Otimizacao) Comentario_Robo += "\n CEV : " + DoubleToString(Fuzzy_CEV()); //DEBUG

  delete(OBV_oo);
  delete(MACD_oo);
}


#include <ibsen\ibsen_MACD.mqh>
#include <ibsen\ibsen_MOMENTO.mqh>
#include <ibsen\ibsen_SINAL.mqh>
#include <ibsen\ibsen_CEV.mqh>
#include <ibsen\ibsen_file.mqh>

BB O_BB(TimeFrame,NULL,p_bb);
//Ibsen Ibsen_o ;
