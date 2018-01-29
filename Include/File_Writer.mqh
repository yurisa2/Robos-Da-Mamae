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

    FileWrite(file_handle_w, "io;hora;ativo;posicao;direcao;lucro;AC;AD;ADX;ATR;BB_Delta_Bruto;Banda_Delta_Valor;BB_Posicao_Percent;BullsP;BearsP;BWMFI;CCI;DeMarker;DP_DMM20;DP_PAAMM20;DP_MM20MM50;DP_D;hilo_direcao;MACD;MFI;Momentum;RSI;Stoch;Volume;WPR");
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
  double AD_Var;
  double ADX_FW;
  double ATR_Var;
  double BB_Delta_Bruto;
  double Banda_Delta_Valor;
  double BB_Posicao_Percent;
  double BullsP_Var;
  double BearsP_Var;
  double BWMFI_Var;
  double CCI_Var;
  double DeMarker_Var;
  int DP_DMM20;
  int DP_PAAMM20;
  int DP_MM20MM50;
  int DP_D;
  int Hilo_Direcao;
  double MACD_FW;
  double MFI_FW;
  double Momentum_Var;
  double RSI_Var;
  double Stoch_FW;
  double Volume_FW;
  double WPR_Var;





};


File::File()
{
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

  AC_Var  =  AC_Ind.Valor(0)  ;
  AD_Var   =  AD_Ind.Valor(0)  ;
  ADX_FW  = ADX_OO.Valor(0) ;
  ATR_Var =   ATR_Ind.Valor(0) ;
  BB_Delta_Bruto = Banda_BB.BB_Delta_Bruto(0) ;
  Banda_Delta_Valor = Banda_BB.Banda_Delta_Valor() ;
  BB_Posicao_Percent = Banda_BB.BB_Posicao_Percent(0) ;
  BullsP_Var =   BullsPower_Ind.Valor(1) ;
  BearsP_Var =   BearsPower_Ind.Valor(1) ;
  BWMFI_Var =   BWMFI_Ind.Valor(1) ;
  CCI_Var =  CCI_Ind.Valor(0)  ;
  DeMarker_Var =  DeMarker_Ind.Valor(0)  ;
  DP_DMM20 = DP_Ind.DirecaoMM20(0);
  DP_PAAMM20 = DP_Ind.PrecoRMM20(0);
  DP_MM20MM50 = DP_Ind.MM20AcimaAbaixoMM50(0);
  DP_D = DP_Ind.Direcao(0);
  Hilo_Direcao = hilo.Direcao() ;
  MACD_FW = macd.Valor(0) ;
  MFI_FW = MFI_OO.Valor(0) ;
  Momentum_Var =  Momentum_OO.Valor(0)  ;
  RSI_Var =  RSI_OO.Valor(0)  ;
  Stoch_FW = Stoch_OO.Valor(0) ;
  Volume_FW = Volumes_OO.Valor(1) ;
  WPR_Var = WPR_Ind.Valor(0)   ;

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
  DoubleToString(AD_Var)
  + "\";\"" +
  DoubleToString(ADX_FW)
  + "\";\"" +
  DoubleToString(ATR_Var)
  + "\";\"" +
  DoubleToString(BB_Delta_Bruto)
  + "\";\"" +
  DoubleToString(Banda_Delta_Valor)
  + "\";\"" +
  DoubleToString(BB_Posicao_Percent)
  + "\";\"" +
  DoubleToString(BullsP_Var)
  + "\";\"" +
  DoubleToString(BearsP_Var)
  + "\";\"" +
  DoubleToString(BWMFI_Var)
  + "\";\"" +
  DoubleToString(CCI_Var)
  + "\";\"" +
  DoubleToString(DeMarker_Var)
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
  DoubleToString(MFI_FW)
  + "\";\"" +
  DoubleToString(Momentum_Var)
  + "\";\"" +
  DoubleToString(RSI_Var)
  + "\";\"" +
  DoubleToString(Stoch_FW)
  + "\";\"" +
  DoubleToString(Volume_FW)
  + "\";\"" +
  DoubleToString(WPR_Var)

  + "\""
  ;

  FileWrite(file_handle_w,Line);

  FileFlush(file_handle_w);


}
