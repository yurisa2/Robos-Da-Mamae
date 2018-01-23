/* -*- C++ -*- */




input string Halley_Label = "Configs do Halley";  // -----------H-A-L-L-E-Y----------------
input double n_vezes = 2;  //Quantas vezes sombra > corpo
input double n_ultimos = 3;  //Verificar quantos Candles para trás
input double prop_sombra = 2; //Proporção minima entre as duas sombras
input bool Opera_Somente_Formato = false; //Opera Somente Formato
enum Tipo_Op
{
  Martelo = 1,
  Todos = 0,
  SStar  = -1
};
input Tipo_Op Halley_Tipo_op = 0;
input bool Utiliza_SL_Setup = false;


datetime UltimoFormato = NULL;
