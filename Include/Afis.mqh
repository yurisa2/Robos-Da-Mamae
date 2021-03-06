/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                              Sa2 |
//|                                           https://www.sa2.com.br |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

#include <Math\Fuzzy\MamdaniFuzzySystem.mqh>

class Afis
{
  public:
  Afis() {this.linesize = 100;
    this.param_feature_min_cut = 0.5;
    this.debug_afis = false;
    this.feature_method = "spearman";
    this.feature_ranking_temp_print = false;
    this.feature_ranking_print = false;
    this.selected_features_print = false;
    this.feature_selection_method = "upperhinge";
    this.rules_method = "dynamic";
    this.linhas = 0;
    this.max_feats = 10;
    this.min_feats = 2;
    this.dataset_min_size = 6;
    this.dataset_max_size = 99999999;
  };

  void addLine(double& line[]);
  void bxCols(double& dataset_full_in[][100], double& feature_full_bx_out[][5]);
  void calcBX(const double& col_feature_in[], double& box_out[]);
  void combinationUtil(string& arr[], string& data[], int start, int end, int index, int r, string& final_ar[][100]);
  void datasetLastLines();
  void divideDatasets(double& dataset_inteiro[][100]);
  void dynamicRules( CMamdaniFuzzySystem& Afis_Model);
  void featureSelector(int& Features_idx[]);
  void fuzzyModel(int which_dataset, CMamdaniFuzzySystem& Afis_Model_Sep, CList& in);
  void featureRanking();
  void getFeatureCol(double& dataset_feature_in[][100], double& feature_col_out[], int feature);
  void inputVarGenerator(int which_dataset,int Feature_idx,CMamdaniFuzzySystem& Afis_Model, CList& in);
  void outputVarGenerator(CMamdaniFuzzySystem& Afis_Model);
  void staticRules(int Feature_idx, CMamdaniFuzzySystem& Afis_Model);
  void process(double& process[]);

  bool debug_afis;
  bool feature_ranking_temp_print;
  bool feature_ranking_print;
  bool selected_features_print;

  int dataset_min_size;
  int dataset_max_size;
  int linhas;
  int linesize;
  int max_feats;
  int min_feats;
  int selected_features[];

  string feature_method;
  string feature_selection_method;
  string rules_method;

  double dataset[][100]; // Hope doesn't get shit
  double dataset_0[][100]; //dataset_0[line][column/featureVALUE]
  double dataset_1[][100];
  double dataset_0_bx[][5]; //dataset_0_bx[featureINDEX][bx_data]
  double dataset_1_bx[][5];
  double input_fuzzy[];
  double feature_ranking[];
  double param_feature_min_cut;
  double result_raw[]; //Nao usando ainda, é para fazer correlacões como FeatureRanking...melhor pensar

  private:

  };

  void Afis::addLine(double& line[]) {
    ArrayResize(this.dataset, ArrayRange(this.dataset,0)+1); //Aumenta o Array em uma unidade

    for(int i = 0; i <  this.linesize; i++) {
      this.dataset[(ArrayRange(this.dataset,0)-1)][i] = line[i];
    }
  }

  void Afis::divideDatasets(double& dataset_inteiro[][100]) {

    for (int i = 0; i <  ArrayRange(dataset_inteiro,0); i++) {

      if(dataset_inteiro[i][0] < 0) dataset_inteiro[i][0] = 0;
      if(dataset_inteiro[i][0] > 0) dataset_inteiro[i][0] = 1;

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

  void Afis::calcBX(const double& col_feature_in[], double& box_out[]) {
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
    void Afis::getFeatureCol(double& dataset_feature_in[][100], double& feature_col_out[], int feature) {
      ArrayResize(feature_col_out,ArrayRange(dataset_feature_in,0));

      for (int i = 0; i < ArrayRange(dataset_feature_in,0); i++) { // Linhas
        feature_col_out[i] = dataset_feature_in[i][feature];
      }
    }

    void Afis::bxCols(double& dataset_full_in[][100], double& feature_full_bx_out[][5]) {
      ArrayResize(feature_full_bx_out,this.linesize);
      double bx_values_temp[5] ;

      for (int i = 0; i < this.linesize; i++) {
        double array_coluna[];
        ArrayResize(array_coluna,ArrayRange(dataset_full_in,0));
        this.getFeatureCol(dataset_full_in,array_coluna,i);
        this.calcBX(array_coluna, bx_values_temp);

        for (int j = 0; j < 5; j++) {
          feature_full_bx_out[i][j] = bx_values_temp[j];
        }
      }
    }

    void Afis::featureRanking() {
      ArrayResize(feature_ranking,this.linesize);
      double feature_ranking_temp[];
      ArrayResize(feature_ranking_temp,this.linesize);

      double feat_array0[];
      double feat_array1[];

      double feat_array_target[];
      double feat_array_full[];


      ArrayResize(feat_array0,this.linesize);
      ArrayResize(feat_array1,this.linesize);

      double features[];
      ArrayResize(features,this.linesize);


      for (int i = 1; i < this.linesize; i++) {
        this.getFeatureCol(this.dataset_0,feat_array0,i);
        this.getFeatureCol(this.dataset_1,feat_array1,i);

        this.getFeatureCol(this.dataset,feat_array_target,0);
        this.getFeatureCol(this.dataset,feat_array_full,i);

        if(this.feature_method == "variance"){
          double vari_0;
          double vari_1;

          vari_0 = MathVariance(feat_array0);
          vari_1 = MathVariance(feat_array1);

          if(vari_0 == 0 || vari_1 == 0) {
            feature_ranking_temp[i] = 0;
          } else {
            feature_ranking_temp[i] = divisao(MathMax(vari_0,vari_1),
            MathMin(vari_0,vari_1));
          }
        }

        if(this.feature_method == "quantile"){
          double quant_0[5];
          double quant_1[5];

          MathTukeySummary(
            feat_array0,
            true,
            quant_0[0],
            quant_0[1],
            quant_0[2],
            quant_0[3],
            quant_0[4]        // maximum value
          );

          MathTukeySummary(
            feat_array1,
            true,
            quant_1[0],
            quant_1[1],
            quant_1[2],
            quant_1[3],
            quant_1[4]        // maximum value
          );

          double min_feature = MathMin(quant_1[0],quant_0[0]);
          double top_feature = MathMax(quant_1[4],quant_0[4]);

          double full_delta = top_feature - min_feature;

          if(full_delta == 0) full_delta = 0.0001;

          double delta_min = MathMax(quant_1[0],quant_0[0]) -
          MathMin(quant_1[0],quant_0[0]);

          double delta_q1 = MathMax(quant_1[1],quant_0[1]) -
          MathMin(quant_1[1],quant_0[1]);

          double delta_median = MathMax(quant_1[2],quant_0[2]) -
          MathMin(quant_1[2],quant_0[2]);

          double delta_q3 = MathMax(quant_1[3],quant_0[3]) -
          MathMin(quant_1[3],quant_0[3]);

          double delta_max = MathMax(quant_1[4],quant_0[4]) -
          MathMin(quant_1[4],quant_0[4]);

          double p_delta_min = (delta_min / full_delta) * 1;
          double p_delta_q1 = (delta_q1 / full_delta) * 1;
          double p_delta_median = (delta_median / full_delta) * 2000;
          double p_delta_q3 = (delta_q3 / full_delta) * 1;
          double p_delta_max = (delta_max / full_delta) * 1;

          // double p_total = p_delta_min + p_delta_q1 + p_delta_median + p_delta_q3 +
          //                  p_delta_max;
          double p_total = delta_median;

          feature_ranking_temp[i] = p_total;
        }

        if(this.feature_method == "spearman"){
          // double spear_0;
          double spear;

          // spear_0 = MathCorrelationSpearman(feat_array0,feat_array0_target[],spear_0);
          spear = MathCorrelationSpearman(feat_array_target,feat_array_full,spear);


          feature_ranking_temp[i] = MathAbs(spear);
        }
      }

      if(this.debug_afis || this.feature_ranking_temp_print) {
        for (int i = 0; i < ArrayRange(feature_ranking_temp,0); i++) {
          Print("i: " + IntegerToString(i) + " | feature_ranking_temp[i]: ",DoubleToString(feature_ranking_temp[i]));
        }
      }

      Normaliza_Array(feature_ranking_temp,this.feature_ranking,1);

    }

    void Afis::featureSelector(int& Features_idx[]) {


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

      double ranked_feats_idxs[][2];
      ArrayResize(ranked_feats_idxs,ArrayRange(this.feature_ranking,0));

      for(int i = 1; i < ArrayRange(this.feature_ranking,0); i++) {
        ranked_feats_idxs[i][0] = this.feature_ranking[i];
        ranked_feats_idxs[i][1] = i;

        if(this.feature_ranking[i] > upper_hinge && this.feature_selection_method == "upperhinge") {
          ArrayResize(Features_idx,ArrayRange(Features_idx,0)+1);
          Features_idx[ArrayRange(Features_idx,0)-1] = i;
        }

        if(this.feature_ranking[i] > this.param_feature_min_cut && this.feature_selection_method == "cut") {
          ArrayResize(Features_idx,ArrayRange(Features_idx,0)+1);
          Features_idx[ArrayRange(Features_idx,0)-1] = i;
        }

        if(this.feature_selection_method == "all") {
          ArrayResize(Features_idx,ArrayRange(Features_idx,0)+1);
          Features_idx[ArrayRange(Features_idx,0)-1] = i;
        }
      }

      ArraySort(ranked_feats_idxs);
      // ArrayPrint(ranked_feats_idxs);//DEBUG

      if(ArrayRange(Features_idx,0) > this.max_feats) {
        ArrayFree(Features_idx);
        for (int i = ArrayRange(ranked_feats_idxs,0); i > (ArrayRange(ranked_feats_idxs,0)-this.max_feats); i--) {
          ArrayResize(Features_idx,ArrayRange(Features_idx,0)+1);

          Features_idx[ArrayRange(Features_idx,0)-1] = int(ranked_feats_idxs[i-1][1]);
        }
      }

      // ArrayPrint(Features_idx);//DEBUG

      if(ArrayRange(Features_idx,0) < this.min_feats) {
        ArrayFree(Features_idx);
        for (int i = ArrayRange(ranked_feats_idxs,0); i > (ArrayRange(ranked_feats_idxs,0)-this.min_feats); i--) {
          ArrayResize(Features_idx,ArrayRange(Features_idx,0)+1);

          Features_idx[ArrayRange(Features_idx,0)-1] = int(ranked_feats_idxs[i-1][1]);
        }
      }

      // ArrayPrint(Features_idx);//DEBUG

    }

    void Afis::inputVarGenerator(int which_dataset,int Feature_idx,CMamdaniFuzzySystem& Afis_Model, CList& in) {
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

    void Afis::outputVarGenerator(CMamdaniFuzzySystem& Afis_Model) {
      CFuzzyVariable *OutputVar = new CFuzzyVariable("Resultado",0,100);
      OutputVar.Terms().Add(new CFuzzyTerm("Baixo", new CTriangularMembershipFunction(0,0,50)));
      OutputVar.Terms().Add(new CFuzzyTerm("Neutro", new CTriangularMembershipFunction(0,50,100)));
      OutputVar.Terms().Add(new CFuzzyTerm("Alto", new CTriangularMembershipFunction(50,100,100)));
      Afis_Model.Output().Add(OutputVar);

    }

    void Afis::staticRules(int Feature_idx, CMamdaniFuzzySystem& Afis_Model) {
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


    void Afis::combinationUtil(string& arr[], string& data[], int start, int end,
      int index, int r, string& final_ar[][100])
      {
        if (index == r)    {
          for (int j=0; j<r; j++){
            // Print("linhas: " + linhas); //DEBUG
            if(j < r) final_ar[linhas][j] = data[j];
          }
          this.linhas++;
          return;
        }

        for (int i=start; i<=end; i++)     {
          data[index] = arr[i];
          this.combinationUtil(arr, data, 0, end, index+1, r,final_ar);
        }
      }

      void Afis::dynamicRules(CMamdaniFuzzySystem& Afis_Model) {
        // string definitive_rules[];
        string antecedents[] = {"a3", "a2", "n1", "b2", "b3"};
        // string antecedents[] = {"a3", "a2"};
        // string consequents[] = {"Baixo", "Neutro", "Alto"};
        // this.selected_features;
        string output_full[][100];
        double results_rules[];
        string output_strings[];

        this.linhas = 0;

        int r = ArrayRange(this.selected_features,0);

        // Print("r: " + r);
        // Print("ArrayRange(selected_features,0): " + ArrayRange(selected_features,0));

        int combinations = int(MathPow(ArrayRange(antecedents,0),r));

        // Print("combinations: " + combinations);

        int n = sizeof(antecedents)/sizeof(antecedents[0]);

        ArrayResize(output_full,combinations);

        string data[];
        ArrayResize(data,r);

        // ArrayPrint(output_full);
        combinationUtil(antecedents, data, 0, n-1, 0, r,output_full);

        ArrayResize(results_rules,combinations);

        for (int i = 0; i < combinations; i++) { //LINHAS
          double soma_linha = 0;

          for (int j = 0; j < r; j++) { //OLS
            string valor = output_full[i][j];
            if(valor == "a3" || valor == "b3") soma_linha = soma_linha + 1;
            if(valor == "a2" || valor == "b2") soma_linha = soma_linha + 2;
            if(valor == "n1") soma_linha = soma_linha + 3;
          }
          results_rules[i] =soma_linha;

        }

        Normaliza_Array(results_rules,results_rules);

        string consequents[];
        ArrayResize(consequents,combinations);

        for (int i = 0; i < ArrayRange(results_rules,0); i++) {
          if(results_rules[i] <= 0.33) consequents[i] = "Baixo";
          if(results_rules[i] > 0.33 && results_rules[i] < 0.66) consequents[i] = "Neutro";
          if(results_rules[i] >= 0.66) consequents[i] = "Alto";
          // Print("Rules: " + results_rules[i]); //DEBUG
        }


        ArrayResize(output_strings,combinations);

        for (int i = 0; i < combinations; i++) { //LINHAS
          string output = "if";

          for (int j = 0; j < r; j++) { //COLS

            output += " (";
            output += IntegerToString(this.selected_features[j]);
            output += " is ";
            output += output_full[i][j];
            output += ") ";

            if(r != (j+1))   output += "and";
          }
          output += "then Resultado is ";
          output += consequents[i];
          output_strings[i] = output;
          CMamdaniFuzzyRule *rule1 = Afis_Model.ParseRule(output);
          Afis_Model.Rules().Add(rule1);

        }

        // ArrayPrint(results_rules);
        // ArrayPrint(consequents);
        // ArrayPrint(output_strings);

        // ArrayPrint(output_full);
        // Print("Afis::dynamicRules() END"); //DEBUG

      }

      void Afis::fuzzyModel(int which_dataset, CMamdaniFuzzySystem& Afis_Model_Sep, CList& in) {

        this.outputVarGenerator(Afis_Model_Sep);

        for (int i = 0; i < ArrayRange(selected_features,0); i++) {
          this.inputVarGenerator(which_dataset,selected_features[i],Afis_Model_Sep,in);
          if(this.rules_method == "static") {
            this.staticRules(selected_features[i], Afis_Model_Sep);
            // Print("Static Rules");
          }
        }
        if(this.rules_method == "dynamic") {
          this.dynamicRules(Afis_Model_Sep);
          // Print("Dynamic Rules");
        }
      }

      void Afis::process(double& process[]) {
        ArrayResize(process,2);


        if(ArrayRange(this.dataset,0) < this.dataset_min_size) {
          process[0] = -1;
          process[1] = -1;
          return;
        }

        if(ArrayRange(this.dataset,0) > this.dataset_max_size) {
          this.datasetLastLines();
        }

        this.divideDatasets(this.dataset);

        if(ArrayRange(this.dataset_0,0) < 2 || ArrayRange(this.dataset_1,0) < 2) {
          process[0] = -1;
          process[1] = -1;
          return;
        }

        this.bxCols(this.dataset_0,this.dataset_0_bx);

        this.bxCols(this.dataset_1,this.dataset_1_bx);

        this.featureRanking();
        if(this.debug_afis || this.feature_ranking_print) {
          Print("/// FEATURE RANKING BEGIN ///");
          for (int i = 0; i < ArrayRange(this.feature_ranking,0); i++) {
            Print("i: " + IntegerToString(i) + " | this.feature_ranking[i]: ",DoubleToString(this.feature_ranking[i]));
          }
          Print("/// FEATURE RANKING BEGIN ///");
        }

        int results_order[];

        this.featureSelector(this.selected_features);
        if(this.debug_afis || this.selected_features_print) {
          Print("/// SELECTED FEATURES BEGIN ///");
          for (int i = 0; i < ArrayRange(this.selected_features,0); i++) {
            Print("i: ",IntegerToString(i)," | this.selected_features[i]: ",DoubleToString(this.selected_features[i]));
          }
          Print("/// SELECTED FEATURES END ///");
        }

        CList *in0=new CList;
        CList *in1=new CList;

        // 0 MODEL
        CMamdaniFuzzySystem *Model_0 = new CMamdaniFuzzySystem();
        this.fuzzyModel(0,Model_0,in0);

        // this.dynamicRules(Model_0);

        // 1 MODEL
        CMamdaniFuzzySystem *Model_1 = new CMamdaniFuzzySystem();
        this.fuzzyModel(1,Model_1,in1);

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

void Afis::datasetLastLines() {
  double dataset_temp[][100];
  ArrayCopy(dataset_temp,this.dataset);
  ArrayFree(this.dataset);

  ArrayPrint(this.dataset);

  int for_s = ArrayRange(dataset_temp,0) - this.dataset_max_size;


  int art_i = 0;
  for (int i = for_s; i < ArrayRange(dataset_temp,0); i++) {
    ArrayResize(this.dataset,art_i+1);
    for (int j = 0; j < 100; j++) {
      this.dataset[art_i][j] = dataset_temp[i][j];
    }
    art_i++;
  }


  // Print("for_s: " + for_s); //DEBUG
  // Print("datasetLastLines(): " + ArrayRange(this.dataset,0)); //DEBUG


}
