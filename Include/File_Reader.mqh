/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                  File_Writer.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class File_Read
{
  public:
  void File_Read::File_Read(string InpFileName="teste.txt", string InpDirectoryName="Data");
  string linha_str_array[];
  string linha_str_array_cols[1][256];
  int num_linhas;

  private:

};

  void File_Read::File_Read(string InpFileName="teste.txt", string InpDirectoryName="Data")
  {
    int file_handle_r = -1;

    ResetLastError();
    file_handle_r=FileOpen(InpDirectoryName+"//"+InpFileName,FILE_READ|FILE_TXT|FILE_ANSI);

    if(file_handle_r!=INVALID_HANDLE)
    {
      // PrintFormat("Arquivo: %s existe",InpFileName);
      // PrintFormat("Pasta: %s\\Files\\",TerminalInfoString(TERMINAL_DATA_PATH));
      //--- additional variables
      int    str_size;
      string str;
      int i = 0;
      ArrayResize(linha_str_array,i);

      //--- read data from the file
      while(!FileIsEnding(file_handle_r))
      {
        //--- find out how many symbols are used for writing the time
        str_size=FileReadInteger(file_handle_r,INT_VALUE);
        //--- read the string
        str=FileReadString(file_handle_r,str_size);
        //--- print the string
        // PrintFormat(str);

        ArrayResize(linha_str_array,i+1);
        linha_str_array[i] = str;
        i++;
        num_linhas = i;

      }
      //--- close the file
      FileClose(file_handle_r);
    //  PrintFormat("Arquivo Lido, %s foi fechado",InpFileName);
    }
    else
  PrintFormat("Impossivel abrir %s, Erro = %d",InpFileName,GetLastError());
  }
