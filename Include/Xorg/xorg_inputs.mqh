/* -*- C++ -*- */


input string Xorg_Label = "Configs do Xorg";  // -----------XORG--------------
input double Xorg_Grau_entrada = 2;
input double Xorg_Grau_saida = 20;
double Xorg_inf_compra = 50 + Xorg_Grau_entrada;
double Xorg_sup_compra = 100 - Xorg_Grau_saida;
double Xorg_sup_venda = 50 - Xorg_Grau_entrada ;
double Xorg_inf_venda = 0 + Xorg_Grau_saida;
input bool Xorg_sair_indicador = true;
input bool Xorg_Filtro_Fuzzy = false;
