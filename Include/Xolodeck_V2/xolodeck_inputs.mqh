/* -*- C++ -*- */




input string Xolodeck_Label = "Configs do Xolodeck";  // -----------H-O-L-O-D-E-C-K--------------
input int n_ultimos = 20;  //Verificar quantos Candles para trás rompeu
input int p_bb = 20; //Periodos da Banda
input int rompimento_mediana = 0 ; // Distancia da mediana que entra *TickSize
input bool xolo_compra = true;
input bool xolo_venda = true;


datetime ultimo_rompimento = NULL;
datetime ultimo_rompimento_operado = NULL;
