/* -*- C++ -*- */

class Xeon_beta
{

  public:
  void Comentario();

  void Avalia();
  void Init();
  int Exchange();
  Xeon_beta();

  private:

};



void Xeon_beta::Xeon_beta()
{


}

void Xeon_beta::Avalia()
{

}

int Xeon_beta::Exchange()
{
  return 0;
}

void Xeon_beta::Comentario()
{

}

void Xeon_beta::Init() {
  Afis *afis = new Afis;
  afis.linesize = 9;


  for(int i = 0; i < 20 ; i++) {
    double pizza[9];

    pizza[0] = 0;
    if(MathRand() > 16383 )   pizza[0] = 1;

    pizza[1] = MathRand();
    pizza[2] = MathRand();
    pizza[3] = MathRand();
    pizza[4] = MathRand();
    pizza[5] = MathRand();
    pizza[6] = MathRand();
    pizza[7] = MathRand();
    pizza[8] = MathRand();
    afis.Add_Line(pizza);
  }

afis.divide_datasets(afis.dataset);
//
// for (int i = 0; i < ArrayRange(afis.dataset_0,0); i++) {
//   Print("afis.dataset_0[i][0]: ",afis.dataset_0[i][0]);
// }
//
// for (int i = 0; i < ArrayRange(afis.dataset_1,0); i++) {
//   Print("afis.dataset_1[i][0]: ",afis.dataset_1[i][0]);
// }

double teste_feature[];
ArrayResize(teste_feature,ArrayRange(afis.dataset_0,0));

afis.Get_Feature_Col(afis.dataset_0,teste_feature,1);
//
// for (int i = 0; i < ArrayRange(teste_feature,0); i++) {
//   Print("i: ",i);
//   Print(" | teste_feature[0]: ",teste_feature[i]);
// }

double teste_bx_out[];
afis.Calc_BX(teste_feature,teste_bx_out);

//
// for (int i = 0; i < ArrayRange(teste_bx_out,0); i++) {
//   Print("i: ",i);
//   Print(" | teste_bx_out[i]: ",teste_bx_out[i]);
// }

double full_bx[][5];
afis.BX_Cols(afis.dataset_1,full_bx);
//
// for (int i = 0; i < ArrayRange(full_bx,0); i++) {
//   Print("i: ",i);
//   Print(" | full_bx[0]: ",full_bx[i][0]);
//   Print(" | full_bx[1]: ",full_bx[i][1]);
//   Print(" | full_bx[2]: ",full_bx[i][2]);
//   Print(" | full_bx[3]: ",full_bx[i][3]);
//   Print(" | full_bx[4]: ",full_bx[i][4]);
// }
afis.Feature_Ranking();

for (int i = 0; i < ArrayRange(afis.feature_ranking,0); i++) {
  Print("i: ",i);
  Print(" | afis.feature_ranking[i]: ",afis.feature_ranking[i]);
}

delete(afis);

}
