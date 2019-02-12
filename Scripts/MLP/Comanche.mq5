//+------------------------------------------------------------------+
//|                                                     TestMLPs.mq5 |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
#include <Math\Alglib\alglib.mqh>
#include <dados_nn_stub.mqh>
#include <ML.mqh>

#property strict
#property script_show_inputs
//+------------------------------------------------------------------+
input int rna_epochs = 1000;
input int rna_segunda_camada = 10;
input int rna_camada_saida = 2;
int rna_terceira_camada = rna_camada_saida;
input int rna_restarts_ = 5 ;
input double rna_wstep_ = 0.001 ;
input double rna_decay_ = 0.01 ;
input bool rna_Salva_Arquivo_rede = false;
input string rna_nome_arquivo_rede = "treinado.trn";
double mse = 0;

bool ml_on = 1;
bool rna_on_realtime = 0;
int rna_on_realtime_min_samples = 0;
bool rna_filtros_on = 0;

int Tipo_Comentario = 0;


//+------------------------------------------------------------------+
void OnStart()
{

    ML *machine_learning2 = new ML;

    CAlglib algebra;
    CMultilayerPerceptronShell network;

    int amostras;

    machine_learning2.ML_Load(rna_nome_arquivo_rede);

    amostras = machine_learning2.numero_linhas;


    Print("machine_learning2.num_linhas " + IntegerToString(machine_learning2.numero_linhas));
    Print("machine_learning2.entradas " + IntegerToString(machine_learning2.entradas));


    CMatrixDouble xy(amostras+1,machine_learning2.entradas);
    for(int i = 0; i < amostras; i++) {
      for(int j = 0; j < machine_learning2.entradas; j++)
      {
          xy[i].Set(j,machine_learning2.Matriz[i][j]);
      }
    }

    CMLPReportShell infotreino;

    int resposta;

    algebra.MLPCreateC1(machine_learning2.entradas-1,rna_segunda_camada,rna_camada_saida,network);
    // algebra.MLPTrainLM(network,xy,amostras,decay_,restarts,resposta,infotreino);
    algebra.MLPTrainLBFGS(network,xy,amostras,rna_decay_,rna_restarts_,rna_wstep_,rna_epochs,resposta,infotreino);

    string rna_rna_nome_arquivo_rede_rede = rna_nome_arquivo_rede+"."+IntegerToString(machine_learning2.entradas-1)+"-"
    +IntegerToString(rna_segunda_camada)+"-"+IntegerToString(rna_camada_saida);
    if(rna_Salva_Arquivo_rede) machine_learning2.Salva_RNA(network,rna_rna_nome_arquivo_rede_rede,machine_learning2.entradas-1,rna_segunda_camada,rna_camada_saida);

    mse = algebra.MLPRMSError(network,xy,amostras);

    Print("Erro? " + DoubleToString(algebra.MLPRMSError(network,xy,amostras)));

    delete machine_learning2;
    ExpertRemove();
}
//+------------------------------------------------------------------+
