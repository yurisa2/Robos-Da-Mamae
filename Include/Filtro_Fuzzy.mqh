/* -*- C++ -*- */

class FiltroF
{
  public:
  FiltroF() {};
  ~FiltroF() {};
  double Fuzzy();
  void Aquisicao();
  int Leitor_Arquivo_Calcula_Medias();
  int FiltroF::Escreve_Medias_Filtro();

  struct Matrix_Fuzzy
  {
    double a1Neutro;
    double b1Neutro;
    double c1Neutro;
    double d1Neutro;
    double a2Neutro;
    double b2Neutro;
    double c2Neutro;
    double d2Neutro;
    double aRuim;
    double bRuim;
    double cRuim;
    double aMuitoRuim;
    double bMuitoRuim;
    double cMuitoRuim;
    double aMuitoBom;
    double bMuitoBom;
    double cMuitoBom;
    double aBom;
    double bBom;
    double cBom;
  };

  // Matrix_Fuzzy muz;
  Matrix_Fuzzy Calculator(double Bom, double Ruim, double Var_Input);

  string Rotulos[] ;
  double Medias_Positivas[56];
  double Medias_Negativas[56];

  private:

};

double FiltroF::Fuzzy()
{
  Aquisicao *ind = new Aquisicao;

  double retorno = 0;
  //--- Set input value
  CList *in=new CList;
  CMamdaniFuzzySystem *fsFILTRO=new CMamdaniFuzzySystem();
  //--- Create Output
  CFuzzyVariable *fvFILTRO=new CFuzzyVariable("FILTRO",0,100);
  fvFILTRO.Terms().Add(new CFuzzyTerm("MuitoRuim", new CTrapezoidMembershipFunction(0,0,10,20)));
  fvFILTRO.Terms().Add(new CFuzzyTerm("Ruim", new CTriangularMembershipFunction(10,20,30)));
  fvFILTRO.Terms().Add(new CFuzzyTerm("Neutro", new CTrapezoidMembershipFunction(20,30,70,80)));
  fvFILTRO.Terms().Add(new CFuzzyTerm("Bom", new CTriangularMembershipFunction(70,80,90)));
  fvFILTRO.Terms().Add(new CFuzzyTerm("MuitoBom", new CTrapezoidMembershipFunction(80,90,100,100)));
  fsFILTRO.Output().Add(fvFILTRO);

  //Mano, sistema fuzzy automático e serial...CARALHO

  //ESQUEMA AQUI VAI SER CRIAR UMA FUNCAO QUE PEGUE OS DADOS DO ARQUIVO USANDO
  //O OBJETO FILEREADER, DESMONTE CADA STRING E RETORNE o nome, bom, ruim ...  Var_Input a gente pega do aquisicao
  //Monta um while baseado na funcao

  string VAR = NULL;
  double Var_Input = NULL;
  double bom = NULL;
  double ruim = NULL;

  int regras = 0;

  File_Read *file_read = new File_Read(".zwift-filtro-fuzzy.fuz", "");
  for(int i=0; i<file_read.num_linhas ; i++)
  {
    string Valores[10];
    StringSplit(file_read.linha_str_array[i],StringGetCharacter(",",0),Valores);


    //Entrando no Fuzzy DEBUG
    // Print("Indicador: " + Valores[0]);
    // Print("Valor BOM: " + Valores[1]);
    // Print("Valor RUIM: " + Valores[2]);
    // Print("Valor INPUT: " + DoubleToString(ind.Busca_Var(VAR)));

    VAR = Valores[0];
    // Var_Input = ind.Busca_Var(VAR);
    Var_Input = ind.Busca_Var(VAR);
    bom =  StringToDouble(Valores[1]);
    ruim = StringToDouble(Valores[2]);

    double Histerese = 0;
    double H_Diff = MathMax(bom,ruim) - MathMin(bom,ruim);
    if(bom != 0 && ruim != 0) Histerese = H_Diff/MathMax(bom,ruim); //Matematicamente  Mais Correto

    if(ind.Busca_Var(VAR) != NULL && (bom - ruim) != 0 && bom != 0 && ruim != 0 && Histerese > Filtro_Fuzzy_Histerese)
    {

      // File_Gen *arquivo_generico = new File_Gen("variaveis-usadas.var");
      // arquivo_generico.Linha(TimeToString(TimeCurrent()) + " - " + VAR + ": " + DoubleToString(Var_Input,5) + " | bom: " + Valores[1] + " | ruim:" + Valores[2]);
      // delete arquivo_generico;

      Matrix_Fuzzy matriz;
      matriz = Calculator(bom,ruim,Var_Input);

      CFuzzyVariable *fvVAR=new CFuzzyVariable(VAR,matriz.a1Neutro,matriz.d2Neutro);
      fvVAR.Terms().Add(new CFuzzyTerm("NeutroA", new CTrapezoidMembershipFunction(matriz.a1Neutro,matriz.b1Neutro,matriz.c1Neutro,matriz.d1Neutro)));
      fvVAR.Terms().Add(new CFuzzyTerm("MuitoRuim", new CTriangularMembershipFunction(matriz.aMuitoRuim,matriz.bMuitoRuim,matriz.cMuitoRuim)));
      fvVAR.Terms().Add(new CFuzzyTerm("Ruim", new CTriangularMembershipFunction(matriz.aRuim,matriz.bRuim,matriz.cRuim)));
      fvVAR.Terms().Add(new CFuzzyTerm("Bom", new CTriangularMembershipFunction(matriz.aBom,matriz.bBom,matriz.cBom)));
      fvVAR.Terms().Add(new CFuzzyTerm("MuitoBom", new CTriangularMembershipFunction(matriz.aMuitoBom,matriz.bMuitoBom,matriz.cMuitoBom)));
      fvVAR.Terms().Add(new CFuzzyTerm("NeutroB", new CTrapezoidMembershipFunction(matriz.a2Neutro,matriz.b2Neutro,matriz.c2Neutro,matriz.d2Neutro)));
      fsFILTRO.Input().Add(fvVAR);
      CMamdaniFuzzyRule *Ac_Neutro1 = fsFILTRO.ParseRule("if ("+ VAR +" is NeutroA) then FILTRO is Neutro");
      CMamdaniFuzzyRule *Ac_MuitoRuim = fsFILTRO.ParseRule("if ("+ VAR +" is MuitoRuim) then FILTRO is MuitoRuim");
      CMamdaniFuzzyRule *Ac_Ruim = fsFILTRO.ParseRule("if ("+ VAR +" is Ruim) then FILTRO is Ruim");
      CMamdaniFuzzyRule *Ac_Bom = fsFILTRO.ParseRule("if ("+ VAR +" is Bom) then FILTRO is Bom");
      CMamdaniFuzzyRule *Ac_MuitoBom = fsFILTRO.ParseRule("if ("+ VAR +" is MuitoBom) then FILTRO is MuitoBom");
      CMamdaniFuzzyRule *Ac_Neutro2 = fsFILTRO.ParseRule("if ("+ VAR +" is NeutroB) then FILTRO is Neutro");
      fsFILTRO.Rules().Add(Ac_Neutro1);
      fsFILTRO.Rules().Add(Ac_MuitoRuim);
      fsFILTRO.Rules().Add(Ac_Ruim);
      fsFILTRO.Rules().Add(Ac_Bom);
      fsFILTRO.Rules().Add(Ac_MuitoBom);
      fsFILTRO.Rules().Add(Ac_Neutro2);
      CDictionary_Obj_Double *p_od_AC_Ind=new CDictionary_Obj_Double;
      in.Add(p_od_AC_Ind);
      p_od_AC_Ind.SetAll(fvVAR, Var_Input);

      regras++;
    }
  }

  if(Filtro_Fuzzy_Ligado && regras > 0) //Observar o que leva a calcular
  {
    //--- Get result
    CList *result;
    CDictionary_Obj_Double *p_od_Ipsus;
    result=fsFILTRO.Calculate(in);
    p_od_Ipsus=result.GetNodeAtIndex(0);
    //   Print("Ipsus, escala: ",p_od_Ipsus.Value());

    retorno = p_od_Ipsus.Value();
    delete result;
  }
  delete in;
  delete fsFILTRO;

  delete(file_read);
  delete ind;

  return retorno;
}

Matrix_Fuzzy FiltroF::Calculator(double Bom, double Ruim, double Var_Input)
{
  Matrix_Fuzzy muz = {0};
  double Diff = Bom - Ruim;

  double Max = MathMax(MathAbs(1000*Diff), MathAbs(Var_Input));
  if(Diff < 0) Max = Max * -1;

  double Ia = Ruim - Max;
  double Ib = Ruim - Max;
  double Ic = Ruim - Diff - Diff;
  double Id = Ruim - Diff;
  double Ja = Ruim - Diff - Diff;
  double Jb = Ruim - Diff;
  double Jc = Ruim;
  double Ka = Ruim - Diff;
  double Kb = Ruim;
  double Kc = Ruim + Diff;
  double La = Bom - Diff;
  double Lb = Bom;
  double Lc = Bom + Diff;
  double Ma = Bom;
  double Mb = Bom + Diff;
  double Mc = Bom + Diff + Diff;
  double Na = Bom + Diff;
  double Nb = Bom + Diff + Diff;
  double Nc = Bom + Max;
  double Nd = Bom + Max;

  if(Diff > 0)
  {
    muz.a1Neutro = Ia;
    muz.b1Neutro = Ib;
    muz.c1Neutro = Ic;
    muz.d1Neutro = Id;
    muz.aRuim = Ja;
    muz.bRuim = Jb;
    muz.cRuim = Jc;
    muz.aMuitoRuim = Ka;
    muz.bMuitoRuim = Kb;
    muz.cMuitoRuim = Kc;
    muz.aMuitoBom = La;
    muz.bMuitoBom = Lb;
    muz.cMuitoBom = Lc;
    muz.aBom = Ma;
    muz.bBom = Mb;
    muz.cBom = Mc;
    muz.a2Neutro = Na;
    muz.b2Neutro = Nb;
    muz.c2Neutro = Nc;
    muz.d2Neutro = Nd;
  }
  if(Diff < 0)
  {
    muz.a1Neutro = Nd;
    muz.b1Neutro = Nc;
    muz.c1Neutro = Nb;
    muz.d1Neutro = Na;
    muz.aRuim = Jc;
    muz.bRuim = Jb;
    muz.cRuim = Ja;
    muz.aMuitoRuim = Kc;
    muz.bMuitoRuim = Kb;
    muz.cMuitoRuim = Ka;
    muz.aMuitoBom = Lc;
    muz.bMuitoBom = Lb;
    muz.cMuitoBom = La;
    muz.aBom = Mc;
    muz.bBom = Mb;
    muz.cBom = Ma;
    muz.a2Neutro = Id;
    muz.b2Neutro = Ic;
    muz.c2Neutro = Ib;
    muz.d2Neutro = Ia;
  }

  return muz;
}

int FiltroF::Leitor_Arquivo_Calcula_Medias()
{
  File_Read *file_read = new File_Read(".Filtro_Fuzzy.csv","");

  if(ArraySize(file_read.linha_str_array) == 0)
  {
    delete(file_read);
    return NULL;
  }
  StringSplit(file_read.linha_str_array[0],StringGetCharacter(",",0),Rotulos);

  // Print("file_read.linha_str_array[0]: " + file_read.linha_str_array[0]);
  // Print("file_read.linha_str_array[1]: " + file_read.linha_str_array[1]);
  // Print("file_read.linha_str_array[2]: " + file_read.linha_str_array[2]);
  // Print("ArraySize(Rotulos): " + ArraySize(Rotulos));

  int Num_Rotulos = ArraySize(Rotulos); // HOJE TA EM 56 - Ou Pensa em algo melhor ou nunca mais muda a porra das colunas

  string Linhas[][56]; //Ou Pensa em algo melhor ou nunca mais muda a porra das colunas Fomato: Linha[#][Rotulo]

  ArrayResize(Linhas,file_read.num_linhas);

  string Linhas_Positivas[][56];
  string Linhas_Negativas[][56];

  //CALCULA O NUMERO DE LINHAS PARA O FILTRO FUZZY //ARRUMAR PQ NAO TA CLARO QUAL EH O MENOR NUMERO (ENVOLVER ERRO DE INPUT)
  int Start_Linha_Geral = 1;

  Start_Linha_Geral = Filtro_Fuzzy_Ultimas_Linhas + 1;

  if(Filtro_Fuzzy_Ultimas_Linhas == 0) Start_Linha_Geral = 1;

  for(int i=Start_Linha_Geral; i<file_read.num_linhas ; i++)  // LE LINHA POR LINHA (COMECA EM 1 PARA MATAR O ROTULO) LIMITAR AS LINHAS AQUI PARA NAO DIVIDIR
  {
    string Linha_Separada[56];
    StringSplit(file_read.linha_str_array[i],StringGetCharacter(",",0),Linha_Separada);

    for(int Rotulo=0; Rotulo<Num_Rotulos ; Rotulo++)  // LE Rotulo e Coloca na linha
    {
      Linhas[i][Rotulo] = Linha_Separada[Rotulo];
    }
    // Print("FiltroF::Leitor_Arquivo_Calcula_Medias() file_read.linha_str_array[i]" + file_read.linha_str_array[i]);
  }

  // Print("Num_Rotulos" + Num_Rotulos);
  // Print("Linhas" + ArrayRange(Linhas,0));
  // Print("Rotulos[55]" + Rotulos[5]);
  // Print("Linhas[0][55]" + Linhas[1][5]);

  //Bloco de Linhas POSITIVAS
  for(int i=1; i<file_read.num_linhas ; i++)  // LE LINHA POR LINHA (COMECA EM 1 PARA MATAR O ROTULO)
  {
    string Linha_Separada[56];
    StringSplit(file_read.linha_str_array[i],StringGetCharacter(",",0),Linha_Separada);

    if(StringToDouble(Linha_Separada[5]) >= 0){
      ArrayResize(Linhas_Positivas,ArrayRange(Linhas_Positivas,0)+1);
      for(int Rotulo=0; Rotulo<Num_Rotulos ; Rotulo++)  // LE Rotulo e Coloca na linyha
      {
        Linhas_Positivas[ArrayRange(Linhas_Positivas,0)-1][Rotulo] = Linha_Separada[Rotulo]; //Linha CORE
      }}

      // Print("FiltroF::Leitor_Arquivo_Calcula_Medias() file_read.linha_str_array[i]" + file_read.linha_str_array[i]);
    }
    // FIM Bloco de Linhas POSITIVAS

    //Bloco de Linhas NEGATIVAS
    for(int i=1; i<file_read.num_linhas ; i++)  // LE LINHA POR LINHA (COMECA EM 1 PARA MATAR O ROTULO)
    {
      string Linha_Separada[56];
      StringSplit(file_read.linha_str_array[i],StringGetCharacter(",",0),Linha_Separada);

      if(StringToDouble(Linha_Separada[5]) < 0){
        ArrayResize(Linhas_Negativas,ArrayRange(Linhas_Negativas,0)+1);
        for(int Rotulo=0; Rotulo<Num_Rotulos ; Rotulo++)  // LE Rotulo e Coloca na linyha
        {
          Linhas_Negativas[ArrayRange(Linhas_Negativas,0)-1][Rotulo] = Linha_Separada[Rotulo]; //Linha CORE
        }}

        // Print("FiltroF::Leitor_Arquivo_Calcula_Medias() file_read.linha_str_array[i]" + file_read.linha_str_array[i]);
      }
      // FIM Bloco de Linhas NEGATIVAS

      // Print("ArrayRange(Linhas_Positivas,0)" + ArrayRange(Linhas_Positivas,0));
      // Print("ArrayRange(Linhas_Negativas,0)" + ArrayRange(Linhas_Negativas,0));
      if(file_read.num_linhas > Filtro_Fuzzy_Num_Linhas)     //AQUI ELE LIMITA O START DAS LINHAS
      {
        for(int Coluna = 0; Coluna <56;Coluna++)
        {
          double Media_Coluna = 0;
          double Soma_Coluna = 0;
          for(int Linha = 1; Linha<=ArrayRange(Linhas_Positivas,0);Linha++) //PARA LIMITAR O CONJUNTO DE ULTIMAS LINHAS
          {
            Soma_Coluna = Soma_Coluna + StringToDouble(Linhas_Positivas[Linha-1][Coluna]);
            Media_Coluna = Soma_Coluna / Linha;
          }
          Medias_Positivas[Coluna] = Media_Coluna;
        }

        for(int Coluna = 0; Coluna <56;Coluna++)
        {
          double Media_Coluna = 0;
          double Soma_Coluna = 0;
          for(int Linha = 1; Linha<=ArrayRange(Linhas_Negativas,0);Linha++)
          {
            Soma_Coluna = Soma_Coluna + StringToDouble(Linhas_Negativas[Linha-1][Coluna]);
            Media_Coluna = Soma_Coluna / Linha;
          }
          Medias_Negativas[Coluna] = Media_Coluna;
        }
      }
      // Print("Rotulos[5]" + Rotulos[5]);
      // Print("Medias_Positivas[5]" + Medias_Positivas[5]);
      // Print("Medias_Negativas[5]" + Medias_Negativas[5]);
      delete(file_read);
      return 1;
    }

    int FiltroF::Escreve_Medias_Filtro()
    {
      if(Leitor_Arquivo_Calcula_Medias() == NULL) return NULL;
      if(Filtro_Fuzzy_Escreve_Fuz)
      {
        string Line = "";
        for(int i=6;i<55;i++)
        {
          Line += Rotulos[i];
          Line += ",";
          Line += DoubleToString(Medias_Positivas[i]);
          Line += ",";
          Line += DoubleToString(Medias_Negativas[i]);
          Line +="\n";
        }
        File_Gen *arquivo_generico = new File_Gen(".zwift-filtro-fuzzy.fuz","CREATE");
        arquivo_generico.Linha(Line);
        delete arquivo_generico;
      }
      return 1;
    }
