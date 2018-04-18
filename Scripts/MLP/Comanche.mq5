//+------------------------------------------------------------------+
//|                                                     TestMLPs.mq5 |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
#include <Math\Alglib\alglib.mqh>
#include <ML.mqh>
#property strict
#property script_show_inputs
//+------------------------------------------------------------------+
input int epochs = 1000;
input int segunda_camada = 10;
input int terceira_camada = 6;
input int quarta_camada = 2;
input int restarts_ = 5 ;
input double wstep_ = 0.001 ;
input double decay_ = 0.01 ;
input bool Salva_Arquivo = false;
input string nome_arquivo = "Zefero_Corte.hist";
double mse = 0;
//+------------------------------------------------------------------+
void OnStart()
{
 
    ML *machine_learning = new ML;

    CAlglib algebra;
    CMultilayerPerceptronShell network;

    int amostras;

    machine_learning.ML_Load(nome_arquivo);

    amostras = machine_learning.numero_linhas;


    Print("machine_learning.num_linhas " + IntegerToString(machine_learning.numero_linhas));
    Print("machine_learning.entradas " + IntegerToString(machine_learning.entradas));


    CMatrixDouble xy(amostras+1,machine_learning.entradas);
    for(int i = 0; i < amostras; i++) {
      for(int j = 0; j < machine_learning.entradas; j++)
      {
          xy[i].Set(j,machine_learning.Matriz[i][j]);
      }
    }

    CMLPReportShell infotreino;

    int resposta;

    algebra.MLPCreateC2(machine_learning.entradas-1,segunda_camada,terceira_camada,quarta_camada,network);
    // algebra.MLPTrainLM(network,xy,amostras,decay_,restarts,resposta,infotreino);
    algebra.MLPTrainLBFGS(network,xy,amostras,decay_,restarts_,wstep_,epochs,resposta,infotreino);

    string Nome_Arquivo = nome_arquivo+"."+IntegerToString(machine_learning.entradas-1)+"-"
    +IntegerToString(segunda_camada)+"-"+IntegerToString(terceira_camada)+"-"+IntegerToString(quarta_camada);
    if(Salva_Arquivo) machine_learning.SalvaRede(network,Nome_Arquivo,machine_learning.entradas-1,segunda_camada,terceira_camada,quarta_camada);

    mse = algebra.MLPRMSError(network,xy,amostras);

    Print("Erro? " + DoubleToString(algebra.MLPRMSError(network,xy,amostras)));

    delete machine_learning;
    ExpertRemove();
}
//+------------------------------------------------------------------+
