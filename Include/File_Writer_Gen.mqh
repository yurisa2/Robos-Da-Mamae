/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                  File_Gen_Writer.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

string Arquivos[][2];

class File_Gen
{
  public:
  File_Gen(string nome,string MODE = "APPEND"); // APPEND = Adiciona |  CREATE = Substitui
  ~File_Gen();
  void File_Gen::Linha(string linha);
  int File_Gen::Cria_Arquivo_Virtual(string Nome_Arquivo);
  int Retorna_Indice_Arquivo_Virtual(string Nome_Arquivo);

  private:
  int Handle_Arquivo;
  string Nome_Montado;
  string MODO_OP;
  int Indice_Arquivo;


};


File_Gen::File_Gen(string nome,string MODE = "APPEND")
{
  MODO_OP = MODE;
  Nome_Montado = Nome_Robo + "." + IntegerToString(Rand_Geral) + "." + EnumToString(TimeFrame) + nome;
  if(Filtro_Fuzzy_Arquivo_Fisico)
  {
  if(MODE == "APPEND") Handle_Arquivo = FileOpen(Nome_Montado, FILE_WRITE|FILE_READ|FILE_TXT|FILE_ANSI|FILE_COMMON);
  if(MODE == "CREATE") Handle_Arquivo = FileOpen(Nome_Montado, FILE_WRITE|FILE_TXT|FILE_ANSI|FILE_COMMON);
  FileSeek(Handle_Arquivo,0,SEEK_END);
  }

  if(!Filtro_Fuzzy_Arquivo_Fisico)
  {
    Indice_Arquivo = Retorna_Indice_Arquivo_Virtual(Nome_Montado);
  }
}

File_Gen::~File_Gen()
{
  if(Filtro_Fuzzy_Arquivo_Fisico)
  {
  FileClose(Handle_Arquivo);
  }
  MODO_OP = "";
}

void File_Gen::Linha(string linha)
{
  if(Filtro_Fuzzy_Arquivo_Fisico)
  {
  FileSeek(Handle_Arquivo,0,SEEK_END);
  FileWrite(Handle_Arquivo,linha);
  FileFlush(Handle_Arquivo);
  }

  if(!Filtro_Fuzzy_Arquivo_Fisico && linha != "" && linha != "\n")
  {
    if(MODO_OP == "CREATE")
    {
    Arquivos[Indice_Arquivo][1] = linha + "\n";
    // PrintFormat("conteudo completo do arquivo %s: %s",Arquivos[Indice_Arquivo][0],Arquivos[Indice_Arquivo][1]);
    }
    if(MODO_OP == "APPEND")
    {
    Arquivos[Indice_Arquivo][1] += linha + "\n";
    // PrintFormat("conteudo completo do arquivo %s: %s",Arquivos[Indice_Arquivo][0],Arquivos[Indice_Arquivo][1]);
    }
  }
}


int File_Gen::Cria_Arquivo_Virtual(string Nome_Arquivo)
{
  int Tamanho_Array_Arquivos = ArrayRange(Arquivos,0);
  // PrintFormat("Tamanho_Array_Arquivos ANTES: %i", Tamanho_Array_Arquivos);
  ArrayResize(Arquivos,Tamanho_Array_Arquivos+1);
  Arquivos[Tamanho_Array_Arquivos][0] = Nome_Arquivo;
//   PrintFormat("Arquivos[Tamanho_Array_Arquivos][0]: %s", Arquivos[Tamanho_Array_Arquivos][0]);
//
// ExpertRemove();
return Tamanho_Array_Arquivos;

}

int File_Gen::Retorna_Indice_Arquivo_Virtual(string Nome_Arquivo)
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

if(retorno == -1) retorno = Cria_Arquivo_Virtual(Nome_Arquivo);
return retorno;
}
