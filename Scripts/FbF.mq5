//+------------------------------------------------------------------+
//|                                                     TestMLPs.mq5 |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
string Nome_Robo = "ML_JarqueBeraTest";

#include <Math\Alglib\alglib.mqh>
 #include <Math\Stat\Stat.mqh>
#include <dados_nn_stub.mqh>
#include <ML.mqh>
#include <Inputs_ML.mqh>

ENUM_TIMEFRAMES TimeFrame = TimeFrame_;                              //TimeFrame base
int Tipo_Comentario = 0;                                          //Tipo de Comentario (0 - simples, 1 - Avancado, 2 - DEBUG)
bool rna_filtros_on = false;
bool rdf_filtros_on = false;

#property strict
#property script_show_inputs

void OnStart()
{
  Print("Let the games begin: "+TimeToString(TimeCurrent(),TIME_SECONDS));


  //Carrega Historico
  machine_learning.ML_Load(ml_nome_arquivo_hist);

  double features_scores[];
classifica_features(features_scores);


int num_features = 5;
double organizado[];
ArrayResize(organizado,ArraySize(features_scores));
ArrayCopy(organizado,features_scores);
ArraySort(organizado);

double array_valores_temps[];


for(int i = 0, j = 0; i < ArraySize(organizado); i++)
{
  if(organizado[i] > 0.01)
  {
    ArrayResize(array_valores_temps,j+1);
    array_valores_temps[j] = organizado[i];
    PrintFormat("#%i = %f",j,array_valores_temps[j]);
    j++;
    if(j == num_features) break;
  }
}
//Agora precisa pegar esses valores e achar o numero da feature


Print("foi bom: "+TimeToString(TimeCurrent(),TIME_SECONDS));

  ExpertRemove();
}

void FeatureByFeature(double &Matriz_entrada[][100], double indice_coluna, double &coluna_resultado[][3])
{
  double Linhas_Perde[];
  double Linhas_Ganha[];

  ArrayResize(coluna_resultado,ArrayRange(Matriz_entrada,0));

  for(int j = 0; j < machine_learning.entradas; j++)
  {
    if(indice_coluna == j)
    {
      int k = 0;
      // PrintFormat("Coluna %i",j); //DEBUG
      for(int i = 0; i < ArrayRange(Matriz_entrada,0); i++)
      {
        coluna_resultado[k][0] = Matriz_entrada[i][j];
        coluna_resultado[k][1] = Matriz_entrada[i][machine_learning.entradas-2];
        coluna_resultado[k][2] = Matriz_entrada[i][machine_learning.entradas-1];
        // PrintFormat("k: %i Value: %f resultado: %f",k,coluna_resultado[k][0],coluna_resultado[k][1]); //DEBUG
        k++;
      }
    }
  }
}

double TreinaFeature(double &coluna_resultado[][3])
{
int rna_grau_liberdade = 5;
int amostras = ArrayRange(coluna_resultado,0);
CMLPReportShell infotreino_trn;
CDFReportShell infotreino_trn_rdf;
CMultilayerPerceptronShell network_trn;

CDecisionForestShell tree_trn;

int resposta_trn;

double array_desvio[];
ArrayResize(array_desvio,amostras);

CMatrixDouble xy_feature(amostras,3);
for(int i = 0; i < amostras; i++)
{
    xy_feature[i].Set(0,coluna_resultado[i][0]);
    xy_feature[i].Set(1,coluna_resultado[i][1]);
    xy_feature[i].Set(2,coluna_resultado[i][2]);
    array_desvio[i] = coluna_resultado[i][0];
}


int total_neuronios = int(MathRound(((amostras) / (rna_grau_liberdade *(1 + 2)))));
// PrintFormat("Amostras: %i",amostras);
// PrintFormat("TotalNeuronios: %i",total_neuronios);
CAlglib::MLPCreateC0(2,2,network_trn);
CAlglib::MLPTrainLM(network_trn,xy_feature,amostras,0.001,10,resposta_trn,infotreino_trn);

// CAlglib::DFBuildRandomDecisionForest(xy_feature,amostras,2,2,50,0.1,resposta_trn,tree_trn,infotreino_trn_rdf);

double desvio = MathStandardDeviation(array_desvio);

// PrintFormat("Desvio Padrao: %f",desvio);
// PrintFormat("Desvio Padrao: %f",desvio);
// double erro = CAlglib::MLPRelClsError(network_trn,xy_feature,amostras);
// PrintFormat("MLPRelClsError %f",erro);
 double erro = CAlglib::MLPAvgCE(network_trn,xy_feature,amostras);
// PrintFormat("MLPAvgCE %f",erro);
//  erro = CAlglib::MLPRMSError(network_trn,xy_feature,amostras);
// PrintFormat("MLPRMSError %f",erro);
// double erro = CAlglib::DFRelClsError(tree_trn,xy_feature,amostras);
// PrintFormat("DFRelClsError %f",erro);
//  erro = CAlglib::DFAvgCE(tree_trn,xy_feature,amostras);  //PROMISSOR
// PrintFormat("DFAvgCE %f",erro);
//  erro = CAlglib::DFRMSError(tree_trn,xy_feature,amostras); //Promissor
// PrintFormat("DFRMSError %f",erro);

double retorno = erro * desvio; //Testar com o Decay Certo
// double retorno = MathMin(erro,(1-erro)); //Testar com o Decay Certo

return retorno;
}

void classifica_features(double &features_scores[])
{
// for(int i = 0; i < 5; i++)
for(int i = 0; i < machine_learning.entradas-2; i++)
// for(int i = 0; i < 10; i++)
{
  ArrayResize(features_scores,i+1);
  double feature_resultado[][3];
  FeatureByFeature(machine_learning.Matriz,i,feature_resultado);
  features_scores[i] = TreinaFeature(feature_resultado);
  // PrintFormat("Erro da feature %i: %f",i,score);
  ArrayFree(feature_resultado);
}
}
