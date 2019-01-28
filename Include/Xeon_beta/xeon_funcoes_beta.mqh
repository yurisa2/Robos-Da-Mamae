/* -*- C++ -*- */

class Xeon_beta
{

  public:
  void Comentario();

  void Avalia();
  int Exchange();
  Xeon_beta();

  private:

};



void Xeon_beta::Xeon_beta()
{


}

int Xeon_beta::Exchange()
{
  return 0;
}

void Xeon_beta::Comentario()
{

}

void Xeon_beta::Avalia() {

  Aquisicao *ind = new Aquisicao(60);
  Afis *afis = new Afis;

  afis.param_feature_min_cut = 0;

  HiLo_OO *hilo = new HiLo_OO(4);
  int direcao_now = hilo.Direcao();

  afis.linesize = 62;

  int actual_i = 0;


  double array_afis_temp[62];

    int n = 0;

for (int i = 1; i < 3000; i++) {
  ind.Dados(i);

  if(direcao_now == ind.Hilo_Direcao) {
    double delta_atual = (Preco(i+1).close - Preco(i+2).close);
    delta_atual = delta_atual * hilo.Direcao();

    if(delta_atual > 0  && delta_atual > xeon_min_diff) array_afis_temp[n++] = 1;
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
    // 10
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
    // 20
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
    // 30
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
    // 40
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
    // 50
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
    // 60
    array_afis_temp[n++] = ind.WPR_Var_Cx;
    array_afis_temp[n++] = ind.WPR_norm;

    n = 0;

    afis.Add_Line(array_afis_temp);
    actual_i++;

    if(actual_i == xeon_count_periods) break;
  }
}


delete(hilo);


ArrayResize(afis.input_fuzzy,afis.linesize);

ind.Dados(0);

  array_afis_temp[n++] = 0;

  array_afis_temp[n++] = ind.Hilo_Perm;
  array_afis_temp[n++] = Preco(1).close - Preco(2).close;
  array_afis_temp[n++] = Normaliza_Hora(Preco(1).time);
  array_afis_temp[n++] = ind.AC_Var;
  array_afis_temp[n++] = ind.AC_cx;
  array_afis_temp[n++] = ind.AC_norm;
  array_afis_temp[n++] = ind.AD_Var;
  array_afis_temp[n++] = ind.AD_cx;
  array_afis_temp[n++] = ind.AD_norm;
  // 10
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
  // 20
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
  // 30
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
  // 40
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
  // 50
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
  // 60
  array_afis_temp[n++] = ind.WPR_Var_Cx;
  array_afis_temp[n++] = ind.WPR_norm;


afis.debug_afis = false;


double processado[];
afis.Process(processado);

// for (int i = 0; i < ArrayRange(processado,0); i++) {
//   Print("i: " + IntegerToString(i) + " | processado[i]: ",DoubleToString(processado[i]));
// }
//
if(processado[1] > processado[0] &&
  processado[0] > 16 &&
  processado[1] > 16) Print("direcao_now: " + direcao_now + " | Vai: 1 - v0: " + DoubleToString(processado[0],2) + " | v1: " + DoubleToString(processado[1],2));
else Print("direcao_now: " + direcao_now + " | Vai: 0 - v0 - " + DoubleToString(processado[0],2) + " | v1: " + DoubleToString(processado[1],2));

// Print("ArrayRange(afis.dataset_0,0)" + ArrayRange(afis.dataset_0,0));
// Print("ArrayRange(afis.dataset_1,0)" + ArrayRange(afis.dataset_1,0));

// Print("reco(1).close - Preco(2).close: " + (Preco(1).close - Preco(2).close));

delete(afis);
delete(ind);

}
