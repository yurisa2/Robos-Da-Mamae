/* -*- C++ -*- */

class Xeon_beta
{

  public:
  Xeon_beta();
  void Comentario();

  void Avalia();
  void Get_Data(int barra, int& Array_Size, double& Valores[]);

  private:

};



void Xeon_beta::Xeon_beta()
{


}

void Xeon_beta::Get_Data(int barra, int& Array_Size, double& Valores[])
{
  Aquisicao *ind = new Aquisicao(xeon_norm);
  HiLo_OO *hilo = new HiLo_OO(4);
  int direcao_hilo = hilo.Direcao(barra);

  ArrayResize(Valores,Array_Size);

  int n = 0;

  double delta_atual = (Preco(barra+1).close - Preco(barra+2).close);
  delta_atual = delta_atual * direcao_hilo;

  if(delta_atual > 0  && delta_atual > xeon_min_diff) Valores[n++] = 1;
  else Valores[n++] = 0;

  Valores[n++] = ind.Hilo_Perm;
  Valores[n++] = Preco(barra+1).close - Preco(barra+2).close;
  Valores[n++] = Normaliza_Hora(Preco(barra).time);
  Valores[n++] = ind.AC_Var;
  Valores[n++] = ind.AC_cx;
  Valores[n++] = ind.AC_norm;
  Valores[n++] = ind.AD_Var;
  Valores[n++] = ind.AD_cx;
  Valores[n++] = ind.AD_norm;
  // 10
  Valores[n++] = ind.ADX_FW;
  Valores[n++] = ind.adx_cx;
  Valores[n++] = ind.adx_norm;
  Valores[n++] = ind.ATR_Var;
  Valores[n++] = ind.ATR_cx;
  Valores[n++] = ind.ATR_norm;
  Valores[n++] = ind.BB_Delta_Bruto;
  Valores[n++] = ind.BB_Delta_Bruto_Cx;
  Valores[n++] = ind.BB_Delta_Bruto_norm;
  Valores[n++] = ind.Banda_Delta_Valor;
  // 20
  Valores[n++] = ind.BB_Posicao_Percent;
  Valores[n++] = ind.BB_Posicao_Percent_Cx;
  Valores[n++] = ind.BB_Posicao_Percent_norm;
  Valores[n++] = ind.BullsP_Var;
  Valores[n++] = ind.BullsP_Var_Cx;
  Valores[n++] = ind.BearsP_Var;
  Valores[n++] = ind.BearsP_Var_Cx;
  Valores[n++] = ind.BearsP_norm;
  Valores[n++] = ind.BWMFI_Var;
  Valores[n++] = ind.BWMFI_Var_Cx;
  // 30
  Valores[n++] = ind.BWMFI_norm;
  Valores[n++] = ind.CCI_Var;
  Valores[n++] = ind.CCI_Var_Cx;
  Valores[n++] = ind.CCI_norm;
  Valores[n++] = ind.DeMarker_Var;
  Valores[n++] = ind.DeMarker_Var_Cx;
  Valores[n++] = ind.DeMarker_norm;
  Valores[n++] = ind.DP_D_Perm;
  Valores[n++] = ind.MA_high;
  Valores[n++] = ind.MA_low;
  // 40
  Valores[n++] = ind.MA_delta;
  Valores[n++] = ind.MACD_FW;
  Valores[n++] = ind.MFI_FW;
  Valores[n++] = ind.MFI_Cx;
  Valores[n++] = ind.MFI_norm;
  Valores[n++] = ind.Momentum_Var;
  Valores[n++] = ind.Momentum_Var_Cx;
  Valores[n++] = ind.Momentum_norm;
  Valores[n++] = ind.RSI_Var;
  Valores[n++] = ind.RSI_Var_Cx;
  // 50
  Valores[n++] = ind.RSI_norm;
  Valores[n++] = ind.Stoch_FW;
  Valores[n++] = ind.Stoch_Cx_0;
  Valores[n++] = ind.Stoch_Cx_1;
  Valores[n++] = ind.Stoch_norm_1;
  Valores[n++] = ind.Stoch_norm_2;
  Valores[n++] = ind.Volume_FW;
  Valores[n++] = ind.Volume_Cx;
  Valores[n++] = ind.Volume_norm;
  Valores[n++] = ind.WPR_Var;
  // 60
  Valores[n++] = ind.WPR_Var_Cx;
  Valores[n++] = ind.WPR_norm;

  delete(ind);
  delete(hilo);
}

void Xeon_beta::Comentario()
{

}

void Xeon_beta::Avalia() {

  Afis *afis = new Afis;

  afis.param_feature_min_cut = xeon_cut;
  afis.debug_afis = false;
  afis.selected_features_print = false;
  afis.feature_ranking_print = false;

  afis.feature_selection_method = "upperhinge";


  afis.max_feats = xeon_max_feats;
  afis.min_feats = 1 ;

  if(xeon_feature_selection == 0) afis.feature_method = "variance";
  if(xeon_feature_selection == 1) afis.feature_method = "spearman";
  if(xeon_feature_selection == 2) afis.feature_method = "quantile";

  HiLo_OO *hilo = new HiLo_OO(4);
  int direcao_now = hilo.Direcao();

  afis.linesize = 62;
  double array_afis_temp[62];

  ArrayResize(afis.input_fuzzy,afis.linesize);

  int actual_i = 0;
  int n = 0;

  for (int i = 1; i < 3000; i++) {

    if(direcao_now == hilo.Direcao(i)) {

      this.Get_Data(i, afis.linesize, array_afis_temp);

      afis.Add_Line(array_afis_temp);
      actual_i++;
      if(actual_i == xeon_count_periods) break;
    }
  }


  delete(hilo);




  this.Get_Data(0, afis.linesize, afis.input_fuzzy);

  double processado[];
  afis.Process(processado);

  int status_exchange = 0;

  if(processado[1] > xeon_thresh &&
    processado[0] > 16)
    {
      Print("direcao_now: " + direcao_now + " | Vai: 1 - v0: " + DoubleToString(processado[0],2) + " | v1: " + DoubleToString(processado[1],2));
      status_exchange = 1;
    }
    // else Print("direcao_now: " + direcao_now + " | Vai: 0 - v0 - " + DoubleToString(processado[0],2) + " | v1: " + DoubleToString(processado[1],2));

    // Print("ArrayRange(afis.dataset_0,0)" + ArrayRange(afis.dataset_0,0));
    // Print("ArrayRange(afis.dataset_1,0)" + ArrayRange(afis.dataset_1,0));

    // Print("reco(1).close - Preco(2).close: " + (Preco(1).close - Preco(2).close));

    Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

    if((xeon_encerra_zero && status_exchange == 0) ||
    (O_Stops.Tipo_Posicao() != 0 &&
    O_Stops.Tipo_Posicao() != direcao_now) )  {
      Opera_Mercado *opera = new Opera_Mercado;
      opera.FechaPosicao() ;
      delete(opera);
    }

    if(status_exchange == 1 && Condicoes.Horario()) {

      Filtro_Afis *f_afis = new Filtro_Afis;

      f_afis.calc();


      Opera_Mercado *opera = new Opera_Mercado;
      opera.AbrePosicao(direcao_now, "Entrada Xeon");
      delete(opera);
    }


    delete(afis);
    delete(Condicoes);

  }
