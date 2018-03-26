/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                  File_Filtro_Writer.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"


Aquisicao filtro_ind;

void File_Filtro_Init() {

  File_Gen *arquivo_generico = new File_Gen(".Filtro_Fuzzy.csv");

  string Linha0  = "io,hora,ativo,posicao,direcao,lucro,AC_Var,AC_cx,AD_Var,AD_cx,ADX_FW,adx_cx,ATR_Var,ATR_cx,BB_Delta_Bruto,BB_Delta_Bruto_Cx,Banda_Delta_Valor,BB_Posicao_Percent,BB_Posicao_Percent_Cx,BullsP_Var,BullsP_Var_Cx,BearsP_Var,BearsP_Var_Cx,BWMFI_Var,BWMFI_Var_Cx,CCI_Var,CCI_Var_Cx,DeMarker_Var,DeMarker_Var_Cx,DP_DMM20,DP_PAAMM20,DP_MM20MM50,DP_D,Hilo_Direcao,MACD_FW,MACD_Cx_0,MACD_Cx_1,MACD_Diff_Angulo_LS,MACD_Distancia_Linha_Sinal,MACD_Distancia_Linha_Zero,MACD_Normalizacao,MACD_Normalizacao_Zero,MFI_FW,MFI_Cx,Momentum_Var,Momentum_Var_Cx,RSI_Var,RSI_Var_Cx,Stoch_FW,Stoch_Cx_0,Stoch_Cx_1,Volume_FW,Volume_Cx,WPR_Var,WPR_Var_Cx,Filtro_Fuzzy";

  arquivo_generico.Linha(Linha0);
  delete arquivo_generico;

  }

class File_Filtro
{
  public:
  File_Filtro();
  ~File_Filtro();
  void Escreve(string posicao_fw,string direcao,double lucro, ENUM_DEAL_ENTRY io);

  private:

};


File_Filtro::File_Filtro()
{

}

File_Filtro::~File_Filtro()
{

}

void File_Filtro::Escreve(string posicao_fw,string direcao,double lucro, ENUM_DEAL_ENTRY io)
{
  File_Gen *arquivo_generico = new File_Gen(".Filtro_Fuzzy.csv");

  string Line = "" +
  EnumToString(io)
  + "," +
  TimeToString(TimeCurrent(),TIME_DATE|TIME_SECONDS)
  + "," +
  Symbol()
  + "," +
  posicao_fw
  + "," +
  direcao
  + "," +
  DoubleToString(lucro)
  + "," +
  DoubleToString(filtro_ind.AC_Var)
  + "," +
  DoubleToString(filtro_ind.AC_cx)
  + "," +
  DoubleToString(filtro_ind.AD_Var)
  + "," +
  DoubleToString(filtro_ind.AD_cx)
  + "," +
  DoubleToString(filtro_ind.ADX_FW)
  + "," +
  DoubleToString(filtro_ind.adx_cx)
  + "," +
  DoubleToString(filtro_ind.ATR_Var)
  + "," +
  DoubleToString(filtro_ind.ATR_cx)
  + "," +
  DoubleToString(filtro_ind.BB_Delta_Bruto)
  + "," +
  DoubleToString(filtro_ind.BB_Delta_Bruto_Cx)
  + "," +
  DoubleToString(filtro_ind.Banda_Delta_Valor)
  + "," +
  DoubleToString(filtro_ind.BB_Posicao_Percent)
  + "," +
  DoubleToString(filtro_ind.BB_Posicao_Percent_Cx)
  + "," +
  DoubleToString(filtro_ind.BullsP_Var)
  + "," +
  DoubleToString(filtro_ind.BullsP_Var_Cx)
  + "," +
  DoubleToString(filtro_ind.BearsP_Var)
  + "," +
  DoubleToString(filtro_ind.BearsP_Var_Cx)
  + "," +
  DoubleToString(filtro_ind.BWMFI_Var)
  + "," +
  DoubleToString(filtro_ind.BWMFI_Var_Cx)
  + "," +
  DoubleToString(filtro_ind.CCI_Var)
  + "," +
  DoubleToString(filtro_ind.CCI_Var_Cx)
  + "," +
  DoubleToString(filtro_ind.DeMarker_Var)
  + "," +
  DoubleToString(filtro_ind.DeMarker_Var_Cx)
  + "," +
  DoubleToString(filtro_ind.DP_DMM20)
  + "," +
  DoubleToString(filtro_ind.DP_PAAMM20)
  + "," +
  DoubleToString(filtro_ind.DP_MM20MM50)
  + "," +
  DoubleToString(filtro_ind.DP_D)
  + "," +
  DoubleToString(filtro_ind.Hilo_Direcao)
  + "," +
  DoubleToString(filtro_ind.MACD_FW)
  + "," +
  DoubleToString(filtro_ind.MACD_Cx_0)
  + "," +
  DoubleToString(filtro_ind.MACD_Cx_1)
  + "," +
  DoubleToString(filtro_ind.MACD_Diff_Angulo_LS)
  + "," +
  DoubleToString(filtro_ind.MACD_Distancia_Linha_Sinal)
  + "," +
  DoubleToString(filtro_ind.MACD_Distancia_Linha_Zero)
  + "," +
  DoubleToString(filtro_ind.MACD_Normalizacao)
  + "," +
  DoubleToString(filtro_ind.MACD_Normalizacao_Zero)
  + "," +
  DoubleToString(filtro_ind.MFI_FW)
  + "," +
  DoubleToString(filtro_ind.MFI_Cx)
  + "," +
  DoubleToString(filtro_ind.Momentum_Var)
  + "," +
  DoubleToString(filtro_ind.Momentum_Var_Cx)
  + "," +
  DoubleToString(filtro_ind.RSI_Var)
  + "," +
  DoubleToString(filtro_ind.RSI_Var_Cx)
  + "," +
  DoubleToString(filtro_ind.Stoch_FW)
  + "," +
  DoubleToString(filtro_ind.Stoch_Cx_0)
  + "," +
  DoubleToString(filtro_ind.Stoch_Cx_1)
  + "," +
  DoubleToString(filtro_ind.Volume_FW)
  + "," +
  DoubleToString(filtro_ind.Volume_Cx)
  + "," +
  DoubleToString(filtro_ind.WPR_Var)
  + "," +
  DoubleToString(filtro_ind.WPR_Var_Cx)
  + "," +
  DoubleToString(filtro_fuzzy_arquivo)
  + ""
  ;
  arquivo_generico.Linha(Line);
  delete arquivo_generico;

}
