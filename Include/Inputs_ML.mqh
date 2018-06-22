/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                       Inputs.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robos feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

/////////////////////////////////////// Inputs M-FUCKING-L

input string Label_Aq_ML = "---------- ML Aquisicao e Treino_RNA (RNA e RDF) ----------";
input bool ml_on = false;
input bool ml_Salva_Arquivo_hist = false; //Salva Historico
input string ml_nome_arquivo_hist = "historico";  //Nome do Arquivo Historico

input bool rna_on_treino = false;
input bool rdf_on_treino = false;

bool rna_on_realtime = false; //DESLIGADO POR ENQUANTO
int rna_on_realtime_min_samples = 100; //DESLIGADO POR ENQUANTO

input string Label_Detalhes_RNA = "---------- Detalhes RNA ----------";
int rna_epochs = 1000; //DESLIGADO POR ENQUANTO
int rna_hidden_layers = 1; //Desligando para tentar sistema auto9matico com liberdade
int rna_segunda_camada = 10; //Desligando para tentar sistema auto9matico com liberdade
int rna_terceira_camada = 0; //Desligando para tentar sistema auto9matico com liberdade
int rna_camada_saida = 2; //DESLIGADO POR ENQUANTO E quando voltar, provavelmente será automática
input int rna_grau_liberdade_alpha = 2; //Grau de liberdade da rede (2-10, 2 eh mais neuronios)
int rna_restarts_ = 2 ; //Restarts (2 na doc)
// input double rna_wstep_ = 0.001 ;
input double rna_decay_ = 0.01 ;
input bool rna_Salva_Arquivo_rede = false; //RNA Salva Arquivo Treinado
input string rna_nome_arquivo_rede = "rede"; //RNA Nome do arquivo Treinado

input string Label_Detalhes_RDF = "---------- Detalhes RDF ----------"; //FILTROS RNA
input int rdf_trees = 50; //RDF - Trees (50-100 no doc)
input double rdf_r = 0.5; //RDF - R (0.1-0.66) (qto maior menor noise)
input bool rdf_Salva_Arquivo_Arvores = false; //RDF Salva Arquivo Treinado
input string rdf_nome_arquivo_arvores = "rede"; //RDF Nome do arquivo Treinado
