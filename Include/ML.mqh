/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                  File_Writer.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"
int entrada = 57;
double x_entrada[];
double resposta_y[2];
int rna_entrada = entrada;
class ML
{

  public:
  ML() {ArrayResize(x_entrada,entrada);};
  void  ML_Save(string NomeArquivo);
  void Append(string Linha);
  bool Levanta(CMultilayerPerceptronShell &objRed, string nombArch= "");
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
  NomeArquivo =
  Nome_Robo
  +NomeArquivo
  +".in"+IntegerToString(this.entradas-1)
  +".tf"+EnumToString(TimeFrame)
  +".ln"+IntegerToString(numero_linhas)
  +".hist";

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
  ArrayResize(linha_temp,entradas);

  ArrayResize(Matriz,ArrayRange(Matriz,0)+1);
  num_linhas = StringSplit(Linha,StringGetCharacter(",",0),linha_temp);
  entradas = num_linhas; //Essas linhas aqui s�o da segunda dimensao

  for(int i=0; i<entradas;i++)
  {
    Matriz[tamanho_linhas][i] = StringToDouble(linha_temp[i]);
  }
  //Preenche o resto com NULL
  for(int i = num_linhas;i<entradas;i++)
  {
    Matriz[tamanho_linhas][i] = NULL;
  }
  numero_linhas = ArraySize(Lines);
  // PrintFormat("Matriz Range: %f",ArrayRange(Matriz,0));  //DEBUG

}

bool ML::SalvaRede(CMultilayerPerceptronShell &objRed, string nombArch= "",int nNeuronEntra = 14,int nNeuronCapa1 = 60,int nNeuronCapa2 = 60,int nNeuronSal = 2)
{
  string      _local_str;

  CAlglib::MLPSerialize(objRed,_local_str);

  int handler_ann = FileOpen(nombArch, FILE_WRITE|FILE_TXT|FILE_COMMON);
  FileWrite(handler_ann,_local_str);
  FileFlush(handler_ann);

  return(1);
}

bool ML::Levanta(CMultilayerPerceptronShell &objRed, string nombArch= "")
{
  int file_handle_r= FileOpen(nombArch, FILE_READ|FILE_TXT|FILE_COMMON|FILE_SHARE_READ);
  int    str_size;
  string str;

  while(!FileIsEnding(file_handle_r))
  {
    str_size=FileReadInteger(file_handle_r,INT_VALUE);
    str+=FileReadString(file_handle_r,str_size);
    str+="\n";
  }
  PrintFormat(str);

  CAlglib::MLPUnserialize(str,objRed);

    int nEntradas= 0, nSalidas= 0, nPesos= 0, nNeuronCapa1 = 0, nNeuronCapa2 = 0;
    CAlglib::MLPProperties(objRed, nEntradas, nSalidas, nPesos);
    Print("N. neuron in the input layer ", nEntradas);
    Print("N. neuron in the hidden layer 1 ", nNeuronCapa1);
    Print("N. neuron in the hidden layer 2 ", nNeuronCapa2);
    Print("N. neuron in the output layer ", nSalidas);
    Print("Pesos: ", nPesos);

  return(1);
}

void ML::Treino(CMultilayerPerceptronShell &network_trn)
{
  CAlglib algebra_trn;
  CMLPReportShell infotreino_trn;

  int amostras = this.numero_linhas; //Verificar a Matrix
  PrintFormat("Amostras: %f | Entradas: %f: ",amostras,this.entradas);

  CMatrixDouble xy(amostras+1,this.entradas);
  for(int i = 0; i < amostras; i++) { //Mano AQUI FAVA i = amostras?!?!?!?! WAHHHHHH?
    for(int j = 0; j < this.entradas; j++)
    {
      xy[i].Set(j,this.Matriz[i][j]);
      // PrintFormat("xy[%f].Set(%f,%f)",i,j,this.Matriz[i][j]); //DEBUG Verifica a Matriz XY
    }
  }

  int resposta_trn;

  PrintFormat("Iniciando Treino em %i Amostras",amostras);
  PrintFormat("Entradas %i ",entradas);
  // PrintFormat("rna_entrada %i ",rna_entrada);
  PrintFormat("Matriz Range: %f ",ArrayRange(Matriz,0));

  // algebra_trn.MLPCreateC2(this.entradas-1,rna_segunda_camada,rna_terceira_camada,rna_camada_saida,network_trn);
  if(rna_hidden_layers == 0) algebra_trn.MLPCreateC0(this.entradas-1,rna_camada_saida,network_trn);
  if(rna_hidden_layers == 1) algebra_trn.MLPCreateC1(this.entradas-1,rna_segunda_camada,rna_camada_saida,network_trn);
  if(rna_hidden_layers == 2) algebra_trn.MLPCreateC2(this.entradas-1,rna_segunda_camada,rna_terceira_camada,rna_camada_saida,network_trn);

  int nPesos = 0;
  int entradas_prop = this.entradas-1;
  CAlglib::MLPProperties(network_trn, entradas_prop, rna_camada_saida, nPesos);


  if(nPesos < 500)
  {
    Print("Numero de Pesos Menor que 500");
    algebra_trn.MLPTrainLM(network_trn,xy,amostras,rna_decay_,rna_restarts_,resposta_trn,infotreino_trn);
  }
  if(nPesos > 500 || nPesos == 0)
  {
    Print("Numero de Pesos Maior que 500");
    algebra_trn.MLPTrainLBFGS(network_trn,xy,amostras,rna_decay_,rna_restarts_,rna_wstep_,rna_epochs,resposta_trn,infotreino_trn);
  }
  this.mse = algebra_trn.MLPRelClsError(network_trn,xy,amostras);

  string camadas = "";
  if(rna_hidden_layers == 0) camadas = "-(0)-";
  if(rna_hidden_layers == 1) camadas = "-(1)"+IntegerToString(rna_segunda_camada)+"-";
  if(rna_hidden_layers == 2) camadas = "-(2)"+IntegerToString(rna_segunda_camada)+"-"+IntegerToString(rna_terceira_camada)+"-";


  string Nome_Arquivo =
  Nome_Robo
  +rna_nome_arquivo_rede
  +"."+IntegerToString(this.entradas-1)
  +camadas+"-"
  +IntegerToString(rna_camada_saida)
  +".tf"+EnumToString(TimeFrame)
  +".a"+IntegerToString(amostras)
  +".e"+DoubleToString(mse)+".trn";

  if(rna_Salva_Arquivo_rede)
  this.SalvaRede(network_trn,Nome_Arquivo,this.entradas-1,
    rna_segunda_camada,rna_terceira_camada,rna_camada_saida);


    Print("Entradas: " + IntegerToString(this.entradas-1));
    Print("Pesos: " + IntegerToString(nPesos));
    Print("Erro% " + DoubleToString(algebra_trn.MLPRMSError(network_trn,xy,amostras)));
  }

  void ML::Processa(double &y[], CMultilayerPerceptronShell &objRed,double &x[])
  {
    if((this.numero_linhas > rna_on_realtime_min_samples && rna_on_realtime && rna_filtros_on) || (rna_filtros_on && !rna_on_realtime))
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
      x[9] = dados_nn.BB_Posicao_Percent;
      x[10] = dados_nn.RSI_Valor;
      x[11] = dados_nn.RSI_Cx;
      x[12] = dados_nn.RSI_Normalizado;
      x[13] = dados_nn.Hilo;

      x[14] = dados_nn.Hora_n;
      x[15] = dados_nn.MFI_Normalizado;
      x[16] = dados_nn.MFI_Cx;
      x[17] = dados_nn.Demarker_Normalizado;
      x[18] = dados_nn.Demarker_Cx;
      x[19] = dados_nn.Bulls_Normalizado;
      x[20] = dados_nn.Bulls_Cx;
      x[21] = dados_nn.Bears_Normalizado;
      x[22] = dados_nn.Bears_Cx;
      x[23] = dados_nn.AC_Normalizado;
      x[24] = dados_nn.AC_Cx;
      x[25] = dados_nn.ADX_Normalizado;
      x[26] = dados_nn.ADX_Cx;
      x[27] = dados_nn.Igor_N;

      x[28] = dados_nn.ATR_Normalizado;
      x[29] = dados_nn.ATR_Cx;
      x[30] = dados_nn.CCI_Normalizado;
      x[31] = dados_nn.CCI_Cx;
      x[32] = dados_nn.DP_MM20;
      x[33] = dados_nn.DP_PRMM20;
      x[34] = dados_nn.DP_mm20AAmm50;
      x[35] = dados_nn.DP_Direcao;
      x[36] = dados_nn.MACD_normalizado0;
      x[37] = dados_nn.MACD_normalizado1;
      x[38] = dados_nn.MACD_normalizado2;
      x[39] = dados_nn.MACD_Distancia_Linha_Zero;
      x[40] = dados_nn.MACD_Distancia_Linha_Sinal;
      x[41] = dados_nn.MACD_Diferenca_Angulo_Linha_Sinal;
      x[42] = dados_nn.MACD_Cx0;
      x[43] = dados_nn.MACD_Cx1;
      x[44] = dados_nn.MACD_Cx2;
      x[45] = dados_nn.Momentum_Normalizado;
      x[46] = dados_nn.Momentum_Cx;
      x[47] = dados_nn.Stoch_Normalizado0;
      x[48] = dados_nn.Stoch_Normalizado1;
      x[49] = dados_nn.Stoch_Cx0;
      x[50] = dados_nn.Stoch_Cx1;
      x[51] = dados_nn.Volumes_Normalizado;
      x[52] = dados_nn.Volumes_Cx;
      x[53] = dados_nn.WPR_Normalizado;
      x[54] = dados_nn.WPR_Cx;
      x[55] = dados_nn.OBV_Normalizado;
      x[56] = dados_nn.OBV_Cx;

      // for(int i = 0; i < ArraySize(x); i++)
      // {
      // PrintFormat("i: %f valor: %f",i,x[i]);
      // } //IMPRIME ENTRADA

      CAlglib algebra_proc;

      ZeroMemory(y);
      ZeroMemory(resposta_y);

      algebra_proc.MLPProcess(objRed,x,y);
      if(Tipo_Comentario != 2)
      {
        // PrintFormat("Valor y[0]: %f e y[1]: %f.",y[0],y[1]);
      // for(int i = 0; i < ArraySize(x); i++)
      // {
      //   PrintFormat("x[%i] = %f",i,x[i]);
      // }
    }
  }
  else {
    if(Tipo_Comentario != 2) PrintFormat("Processa sem dados Suficientes %i, autorizando tudo.",this.numero_linhas);
    // ArrayResize(y,2);

    y[0]=1;
    y[1]=1;
    // resposta_y[0]=1;
    // resposta_y[1]=1;
  }
}

void ML::Saida()
{
  if(rna_on && rna_on_realtime && this.numero_linhas > rna_on_realtime_min_samples) Treino(this.rede_obj);
}





ML machine_learning;
