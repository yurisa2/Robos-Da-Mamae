//+------------------------------------------------------------------+
//|                                                     TestMLPs.mq5 |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
string Nome_Robo = "ML_JarqueBeraTest";

#include <Math\Alglib\alglib.mqh>
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

  double Matriz_perde[][100];
  double Matriz_ganha[][100];
  int num_perdeu = 0;
  int num_ganhou = 0;


  //Carrega Historico
  machine_learning.ML_Load(ml_nome_arquivo_hist);

  ML_JarqueBeraTest(machine_learning.Matriz,frere);

  for(int i = 0; i < machine_learning.entradas; i++)
  {

    PrintFormat("Coluna: %i JB Perde: %f JB Ganha: %f Soma: %f",i,frere[i][0],frere[i][1],frere[i][0]+frere[i][0]+frere[i][1]);

  }

  ExpertRemove();
}

void ML_JarqueBeraTest(double &Matriz_entrada[][100], double &frere[][2])
{
  double p;
  double x[];

  double Linhas_Perde[];
  double Linhas_Ganha[];

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

    CAlglib *algebra = new CAlglib;
    algebra.JarqueBeraTest(Linhas_Perde,ArraySize(Linhas_Perde),p);
    // PrintFormat("#%i JarqueBera Perdeu: %f",j,p);
    frere[j][0] = p;

    ZeroMemory(p);

    algebra.JarqueBeraTest(Linhas_Ganha,ArraySize(Linhas_Ganha),p);
    // PrintFormat("#%i JarqueBera Ganhos: %f",j,p);
    frere[j][1] = p;

    delete(algebra);

    ArrayFree(Linhas_Ganha);
    ArrayFree(Linhas_Perde);

    if(j == machine_learning.entradas) break;

  }
// Print("FrereTamanho: " + ArrayRange(frere,0)); //Ta grande
//Retorna o seguinte Array[][2] (primeira dimensao coluna seguna 0 perde 1 ganha)
}
