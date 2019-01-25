/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                              Sa2 |
//|                                           https://www.sa2.com.br |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class Afis
{
  public:
  Afis() {this.linesize = 100;
          this.param_feature_min_cut = 0.5;
  };

  void divide_datasets(double& dataset_inteiro[][100]);

  void Calc_BX(const double& col_feature_in[], double& box_out[]);
  void Get_Feature_Col(double& dataset_feature_in[][100], double& feature_col_out[], int feature);
  void BX_Cols(double& dataset_full_in[][100], double& feature_full_bx_out[][5]);

  void Feature_Ranking();

  void Fuzzy_Model(int which_dataset, CMamdaniFuzzySystem& Afis_Model_Sep);
  void Input_Var_Generator(int which_dataset,int Feature_idx,CMamdaniFuzzySystem& Afis_Model);
  void Output_Var_Generator(int which_dataset,CMamdaniFuzzySystem& Afis_Model);
  void StaticRules(int Feature_idx, CMamdaniFuzzySystem& Afis_Model);
  void Feature_Selector(int& Features_idx[]);
  void Process(double& process[]);

  int selected_features[];

  double param_feature_min_cut;

  void Add_Line(double& line[]);
  int linesize;
  double dataset_0[][100]; //dataset_0[line][column/featureVALUE]
  double dataset_1[][100];

  double dataset_0_bx[][5]; //dataset_0_bx[featureINDEX][bx_data]
  double dataset_1_bx[][5];

  double feature_ranking[];

  double dataset[][100]; // Hope doesn't get shit


  private:

};

void Afis::Add_Line(double& line[]) {
  ArrayResize(this.dataset, ArrayRange(this.dataset,0)+1); //Aumenta o Array em uma unidade

  for(int i = 0; i <  this.linesize; i++) {
    this.dataset[(ArrayRange(this.dataset,0)-1)][i] = line[i];
  }
}

void Afis::divide_datasets(double& dataset_inteiro[][100]) {

  for (int i = 0; i <  ArrayRange(dataset_inteiro,0); i++) {

    if(dataset_inteiro[i][0] == 0) {
      ArrayResize(this.dataset_0, ArrayRange(this.dataset_0,0)+1);
      for(int j = 0; j <  this.linesize; j++) {
        this.dataset_0[(ArrayRange(this.dataset_0,0)-1)][j] = dataset_inteiro[i][j];
      }
    }
    if(dataset_inteiro[i][0] == 1) {
      ArrayResize(this.dataset_1, ArrayRange(this.dataset_1,0)+1);
      for(int j = 0; j <  this.linesize; j++) {
        this.dataset_1[(ArrayRange(this.dataset_1,0)-1)][j] = dataset_inteiro[i][j];
      }
    }
  }
}

void Afis::Calc_BX(const double& col_feature_in[], double& box_out[]) {
ArrayResize(box_out,5);
  MathTukeySummary(col_feature_in,
                    true,
                    box_out[0], //Min
                    box_out[1], //Q1
                    box_out[2], //Median
                    box_out[3], //Q3
                    box_out[4]); // MAX
}

// Extracts a Col as an array
void Afis::Get_Feature_Col(double& dataset_feature_in[][100], double& feature_col_out[], int feature) {
  ArrayResize(feature_col_out,ArrayRange(dataset_feature_in,0));

  for (int i = 0; i < ArrayRange(dataset_feature_in,0); i++) { // Linhas
    feature_col_out[i] = dataset_feature_in[i][feature];
  }
}

void Afis::BX_Cols(double& dataset_full_in[][100], double& feature_full_bx_out[][5]) {
  ArrayResize(feature_full_bx_out,this.linesize);
  double bx_values_temp[5] ;

  for (int i = 0; i < this.linesize; i++) {
    double array_coluna[];
    ArrayResize(array_coluna,ArrayRange(dataset_full_in,0));
    this.Get_Feature_Col(dataset_full_in,array_coluna,i);
    this.Calc_BX(array_coluna, bx_values_temp);

    for (int j = 0; j < 5; j++) {
      feature_full_bx_out[i][j] = bx_values_temp[j];
    }
  }
}

void Afis::Feature_Ranking() {
  ArrayResize(feature_ranking,this.linesize);
  double feature_ranking_temp[];
  ArrayResize(feature_ranking_temp,this.linesize);

  double vari_0;
  double vari_1;

  double feat_array0[];
  double feat_array1[];
  ArrayResize(feat_array0,this.linesize);
  ArrayResize(feat_array1,this.linesize);

  double features[];
  ArrayResize(features,this.linesize);


  for (int i = 1; i < this.linesize; i++) {
    this.Get_Feature_Col(this.dataset_0,feat_array0,i);
    this.Get_Feature_Col(this.dataset_1,feat_array1,i);


    vari_0 = MathVariance(feat_array0);
    vari_1 = MathVariance(feat_array1);

    feature_ranking_temp[i] = MathMax(vari_0,vari_1) /
    MathMin(vari_0,vari_1);
  }

Normaliza_Array(feature_ranking_temp,this.feature_ranking,1);
}

void Afis::Feature_Selector(int& Features_idx[]) {

  for(int i = 0; i < ArrayRange(this.feature_ranking,0); i++) {
    if(this.feature_ranking[i] > param_feature_min_cut) {
      ArrayResize(Features_idx,ArrayRange(Features_idx,0)+1);
      Features_idx[ArrayRange(Features_idx,0)-1] = i;
    }
  }
}

void Afis::Input_Var_Generator(int which_dataset,int Feature_idx,CMamdaniFuzzySystem& Afis_Model) {
double dataset_bx[][5]; //dataset_0_bx[featureINDEX][bx_data]

if(which_dataset == 0) ArrayCopy(dataset_bx,this.dataset_0_bx);
else ArrayCopy(dataset_bx,this.dataset_1_bx);

    CFuzzyVariable *InputVar = new CFuzzyVariable(IntegerToString(Feature_idx),dataset_bx[Feature_idx][0],dataset_bx[Feature_idx][4]);
    InputVar.Terms().Add(new CFuzzyTerm("a3", new CTriangularMembershipFunction(dataset_bx[Feature_idx][0],dataset_bx[Feature_idx][0],dataset_bx[Feature_idx][1])));
    InputVar.Terms().Add(new CFuzzyTerm("a2", new CTriangularMembershipFunction(dataset_bx[Feature_idx][0],dataset_bx[Feature_idx][1],dataset_bx[Feature_idx][2])));
    InputVar.Terms().Add(new CFuzzyTerm("1", new CTriangularMembershipFunction(dataset_bx[Feature_idx][2],dataset_bx[Feature_idx][3],dataset_bx[Feature_idx][4])));
    InputVar.Terms().Add(new CFuzzyTerm("b2", new CTriangularMembershipFunction(dataset_bx[Feature_idx][3],dataset_bx[Feature_idx][4],dataset_bx[Feature_idx][5])));
    InputVar.Terms().Add(new CFuzzyTerm("b3", new CTriangularMembershipFunction(dataset_bx[Feature_idx][4],dataset_bx[Feature_idx][5],dataset_bx[Feature_idx][5])));

    Afis_Model.Input().Add(InputVar);
}

void Afis::Output_Var_Generator(int which_dataset,CMamdaniFuzzySystem& Afis_Model) {
  CFuzzyVariable *OutputVar = new CFuzzyVariable("Resultado",0,100);
  OutputVar.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(0,0,50)));
  OutputVar.Terms().Add(new CFuzzyTerm("Neutro", new CTriangularMembershipFunction(0,50,100)));
  OutputVar.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(50,100,100)));
  Afis_Model.Output().Add(OutputVar);

}

void Afis::StaticRules(int Feature_idx, CMamdaniFuzzySystem& Afis_Model) {
  CMamdaniFuzzyRule *rule1 = Afis_Model.ParseRule("if (" + IntegerToString(Feature_idx)  + " is a3) then (Resultado is Baixo)");
  CMamdaniFuzzyRule *rule2 = Afis_Model.ParseRule("if (" + IntegerToString(Feature_idx)  + " is a2) then (Resultado is Neutro)");
  CMamdaniFuzzyRule *rule3 = Afis_Model.ParseRule("if (" + IntegerToString(Feature_idx)  + " is 1) then (Resultado is Alto)");
  CMamdaniFuzzyRule *rule4 = Afis_Model.ParseRule("if (" + IntegerToString(Feature_idx)  + " is b2) then (Resultado is Neutro)");
  CMamdaniFuzzyRule *rule5 = Afis_Model.ParseRule("if (" + IntegerToString(Feature_idx)  + " is b3) then (Resultado is Baixo)");
  Afis_Model.Rules().Add(rule1);
  Afis_Model.Rules().Add(rule2);
  Afis_Model.Rules().Add(rule3);
  Afis_Model.Rules().Add(rule4);
  Afis_Model.Rules().Add(rule5);
}

void Afis::Fuzzy_Model(int which_dataset, CMamdaniFuzzySystem& Afis_Model_Sep) {

     this.Output_Var_Generator(which_dataset,Afis_Model_Sep);

     for (int i = 0; i < ArrayRange(selected_features,0); i++) {
       this.Input_Var_Generator(which_dataset,selected_features[i],Afis_Model_Sep);
       this.StaticRules(selected_features[i], Afis_Model_Sep);
     }
}

void Afis::Process(double& process[]) {
  ArrayResize(process,2);

  this.divide_datasets(this.dataset);


}

//  auto_feature_selector
  // - Evaluate and rank Features comparing their BX values
  // - Select features by a param
  // - Grava Indices (classificacoes/pesos)



// Main AFIS
// Cria Entradas
// Cria Saidas
// Cria Regras - Fixas e dinamicas
// Avalia Saidas
