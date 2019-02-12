//+------------------------------------------------------------------+
//|                                                     TestMLPs.mq5 |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
#include <Math\Alglib\alglib.mqh>

//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
void OnStart()
{
  CAlglib algebra;
  CMultilayerPerceptronShell network;

  CMatrixDouble xy(4,4);


  xy[0].Set(0,1);
  xy[0].Set(1,1);
  xy[0].Set(2,2);
  xy[0].Set(3,1);

  xy[1].Set(0,1);
  xy[1].Set(1,2);
  xy[1].Set(2,3);
  xy[1].Set(3,2);

  xy[2].Set(0,2);
  xy[2].Set(1,1);
  xy[2].Set(2,3);
  xy[2].Set(3,2);

  xy[3].Set(0,2);
  xy[3].Set(1,2);
  xy[3].Set(2,4);
  xy[3].Set(3,5);



  double x[] = {2,1};
  double y[] = {0,0};

  CMLPReportShell infotreino;

  int resposta;

  algebra.MLPCreate1(2,5,2,network);
  algebra.MLPTrainLM(network,xy,10,0.01,2,resposta,infotreino);

  algebra.MLPProcess(network,x,y);

  Print("x[0]: "+x[0]);
  Print("x[1]: "+x[1]);
  Print("y[0]: "+y[0]);
  Print("y[1]: "+y[1]);

}
//+------------------------------------------------------------------+


double numero() {
  double retorno = MathRand();
  retorno = retorno / 32767;
  int sinal = MathRand();
  if(MathMod(sinal,2) == 0) sinal = 1;
  else sinal = -1;

  return retorno * sinal;
}

double classifica(double numero) {
double retorno = 0;

  if(numero > 0) retorno = 0;
  if(numero < 0) retorno = 1;
  if(numero == 0) retorno = 0;


return retorno;
}
