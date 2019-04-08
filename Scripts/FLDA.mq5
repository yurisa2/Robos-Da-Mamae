//+------------------------------------------------------------------+
//|                                                     TestMLPs.mq5 |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
string Nome_Robo = "FisherLDA";

#include <Math\Alglib\alglib.mqh>
#include <dados_nn_stub.mqh>
#include <ML.mqh>
#include <Inputs_ML.mqh>

ENUM_TIMEFRAMES TimeFrame = TimeFrame_;                              //TimeFrame base
int Tipo_Comentario = 0;                                          //Tipo de Comentario (0 - simples, 1 - Avancado, 2 - DEBUG)
bool rna_filtros_on = false;
bool rdf_filtros_on = false;

input string ml_nome_arquivo_hist = "historico";

#property strict
#property script_show_inputs

void OnStart()
{

    double w[];
    CMatrixDouble w2;
    int info;

    //Carrega Historico
    machine_learning.ML_Load(ml_nome_arquivo_hist);


      CMatrixDouble xy_inteira(machine_learning.numero_linhas+1,machine_learning.entradas);
      for(int i = 0; i < machine_learning.numero_linhas; i++)
      { //Mano AQUI FAVA i = amostras?!?!?!?! WAHHHHHH?
        for(int j = 0; j < machine_learning.entradas; j++)
        {
          xy_inteira[i].Set(j,machine_learning.Matriz[i][j]);
          // PrintFormat("xy[%f].Set(%f,%f)",i,j,machine_learning.Matriz[i][j]); //DEBUG Verifica a Matriz XY
        }
      }

      CLDA::FisherLDA(xy_inteira,machine_learning.numero_linhas,machine_learning.entradas-1,2,info,w);
      Print("info w: " + info);
//       CLDA::FisherLDAN(xy_inteira,machine_learning.numero_linhas,machine_learning.entradas-1,2,info,w2);
// Print("info w: " + info);
      Print("FisherLDA");
      for(int i = 0; i < ArraySize(w); i++)
    {
      Print("w i:" + i + " value: " + w[i]);
    }
  //
  //   Print("FisherLDAN");
  //   for(int i = 0; i < ArraySize(w); i++)
  // {
  //   Print("w20 i:" + i + " value: " + w2[i][0]);
  //   Print("w21 i:" + i + " value: " + w2[i][1]);
  //   Print("w22 i:" + i + " value: " + w2[i][2]);
  // }
CMatrixDouble v;
double s2[];

CAlglib::PCABuildBasis(xy_inteira,machine_learning.numero_linhas,machine_learning.entradas-1,info,s2,v);

Print("PCA s2");
for(int i = 0; i < ArraySize(w); i++)
{
Print("s2 i:" + i + " value: " + s2[i]);
}
Print("PCA v");
for(int i = 0; i < ArrayRange(s2); i++)
{
Print("v0 i:" + i + " value: " + v[i][0]);
Print("v1 i:" + i + " value: " + v[i][1]);
Print("v2 i:" + i + " value: " + v[i][2]);
}

    ExpertRemove();
}
