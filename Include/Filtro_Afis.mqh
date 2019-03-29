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
  double output[];
  Afis *afis;
  Aquisicao *aquisicao;
  double inputs[]; // PEGAR INPUTS ATUAIS VIA AQUISICAO

  double res_0;
  double res_1;


  int calc();

};

void Filtro_Afis::Filtro_Afis() {
  this.afis = new Afis;
  this.aquisicao = new Aquisicao;



}

int Filtro_Afis::calc() {

  if(ArrayRange(deal_matrix.matrix,0) == 0) return -1;

  this.afis.linesize = 79 ;

  this.afis.max_feats = 5;
  this.afis.min_feats = 1 ;

  this.afis.dataset_max_size = 20;

  ArrayCopy(this.afis.dataset, deal_matrix.matrix);

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
