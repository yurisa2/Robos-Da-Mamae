/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                  File_Writer.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class ML
{

  public:
  void  ML_Save(string NomeArquivo);
  string Lines[];
  void Append(string Linha);
  double Matriz[][200];
  int entradas;
  bool Levanta(CMultilayerPerceptronShell &objRed, string nombArch= "",int nNeuronEntra = 9,int nNeuronCapa1 = 10,int nNeuronCapa2 = 6,int nNeuronSal = 2);
  bool SalvaRede(CMultilayerPerceptronShell &objRed, string nombArch= "",int nNeuronEntra = 9,int nNeuronCapa1 = 10,int nNeuronCapa2 = 6,int nNeuronSal = 2);

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


bool ML::SalvaRede(CMultilayerPerceptronShell &objRed, string nombArch= "",int nNeuronEntra = 9,int nNeuronCapa1 = 10,int nNeuronCapa2 = 6,int nNeuronSal = 2)
{bool redSalvada= false;
  int k= 0, i= 0, j= 0, numCapas= 0, arNeurCapa[], neurCapa1= 1, funcTipo= 0, puntFichRed= 9999;
  double umbral= 0, peso= 0, media= 0, sigma= 0;
  if(nombArch=="") nombArch= "copiaSegurRed";
  nombArch= nombArch+".red";
  FileDelete(nombArch, FILE_COMMON);
  ResetLastError();
  puntFichRed= FileOpen(nombArch, FILE_WRITE|FILE_BIN|FILE_COMMON);
  redSalvada= puntFichRed!=INVALID_HANDLE;
  if(redSalvada)
  {
    numCapas= CAlglib::MLPGetLayersCount(objRed);
    redSalvada= redSalvada && FileWriteDouble(puntFichRed, numCapas)>0;
    ArrayResize(arNeurCapa, numCapas);
    for(k= 0; redSalvada && k<numCapas; k++)
    {
      arNeurCapa[k]= CAlglib::MLPGetLayerSize(objRed, k);
      redSalvada= redSalvada && FileWriteDouble(puntFichRed, arNeurCapa[k])>0;
    }
    for(k= 0; redSalvada && k<numCapas; k++)
    {
      for(i= 0; redSalvada && i<arNeurCapa[k]; i++)
      {
        if(k==0)
        {
          CAlglib::MLPGetInputScaling(objRed, i, media, sigma);
          FileWriteDouble(puntFichRed, media);
          FileWriteDouble(puntFichRed, sigma);
        }
        else if(k==numCapas-1)
        {
          CAlglib::MLPGetOutputScaling(objRed, i, media, sigma);
          FileWriteDouble(puntFichRed, media);
          FileWriteDouble(puntFichRed, sigma);
        }
        CAlglib::MLPGetNeuronInfo(objRed, k, i, funcTipo, umbral);
        FileWriteDouble(puntFichRed, funcTipo);
        FileWriteDouble(puntFichRed, umbral);
        for(j= 0; redSalvada && k<(numCapas-1) && j<arNeurCapa[k+1]; j++)
        {
          peso= CAlglib::MLPGetWeight(objRed, k, i, k+1, j);
          redSalvada= redSalvada && FileWriteDouble(puntFichRed, peso)>0;
        }
      }
    }
    FileClose(puntFichRed);
  }
  // if(!redSalvada) infoError(_LastError, __FUNCTION__);
  return(redSalvada);
}


bool ML::Levanta(CMultilayerPerceptronShell &objRed, string nombArch= "",int nNeuronEntra = 9,int nNeuronCapa1 = 10,int nNeuronCapa2 = 6,int nNeuronSal = 2)
{
  bool exito= false;
   int k= 0, i= 0, j= 0, nEntradas= 0, nSalidas= 0, nPesos= 0,
       numCapas= 0, arNeurCapa[], funcTipo= 0, puntFichRed= 9999;
   double umbral= 0, peso= 0, media= 0, sigma= 0;
   if(nombArch=="") nombArch= "copiaSegurRed";
   nombArch= nombArch+".red";
   puntFichRed= FileOpen(nombArch, FILE_READ|FILE_BIN|FILE_COMMON);
   exito= puntFichRed!=INVALID_HANDLE;
   if(exito)
   {
      numCapas= (int)FileReadDouble(puntFichRed);
      ArrayResize(arNeurCapa, numCapas);
      for(k= 0; k<numCapas; k++) arNeurCapa[k]= (int)FileReadDouble(puntFichRed);
      if(numCapas==2) CAlglib::MLPCreateC0(nNeuronEntra, nNeuronSal, objRed);
      else if(numCapas==3) CAlglib::MLPCreateC1(nNeuronEntra, nNeuronCapa1, nNeuronSal, objRed);
      else if(numCapas==4) CAlglib::MLPCreateC2(nNeuronEntra, nNeuronCapa1, nNeuronCapa2, nNeuronSal, objRed);

         CAlglib::MLPProperties(objRed, nEntradas, nSalidas, nPesos);
         Print("N� neurons in the input layer ", nEntradas);
         Print("N� neurons in the hidden layer 1 ", nNeuronCapa1);
         Print("N� neurons in the hidden layer 2 ", nNeuronCapa2);
         Print("N� neurons in the output layer ", nSalidas);
         Print("Pesos", nPesos);
         for(k= 0; k<numCapas; k++)
         {
            for(i= 0; i<arNeurCapa[k]; i++)
            {
               if(k==0)
               {
                  media= FileReadDouble(puntFichRed);
                  sigma= FileReadDouble(puntFichRed);
                  CAlglib::MLPSetInputScaling(objRed, i, media, sigma);
               }
               else if(k==numCapas-1)
               {
                  media= FileReadDouble(puntFichRed);
                  sigma= FileReadDouble(puntFichRed);
                  CAlglib::MLPSetOutputScaling(objRed, i, media, sigma);
               }
               funcTipo= (int)FileReadDouble(puntFichRed);
               umbral= FileReadDouble(puntFichRed);
               CAlglib::MLPSetNeuronInfo(objRed, k, i, funcTipo, umbral);
               for(j= 0; k<(numCapas-1) && j<arNeurCapa[k+1]; j++)
               {
                  peso= FileReadDouble(puntFichRed);
                  CAlglib::MLPSetWeight(objRed, k, i, k+1, j, peso);
               }
            }
         }

   }
   FileClose(puntFichRed);
   return(exito);
}
