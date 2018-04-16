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
  int amostras = 20 ;
  int restarts = 4 ;
  double wstep = 0.001 ;
  double decay = 0.01 ;


  string linha_entradas;

for(int i = 0; i < amostras; i++) {
  double numero1 = numero();
  double numero2 = numero();
  double numero3 = numero();
  double numero4 = numero();
  double numero5 = numero();
  double numero6 = numero();
  double numero7 = numero();
  double numero8 = numero();
  double numero9 = numero();

  // Print("Numero: " + numero1);
  // Print("Numero: " + numero2);
  // Print("classifica: " + classifica(numero1,numero2));
  // Print("i: " + i);
  string resultado = classifica(numero1,numero2,numero3,numero4,numero5,numero6,numero7,numero8,numero9);

  linha_entradas = numero1 + "," + numero2 + "," + numero3 + "," + numero4 + "," + numero5 + "," + numero6 + "," + numero7 + "," + numero8 + "," + numero9 + "," + resultado;
  machine_learning.Append(linha_entradas);

}

machine_learning.ML_Save("teste_ML.txt");
Print("machine_learning.ML_Save.entradas"+machine_learning.entradas);

CMatrixDouble xy(amostras+1,machine_learning.entradas);
for(int i = 0; i < amostras; i++) {
  for(int j = 0; j < machine_learning.entradas; j ++)
  {
    xy[i].Set(j,machine_learning.Matriz[i][j]);
    xy[i].Set(j,machine_learning.Matriz[i][j]);
    xy[i].Set(j,machine_learning.Matriz[i][j]);
    xy[i].Set(j,machine_learning.Matriz[i][j]);
    xy[i].Set(j,machine_learning.Matriz[i][j]);
    xy[i].Set(j,machine_learning.Matriz[i][j]);
    xy[i].Set(j,machine_learning.Matriz[i][j]);
    xy[i].Set(j,machine_learning.Matriz[i][j]);
    xy[i].Set(j,machine_learning.Matriz[i][j]);
    xy[i].Set(j,machine_learning.Matriz[i][j]);
  }
}



  double x[] = {0,0,0,0,0,0,0,0,0};
  double y[] = {0,0};

  CMLPReportShell infotreino;

  int resposta;

  algebra.MLPCreateC2(9,10,6,2,network);
  // algebra.MLPTrainLM(network,xy,amostras,decay,restarts,resposta,infotreino);
  algebra.MLPTrainLBFGS(network,xy,amostras,decay,restarts,wstep,epochs,resposta,infotreino);

  SalvaRede(network,"Networken");


   Print("Erro? " + algebra.MLPRMSError(network,xy,amostras));

  x[0] = 0.1;
  x[1] = 0.2;
  x[2] = 0.3;
  x[3] = 0.3;
  x[4] = 0.2;
  x[5] = 0.1;
  x[6] = 0.2;
  x[7] = 0.3;
  x[8] = 0.1;
  algebra.MLPProcess(network,x,y);

  Print("Menor "+x[0]+x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[7]+x[8]);
  Print("y[0]: "+y[0]);
  Print("y[1]: "+y[1]);

  x[0] = 0.9;
  x[1] = 0.82;
  x[2] = 0.83;
  x[3] = 0.73;
  x[4] = 0.62;
  x[5] = 0.71;
  x[6] = 0.82;
  x[7] = 0.53;
  x[8] = 0.51;
  algebra.MLPProcess(network,x,y);

  Print("Maior "+x[0]+x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[7]+x[8]);
  Print("y[0]: "+y[0]);
  Print("y[1]: "+y[1]);

  x[0] = 0.41;
  x[1] = 0.56;
  x[2] = 0.45;
  x[3] = 0.43;
  x[4] = 0.32;
  x[5] = 0.21;
  x[6] = 0.12;
  x[7] = 0.43;
  x[8] = 0.31;
  algebra.MLPProcess(network,x,y);

  Print("Pouco Menor "+x[0]+x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[7]+x[8]);
  Print("y[0]: "+y[0]);
  Print("y[1]: "+y[1]);

  x[0] = 0.61;
  x[1] = 0.56;
  x[2] = 0.45;
  x[3] = 0.83;
  x[4] = 0.72;
  x[5] = 0.61;
  x[6] = 0.82;
  x[7] = 0.93;
  x[8] = 0.51;
  algebra.MLPProcess(network,x,y);

  Print("Pouco Maior "+x[0]+x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[7]+x[8]);
  Print("y[0]: "+y[0]);
  Print("y[1]: "+y[1]);

  delete machine_learning;
}
//+------------------------------------------------------------------+

//POSITIVO NEGATIVO
// double numero() {
//   double retorno = MathRand();
//   retorno = retorno / 32767;
//   int sinal = MathRand();
//   if(MathMod(sinal,2) == 0) sinal = 1;
//   else sinal = -1;
//
//   return retorno * sinal;
// }
// double classifica(double numero) {
// double retorno = 0;
//
//   if(numero > 0) retorno = 0;
//   if(numero < 0) retorno = 1;
//   if(numero == 0) retorno = 0;
//
//
// return retorno;
// }

//PAR IMPAR
double numero() {
  double retorno = MathRand();
  retorno = retorno / 32767;
  int sinal = MathRand();
  if(MathMod(sinal,2) == 0) sinal = 1;
  else sinal = 1;
  // else sinal = -1;

  return retorno * sinal;
}

double classifica(double numero1,double numero2,double numero3,double numero4,double numero5,double numero6,double numero7,double numero8,double numero9) {
double retorno = 0;

if(numero1 + numero2 + numero3 + numero4 + numero5 + numero6 + numero7 + numero8 + numero9 < 4.5) retorno = 1;
else retorno = 0;

return retorno;
}


bool SalvaRede(CMultilayerPerceptronShell &objRed, string nombArch= "")
{
  int flw =0;
   int k= 0, i= 0, j= 0, numCapas= 0, arNeurCapa[], neurCapa1= 1, funcTipo= 0, puntFichRed= 9999;
   double umbral= 0, peso= 0, media= 0, sigma= 0;
   if(nombArch=="") nombArch= "copiaSegurRed";
   nombArch= nombArch+".red";
   FileDelete(nombArch, FILE_COMMON);
   ResetLastError();
   puntFichRed= FileOpen(nombArch, FILE_WRITE|FILE_BIN|FILE_COMMON);

      numCapas= CAlglib::MLPGetLayersCount(objRed);
  flw = FileWriteDouble(puntFichRed, numCapas)>0;
      ArrayResize(arNeurCapa, numCapas);
      for(k= 0; k<numCapas; k++)
      {
         arNeurCapa[k]= CAlglib::MLPGetLayerSize(objRed, k);
      flw = FileWriteDouble(puntFichRed, arNeurCapa[k])>0;
      }
      for(k= 0; k<numCapas; k++)
      {
         for(i= 0; i<arNeurCapa[k]; i++)
         {
            if(k==0)
            {
               CAlglib::MLPGetInputScaling(objRed, i, media, sigma);
               FileWriteDouble(puntFichRed, media);
               FileWriteDouble(puntFichRed, sigma);
            }
            else if(k==numCapas-1)
            {
               CAlglib::MLPGetOutputScaling(objRed, i, media, sigma);
               FileWriteDouble(puntFichRed, media);
               FileWriteDouble(puntFichRed, sigma);
            }
            CAlglib::MLPGetNeuronInfo(objRed, k, i, funcTipo, umbral);
            FileWriteDouble(puntFichRed, funcTipo);
            FileWriteDouble(puntFichRed, umbral);
            for(j= 0; k<(numCapas-1) && j<arNeurCapa[k+1]; j++)
            {
               peso= CAlglib::MLPGetWeight(objRed, k, i, k+1, j);
            flw = FileWriteDouble(puntFichRed, peso)>0;
            }
         }
      }
      FileFlush(puntFichRed);
      FileClose(puntFichRed);
      return(1);

   }
