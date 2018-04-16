/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                  File_Writer.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class ML
{

  public:
  void  ML_Save(string NomeArquivo);
  string Lines[];
  void Append(string Linha);
  double Matriz[][200];
  int entradas;

  private:
  int Handle_Arquivo;

};

void ML::ML_Save(string NomeArquivo)
{
Handle_Arquivo = FileOpen(NomeArquivo, FILE_WRITE|FILE_TXT|FILE_ANSI|FILE_COMMON);

for(int i = 0; i < ArraySize(Lines); i++)
{
FileSeek(Handle_Arquivo,0,SEEK_END);
FileWrite(Handle_Arquivo,Lines[i]);
}

FileFlush(Handle_Arquivo);

}


void ML::Append(string Linha)
{
  int comeco = ArraySize(Lines);

  int num_linhas;

  ArrayResize(Lines,ArraySize(Lines)+1);
  Lines[comeco] += Linha;

  string linha_temp[200];
  ArrayResize(Matriz,ArraySize(Matriz)+1);
  num_linhas = StringSplit(Linha,StringGetCharacter(",",0),linha_temp);
  entradas = num_linhas;

  for(int i=0; i<200;i++)
  {
    Matriz[comeco][i] = StringToDouble(linha_temp[i]);
  }
  //Preenche o resto com -9999
  for(int i = num_linhas;i<200;i++)
  {
    Matriz[comeco][i] = -9999;
  }
}
