/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                  File_Writer.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"


string file_name     = IntegerToString(MathRand()) + ".csv";
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

    FileWrite(file_handle_w, "io;hora;ativo;posicao;direcao;lucro;AC;AC_cx;AD;AD_cx;ADX;adx_cx;ATR;ATR_cx;BB_Delta_Bruto;BB_Delta_Bruto_cx;Banda_Delta_Valor;BB_Posicao_Percent;BB_Posicao_Percent_Cx;BullsP;BullsP_cx;BearsP;BearsP_cx;BWMFI;BWMFI_cx;CCI;CCI_cx;DeMarker;DeMarker_cx;DP_DMM20;DP_PAAMM20;DP_MM20MM50;DP_D;hilo_direcao;MACD;MACD_cx_0;MACD_cx_1;MACD_Diff_Angulo_LS;MACD_Distancia_Linha_Sinal;MACD_Distancia_Linha_Zero;MACD_Normalizacao;MACD_Normalizacao_Zero;MFI;MFI_cx;Momentum;Momentum_cx;RSI;RSI_cx;Stoch;Stoch_Cx_0;Stoch_Cx_1;Volume;Volume_cx;WPR;WPR_cx");
    //FileFlush(file_handle_w);
  }
}

class File
{
  public:
  File();
  void Escreve(string posicao_fw,string direcao,double lucro, ENUM_DEAL_ENTRY io);

  private:
  double AC_Var;
  double AC_cx;
  double AD_Var;
  double AD_cx;
  double ADX_FW;
  double adx_cx;
  double ATR_Var;
  double ATR_cx;
  double BB_Delta_Bruto;
  double BB_Delta_Bruto_Cx;
  double Banda_Delta_Valor;
  double BB_Posicao_Percent;
  double BB_Posicao_Percent_Cx;
  double BullsP_Var;
  double BullsP_Var_Cx;
  double BearsP_Var;
  double BearsP_Var_Cx;
  double BWMFI_Var;
  double BWMFI_Var_Cx;
  double CCI_Var;
  double CCI_Var_Cx;
  double DeMarker_Var;
  double DeMarker_Var_Cx;
  int DP_DMM20;
  int DP_PAAMM20;
  int DP_MM20MM50;
  int DP_D;
  int Hilo_Direcao;
  double MACD_FW;
  double MACD_Cx_0;
  double MACD_Cx_1;
  double MACD_Diff_Angulo_LS;
  double MACD_Distancia_Linha_Sinal;
  double MACD_Distancia_Linha_Zero;
  double MACD_Normalizacao;
  double MACD_Normalizacao_Zero;
  double MFI_FW;
  double MFI_Cx;
  double Momentum_Var;
  double Momentum_Var_Cx;
  double RSI_Var;
  double RSI_Var_Cx;
  double Stoch_FW;
  double Stoch_Cx_0;
  double Stoch_Cx_1;
  double Volume_FW;
  double Volume_Cx;
  double WPR_Var;
  double WPR_Var_Cx;

};


File::File()
{

  double conv = 180 / 3.14159265359;
  AC *AC_Ind = new AC();
  AD *AD_Ind = new AD();
  ADX *ADX_OO = new ADX(14,TimeFrame);
  ATR *ATR_Ind = new ATR();
  BB *Banda_BB = new BB(TimeFrame);
  BullsPower *BullsPower_Ind = new BullsPower();
  BearsPower *BearsPower_Ind = new BearsPower();
  BWMFI *BWMFI_Ind = new BWMFI();
  CCI *CCI_Ind = new CCI();
  DeMarker *DeMarker_Ind = new DeMarker();
  DP *DP_Ind = new DP();
  HiLo_OO *hilo = new HiLo_OO(4);
  MACD *macd = new MACD(12,26,9,NULL,TimeFrame);
  MFI *MFI_OO = new MFI(TimeFrame);
  Momentum *Momentum_OO = new Momentum();
  RSI *RSI_OO = new RSI(14,TimeFrame);
  Stoch *Stoch_OO = new Stoch(10,3,3,TimeFrame);
  Volumes *Volumes_OO = new Volumes(NULL,TimeFrame);
  WPR *WPR_Ind = new WPR();

  AC_Var  =  AC_Ind.Normalizado(0)*100  ;
  AC_cx  =  AC_Ind.Cx(0)*conv  ;
  AD_Var   =  AD_Ind.Normalizado(0)*100  ;
  AD_cx   =  AD_Ind.Cx(0)*conv  ;
  ADX_FW  = ADX_OO.Valor(0) ;
  adx_cx  = ADX_OO.Cx(0)*conv  ;
  ATR_Var =   ATR_Ind.Normalizado(0)*100 ;
  ATR_cx =   ATR_Ind.Cx(0)*conv;
  BB_Delta_Bruto = Banda_BB.BB_Delta_Bruto(0) ;
  BB_Delta_Bruto_Cx = Banda_BB.Cx_BB_Delta_Bruto(0) ;
  Banda_Delta_Valor = Banda_BB.Banda_Delta_Valor() ;
  BB_Posicao_Percent = Banda_BB.BB_Posicao_Percent(0) ;
  BB_Posicao_Percent_Cx = Banda_BB.Cx_BB_Posicao_Percent(0) ;
  BullsP_Var =   BullsPower_Ind.Normalizado(1)*100 ;
  BullsP_Var_Cx =   BullsPower_Ind.Cx(0)*conv;
  BearsP_Var =   BearsPower_Ind.Normalizado(1)*100 ;
  BearsP_Var_Cx =   BearsPower_Ind.Cx(0)*conv;
  BWMFI_Var =   BWMFI_Ind.Valor(1) ;
  BWMFI_Var_Cx =   BWMFI_Ind.Cx(0)*conv;
  CCI_Var =  CCI_Ind.Valor(0)  ;
  CCI_Var_Cx =  CCI_Ind.Cx(0)*conv;
  DeMarker_Var =  DeMarker_Ind.Valor(0)*100  ;
  DeMarker_Var_Cx =  DeMarker_Ind.Cx(0)*conv;
  DP_DMM20 = DP_Ind.DirecaoMM20(0);
  DP_PAAMM20 = DP_Ind.PrecoRMM20(0);
  DP_MM20MM50 = DP_Ind.MM20AcimaAbaixoMM50(0);
  DP_D = DP_Ind.Direcao(0);
  Hilo_Direcao = hilo.Direcao() ;
  MACD_FW = macd.Valor(0) ;
  MACD_Cx_0 = macd.Cx(0)*conv ;
  MACD_Cx_1 = macd.Cx(1)*conv ;
  MACD_Diff_Angulo_LS = macd.Diferenca_Angulo_Linha_Sinal()*conv;
  MACD_Distancia_Linha_Sinal = macd.Distancia_Linha_Sinal()*100;
  MACD_Distancia_Linha_Zero = macd.Distancia_Linha_Zero()*100;
  MACD_Normalizacao = macd.Normalizacao_Valores_MACD(0,0,0)*100;
  MACD_Normalizacao_Zero = macd.Normalizacao_Valores_MACD(0,0,-1)*100;
  MFI_FW = MFI_OO.Valor(0) ;
  MFI_Cx = MFI_OO.Cx(0)*conv;
  Momentum_Var =  Momentum_OO.Valor(0)  ;
  Momentum_Var_Cx =  Momentum_OO.Cx(0)*conv;
  RSI_Var =  RSI_OO.Valor(0)  ;
  RSI_Var_Cx =  RSI_OO.Cx(0)*conv  ;
  Stoch_FW = Stoch_OO.Valor(0) ;
  Stoch_Cx_0 = Stoch_OO.Cx(0,0)*conv ;
  Stoch_Cx_1 = Stoch_OO.Cx(1,0)*conv ;
  Volume_FW = Volumes_OO.Normalizado(1)*100 ;
  Volume_Cx = Volumes_OO.Cx(1)*conv ;
  WPR_Var = WPR_Ind.Valor(0)   ;
  WPR_Var_Cx = WPR_Ind.Cx(0)*conv   ;

  delete(AC_Ind);
  delete(AD_Ind);
  delete(ADX_OO);
  delete(ATR_Ind);
  delete(BullsPower_Ind);
  delete(BearsPower_Ind);
  delete(BWMFI_Ind);
  delete(CCI_Ind);
  delete(hilo);
  delete(macd);
  delete(MFI_OO);
  delete(Momentum_OO);
  delete(RSI_OO);
  delete(Stoch_OO);
  delete(Volumes_OO);
  delete(WPR_Ind);

}

void File::Escreve(string posicao_fw,string direcao,double lucro, ENUM_DEAL_ENTRY io)
{

  FileSeek(file_handle_w,0,SEEK_END);
//   FileWrite(file_handle_w,
//   EnumToString(io),
//   TimeToString(TimeCurrent(),TIME_DATE|TIME_SECONDS),
//   Symbol(),
//   posicao_fw,
//   direcao,
//   DoubleToString(lucro),
//   DoubleToString(ADX_FW),
//   DoubleToString(BB_Delta_Bruto),
//   DoubleToString(Banda_Delta_Valor),
//   DoubleToString(BB_Posicao_Percent),
//   IntegerToString(Hilo_Direcao),
//   DoubleToString(MACD_FW),
//   DoubleToString(MFI_FW),
//   DoubleToString(Stoch_FW),
//   DoubleToString(Volume_FW)
// );

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
  DoubleToString(AC_Var)
  + "\";\"" +
  DoubleToString(AC_cx)
  + "\";\"" +
  DoubleToString(AD_Var)
  + "\";\"" +
  DoubleToString(AD_cx)
  + "\";\"" +
  DoubleToString(ADX_FW)
  + "\";\"" +
  DoubleToString(adx_cx)
  + "\";\"" +
  DoubleToString(ATR_Var)
  + "\";\"" +
  DoubleToString(ATR_cx)
  + "\";\"" +
  DoubleToString(BB_Delta_Bruto)
  + "\";\"" +
  DoubleToString(BB_Delta_Bruto_Cx)
  + "\";\"" +
  DoubleToString(Banda_Delta_Valor)
  + "\";\"" +
  DoubleToString(BB_Posicao_Percent)
  + "\";\"" +
  DoubleToString(BB_Posicao_Percent_Cx)
  + "\";\"" +
  DoubleToString(BullsP_Var)
  + "\";\"" +
  DoubleToString(BullsP_Var_Cx)
  + "\";\"" +
  DoubleToString(BearsP_Var)
  + "\";\"" +
  DoubleToString(BearsP_Var_Cx)
  + "\";\"" +
  DoubleToString(BWMFI_Var)
  + "\";\"" +
  DoubleToString(BWMFI_Var_Cx)
  + "\";\"" +
  DoubleToString(CCI_Var)
  + "\";\"" +
  DoubleToString(CCI_Var_Cx)
  + "\";\"" +
  DoubleToString(DeMarker_Var)
  + "\";\"" +
  DoubleToString(DeMarker_Var_Cx)
  + "\";\"" +
  DoubleToString(DP_DMM20)
  + "\";\"" +
  DoubleToString(DP_PAAMM20)
  + "\";\"" +
  DoubleToString(DP_MM20MM50)
  + "\";\"" +
  DoubleToString(DP_D)
  + "\";\"" +
  DoubleToString(Hilo_Direcao)
  + "\";\"" +
  DoubleToString(MACD_FW)
  + "\";\"" +
  DoubleToString(MACD_Cx_0)
  + "\";\"" +
  DoubleToString(MACD_Cx_1)
  + "\";\"" +
  DoubleToString(MACD_Diff_Angulo_LS)
  + "\";\"" +
  DoubleToString(MACD_Distancia_Linha_Sinal)
  + "\";\"" +
  DoubleToString(MACD_Distancia_Linha_Zero)
  + "\";\"" +
  DoubleToString(MACD_Normalizacao)
  + "\";\"" +
  DoubleToString(MACD_Normalizacao_Zero)
  + "\";\"" +
  DoubleToString(MFI_FW)
  + "\";\"" +
  DoubleToString(MFI_Cx)
  + "\";\"" +
  DoubleToString(Momentum_Var)
  + "\";\"" +
  DoubleToString(Momentum_Var_Cx)
  + "\";\"" +
  DoubleToString(RSI_Var)
  + "\";\"" +
  DoubleToString(RSI_Var_Cx)
  + "\";\"" +
  DoubleToString(Stoch_FW)
  + "\";\"" +
  DoubleToString(Stoch_Cx_0)
  + "\";\"" +
  DoubleToString(Stoch_Cx_1)
  + "\";\"" +
  DoubleToString(Volume_FW)
  + "\";\"" +
  DoubleToString(Volume_Cx)
  + "\";\"" +
  DoubleToString(WPR_Var)
  + "\";\"" +
  DoubleToString(WPR_Var_Cx)
  + "\""
  ;

  FileWrite(file_handle_w,Line);

  FileFlush(file_handle_w);


}
