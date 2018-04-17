//+------------------------------------------------------------------+
//|                                                     TestMLPs.mq5 |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
#include <Math\Alglib\alglib.mqh>
#include <ML.mqh>
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
void OnStart()
{
  ML *machine_learning = new ML;

  CAlglib algebra;
  CMultilayerPerceptronShell network;

  int epochs = 100;
  int amostras;
  int restarts = 4 ;
  double wstep = 0.001 ;
  double decay = 0.01 ;

  machine_learning.ML_Load("Zefero.hist");

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
        PrintFormat("xy[%i].Set(%i,machine_learning.Matriz[%i][%i]) Valor: %i",i,j,i,j,machine_learning.Matriz[i][j]);
    }
  }

  // double x[] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0};
  // double y[] = {0,0};
  //
  // CMLPReportShell infotreino;
  //
  // int resposta;
  //
  // algebra.MLPCreateC2(9,10,6,2,network);
  // // algebra.MLPTrainLM(network,xy,amostras,decay,restarts,resposta,infotreino);
  // algebra.MLPTrainLBFGS(network,xy,amostras,decay,restarts,wstep,epochs,resposta,infotreino);
  //
  // machine_learning.SalvaRede(network,"Networken");
  //
  // int handleTeste= FileOpen("teste", FILE_WRITE|FILE_BIN|FILE_COMMON);
  //
  // Print("Erro? " + algebra.MLPRMSError(network,xy,amostras));
  //
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
