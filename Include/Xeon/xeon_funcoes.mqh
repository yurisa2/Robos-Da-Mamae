/* -*- C++ -*- */

class Xeon
{

  public:
  void Comentario();
  int SendJson(string url, CJAVal &json_type);

  void Avalia();
  int Exchange();
  Xeon();

  private:

};

void Xeon::Xeon()
{


}

void Xeon::Avalia()
{
  int status_exchange = this.Exchange();

  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  if(xeon_encerra_zero && status_exchange == 0)  {
  Opera_Mercado *opera = new Opera_Mercado;
  opera.FechaPosicao() ;
  delete(opera);
  }

  if(status_exchange == 1 && Condicoes.Horario()) {
    HiLo_OO *hilo = new HiLo_OO(4);
    int direcao_now = hilo.Direcao();
    delete(hilo);

    Opera_Mercado *opera = new Opera_Mercado;
    opera.AbrePosicao(direcao_now, "Entrada Xeon");
    delete(opera);
  }
  delete(Condicoes);
}

int Xeon::Exchange()
{
  Aquisicao *ind = new Aquisicao;

  HiLo_OO *hilo = new HiLo_OO(4);
  int direcao_now = hilo.Direcao();
  delete(hilo);

  string base_url = xeon_url;

  int actual_i = 0;

  CJAVal jv_main(NULL, jtUNDEF);

  for(int i = 0; i < 300 ; i++) {
    ind.Dados(i);
    if(direcao_now == ind.Hilo_Direcao) {

      CJAVal *jv = new CJAVal;

      jv["i"] = (IntegerToString(i));
      jv["lucro"] = (DoubleToString(Preco(i+1).close - Preco(i+2).close));
      jv["Hilo_Direcao"] = (DoubleToString(ind.Hilo_Direcao));
      jv["AC_Var"] = (DoubleToString(ind.AC_Var));
      jv["AC_cx"] = (DoubleToString(ind.AC_cx));
      jv["AC_norm"] = (DoubleToString(ind.AC_norm));
      jv["AD_Var"] = (DoubleToString(ind.AD_Var));
      jv["AD_cx"] = (DoubleToString(ind.AD_cx));
      jv["AD_norm"] = (DoubleToString(ind.AD_norm));
      jv["ADX_FW"] = (DoubleToString(ind.ADX_FW));
      jv["adx_cx"] = (DoubleToString(ind.adx_cx));
      jv["adx_norm"] = (DoubleToString(ind.adx_norm));
      jv["ATR_Var"] = (DoubleToString(ind.ATR_Var));
      jv["ATR_cx"] = (DoubleToString(ind.ATR_cx));
      jv["ATR_norm"] = (DoubleToString(ind.ATR_norm));
      jv["BB_Delta_Bruto"] = (DoubleToString(ind.BB_Delta_Bruto));
      jv["BB_Delta_Bruto_Cx"] = (DoubleToString(ind.BB_Delta_Bruto_Cx));
      jv["BB_Delta_Bruto_norm"] = (DoubleToString(ind.BB_Delta_Bruto_norm));
      jv["Banda_Delta_Valor"] = (DoubleToString(ind.Banda_Delta_Valor));
      jv["BB_Posicao_Percent"] = (DoubleToString(ind.BB_Posicao_Percent));
      jv["BB_Posicao_Percent_Cx"] = (DoubleToString(ind.BB_Posicao_Percent_Cx));
      jv["BB_Posicao_Percent_norm"] = (DoubleToString(ind.BB_Posicao_Percent_norm));
      jv["BullsP_Var"] = (DoubleToString(ind.BullsP_Var));
      jv["BullsP_Var_Cx"] = (DoubleToString(ind.BullsP_Var_Cx));
      jv["BullsP_norm"] = (DoubleToString(ind.BullsP_norm));
      jv["BearsP_Var"] = (DoubleToString(ind.BearsP_Var));
      jv["BearsP_Var_Cx"] = (DoubleToString(ind.BearsP_Var_Cx));
      jv["BearsP_norm"] = (DoubleToString(ind.BearsP_norm));
      jv["BWMFI_Var"] = (DoubleToString(ind.BWMFI_Var));
      jv["BWMFI_Var_Cx"] = (DoubleToString(ind.BWMFI_Var_Cx));
      jv["BWMFI_norm"] = (DoubleToString(ind.BWMFI_norm));
      jv["CCI_Var"] = (DoubleToString(ind.CCI_Var));
      jv["CCI_Var_Cx"] = (DoubleToString(ind.CCI_Var_Cx));
      jv["CCI_norm"] = (DoubleToString(ind.CCI_norm));
      jv["DeMarker_Var"] = (DoubleToString(ind.DeMarker_Var));
      jv["DeMarker_Var_Cx"] = (DoubleToString(ind.DeMarker_Var_Cx));
      jv["DeMarker_norm"] = (DoubleToString(ind.DeMarker_norm));
      // jv["DP_DMM20"] = (DoubleToString(ind.DP_DMM20));
      // jv["DP_PAAMM20"] = (DoubleToString(ind.DP_PAAMM20));
      // jv["DP_MM20MM50"] = (DoubleToString(ind.DP_MM20MM50));
      // jv["DP_D"] = (DoubleToString(ind.DP_D));
      jv["MFI_FW"] = (DoubleToString(ind.MFI_FW));
      jv["MFI_Cx"] = (DoubleToString(ind.MFI_Cx));
      jv["MFI_norm"] = (DoubleToString(ind.MFI_norm));
      jv["Momentum_Var"] = (DoubleToString(ind.Momentum_Var));
      jv["Momentum_Var_Cx"] = (DoubleToString(ind.Momentum_Var_Cx));
      jv["Momentum_norm"] = (DoubleToString(ind.Momentum_norm));
      jv["RSI_Var"] = (DoubleToString(ind.RSI_Var));
      jv["RSI_Var_Cx"] = (DoubleToString(ind.RSI_Var_Cx));
      jv["RSI_norm"] = (DoubleToString(ind.RSI_norm));
      jv["Stoch_FW"] = (DoubleToString(ind.Stoch_FW));
      jv["Stoch_Cx_0"] = (DoubleToString(ind.Stoch_Cx_0));
      jv["Stoch_Cx_1"] = (DoubleToString(ind.Stoch_Cx_1));
      jv["Stoch_norm_1"] = (DoubleToString(ind.Stoch_norm_1));
      jv["Stoch_norm_2"] = (DoubleToString(ind.Stoch_norm_2));
      jv["Volume_FW"] = (DoubleToString(ind.Volume_FW));
      jv["Volume_Cx"] = (DoubleToString(ind.Volume_Cx));
      jv["Volume_norm"] = (DoubleToString(ind.Volume_norm));
      jv["WPR_Var"] = (DoubleToString(ind.WPR_Var));
      jv["WPR_Var_Cx"] = (DoubleToString(ind.WPR_Var_Cx));
      jv["WPR_norm"] = (DoubleToString(ind.WPR_norm));

      string index_s = IntegerToString(actual_i);

      jv_main.Add(jv);

      delete(jv);
      actual_i++;

      if(actual_i == xeon_count_periods) {
        break;
      }
    }
  }

  // Print(jv_main.Serialize());

  int retorno = this.SendJson(base_url,jv_main);
  delete(ind);
  return retorno;
}

void Xeon::Comentario()
{
  if(Tipo_Comentario > 0)
  {
    HiLo_OO *hilo = new HiLo_OO(4);

    Comentario_Robo = "Direcao Xeon: ";
    // Comentario_Robo += "\n";
    Comentario_Robo += IntegerToString(hilo.Direcao());
delete(hilo);
  }
}

int Xeon::SendJson(string url, CJAVal &json_type){

  Print("Sending Json" + Symbol());

  string cookie=NULL,result_headers;
  char   data[];
  char result[];
  ResetLastError();
  string headers2 = "Content-Type: application/json\r\n";

  ArrayResize(data,
              StringToCharArray(json_type.Serialize(),
              data, 0, WHOLE_ARRAY)-1);

  int res=WebRequest("POST",url,headers2,500,data,result,result_headers);
  if(res==-1)   {
    Print("Erro no WebRequest. Código de erro =",GetLastError());
    Print("É necessário adicionar um endereço '"+url+
          "' à lista de URL permitidas na guia 'Experts'");
  }  else  {
    if(res==200)  {

      Print("Resultado Xeon: " + CharArrayToString(result) +
            "Ativo: " + Symbol());
      int resultado_api = (int)StringToInteger(StringSubstr(CharArrayToString(result),1,1));
      Print("Processado Xeon: " + IntegerToString(resultado_api) +
            "Simbolo" + Symbol());
      return resultado_api;
    } else {
      PrintFormat("Xeon - Erro de download '%s', código %d",url,res);
      return 0;
    }
    return 0;
  }
  return 0;
}
