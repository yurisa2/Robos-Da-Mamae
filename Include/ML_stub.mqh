/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                  File_Writer.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"
int entrada = 7;
double x_entrada[7];
double resposta_y[2];
int rna_entrada = entrada;
class CMultilayerPerceptronShell
  {

};
class CDecisionForestShell
  {

};

class ML
{

  public:
  // ML() {ArrayResize(x_entrada,entrada);};
  void ML_Load(string NomeArquivo){};
  void  ML_Save(string NomeArquivo){};
  void Append(string Linha){};
  void Treino_RNA(CMultilayerPerceptronShell &network_trn){};
  bool Levanta_RNA(CMultilayerPerceptronShell &objRed, string nombArch= ""){return 1;};
  bool Salva_RNA(CMultilayerPerceptronShell &objRed, string nombArch= ""){return 1;};
  void Processa_RNA(double &y[], CMultilayerPerceptronShell &objRed, double &x[]){};
  void Treino_RDF(CDecisionForestShell &tree_trn){};
  bool Salva_RDF(CDecisionForestShell &tree_trn, string nombArch= ""){return 1;};
  bool Levanta_RDF(CDecisionForestShell &tree_trn, string nombArch= ""){return 1;};
  void Processa_RDF(double &y[], CDecisionForestShell &tree_trn,double &x[]){};
  void Saida_ML(){};
  double resp_y[2];
  CMultilayerPerceptronShell rede_obj;
  CDecisionForestShell      tree_obj;
  double Matriz[][1];
  string Lines[];
  double mse;
  int numero_linhas;
  int entradas; //colunas ativas (sem NULL)

  private:
  int Handle_Arquivo;

};

ML machine_learning;
