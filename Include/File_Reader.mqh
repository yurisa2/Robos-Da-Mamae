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
  int num_linhas;

  private:
  int File_Read::Retorna_Indice_Arquivo_Virtual(string Nome_Arquivo);
};

void File_Read::File_Read(string InpFileName="teste.txt", string InpDirectoryName="Data")
{
  int file_handle_r = -1;
  string InpFileNameCompleto = Nome_Robo + "." + IntegerToString(Rand_Geral) + "." + EnumToString(TimeFrame) + InpFileName;

  if(Filtro_Fuzzy_Arquivo_Fisico)
  {
    ResetLastError();
    file_handle_r=FileOpen(InpDirectoryName+"//"+InpFileNameCompleto,FILE_READ|FILE_TXT|FILE_ANSI|FILE_COMMON|FILE_SHARE_READ);

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
    else {
      PrintFormat("Impossivel abrir (Leitura) %s, Erro = %d",InpFileName,GetLastError());
      File_Gen *arquivo_generico = new File_Gen(InpFileName,"CREATE");
      arquivo_generico.Linha("");
      delete arquivo_generico;
    }
  }

  if(!Filtro_Fuzzy_Arquivo_Fisico)
  {
    int Indice_Arquivo = Retorna_Indice_Arquivo_Virtual(InpFileNameCompleto);
    if(Indice_Arquivo == -1)
    {
      File_Gen *arquivo_generico = new File_Gen(InpFileName,"CREATE");
      arquivo_generico.Linha("");
      delete arquivo_generico;
      Indice_Arquivo = Retorna_Indice_Arquivo_Virtual(InpFileNameCompleto);
    }
    num_linhas  = StringSplit(Arquivos[Indice_Arquivo][1],StringGetCharacter("\n",0),linha_str_array);

    // num_linhas--;
    // if(linha_str_array[num_linhas-1] == "\n")
    // {
    //   Print("Ultima linha era só pulinho MOTHAFUCKA");
    //   ExpertRemove();
    // }
    // PrintFormat("Teste indice: %i ",Indice_Arquivo);
  }
}

int File_Read::Retorna_Indice_Arquivo_Virtual(string Nome_Arquivo)
{
  int retorno = -1;
  int Tamanho_Array_Arquivos = ArrayRange(Arquivos,0);

  for(int i=0; i<Tamanho_Array_Arquivos; i++)
  {
    if(Arquivos[i][0] == Nome_Arquivo)
    {
     retorno = i;
     // PrintFormat("Achei o Arquivo, é o Indice: %i",i);
   }
  }

if(retorno == -1)
{
File_Gen *arquivo_generico = new File_Gen(Nome_Arquivo,"CREATE");
retorno = arquivo_generico.Cria_Arquivo_Virtual(Nome_Arquivo);
delete arquivo_generico;
Print("Tive QUe Criar aqui Na leitura");
}

return retorno;
}
