/* -*- C++ -*- */

input string Label_FF = "FILTRO FUZZY"; // ----------- FILTRO FUZZY -----------
input bool usa_ff = false;
input int ff_dataset_size = 20;
input int ff_max_feats = 5;
input int ff_feature_method = 1;


class Filtro_Afis
{
  public:
  int calc();
  Filtro_Afis();
  void cutDataset();

  Afis *afis;
  Aquisicao *aquisicao;

  double dataset_temp[][100];
  double dataset_temp_0[][100];
  double dataset_temp_1[][100];
  double inputs[]; // PEGAR INPUTS ATUAIS VIA AQUISICAO
  double output[];
  double res_0;
  double res_1;

  int direction;
  int min_feats;
  int num_lines;
  int max_feats;

};

void Filtro_Afis::Filtro_Afis() {
  this.afis = new Afis;
  this.aquisicao = new Aquisicao;
  this.direction = 0;
  this.num_lines = 10;

  if(ff_feature_method == 0) afis.feature_method = "variance";
  if(ff_feature_method == 1) afis.feature_method = "spearman";
  if(ff_feature_method == 2) afis.feature_method = "quantile";

}

void Filtro_Afis::cutDataset() {
  int size_dataset_min = MathMin(ArrayRange(this.dataset_temp_0,0),ArrayRange(this.dataset_temp_1,0));
  int w_i = ArrayRange(this.dataset_temp,0) - 1;
  ArrayFree(this.dataset_temp_0);
  ArrayFree(this.dataset_temp_1);

  // Print("INSIDE WHILE size_dataset_min: " + size_dataset_min);
  // while (size_dataset_min < this.num_lines || w_i > 0) {
  // while (size_dataset_min < this.num_lines) {
  // while (size_dataset_min < this.num_lines && w_i > 0) {
  for(w_i = ArrayRange(this.dataset_temp,0) - 1; w_i >= 0; w_i--) {
    if(this.dataset_temp[w_i][0] <= 0) {
      ArrayResize(this.dataset_temp_0,(ArrayRange(this.dataset_temp_0,0)+1));
      for (int i = 0; i < ArrayRange(this.dataset_temp_0,1); i++) {
        this.dataset_temp_0[(ArrayRange(this.dataset_temp_0,0)-1)][i] = this.dataset_temp[w_i][i];
      }
    } else {
      ArrayResize(this.dataset_temp_1,(ArrayRange(this.dataset_temp_1,0)+1));
      for (int i = 0; i < ArrayRange(this.dataset_temp_1,1); i++) {
        this.dataset_temp_1[(ArrayRange(this.dataset_temp_1,0)-1)][i] = this.dataset_temp[w_i][i];
      }
    }

    size_dataset_min = MathMin(ArrayRange(this.dataset_temp_0,0),ArrayRange(this.dataset_temp_1,0));
    if(size_dataset_min == this.num_lines) break;
    // Print("INSIDE WHILE size_dataset_min: " + size_dataset_min);
  }

  // Print("w_i: " + w_i);
  // Print("POS FOR( ArrayRange(this.dataset_temp,0): " + ArrayRange(this.dataset_temp,0));
  // Print("POS FOR( ArrayRange(this.dataset_temp_0,0): " + ArrayRange(this.dataset_temp_0,0));
  // Print("POS for() ArrayRange(this.dataset_temp_1,0): " + ArrayRange(this.dataset_temp_1,0));

  ArrayRemove(this.dataset_temp,0,w_i);
  // ArrayPrint(dataset_temp);
}

int Filtro_Afis::calc() {

  if(this.direction == 0)  {
    ArrayCopy(this.dataset_temp, deal_matrix.matrix);
    ArrayCopy(this.dataset_temp_0, deal_matrix.matrix_0);
    ArrayCopy(this.dataset_temp_1, deal_matrix.matrix_1);
  }
  if(this.direction < 0)  {
    ArrayCopy(this.dataset_temp, deal_matrix.matrix_sell);
    ArrayCopy(this.dataset_temp_0, deal_matrix.matrix_sell_0);
    ArrayCopy(this.dataset_temp_1, deal_matrix.matrix_sell_1);
  }
  if(this.direction > 0)  {
    ArrayCopy(this.dataset_temp, deal_matrix.matrix_buy);
    ArrayCopy(this.dataset_temp_0, deal_matrix.matrix_buy_0);
    ArrayCopy(this.dataset_temp_1, deal_matrix.matrix_buy_1);
  }



  if(MathMin(ArrayRange(this.dataset_temp_0,0),ArrayRange(this.dataset_temp_1,0)) < this.num_lines) return -1;

  this.afis.linesize = 79 ;

  this.afis.max_feats = 5;
  this.afis.min_feats = 1 ;

  this.afis.dataset_max_size = 99999;

  this.cutDataset();

  ArrayCopy(this.afis.dataset, dataset_temp);

  ArrayResize(inputs,(ArrayRange(this.aquisicao.todosDados,0)+1));

  inputs[0] = NULL;

  for (int i = 1; i < ArrayRange(inputs,0); i++) {
    inputs[i] = this.aquisicao.todosDados[i-1];
  }

  // Print("Dataset-filtro: " + ArrayRange(deal_matrix.matrix,0));

  afis.process(this.output);

  this.res_0 = this.output[0];
  this.res_1 = this.output[1];

  // ArrayPrint(this.output);

  return false;
}
