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
  Afis() {this.linesize = 100;};

  void divide_datasets(double& dataset_inteiro[][100]);

  void Calc_BX(const double& col_feature_in[], double& box_out[]);
  void Get_Feature_Col(double& dataset_feature_in[][100], double& feature_col_out[], int feature);
  void BX_Cols(double& dataset_full_in[][100], double& feature_full_bx_out[][5]);

  double param_feature_min_cut;

  void Add_Line(double& line[]);
  int linesize;
  double dataset_0[][100]; //dataset_0[line][column/featureVALUE]
  double dataset_1[][100];

  double dataset_0_bx[][5]; //dataset_0_bx[featureINDEX][bx_data]
  double dataset_1_bx[][5];


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



//  auto_feature_selector
  // - Evaluate and rank Features comparing their BX values
  // - Select features by a param
  // - Grava Indices (classificacoes/pesos)



// Main AFIS
// Cria Entradas
// Cria Saidas
// Cria Regras - Fixas e dinamicas
// Avalia Saidas
