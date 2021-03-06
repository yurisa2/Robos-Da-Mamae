﻿/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                  File_Writer.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"


string file_name     =  Nome_Robo + "." + Symbol() + ".p" + IntegerToString(file_normalizacao) + "." + IntegerToString(Rand_Geral) + "." + EnumToString(TimeFrame) + ".Stats.csv";

// string file_name     = "teste.txt";
int file_handle_w = -1;

void File_Init() {

  // ...

  //Print("file_name: " + file_name);


  if(!Otimizacao) file_handle_w = FileOpen(file_name, FILE_WRITE|FILE_TXT|FILE_COMMON|FILE_ANSI);
  // file_handle_w = FileOpen(file_name, FILE_WRITE|FILE_CSV|FILE_COMMON|FILE_ANSI);
  if (file_handle_w <= 0 && !Otimizacao) {
    Print("Error opening rep-file: " + file_name);
    //ExpertRemove();
  }


  if ( file_handle_w > 0 && !Otimizacao) {

    File *arquivo = new File();
    delete(arquivo);

    FileWrite(file_handle_w, "io,hora,ativo,posicao,direcao,lucro,AC_Var,AC_cx,AC_norm,AD_Var,AD_cx,AD_norm,ADX_FW,adx_cx,adx_norm,ATR_Var,ATR_cx,ATR_norm,BB_Delta_Bruto,BB_Delta_Bruto_Cx,BB_Delta_Bruto_norm,Banda_Delta_Valor,BB_Posicao_Percent,BB_Posicao_Percent_Cx,BB_Posicao_Percent_norm,BullsP_Var,BullsP_Var_Cx,BullsP_norm,BearsP_Var,BearsP_Var_Cx,BearsP_norm,BWMFI_Var,BWMFI_Var_Cx,BWMFI_norm,CCI_Var,CCI_Var_Cx,CCI_norm,DeMarker_Var,DeMarker_Var_Cx,DeMarker_norm,DP_DMM20,DP_PAAMM20,DP_MM20MM50,DP_D,Hilo_Direcao,MACD_FW,MACD_Cx_0,MACD_Cx_1,MACD_Diff_Angulo_LS,MACD_Distancia_Linha_Sinal,MACD_Distancia_Linha_Zero,MACD_Normalizacao,MACD_Normalizacao_Zero,MFI_FW,MFI_Cx,MFI_norm,Momentum_Var,Momentum_Var_Cx,Momentum_norm,RSI_Var,RSI_Var_Cx,RSI_norm,Stoch_FW,Stoch_Cx_0,Stoch_Cx_1,Stoch_norm_1,Stoch_norm_2,Volume_FW,Volume_Cx,Volume_norm,WPR_Var,WPR_Var_Cx,WPR_norm");
    FileFlush(file_handle_w);
  }
}

class File
{
  public:
  File();
  ~File();
  void Escreve(string posicao_fw,string direcao,double lucro, ENUM_DEAL_ENTRY io,int norm_periods = 7);

  private:

};


File::File()
{

}

File::~File()
{

}

void File::Escreve(string posicao_fw,string direcao,double lucro, ENUM_DEAL_ENTRY io,int norm_periods = 7)
{
  Aquisicao *ind = new Aquisicao(file_normalizacao);
  //FiltroF *filtro_fuzzy = new FiltroF;


  FileSeek(file_handle_w,0,SEEK_END);

  string Line = "\"" +
  EnumToString(io)
  + "\",\"" +
  TimeToString(TimeCurrent(),TIME_DATE|TIME_SECONDS)
  + "\",\"" +
  Symbol()
  + "\",\"" +
  posicao_fw
  + "\",\"" +
  direcao
  + "\",\"" +
  DoubleToString(lucro)
  + "\",\"" +
  DoubleToString(ind.AC_Var)
  + "\",\"" +
  DoubleToString(ind.AC_cx)
  + "\",\"" +
  DoubleToString(ind.AC_norm)
  + "\",\"" +
  DoubleToString(ind.AD_Var)
  + "\",\"" +
  DoubleToString(ind.AD_cx)
  + "\",\"" +
  DoubleToString(ind.AD_norm)
  + "\",\"" +
  DoubleToString(ind.ADX_FW)
  + "\",\"" +
  DoubleToString(ind.adx_cx)
  + "\",\"" +
  DoubleToString(ind.adx_norm)
  + "\",\"" +
  DoubleToString(ind.ATR_Var)
  + "\",\"" +
  DoubleToString(ind.ATR_cx)
  + "\",\"" +
  DoubleToString(ind.ATR_norm)
  + "\",\"" +
  DoubleToString(ind.BB_Delta_Bruto)
  + "\",\"" +
  DoubleToString(ind.BB_Delta_Bruto_Cx)
  + "\",\"" +
  DoubleToString(ind.BB_Delta_Bruto_norm)
  + "\",\"" +
  DoubleToString(ind.Banda_Delta_Valor)
  + "\",\"" +
  DoubleToString(ind.BB_Posicao_Percent)
  + "\",\"" +
  DoubleToString(ind.BB_Posicao_Percent_Cx)
  + "\",\"" +
  DoubleToString(ind.BB_Posicao_Percent_norm)
  + "\",\"" +
  DoubleToString(ind.BullsP_Var)
  + "\",\"" +
  DoubleToString(ind.BullsP_Var_Cx)
  + "\",\"" +
  DoubleToString(ind.BullsP_norm)
  + "\",\"" +
  DoubleToString(ind.BearsP_Var)
  + "\",\"" +
  DoubleToString(ind.BearsP_Var_Cx)
  + "\",\"" +
  DoubleToString(ind.BearsP_norm)
  + "\",\"" +
  DoubleToString(ind.BWMFI_Var)
  + "\",\"" +
  DoubleToString(ind.BWMFI_Var_Cx)
  + "\",\"" +
  DoubleToString(ind.BWMFI_norm)
  + "\",\"" +
  DoubleToString(ind.CCI_Var)
  + "\",\"" +
  DoubleToString(ind.CCI_Var_Cx)
  + "\",\"" +
  DoubleToString(ind.CCI_norm)
  + "\",\"" +
  DoubleToString(ind.DeMarker_Var)
  + "\",\"" +
  DoubleToString(ind.DeMarker_Var_Cx)
  + "\",\"" +
  DoubleToString(ind.DeMarker_norm)
  + "\",\"" +
  DoubleToString(ind.DP_DMM20)
  + "\",\"" +
  DoubleToString(ind.DP_PAAMM20)
  + "\",\"" +
  DoubleToString(ind.DP_MM20MM50)
  + "\",\"" +
  DoubleToString(ind.DP_D)
  + "\",\"" +
  DoubleToString(ind.Hilo_Direcao)
  + "\",\"" +
  DoubleToString(ind.MACD_FW)
  + "\",\"" +
  DoubleToString(ind.MACD_Cx_0)
  + "\",\"" +
  DoubleToString(ind.MACD_Cx_1)
  + "\",\"" +
  DoubleToString(ind.MACD_Diff_Angulo_LS)
  + "\",\"" +
  DoubleToString(ind.MACD_Distancia_Linha_Sinal)
  + "\",\"" +
  DoubleToString(ind.MACD_Distancia_Linha_Zero)
  + "\",\"" +
  DoubleToString(ind.MACD_Normalizacao)
  + "\",\"" +
  DoubleToString(ind.MACD_Normalizacao_Zero)
  + "\",\"" +
  DoubleToString(ind.MFI_FW)
  + "\",\"" +
  DoubleToString(ind.MFI_Cx)
  + "\",\"" +
  DoubleToString(ind.MFI_norm)
  + "\",\"" +
  DoubleToString(ind.Momentum_Var)
  + "\",\"" +
  DoubleToString(ind.Momentum_Var_Cx)
  + "\",\"" +
  DoubleToString(ind.Momentum_norm)
  + "\",\"" +
  DoubleToString(ind.RSI_Var)
  + "\",\"" +
  DoubleToString(ind.RSI_Var_Cx)
  + "\",\"" +
  DoubleToString(ind.RSI_norm)
  + "\",\"" +
  DoubleToString(ind.Stoch_FW)
  + "\",\"" +
  DoubleToString(ind.Stoch_Cx_0)
  + "\",\"" +
  DoubleToString(ind.Stoch_Cx_1)
  + "\",\"" +
  DoubleToString(ind.Stoch_norm_1)
  + "\",\"" +
  DoubleToString(ind.Stoch_norm_2)
  + "\",\"" +
  DoubleToString(ind.Volume_FW)
  + "\",\"" +
  DoubleToString(ind.Volume_Cx)
  + "\",\"" +
  DoubleToString(ind.Volume_norm)
  + "\",\"" +
  DoubleToString(ind.WPR_Var)
  + "\",\"" +
  DoubleToString(ind.WPR_Var_Cx)
  + "\",\"" +
  DoubleToString(ind.WPR_norm)
  + "\""
  ;

  FileWrite(file_handle_w,Line);
  FileFlush(file_handle_w);
  //delete(filtro_fuzzy);

  delete ind;
}
