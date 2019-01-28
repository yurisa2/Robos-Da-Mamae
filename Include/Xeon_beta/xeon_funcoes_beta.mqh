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

  Aquisicao *ind = new Aquisicao(60);
  Afis *afis = new Afis;

  HiLo_OO *hilo = new HiLo_OO(4);
  int direcao_now = hilo.Direcao();

  afis.linesize = 62;

  double array_afis_temp[62];

    int n = 0;

for (int i = 1; i < 100; i++) {
  ind.Dados(i);

  double delta_atual = (Preco(i+1).close - Preco(i+2).close);

  delta_atual = delta_atual * hilo.Direcao();

  if(delta_atual > 0 ) array_afis_temp[n++] = 1;
  else array_afis_temp[n++] = 0;

  array_afis_temp[n++] = ind.Hilo_Perm;
  array_afis_temp[n++] = Preco(i+1).close - Preco(i+2).close;
  array_afis_temp[n++] = Normaliza_Hora(Preco(i).time);
  array_afis_temp[n++] = ind.AC_Var;
  array_afis_temp[n++] = ind.AC_cx;
  array_afis_temp[n++] = ind.AC_norm;
  array_afis_temp[n++] = ind.AD_Var;
  array_afis_temp[n++] = ind.AD_cx;
  array_afis_temp[n++] = ind.AD_norm;
  array_afis_temp[n++] = ind.ADX_FW;
  array_afis_temp[n++] = ind.adx_cx;
  array_afis_temp[n++] = ind.adx_norm;
  array_afis_temp[n++] = ind.ATR_Var;
  array_afis_temp[n++] = ind.ATR_cx;
  array_afis_temp[n++] = ind.ATR_norm;
  array_afis_temp[n++] = ind.BB_Delta_Bruto;
  array_afis_temp[n++] = ind.BB_Delta_Bruto_Cx;
  array_afis_temp[n++] = ind.BB_Delta_Bruto_norm;
  array_afis_temp[n++] = ind.Banda_Delta_Valor;
  array_afis_temp[n++] = ind.BB_Posicao_Percent;
  array_afis_temp[n++] = ind.BB_Posicao_Percent_Cx;
  array_afis_temp[n++] = ind.BB_Posicao_Percent_norm;
  array_afis_temp[n++] = ind.BullsP_Var;
  array_afis_temp[n++] = ind.BullsP_Var_Cx;
  array_afis_temp[n++] = ind.BearsP_Var;
  array_afis_temp[n++] = ind.BearsP_Var_Cx;
  array_afis_temp[n++] = ind.BearsP_norm;
  array_afis_temp[n++] = ind.BWMFI_Var;
  array_afis_temp[n++] = ind.BWMFI_Var_Cx;
  array_afis_temp[n++] = ind.BWMFI_norm;
  array_afis_temp[n++] = ind.CCI_Var;
  array_afis_temp[n++] = ind.CCI_Var_Cx;
  array_afis_temp[n++] = ind.CCI_norm;
  array_afis_temp[n++] = ind.DeMarker_Var;
  array_afis_temp[n++] = ind.DeMarker_Var_Cx;
  array_afis_temp[n++] = ind.DeMarker_norm;
  array_afis_temp[n++] = ind.DP_D_Perm;
  array_afis_temp[n++] = ind.MA_high;
  array_afis_temp[n++] = ind.MA_low;
  array_afis_temp[n++] = ind.MA_delta;
  array_afis_temp[n++] = ind.MACD_FW;
  array_afis_temp[n++] = ind.MFI_FW;
  array_afis_temp[n++] = ind.MFI_Cx;
  array_afis_temp[n++] = ind.MFI_norm;
  array_afis_temp[n++] = ind.Momentum_Var;
  array_afis_temp[n++] = ind.Momentum_Var_Cx;
  array_afis_temp[n++] = ind.Momentum_norm;
  array_afis_temp[n++] = ind.RSI_Var;
  array_afis_temp[n++] = ind.RSI_Var_Cx;
  array_afis_temp[n++] = ind.RSI_norm;
  array_afis_temp[n++] = ind.Stoch_FW;
  array_afis_temp[n++] = ind.Stoch_Cx_0;
  array_afis_temp[n++] = ind.Stoch_Cx_1;
  array_afis_temp[n++] = ind.Stoch_norm_1;
  array_afis_temp[n++] = ind.Stoch_norm_2;
  array_afis_temp[n++] = ind.Volume_FW;
  array_afis_temp[n++] = ind.Volume_Cx;
  array_afis_temp[n++] = ind.Volume_norm;
  array_afis_temp[n++] = ind.WPR_Var;
  array_afis_temp[n++] = ind.WPR_Var_Cx;
  array_afis_temp[n++] = ind.WPR_norm;



  n = 0;

  afis.Add_Line(array_afis_temp);
}


delete(hilo);


// afis.divide_datasets(afis.dataset);
//
// for (int i = 0; i < ArrayRange(afis.dataset_0,0); i++) {
//   Print("afis.dataset_0[i][0]: ",afis.dataset_0[i][0]);
// }
//
// for (int i = 0; i < ArrayRange(afis.dataset_1,0); i++) {
//   Print("afis.dataset_1[i][0]: ",afis.dataset_1[i][0]);
// }

// double teste_feature[];
// ArrayResize(teste_feature,ArrayRange(afis.dataset_0,0));
//
// afis.Get_Feature_Col(afis.dataset_0,teste_feature,1);
//
// for (int i = 0; i < ArrayRange(teste_feature,0); i++) {
//   Print("i: ",i);
//   Print(" | teste_feature[0]: ",teste_feature[i]);
// }

// double teste_bx_out[];
// afis.Calc_BX(teste_feature,teste_bx_out);

//
// for (int i = 0; i < ArrayRange(teste_bx_out,0); i++) {
//   Print("i: ",i);
//   Print(" | teste_bx_out[i]: ",teste_bx_out[i]);
// }
//
// double full_bx[][5];
// afis.BX_Cols(afis.dataset_1,full_bx);
//
// for (int i = 0; i < ArrayRange(full_bx,0); i++) {
//   Print("i: ",i);
//   Print(" | full_bx[0]: ",full_bx[i][0]);
//   Print(" | full_bx[1]: ",full_bx[i][1]);
//   Print(" | full_bx[2]: ",full_bx[i][2]);
//   Print(" | full_bx[3]: ",full_bx[i][3]);
//   Print(" | full_bx[4]: ",full_bx[i][4]);
// }
// afis.Feature_Ranking();
//
// for (int i = 0; i < ArrayRange(afis.feature_ranking,0); i++) {
//   Print("i: ",i);
//   Print(" | afis.feature_ranking[i]: ",afis.feature_ranking[i]);
// }
ArrayResize(afis.input_fuzzy,afis.linesize);

ind.Dados(0);


afis.input_fuzzy[n++] = 0;
afis.input_fuzzy[n++] = ind.BullsP_norm;
afis.input_fuzzy[n++] = ind.Hilo_Perm;
afis.input_fuzzy[n++] = Preco(1).close - Preco(2).close;
afis.input_fuzzy[n++] = Normaliza_Hora(Preco(1).time);
afis.input_fuzzy[n++] = ind.AC_Var;
afis.input_fuzzy[n++] = ind.AC_cx;
afis.input_fuzzy[n++] = ind.AC_norm;
afis.input_fuzzy[n++] = ind.AD_Var;
afis.input_fuzzy[n++] = ind.AD_cx;
afis.input_fuzzy[n++] = ind.AD_norm;
afis.input_fuzzy[n++] = ind.ADX_FW;
afis.input_fuzzy[n++] = ind.adx_cx;
afis.input_fuzzy[n++] = ind.adx_norm;

afis.debug_afis = true;


double processado[];
afis.Process(processado);

delete(afis);
delete(ind);

}
