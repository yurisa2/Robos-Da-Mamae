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

ENUM_TIMEFRAMES TimeFrame = PERIOD_CURRENT;                              //TimeFrame base
int Tipo_Comentario = 0;                                          //Tipo de Comentario (0 - simples, 1 - Avancado, 2 - DEBUG)
bool rna_filtros_on = false;
bool rdf_filtros_on = false;

#property strict
#property script_show_inputs

void OnStart()
{

  double Matriz_perde[][100];
  double Matriz_ganha[][100];
  int num_perdeu = 0;
  int num_ganhou = 0;


  //Carrega Historico
  machine_learning.ML_Load(ml_nome_arquivo_hist);


for(int i = 0; i < 2; i++)
{
  double feature_resultado[][2];
  FeatureByFeature(machine_learning.Matriz,1,feature_resultado);
  double erro = TreinaFeature(feature_resultado);
  PrintFormat("Erro da feature %i: %f",i,erro);
  ArrayFree(feature_resultado);
}



  ExpertRemove();
}

void FeatureByFeature(double &Matriz_entrada[][100], double indice_coluna, double &coluna_resultado[][2])
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
        coluna_resultado[k][1] = Matriz_entrada[i][machine_learning.entradas-1];
        PrintFormat("k: %i Value: %f resultado: %f",k,coluna_resultado[k][0],coluna_resultado[k][1]); //DEBUG
        k++;
      }
    }
  }
}

double TreinaFeature(double &coluna_resultado[][2])
{
int rna_grau_liberdade = 2;
int amostras = ArrayRange(coluna_resultado,0);
CMLPReportShell infotreino_trn;
CMultilayerPerceptronShell network_trn;
int resposta_trn;

CMatrixDouble xy_feature(amostras,2);
for(int i = 0; i < amostras; i++)
{
    xy_feature[i].Set(0,coluna_resultado[i][0]);
    xy_feature[i].Set(1,coluna_resultado[i][1]);
}


int total_neuronios = int(MathRound(((amostras) / (rna_grau_liberdade *(1 + 2)))));
CAlglib::MLPCreateC1(1,total_neuronios,2,network_trn);
CAlglib::MLPTrainLM(network_trn,xy_feature,amostras,0.01,0,resposta_trn,infotreino_trn);


return CAlglib::MLPRelClsError(network_trn,xy_feature,amostras);
}
