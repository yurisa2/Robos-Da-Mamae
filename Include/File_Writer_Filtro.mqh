/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                  File_Filtro_Writer.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"


string file_name_filtro     = "filtro.csv";
// string file_name_filtro     = "teste.txt";
int file_handle_w_filtro = -1;
Aquisicao filtro_ind;

void File_Filtro_Init() {
  // ...

  //Print("file_name_filtro: " + file_name_filtro);



  if(!Otimizacao) file_handle_w_filtro = FileOpen(file_name_filtro, FILE_WRITE|FILE_TXT|FILE_ANSI);
  // file_handle_w_filtro = FileOpen(file_name_filtro, FILE_WRITE|FILE_CSV|FILE_ANSI);
  if (file_handle_w_filtro <= 0 && !Otimizacao) {
    Print("Error opening rep-file: " + file_name_filtro);
    //ExpertRemove();
  }


  if ( file_handle_w_filtro > 0 && !Otimizacao) {

    File_Filtro *arquivo_filtro = new File_Filtro();
    delete(arquivo_filtro);

    FileWrite(file_handle_w_filtro, "io;hora;ativo;posicao;direcao;lucro;AC;AC_cx;AD;AD_cx;ADX;adx_cx;ATR;ATR_cx;BB_Delta_Bruto;BB_Delta_Bruto_cx;Banda_Delta_Valor;BB_Posicao_Percent;BB_Posicao_Percent_Cx;BullsP;BullsP_cx;BearsP;BearsP_cx;BWMFI;BWMFI_cx;CCI;CCI_cx;DeMarker;DeMarker_cx;DP_DMM20;DP_PAAMM20;DP_MM20MM50;DP_D;hilo_direcao;MACD;MACD_cx_0;MACD_cx_1;MACD_Diff_Angulo_LS;MACD_Distancia_Linha_Sinal;MACD_Distancia_Linha_Zero;MACD_Normalizacao;MACD_Normalizacao_Zero;MFI;MFI_cx;Momentum;Momentum_cx;RSI;RSI_cx;Stoch;Stoch_Cx_0;Stoch_Cx_1;Volume;Volume_cx;WPR;WPR_cx;Filtro_Fuzzy");
    //File_FiltroFlush(file_handle_w_filtro);
  }
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
  FileSeek(file_handle_w_filtro,0,SEEK_END);

  string Line = "\"" +
  EnumToString(io)
  + "\";\"" +
  TimeToString(TimeCurrent(),TIME_DATE|TIME_SECONDS)
  + "\";\"" +
  Symbol()
  + "\";\"" +
  posicao_fw
  + "\";\"" +
  direcao
  + "\";\"" +
  DoubleToString(lucro)
  + "\";\"" +
  DoubleToString(filtro_ind.AC_Var)
  + "\";\"" +
  DoubleToString(filtro_ind.AC_cx)
  + "\";\"" +
  DoubleToString(filtro_ind.AD_Var)
  + "\";\"" +
  DoubleToString(filtro_ind.AD_cx)
  + "\";\"" +
  DoubleToString(filtro_ind.ADX_FW)
  + "\";\"" +
  DoubleToString(filtro_ind.adx_cx)
  + "\";\"" +
  DoubleToString(filtro_ind.ATR_Var)
  + "\";\"" +
  DoubleToString(filtro_ind.ATR_cx)
  + "\";\"" +
  DoubleToString(filtro_ind.BB_Delta_Bruto)
  + "\";\"" +
  DoubleToString(filtro_ind.BB_Delta_Bruto_Cx)
  + "\";\"" +
  DoubleToString(filtro_ind.Banda_Delta_Valor)
  + "\";\"" +
  DoubleToString(filtro_ind.BB_Posicao_Percent)
  + "\";\"" +
  DoubleToString(filtro_ind.BB_Posicao_Percent_Cx)
  + "\";\"" +
  DoubleToString(filtro_ind.BullsP_Var)
  + "\";\"" +
  DoubleToString(filtro_ind.BullsP_Var_Cx)
  + "\";\"" +
  DoubleToString(filtro_ind.BearsP_Var)
  + "\";\"" +
  DoubleToString(filtro_ind.BearsP_Var_Cx)
  + "\";\"" +
  DoubleToString(filtro_ind.BWMFI_Var)
  + "\";\"" +
  DoubleToString(filtro_ind.BWMFI_Var_Cx)
  + "\";\"" +
  DoubleToString(filtro_ind.CCI_Var)
  + "\";\"" +
  DoubleToString(filtro_ind.CCI_Var_Cx)
  + "\";\"" +
  DoubleToString(filtro_ind.DeMarker_Var)
  + "\";\"" +
  DoubleToString(filtro_ind.DeMarker_Var_Cx)
  + "\";\"" +
  DoubleToString(filtro_ind.DP_DMM20)
  + "\";\"" +
  DoubleToString(filtro_ind.DP_PAAMM20)
  + "\";\"" +
  DoubleToString(filtro_ind.DP_MM20MM50)
  + "\";\"" +
  DoubleToString(filtro_ind.DP_D)
  + "\";\"" +
  DoubleToString(filtro_ind.Hilo_Direcao)
  + "\";\"" +
  DoubleToString(filtro_ind.MACD_FW)
  + "\";\"" +
  DoubleToString(filtro_ind.MACD_Cx_0)
  + "\";\"" +
  DoubleToString(filtro_ind.MACD_Cx_1)
  + "\";\"" +
  DoubleToString(filtro_ind.MACD_Diff_Angulo_LS)
  + "\";\"" +
  DoubleToString(filtro_ind.MACD_Distancia_Linha_Sinal)
  + "\";\"" +
  DoubleToString(filtro_ind.MACD_Distancia_Linha_Zero)
  + "\";\"" +
  DoubleToString(filtro_ind.MACD_Normalizacao)
  + "\";\"" +
  DoubleToString(filtro_ind.MACD_Normalizacao_Zero)
  + "\";\"" +
  DoubleToString(filtro_ind.MFI_FW)
  + "\";\"" +
  DoubleToString(filtro_ind.MFI_Cx)
  + "\";\"" +
  DoubleToString(filtro_ind.Momentum_Var)
  + "\";\"" +
  DoubleToString(filtro_ind.Momentum_Var_Cx)
  + "\";\"" +
  DoubleToString(filtro_ind.RSI_Var)
  + "\";\"" +
  DoubleToString(filtro_ind.RSI_Var_Cx)
  + "\";\"" +
  DoubleToString(filtro_ind.Stoch_FW)
  + "\";\"" +
  DoubleToString(filtro_ind.Stoch_Cx_0)
  + "\";\"" +
  DoubleToString(filtro_ind.Stoch_Cx_1)
  + "\";\"" +
  DoubleToString(filtro_ind.Volume_FW)
  + "\";\"" +
  DoubleToString(filtro_ind.Volume_Cx)
  + "\";\"" +
  DoubleToString(filtro_ind.WPR_Var)
  + "\";\"" +
  DoubleToString(filtro_ind.WPR_Var_Cx)
  + "\"" +
  DoubleToString(filtro_fuzzy_arquivo)
  + "\""
  ;

  FileWrite(file_handle_w_filtro,Line);
  FileFlush(file_handle_w_filtro);

}
