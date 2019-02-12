/* -*- C++ -*- */


input string Ibsen_Label = "Configs do Ibsen";  // -----------IBSEN--------------
input int tamanho_candle_p = 60;        //Quantos % um candle só está da banda para operar
input int tamanho_candle_para_fora_p = 50;  //Quantos % um candle está opara fora
input int p_bb = 20; //Periodos da Banda

enum Tipo_Gatilho
{
  Dentro_E_Fora = 1,
  Somente_Fora = 0
};
input Tipo_Gatilho Gatilho = 0;

input bool Opera_Contra = true; //Opera Contrário o rompimento (true) ou a favor (false)
