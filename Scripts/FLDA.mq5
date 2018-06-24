//+------------------------------------------------------------------+
//|                                                     TestMLPs.mq5 |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
string Nome_Robo = "FisherLDA";

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

    double w[];
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

      for(int i = 0; i < ArraySize(w); i++)
    {
      Print("w i:" + i + " value: " + w[i]);
    }

      // static void CLDA::FisherLDA(CMatrixDouble &xy,const int npoints,
      //                             const int nvars,const int nclasses,
      //                             int &info,double &w[])


    ExpertRemove();
}
