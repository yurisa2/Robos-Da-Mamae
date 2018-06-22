//+------------------------------------------------------------------+
//|                                                     TestMLPs.mq5 |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
string Nome_Robo = "McBrain";

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

    //Carrega Historico
    machine_learning.ML_Load(ml_nome_arquivo_hist);

    //Treino rdf
    machine_learning.Treino_RDF(machine_learning.tree_obj);
    // machine_learning.Salva_RDF(machine_learning.tree_obj,rdf_nome_arquivo_arvores);
    //Treino RNA
    machine_learning.Treino_RNA(machine_learning.rede_obj);
    // machine_learning.Salva_RNA(machine_learning.rede_obj,rna_nome_arquivo_rede);


    ExpertRemove();
}
