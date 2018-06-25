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
  double frere[][2];
  double signTest[][2];
  double studentsttest[][2];
  double chi[][2];
  double wilcox[][2];


  double Matriz_perde[][100];
  double Matriz_ganha[][100];
  int num_perdeu = 0;
  int num_ganhou = 0;


  //Carrega Historico
  machine_learning.ML_Load(ml_nome_arquivo_hist);

  ML_JarqueBeraTest(machine_learning.Matriz,frere,signTest,studentsttest,chi,wilcox);

  for(int i = 0; i < machine_learning.entradas; i++)
  {

    PrintFormat("Coluna: %i JB Perde: %f10 JB Ganha: %f10 Soma: %f10",i,frere[i][0],frere[i][1],frere[i][0]+frere[i][0]+frere[i][1]);
    PrintFormat("Coluna: %i signTest Perde: %f10 signTest Ganha: %f10 Soma: %f10",i,signTest[i][0],signTest[i][1],signTest[i][0]+signTest[i][0]+signTest[i][1]);
    PrintFormat("Coluna: %i studentsttest Perde: %f10 studentsttest Ganha: %f10 Soma: %f10",i,studentsttest[i][0],studentsttest[i][1],studentsttest[i][0]+studentsttest[i][0]+studentsttest[i][1]);
    PrintFormat("Coluna: %i chi Perde: %f10 chi Ganha: %f10 Soma: %f10",i,chi[i][0],chi[i][1],chi[i][0]+chi[i][0]+chi[i][1]);
    PrintFormat("Coluna: %i wilcox Perde: %f10 wilcox Ganha: %f10 Soma: %f10",i,wilcox[i][0],wilcox[i][1],wilcox[i][0]+wilcox[i][0]+wilcox[i][1]);

  }

  ExpertRemove();
}

void ML_JarqueBeraTest(double &Matriz_entrada[][100], double &frere[][2], double &signTest[][2],double &studentsttest[][2],double &chi[][2],double &wilcox[][2])
{
  double p;
  double x[];

  double Linhas_Perde[];
  double Linhas_Ganha[];

  double bothTails;
  double leftTail;
  double rightTail;

  ArrayResize(x,ArrayRange(Matriz_entrada,0));
  ArrayResize(frere,machine_learning.entradas);

  for(int j = 0; j < machine_learning.entradas; j++)
  {
    int k = 0;
    // PrintFormat("Coluna %i",j); //DEBUG
    for(int i = 0; i < ArrayRange(Matriz_entrada,0); i++)
    {
      x[k] = Matriz_entrada[i][j];
      if(Matriz_entrada[i][machine_learning.entradas-1] == 0)
      {
        // PrintFormat("k: %i Value: %f",k,x[k]); //DEBUG
        ArrayResize(Linhas_Perde,ArraySize(Linhas_Perde)+1);
        Linhas_Perde[ArraySize(Linhas_Perde)-1] = x[k];
      }
      if(Matriz_entrada[i][machine_learning.entradas-1] != 0)
      {
        // PrintFormat("k: %i Value: %f",k,x[k]); //DEBUG
        ArrayResize(Linhas_Ganha,ArraySize(Linhas_Ganha)+1);
        Linhas_Ganha[ArraySize(Linhas_Ganha)-1] = x[k];
      }
      // PrintFormat("k: %i Value: %f",k,x[k]); //DEBUG
      k++;
    }


    // PrintFormat("Coluna %i",j); //DEBUG
    ArrayResize(frere,ArraySize(frere)+1);
    ArrayResize(signTest,ArraySize(signTest)+1);
    ArrayResize(studentsttest,ArraySize(studentsttest)+1);
    ArrayResize(chi,ArraySize(chi)+1);
    ArrayResize(wilcox,ArraySize(wilcox)+1);

    CAlglib *algebra = new CAlglib;

    algebra.JarqueBeraTest(Linhas_Perde,ArraySize(Linhas_Perde),p);
    frere[j][0] = p;
    ZeroMemory(p);
    algebra.OneSampleSignTest(Linhas_Perde,ArraySize(Linhas_Perde),MathMedian(Linhas_Perde),bothTails,leftTail,rightTail);
    signTest[j][0] = bothTails;
    ZeroMemory(bothTails);
    algebra.WilcoxonSignedRankTest(Linhas_Perde,ArraySize(Linhas_Perde),MathMedian(Linhas_Perde),bothTails,leftTail,rightTail);
    wilcox[j][0] = bothTails;
    ZeroMemory(bothTails);
    algebra.StudentTest1(Linhas_Perde,ArraySize(Linhas_Perde),MathMean(Linhas_Perde),bothTails,leftTail,rightTail);
    studentsttest[j][0] = bothTails;
    ZeroMemory(bothTails);
    algebra.OneSampleVarianceTest(Linhas_Perde,ArraySize(Linhas_Perde),MathVariance(Linhas_Perde),bothTails,leftTail,rightTail);
    chi[j][0] = bothTails;
    ZeroMemory(bothTails);
    algebra.OneSampleVarianceTest(Linhas_Perde,ArraySize(Linhas_Perde),MathVariance(Linhas_Perde),bothTails,leftTail,rightTail);
    chi[j][0] = bothTails;
    ZeroMemory(bothTails);

    algebra.JarqueBeraTest(Linhas_Ganha,ArraySize(Linhas_Ganha),p);
    frere[j][1] = p;
    algebra.OneSampleSignTest(Linhas_Ganha,ArraySize(Linhas_Ganha),MathMedian(Linhas_Ganha),bothTails,leftTail,rightTail);
    signTest[j][0] = bothTails;
    ZeroMemory(bothTails);
    algebra.WilcoxonSignedRankTest(Linhas_Ganha,ArraySize(Linhas_Ganha),MathMedian(Linhas_Ganha),bothTails,leftTail,rightTail);
    wilcox[j][0] = bothTails;
    ZeroMemory(bothTails);
    algebra.StudentTest1(Linhas_Ganha,ArraySize(Linhas_Ganha),MathMean(Linhas_Ganha),bothTails,leftTail,rightTail);
    studentsttest[j][0] = bothTails;
    ZeroMemory(bothTails);
    algebra.OneSampleVarianceTest(Linhas_Ganha,ArraySize(Linhas_Ganha),MathVariance(Linhas_Ganha),bothTails,leftTail,rightTail);
    chi[j][0] = bothTails;
    ZeroMemory(bothTails);

    delete(algebra);

    ArrayFree(Linhas_Ganha);
    ArrayFree(Linhas_Perde);

    if(j == machine_learning.entradas) break;

  }
// Print("FrereTamanho: " + ArrayRange(frere,0)); //Ta grande
//Retorna o seguinte Array[][2] (primeira dimensao coluna seguna 0 perde 1 ganha)
}
