/* -*- C++ -*- */

class Filtro_Afis
{
  public:
  Filtro_Afis();
  int min_lines;
  int max_feats;
  int min_feats;
  string feature_method;
  string feature_selection_method;
  Afis *afis;
  Aquisicao *aquisicao;
  double inputs[]; // PEGAR INPUTS ATUAIS VIA AQUISICAO

  bool calc();

};

void Filtro_Afis::Filtro_Afis() {
  this.afis = new Afis;
  this.aquisicao = new Aquisicao;



}

bool Filtro_Afis::calc() {
  this.afis.linesize = ArrayRange(deal_matrix.matrix,0) ;

  this.afis.debug_afis = false;
  this.afis.selected_features_print = false;
  this.afis.feature_ranking_print = false;

  this.afis.rules_method = "dynamic";

  this.afis.feature_selection_method = "upperhinge";

  this.afis.max_feats = 5;
  this.afis.min_feats = 1 ;

  this.afis.feature_method = "variance";
  // this.afis.feature_method = "spearman";
  // this.afis.feature_method = "quantile";

  ArrayCopy(this.afis.dataset, deal_matrix.matrix);

  ArrayResize(inputs,ArrayRange(deal_matrix.matrix,0));

  inputs[0] = NULL;

  for (int i = 1; i < ArrayRange(inputs,0); i++) {
    inputs[i] = this.aquisicao.todosDados[i-1];
  }


return false;
}
