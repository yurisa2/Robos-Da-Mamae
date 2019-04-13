/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                              Sa2 |
//|                                           https://www.sa2.com.br |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

#include <Math\Alglib\alglib.mqh>

class ANN
{
  public:

  ANN() {
    this.linhas = 0;
    this.linesize = 0;
    this.rna_grau_liberdade_alpha = 2;
    this.rna_camada_saida = 2;
    this.rna_hidden_layers = 1; //Desligando para tentar sistema auto9matico com liberdade
    this.rna_segunda_camada = 10; //Desligando para tentar sistema auto9matico com liberdade
    this.rna_terceira_camada = 0; //Desligando para tentar sistema auto9matico com liberdade
    this.rna_decay_ = 0.01 ;

  };

  void trainANN(CMultilayerPerceptronShell &network_trn);
  void process(double &y[], CMultilayerPerceptronShell &objRed,double &x[]);

  int linhas;
  int linesize;
  int rna_grau_liberdade_alpha;
  int rna_camada_saida;
  int rna_hidden_layers;
  int rna_segunda_camada;
  int rna_terceira_camada;
  double Matriz[][100];
  double rna_decay_;
  int rna_restarts_;
  double mse;

  private:

};


void ANN::trainANN(CMultilayerPerceptronShell &network_trn)
{
  CAlglib algebra_trn;
  CMLPReportShell infotreino_trn;

  // int amostras = this.linhas; //Verificar a Matrix // ORIGINAL
  int amostras = ArrayRange(this.Matrix,0); //Automatico

  PrintFormat("Amostras: %f | Entradas: %f: ",amostras,this.linesize);

  int resposta_trn;

  double total_neuronios = ((amostras) / (rna_grau_liberdade_alpha *((this.linesize-1) + rna_camada_saida)));

  if(total_neuronios > 200) rna_hidden_layers = 2;

  double rna_neuronios_por_camadas = total_neuronios / rna_hidden_layers;

  if(MathMod(total_neuronios,rna_hidden_layers) == 1)
  {
    rna_segunda_camada = int(MathFloor(rna_neuronios_por_camadas) + 1);
    rna_terceira_camada = int(MathFloor(rna_neuronios_por_camadas));
  }
  else rna_segunda_camada = int(rna_neuronios_por_camadas);

  PrintFormat("trainANN em %i Amostras",amostras);
  PrintFormat("Entradas %i ",linesize);
  PrintFormat("total_neuronios: %f ",total_neuronios);
  PrintFormat("rna_hidden_layers: %i ",rna_hidden_layers);
  PrintFormat("rna_segunda_camada: %i ",rna_segunda_camada);
  if(rna_hidden_layers == 2) PrintFormat("rna_terceira_camada: %i ",rna_terceira_camada);


  // algebra_trn.MLPCreateC2(this.linesize-1,rna_segunda_camada,rna_terceira_camada,rna_camada_saida,network_trn);
  if(rna_hidden_layers == 0) algebra_trn.MLPCreateC0(this.linesize-1,rna_camada_saida,network_trn);
  if(rna_hidden_layers == 1) algebra_trn.MLPCreateC1(this.linesize-1,rna_segunda_camada,rna_camada_saida,network_trn);
  if(rna_hidden_layers == 2) algebra_trn.MLPCreateC2(this.linesize-1,rna_segunda_camada,rna_terceira_camada,rna_camada_saida,network_trn);

  int nPesos = 0;
  int linesize_prop = this.linesize-1;
  CAlglib::MLPProperties(network_trn, linesize_prop, rna_camada_saida, nPesos);

  int rna_amostras_principal = 0;
  int rna_amostras_validacao = 0;

  rna_amostras_principal = int(MathFloor(amostras/1.25)); //Esse Virou Amostra (PARETO DISSE 80/20)
  rna_amostras_validacao = int(amostras-rna_amostras_principal);

  //AQUI EH O PRINCIPAL
  CMatrixDouble xy_principal(rna_amostras_principal+1,this.linesize);
  for(int i = 0; i < rna_amostras_principal; i++)
  { //Mano AQUI FAVA i = amostras?!?!?!?! WAHHHHHH?
    for(int j = 0; j < this.linesize; j++)
    {
      xy_principal[i].Set(j,this.Matriz[i][j]);
      // PrintFormat("xy[%f].Set(%f,%f)",i,j,this.Matriz[i][j]); //DEBUG Verifica a Matriz XY
    }
  }

  //AQUI EH O Validacao
  CMatrixDouble xy_valida(rna_amostras_validacao+1,this.linesize);
  for(int i = rna_amostras_principal; i < (rna_amostras_principal+rna_amostras_validacao); i++)
  { //Mano AQUI FAVA i = amostras?!?!?!?! WAHHHHHH?
    int i_2 = i - rna_amostras_principal;
    for(int j = 0; j < this.linesize; j++)
    {
      xy_valida[i_2].Set(j,this.Matriz[i][j]);
      // PrintFormat("xy[%f].Set(%f,%f)",i,j,this.Matriz[i][j]); //DEBUG Verifica a Matriz XY
    }
  }

  CMatrixDouble xy_inteira(amostras+1,this.linesize);
  for(int i = 0; i < amostras; i++)
  { //Mano AQUI FAVA i = amostras?!?!?!?! WAHHHHHH?
    for(int j = 0; j < this.linesize; j++)
    {
      xy_inteira[i].Set(j,this.Matriz[i][j]);
      // PrintFormat("xy[%f].Set(%f,%f)",i,j,this.Matriz[i][j]); //DEBUG Verifica a Matriz XY
    }
  }

  if(nPesos < 1000)
  {
    Print("Numero de Pesos Menor que 1000, LM. Pesos: " + IntegerToString(nPesos));
    algebra_trn.MLPTrainLM(network_trn,xy_inteira,amostras,rna_decay_,rna_restarts_,resposta_trn,infotreino_trn);
  }
  if(nPesos > 1000 || nPesos == 0)
  {
    Print("Numero de Pesos Maior que 1000, Early Stopping. Pesos: " + IntegerToString(nPesos));
    PrintFormat("rna_amostras_principal: %i ",rna_amostras_principal);
    PrintFormat("rna_amostras_validacao: %i ",rna_amostras_validacao);

    algebra_trn.MLPTrainES(network_trn,xy_principal,rna_amostras_principal,xy_valida,rna_amostras_validacao,rna_decay_,rna_restarts_,resposta_trn,infotreino_trn);
  }
  this.mse = algebra_trn.MLPRelClsError(network_trn,xy_inteira,amostras);

  string camadas = "";
  if(rna_hidden_layers == 0) camadas = "-(0)";
  if(rna_hidden_layers == 1) camadas = "-(1)"+IntegerToString(rna_segunda_camada);
  if(rna_hidden_layers == 2) camadas = "-(2)"+IntegerToString(rna_segunda_camada)+"-"+IntegerToString(rna_terceira_camada);


  Print("Entradas: " + IntegerToString(this.linesize-1));
  Print("Pesos: " + IntegerToString(nPesos));
  Print("Erro% " + DoubleToString(this.mse));
}


void ANN::process(double &y[], CMultilayerPerceptronShell &objRed,double &x[])
{

  // dados_nn.Dados_Entrada(); // Entrada

  CAlglib algebra_proc;

  algebra_proc.MLPProcess(objRed,x,y);


  Print("ANN y: ");
  ArrayPrint(y);

}
