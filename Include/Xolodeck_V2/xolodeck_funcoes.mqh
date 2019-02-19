/* -*- C++ -*- */

class Xolodeck
{

  public:
  Xolodeck();
  void Comentario();
  void Avalia();
  void Timer();
  void Get_Dataset();


  private:
  bool Toque_Mediana();
  int Rompimento_Bandas(int barra = 1);
  int Direcao();

};

void Xolodeck::Xolodeck()
{


}

bool Xolodeck::Toque_Mediana()
{
  bool retorno = false;
  if(O_BB.BB_Base() >= (daotick_geral - Tick_Size) && O_BB.BB_Base() <=  (daotick_geral + Tick_Size)) retorno = true;

  //if(retorno) Print("TOCOU HEIN PUTO"); //DEBUG

  return retorno;
}

int Xolodeck::Rompimento_Bandas(int barra)
{
  int retorno = 0;

  MqlRates rates[];
  CopyRates(Symbol(),TimeFrame,0,barra+1,rates);
  ArraySetAsSeries(rates,true);
  double preco_min = rates[barra].low;
  double preco_max = rates[barra].high;

  if(O_BB.BB_Low(barra) > preco_min) retorno = 1;
  if(O_BB.BB_High(barra) < preco_max) retorno = -1;

  // if(retorno !=0) Print("Rompimento_Bandas" + IntegerToString(retorno));
  //if(retorno !=0)  Print("Rompimento_Bandas: " + IntegerToString(retorno) + "  |   barra: " + IntegerToString(barra) + "  |  Hora: " + TimeToString(rates[barra].time));

  if(retorno != 0) ultimo_rompimento = Preco(barra).time;

  return retorno;
}

void Xolodeck::Comentario()
{


}

int Xolodeck::Direcao()
{
  int retorno = 0;
  int barra_i = 0;
  for(int i=1; i <= n_ultimos; i++)
  {
    retorno = Rompimento_Bandas(i);
    barra_i = i;
    if(retorno != 0) break;
  }

  // if(retorno != 0) Print("Direcao! " + IntegerToString(retorno) + "  |   barra_i: " + IntegerToString(barra_i)); //DEBUG

  return retorno;
}

void Xolodeck::Avalia()
{
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  if(Toque_Mediana() &&
  Direcao() != 0 &&
  Condicoes.Horario() &&
  O_Stops.Tipo_Posicao() == 0 &&
  ultimo_rompimento_operado != ultimo_rompimento
  )
  {
    if(Direcao() > 0 && xolo_compra
    && daotick_geral > (O_BB.BB_Base() + (rompimento_mediana * Tick_Size)) )
    {
      Opera_Mercado *opera = new Opera_Mercado;
      opera.AbrePosicao(1,"Valor: " + DoubleToString(daotick_geral));
      delete(opera);
      ultimo_rompimento_operado = ultimo_rompimento;
    }

    if(Direcao() < 0 && xolo_venda
    && daotick_geral < (O_BB.BB_Base() - (rompimento_mediana * Tick_Size)) )
    {
      Opera_Mercado *opera = new Opera_Mercado;
      opera.AbrePosicao(-1,"Valor: " + DoubleToString(daotick_geral));
      delete(opera);
      ultimo_rompimento_operado = ultimo_rompimento;
    }

    // Print("ultimo_rompimento_operado: " + TimeToString(ultimo_rompimento_operado)); //DEBUG
    // Print("ultimo_rompimento: " + TimeToString(ultimo_rompimento)); //DEBUG
  }

  delete(Condicoes);
}

void Xolodeck::Timer()
{


}

void Xolodeck::Get_Dataset()
{
    File_Read_Gen *file_read = new File_Read_Gen("teste.txt", "");

    string dataset_result[][100];
    int max_lines = 100;

     file_read.Convert_CSV();
     ArrayPrint(file_read.dataset_csv);
     // Print(file_read.Index_By_Name("io"));
     // Print(file_read.Index_By_Name("hora"));
     // Print(file_read.Index_By_Name("lucro"));
     // Print(file_read.Index_By_Name("AD_cx"));
     // Print(file_read.Index_By_Name("BB_Delta_Bruto_norm"));
     // Print(file_read.Index_By_Name("BB_Posicao_Percent_Cx"));
     // Print(file_read.Index_By_Name("CCI_Var_Cx"));
     // Print(file_read.Index_By_Name("DeMarker_Var"));

     for(int i = 0; i < ArrayRange(file_read.dataset_csv,0); i++) {
       if(file_read.dataset_csv[i][file_read.Index_By_Name("io")] == "DEAL_ENTRY_IN") {
         int n = 0;
         ArrayResize(dataset_result,ArrayRange(dataset_result,0)+1);


         string lucro =  file_read.dataset_csv[i+1][file_read.Index_By_Name("lucro")];

         if(StringToDouble(lucro) > 0) dataset_result[ArrayRange(dataset_result,0)-1][n++] = 1;
         else dataset_result[ArrayRange(dataset_result,0)-1][n++] = 0;

         dataset_result[ArrayRange(dataset_result,0)-1][n++] = (file_read.dataset_csv[i][file_read.Index_By_Name("AD_cx")]);
         dataset_result[ArrayRange(dataset_result,0)-1][n++] = (file_read.dataset_csv[i][file_read.Index_By_Name("BB_Delta_Bruto_norm")]);
         dataset_result[ArrayRange(dataset_result,0)-1][n++] = (file_read.dataset_csv[i][file_read.Index_By_Name("BB_Posicao_Percent_Cx")]);
         dataset_result[ArrayRange(dataset_result,0)-1][n++] = (file_read.dataset_csv[i][file_read.Index_By_Name("CCI_Var_Cx")]);
         dataset_result[ArrayRange(dataset_result,0)-1][n++] = (file_read.dataset_csv[i][file_read.Index_By_Name("DeMarker_Var")]);
       }
     }
     ArrayPrint(dataset_result);
}

BB O_BB(TimeFrame,NULL,p_bb);
