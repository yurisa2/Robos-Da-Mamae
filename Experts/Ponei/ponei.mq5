//+------------------------------------------------------------------+
//|                                                     TestMLPs.mq5 |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
#include <Math\Alglib\alglib.mqh>
#include <ML.mqh>
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
input int segunda_camada = 6;
input int terceira_camada = 3;
int epochs = 10;
int restarts_ = 1 ;

double mse = 0;
//+-----------------------------------------------------------------+
void OnInit()
{
  int amostras;

    ML *machine_learning = new ML;

    CAlglib algebra;
    CMultilayerPerceptronShell network;

    double wstep = 0.001 ;
    double decay = 0.01 ;

    machine_learning.ML_Load("Zefero_Corte.hist");

    amostras = machine_learning.numero_linhas;
    // machine_learning.entradas;

    // Print("Amostras " + amostras);
    // Print("machine_learning.num_linhas " + machine_learning.numero_linhas);
    // Print("machine_learning.entradas " + machine_learning.entradas);


    CMatrixDouble xy(amostras+1,machine_learning.entradas);
    for(int i = 0; i < amostras; i++) {
      for(int j = 0; j < machine_learning.entradas; j++)
      {
          xy[i].Set(j,machine_learning.Matriz[i][j]);
          // PrintFormat("xy[%i].Set(%i,machine_learning.Matriz[%i][%i]) Valor: %i",i,j,i,j,machine_learning.Matriz[i][j]);
          // Print("machine_learning.Matriz[i][j] " + machine_learning.Matriz[i][j]);
      }
    }

    // double x[] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0};
    // double y[] = {0,0};

    CMLPReportShell infotreino;

    int resposta;

    algebra.MLPCreateC2(machine_learning.entradas-1,segunda_camada,terceira_camada,2,network);
    // algebra.MLPTrainLM(network,xy,amostras,decay,restarts_,resposta,infotreino);
    algebra.MLPTrainLBFGS(network,xy,amostras,decay,restarts_,wstep,epochs,resposta,infotreino);

     
    machine_learning.SalvaRede(network,"Networken_teste_ultimo_extremo",machine_learning.entradas-1,segunda_camada,terceira_camada,2);

    //
    // Print("Erro? " + algebra.MLPRMSError(network,xy,amostras));
    mse = algebra.MLPRMSError(network,xy,amostras);
    // x[0] = 0.61;
    // x[1] = 0.56;
    // x[2] = 0.45;
    // x[3] = 0.83;
    // x[4] = 0.72;
    // x[5] = 0.61;
    // x[6] = 0.82;
    // x[7] = 0.93;
    // x[8] = 0.51;
    // algebra.MLPProcess(network,x,y);
    //
    // Print("Pouco Maior "+x[0]+x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[7]+x[8]);
    // Print("y[0]: "+y[0]);
    // Print("y[1]: "+y[1]);

    delete machine_learning;

}
//+------------------------------------------------------------------+

double OnTester()
{
  return mse;
}
