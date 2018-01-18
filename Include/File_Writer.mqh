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

    FileWrite(file_handle_w, "io;hora;ativo;posicao;direcao;lucro;ADX;BB_Delta_Bruto;Banda_Delta_Valor;BB_Posicao_Percent;Hilo_Direcao;MACD;MFI;Stoch;Volume");
    //FileFlush(file_handle_w);
  }
}

class File
{
  public:
  File();
  void Escreve(string posicao_fw,string direcao,double lucro, ENUM_DEAL_ENTRY io);

  private:
  double ADX_FW;
  double BB_Delta_Bruto;
  double Banda_Delta_Valor;
  double BB_Posicao_Percent;
  int Hilo_Direcao;
  double MACD_FW;
  double MFI_FW;
  double Stoch_FW;
  double Volume_FW;


};


File::File()
{
  BB *Banda_BB = new BB(TimeFrame);
  RSI *RSI_OO = new RSI(14,TimeFrame);
  Stoch *Stoch_OO = new Stoch(10,3,3,TimeFrame);
  MFI *MFI_OO = new MFI(TimeFrame);
  Volumes *Volumes_OO = new Volumes(NULL,TimeFrame);
  ADX *ADX_OO = new ADX(14,TimeFrame);
  HiLo_OO *hilo = new HiLo_OO(4);
  MACD *macd = new MACD(12,26,9,NULL,TimeFrame);


  ADX_FW  = ADX_OO.Valor(0) ;
  BB_Delta_Bruto = Banda_BB.BB_Delta_Bruto(0) ;
  Banda_Delta_Valor = Banda_BB.Banda_Delta_Valor() ;
  BB_Posicao_Percent = Banda_BB.BB_Posicao_Percent(0) ;
  Hilo_Direcao = hilo.Direcao() ;
  MACD_FW = macd.Valor(0) ;
  MFI_FW = MFI_OO.Valor(0) ;
  Stoch_FW = Stoch_OO.Valor(0) ;
  Volume_FW = Volumes_OO.Valor(1) ;

  delete(macd);
  delete(hilo);
  delete(RSI_OO);
  delete(Banda_BB);
  delete(Stoch_OO);
  delete(MFI_OO);
  delete(Volumes_OO);
  delete(ADX_OO);

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
  DoubleToString(ADX_FW)
  + "\";\"" +
  DoubleToString(BB_Delta_Bruto)
  + "\";\"" +
  DoubleToString(Banda_Delta_Valor)
  + "\";\"" +
  DoubleToString(BB_Posicao_Percent)
  + "\";\"" +
  IntegerToString(Hilo_Direcao)
  + "\";\"" +
  DoubleToString(MACD_FW)
  + "\";\"" +
  DoubleToString(MFI_FW)
  + "\";\"" +
  DoubleToString(Stoch_FW)
  + "\";\"" +
  DoubleToString(Volume_FW)
  + "\""
  ;

  FileWrite(file_handle_w,Line);

  FileFlush(file_handle_w);


}
