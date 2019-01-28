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
          this.debug_afis = false;
          this.feature_method = "variance";
  };

  bool debug_afis;

  void divide_datasets(double& dataset_inteiro[][100]);

  void Calc_BX(const double& col_feature_in[], double& box_out[]);
  void Get_Feature_Col(double& dataset_feature_in[][100], double& feature_col_out[], int feature);
  void BX_Cols(double& dataset_full_in[][100], double& feature_full_bx_out[][5]);

  void Feature_Ranking();

  void Fuzzy_Model(int which_dataset, CMamdaniFuzzySystem& Afis_Model_Sep, CList& in);
  void Input_Var_Generator(int which_dataset,int Feature_idx,CMamdaniFuzzySystem& Afis_Model, CList& in);
  void Output_Var_Generator(CMamdaniFuzzySystem& Afis_Model);
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

  double input_fuzzy[];

  double feature_ranking[];

  double dataset[][100]; // Hope doesn't get shit

  string feature_method;

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


  double feat_array0[];
  double feat_array1[];
  ArrayResize(feat_array0,this.linesize);
  ArrayResize(feat_array1,this.linesize);

  double features[];
  ArrayResize(features,this.linesize);


  for (int i = 1; i < this.linesize; i++) {
    this.Get_Feature_Col(this.dataset_0,feat_array0,i);
    this.Get_Feature_Col(this.dataset_1,feat_array1,i);

    if(this.feature_method == "variance"){
      double vari_0;
      double vari_1;

      vari_0 = MathVariance(feat_array0);
      vari_1 = MathVariance(feat_array1);

      if(vari_0 == 0) vari_0 = 0.0000001;
      if(vari_1 == 0) vari_1 = 0.0000001;

      feature_ranking_temp[i] = MathMax(vari_0,vari_1) /
      MathMin(vari_0,vari_1);
      }

    if(this.feature_method == "std"){
      double std_0;
      double std_1;

      std_0 = MathStandardDeviation(feat_array0);
      std_1 = MathStandardDeviation(feat_array1);

      if(std_0 == 0) std_0 = 0.0000001;
      if(std_1 == 0) std_1 = 0.0000001;

      feature_ranking_temp[i] = MathMax(std_0,std_1) /
      MathMin(std_0,std_1);
      }
  }

  if(this.debug_afis) {
  for (int i = 0; i < ArrayRange(feature_ranking_temp,0); i++) {
    Print("i: " + IntegerToString(i) + " | feature_ranking_temp[i]: ",DoubleToString(feature_ranking_temp[i]));
  }
}

Normaliza_Array(feature_ranking_temp,this.feature_ranking,1);

}

void Afis::Feature_Selector(int& Features_idx[]) {


    double        minimum;
    double        lower_hinge;
    double        median;
    double        upper_hinge;
    double        maximum;

    MathTukeySummary(
      this.feature_ranking,
      true,
      minimum,
      lower_hinge,
      median,
      upper_hinge,
      maximum        // maximum value
    );


  for(int i = 1; i < ArrayRange(this.feature_ranking,0); i++) {
    if(this.feature_ranking[i] > upper_hinge) {
      ArrayResize(Features_idx,ArrayRange(Features_idx,0)+1);
      Features_idx[ArrayRange(Features_idx,0)-1] = i;
    }
  }
}

void Afis::Input_Var_Generator(int which_dataset,int Feature_idx,CMamdaniFuzzySystem& Afis_Model, CList& in) {
double dataset_bx[][5]; //dataset_0_bx[featureINDEX][bx_data]
ArrayResize(dataset_bx,this.linesize);
ArrayResize(input_fuzzy,this.linesize);

CDictionary_Obj_Double *rule_dic = new CDictionary_Obj_Double;


if(which_dataset == 0) ArrayCopy(dataset_bx,this.dataset_0_bx);
else ArrayCopy(dataset_bx,this.dataset_1_bx);

    CFuzzyVariable *InputVar = new CFuzzyVariable(IntegerToString(Feature_idx),dataset_bx[Feature_idx][0],dataset_bx[Feature_idx][4]);
    InputVar.Terms().Add(new CFuzzyTerm("a3", new CTriangularMembershipFunction(dataset_bx[Feature_idx][0],dataset_bx[Feature_idx][0],dataset_bx[Feature_idx][1])));
    InputVar.Terms().Add(new CFuzzyTerm("a2", new CTriangularMembershipFunction(dataset_bx[Feature_idx][0],dataset_bx[Feature_idx][1],dataset_bx[Feature_idx][2])));
    InputVar.Terms().Add(new CFuzzyTerm("n1", new CTriangularMembershipFunction(dataset_bx[Feature_idx][1],dataset_bx[Feature_idx][2],dataset_bx[Feature_idx][3])));
    InputVar.Terms().Add(new CFuzzyTerm("b2", new CTriangularMembershipFunction(dataset_bx[Feature_idx][2],dataset_bx[Feature_idx][3],dataset_bx[Feature_idx][4])));
    InputVar.Terms().Add(new CFuzzyTerm("b3", new CTriangularMembershipFunction(dataset_bx[Feature_idx][3],dataset_bx[Feature_idx][4],dataset_bx[Feature_idx][4])));

    Afis_Model.Input().Add(InputVar);

    rule_dic.SetAll(InputVar, n_(this.input_fuzzy[Feature_idx],dataset_bx[Feature_idx][0],dataset_bx[Feature_idx][4]));
    in.Add(rule_dic);
}

void Afis::Output_Var_Generator(CMamdaniFuzzySystem& Afis_Model) {
  CFuzzyVariable *OutputVar = new CFuzzyVariable("Resultado",0,100);
  OutputVar.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(0,0,50)));
  OutputVar.Terms().Add(new CFuzzyTerm("Neutro", new CTriangularMembershipFunction(0,50,100)));
  OutputVar.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(50,100,100)));
  Afis_Model.Output().Add(OutputVar);

}

void Afis::StaticRules(int Feature_idx, CMamdaniFuzzySystem& Afis_Model) {
  CMamdaniFuzzyRule *rule1 = Afis_Model.ParseRule("if (" + IntegerToString(Feature_idx)  + " is a3) then Resultado is Baixo");
  CMamdaniFuzzyRule *rule2 = Afis_Model.ParseRule("if (" + IntegerToString(Feature_idx)  + " is a2) then Resultado is Neutro");
  CMamdaniFuzzyRule *rule3 = Afis_Model.ParseRule("if (" + IntegerToString(Feature_idx)  + " is n1) then Resultado is Alto");
  CMamdaniFuzzyRule *rule4 = Afis_Model.ParseRule("if (" + IntegerToString(Feature_idx)  + " is b2) then Resultado is Neutro");
  CMamdaniFuzzyRule *rule5 = Afis_Model.ParseRule("if (" + IntegerToString(Feature_idx)  + " is b3) then Resultado is Baixo");
  Afis_Model.Rules().Add(rule1);
  Afis_Model.Rules().Add(rule2);
  Afis_Model.Rules().Add(rule3);
  Afis_Model.Rules().Add(rule4);
  Afis_Model.Rules().Add(rule5);
}

void Afis::Fuzzy_Model(int which_dataset, CMamdaniFuzzySystem& Afis_Model_Sep, CList& in) {

     this.Output_Var_Generator(Afis_Model_Sep);

     for (int i = 0; i < ArrayRange(selected_features,0); i++) {
       this.Input_Var_Generator(which_dataset,selected_features[i],Afis_Model_Sep,in);
       this.StaticRules(selected_features[i], Afis_Model_Sep);
     }
}

void Afis::Process(double& process[]) {
  ArrayResize(process,2);

  this.divide_datasets(this.dataset);

  this.BX_Cols(this.dataset_0,this.dataset_0_bx);

  this.BX_Cols(this.dataset_1,this.dataset_1_bx);

  this.Feature_Ranking();
  if(debug_afis) {
    for (int i = 0; i < ArrayRange(this.feature_ranking,0); i++) {
      Print("i: " + IntegerToString(i) + " | this.feature_ranking[i]: ",DoubleToString(this.feature_ranking[i]));
    }
  }

  int results_order[];

  // MathOrder(this.feature_ranking,results_order);
  // ArrayPrint(results_order);

  //
  // Print("minimum" +  minimum);
  // Print("lower_hinge" +  lower_hinge);
  // Print("median" +  median);
  // Print("upper_hinge" +  upper_hinge);
  // Print("maximum" +  maximum);

  this.Feature_Selector(this.selected_features);
  if(debug_afis) {
    for (int i = 0; i < ArrayRange(this.selected_features,0); i++) {
      Print("i: ",IntegerToString(i)," | this.selected_features[i]: ",DoubleToString(this.selected_features[i]));
    }
  }

  CList *in0=new CList;
  CList *in1=new CList;

  // 0 MODEL
  CMamdaniFuzzySystem *Model_0 = new CMamdaniFuzzySystem();
  this.Fuzzy_Model(0,Model_0,in0);

  // 1 MODEL
  CMamdaniFuzzySystem *Model_1 = new CMamdaniFuzzySystem();
  this.Fuzzy_Model(1,Model_1,in1);

  CList *result0;
  CList *result1;
  CDictionary_Obj_Double *Afis_Dic0;
  CDictionary_Obj_Double *Afis_Dic1;
  result0 = Model_0.Calculate(in0);
  result1 = Model_1.Calculate(in1);
  Afis_Dic0 = result0.GetNodeAtIndex(0);
  Afis_Dic1 = result1.GetNodeAtIndex(0);

  process[0] = Afis_Dic0.Value();
  process[1] = Afis_Dic1.Value();

  delete(Afis_Dic0);
  delete(Afis_Dic1);
  delete(result0);
  delete(result1);
  delete(in0);
  delete(in1);
  delete(Model_0);
  delete(Model_1);
}
