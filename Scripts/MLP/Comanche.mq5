//+------------------------------------------------------------------+
//|                                                     TestMLPs.mq5 |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
#include <Math\Alglib\alglib.mqh>
#include <ML.mqh>
#property strict
#property script_show_inputs
//+------------------------------------------------------------------+
input int rna_epochs = 1000;
input int rna_segunda_camada = 10;
input int rna_camada_saida = 2;
input int rna_restarts_ = 5 ;
input double rna_wstep_ = 0.001 ;
input double rna_decay_ = 0.01 ;
input bool rna_Salva_Arquivo_rede = false;
input string nome_arquivo = "Zefero_Corte.hist";
double mse = 0;
//+------------------------------------------------------------------+
void OnStart()
{

    ML *machine_learning2 = new ML;

    CAlglib algebra;
    CMultilayerPerceptronShell network;

    int amostras;

    machine_learning2.ML_Load(nome_arquivo);

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

    string rna_nome_arquivo_rede = nome_arquivo+"."+IntegerToString(machine_learning2.entradas-1)+"-"
    +IntegerToString(rna_segunda_camada)+"-"+IntegerToString(rna_camada_saida);
    if(rna_Salva_Arquivo_rede) machine_learning2.SalvaRede(network,rna_nome_arquivo_rede,machine_learning2.entradas-1,rna_segunda_camada,rna_camada_saida);

    mse = algebra.MLPRMSError(network,xy,amostras);

    Print("Erro? " + DoubleToString(algebra.MLPRMSError(network,xy,amostras)));

    delete machine_learning2;
    ExpertRemove();
}
//+------------------------------------------------------------------+
