/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                  File_Writer.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"
int entrada = 27;
double x_entrada[];
double resposta_y[2];
int rna_entrada = entrada;

class ML
{

  public:
  ML() {ArrayResize(x_entrada,entrada);};
  void  ML_Save(string NomeArquivo);
  void Append(string Linha);
  bool Levanta(CMultilayerPerceptronShell &objRed, string nombArch= "",int nNeuronEntra = 14,int nNeuronCapa1 = 60,int nNeuronCapa2 = 60,int nNeuronSal = 2);
  bool SalvaRede(CMultilayerPerceptronShell &objRed, string nombArch= "",int nNeuronEntra = 14,int nNeuronCapa1 = 60,int nNeuronCapa2 = 60,int nNeuronSal = 2);
  void ML_Load(string NomeArquivo);
  void Treino(CMultilayerPerceptronShell &network_trn);
  void ML::Processa(double &y[], CMultilayerPerceptronShell &objRed, double &x[]);
  void ML::Saida();
  double resp_y[2];
  CMultilayerPerceptronShell rede_obj;
  double Matriz[][100];
  string Lines[];
  double mse;
  int numero_linhas;
  int entradas; //colunas ativas (sem NULL)

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

void ML::ML_Load(string NomeArquivo)
{
  int Handle_Arquivo_Leitura = FileOpen(NomeArquivo, FILE_READ|FILE_TXT|FILE_ANSI|FILE_COMMON);
  int num_linhas = 0;


  if(Handle_Arquivo_Leitura!=INVALID_HANDLE)
  {
    // PrintFormat("Arquivo: %s existe",InpFileName);
    // PrintFormat("Pasta: %s\\Files\\",TerminalInfoString(TERMINAL_DATA_PATH));
    //--- additional variables
    string linha_str_array[];
    int    str_size;
    string str;
    int i = 0;
    ArrayResize(linha_str_array,i);

    //--- read data from the file
    while(!FileIsEnding(Handle_Arquivo_Leitura))
    {
      //--- find out how many symbols are used for writing the time
      str_size=FileReadInteger(Handle_Arquivo_Leitura,INT_VALUE);
      //--- read the string
      str=FileReadString(Handle_Arquivo_Leitura,str_size);
      //--- print the string
      // PrintFormat(str);

      ArrayResize(linha_str_array,i+1);
      linha_str_array[i] = str;
      Append(str);
      i++;
      num_linhas = i;
    }
    numero_linhas = num_linhas;
    //--- close the file
    FileClose(Handle_Arquivo_Leitura);
    //  PrintFormat("Arquivo Lido, %s foi fechado",InpFileName);
  }
  else Print("Problema do arquivo no ML Load" + NomeArquivo);

  FileFlush(Handle_Arquivo_Leitura);
}

void ML::Append(string Linha)
{
  int tamanho_linhas = ArraySize(Lines);
  numero_linhas = 0;
  int num_linhas;

  ArrayResize(Lines,ArraySize(Lines)+1);
  Lines[tamanho_linhas] += Linha;

  string linha_temp[];
  ArrayResize(linha_temp,entrada+1);

  ArrayResize(Matriz,ArrayRange(Matriz,0)+1);
  num_linhas = StringSplit(Linha,StringGetCharacter(",",0),linha_temp);
  entradas = num_linhas;

  for(int i=0; i<entrada+1;i++)
  {
    Matriz[tamanho_linhas][i] = StringToDouble(linha_temp[i]);
  }
  //Preenche o resto com NULL
  for(int i = num_linhas;i<entrada+1;i++)
  {
    Matriz[tamanho_linhas][i] = NULL;
  }
  numero_linhas = ArraySize(Lines);
}

bool ML::SalvaRede(CMultilayerPerceptronShell &objRed, string nombArch= "",int nNeuronEntra = 14,int nNeuronCapa1 = 60,int nNeuronCapa2 = 60,int nNeuronSal = 2)
{bool redSalvada= false;
  int k= 0, i= 0, j= 0, numCapas= 0, arNeurCapa[], neurCapa1= 1, funcTipo= 0, puntFichRed= 9999;
  double umbral= 0, peso= 0, media= 0, sigma= 0;
  if(nombArch=="") nombArch= "copiaSegurRed";
  nombArch= nombArch;
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

bool ML::Levanta(CMultilayerPerceptronShell &objRed, string nombArch= "",int nNeuronEntra = 14,int nNeuronCapa1 = 60,int nNeuronCapa2 = 60,int nNeuronSal = 2)
{
  bool exito= false;
  int k= 0, i= 0, j= 0, nEntradas= 0, nSalidas= 0, nPesos= 0,
  numCapas= 0, arNeurCapa[], funcTipo= 0, puntFichRed= 9999;
  double umbral= 0, peso= 0, media= 0, sigma= 0;
  if(nombArch=="") nombArch= "copiaSegurRed";
  nombArch= nombArch;
  puntFichRed= FileOpen(nombArch, FILE_READ|FILE_BIN|FILE_COMMON|FILE_SHARE_READ);
  if(puntFichRed==INVALID_HANDLE)
  {
    Print("Deu pau no arquivo do Levanta amigo!");
    Print("nombArch " + nombArch);
  }
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
    Print("Nº neurons in the input layer ", nEntradas);
    Print("Nº neurons in the hidden layer 1 ", nNeuronCapa1);
    Print("Nº neurons in the hidden layer 2 ", nNeuronCapa2);
    Print("Nº neurons in the output layer ", nSalidas);
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

void ML::Treino(CMultilayerPerceptronShell &network_trn)
{
  CAlglib algebra_trn;
  CMLPReportShell infotreino_trn;

  int amostras = this.numero_linhas; //Verificar a Matrix


  CMatrixDouble xy(amostras+1,this.entradas);
  for(int i = 0; i < amostras; i++) {
    for(int j = 0; j < this.entradas; j++)
    {
      xy[i].Set(j,this.Matriz[i][j]);
    }
  }

  int resposta_trn;

  PrintFormat("Iniciando Treino em %i Amostras",amostras);

  algebra_trn.MLPCreateC2(this.entradas-1,rna_segunda_camada,rna_terceira_camada,rna_quarta_camada,network_trn);
  // algebra_trn.MLPTrainLM(network_trn,xy,amostras,rna_decay_,restarts,resposta_trn,infotreino_trn);
  algebra_trn.MLPTrainLBFGS(network_trn,xy,amostras,rna_decay_,rna_restarts_,rna_wstep_,rna_epochs,resposta_trn,infotreino_trn);
  this.mse = algebra_trn.MLPRMSError(network_trn,xy,amostras);

  string Nome_Arquivo = rna_nome_arquivo_rede+"."+IntegerToString(this.entradas-1)+"-"
  +IntegerToString(rna_segunda_camada)+"-"+IntegerToString(rna_terceira_camada)+"-"
  +IntegerToString(rna_quarta_camada)+".e"+DoubleToString(mse)+".trn";

  if(rna_Salva_Arquivo_rede)
  this.SalvaRede(network_trn,Nome_Arquivo,this.entradas-1,
    rna_segunda_camada,rna_terceira_camada,rna_quarta_camada);


    Print("Erro? " + DoubleToString(algebra_trn.MLPRMSError(network_trn,xy,amostras)));
  }

void ML::Processa(double &y[], CMultilayerPerceptronShell &objRed,double &x[])
  {
    if(this.numero_linhas > rna_on_realtime_min_samples)
    {
      dados_nn.Dados_Entrada();
      x[0] = dados_nn.BB_Cx_BB_Low;
      x[1] = dados_nn.BB_Cx_BB_Base;
      x[2] = dados_nn.BB_Cx_BB_High;
      x[3] = dados_nn.BB_Cx_BB_Delta_Bruto;
      x[4] = dados_nn.BB_Cx_BB_Posicao_Percent;
      x[5] = dados_nn.BB_Normalizado_BB_Low;
      x[6] = dados_nn.BB_Normalizado_BB_Base;
      x[7] = dados_nn.BB_Normalizado_BB_High;
      x[8] = dados_nn.BB_Normalizado_BB_Delta_Bruto;
      x[9] = dados_nn.BB_Normalizado_BB_Posicao_Percent;
      x[10] = dados_nn.RSI_Valor;
      x[11] = dados_nn.RSI_Cx;
      x[12] = dados_nn.RSI_Normalizado;
      x[13] = dados_nn.Hora_n;
      x[14] = dados_nn.MFI_Normalizado;
      x[15] = dados_nn.MFI_Cx;
      x[16] = dados_nn.Demarker_Normalizado;
      x[17] = dados_nn.Demarker_Cx;
      x[18] = dados_nn.Bulls_Normalizado;
      x[19] = dados_nn.Bulls_Cx;
      x[20] = dados_nn.Bears_Normalizado;
      x[22] = dados_nn.Bears_Cx;
      x[22] = dados_nn.AC_Normalizado;
      x[23] = dados_nn.AC_Cx;
      x[24] = dados_nn.ADX_Normalizado;
      x[25] = dados_nn.ADX_Cx;
      x[26] = dados_nn.Igor_N;
      CAlglib algebra_proc;

      algebra_proc.MLPProcess(objRed,x,y);
    }
    else {
      if(Tipo_Comentario != 2) PrintFormat("Processa sem dados Suficientes %i, autorizando tudo.",this.numero_linhas);
      y[0]=1;
      y[1]=1;
    }
    if(Tipo_Comentario != 2) PrintFormat("Processamento ML: y[0] = %i y[1] = %i",y[0],y[1]);
  }

void ML::Saida()
  {
    if(rna_on && rna_on_realtime && this.numero_linhas > rna_on_realtime_min_samples) Treino(this.rede_obj);
  }

  ML machine_learning;
