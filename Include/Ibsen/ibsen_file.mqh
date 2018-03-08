
int file_handle_w_ibsen = -1;

void File_Init_ibsen()
{
       file_handle_w_ibsen=FileOpen("ibsen.csv",FILE_WRITE|FILE_CSV|FILE_COMMON|FILE_ANSI);

}

void Escreve_ibsen()
{
  Ibsen *Ibsen_o = new Ibsen;
  OBV *OBV_oo = new OBV;


  // FileSeek(file_handle_w_ibsen,0,SEEK_END);

  string Line = "\"" +
  TimeToString(TimeCurrent(),TIME_DATE|TIME_SECONDS)
  + "\";\"" +
  Symbol()
  + "\";\"" +
  DoubleToString(Ibsen_o.Fuzzy_CEV())
  + "\";\"" +
  DoubleToString(Ibsen_o.Fuzzy_Momento())
  + "\";\"" +
  DoubleToString(OBV_oo.Cx())
  + "\";\"" +
  DoubleToString(Ibsen_o.Fuzzy_Sinal())
  + "\""
  ;


  //  Print(Line);
  // Print("Handle: " + file_handle_w_ibsen);

  // FileWrite(file_handle_w_ibsen,Line);
  FileWrite(file_handle_w_ibsen,  TimeToString(TimeCurrent(),TIME_DATE|TIME_SECONDS),Ibsen_o.Fuzzy_CEV(),Ibsen_o.Fuzzy_Momento(),OBV_oo.Cx(),Ibsen_o.Fuzzy_Sinal(),daotick());

  FileFlush(file_handle_w_ibsen);

 delete(Ibsen_o);
 delete(OBV_oo);

}
