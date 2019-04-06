/* -*- C++ -*- */




input string Xeon_Label = "Configs do Xeon";  // -------------------XEON-----------------
input int xeon_count_periods = 100; //xeon_count_periods - Contagem periodos
input int xeon_norm = 60; //xeon_norm - Periodos de Normalizcao
input double xeon_thresh = 55; //xeon_thresh - Limite de corte
input double xeon_cut = 0.01; //xeon_cut - Caso esteja utilizando um metodo diferente (quase inutil)
input double xeon_min_diff = 60; //xeon_min_diff - Diferenca minima para Fitness Function (em Tick Size)
input bool xeon_encerra_zero = true; //xeon_encerra_zero - Encerra quando avalia ZERO
input int xeon_feature_selection = 0; //xeon_feature_selection - Método de selecao de feature
input int xeon_max_feats = 3; //xeon_max_feats - Maximo de features
input double xeon_delta = 0; //xeon_delta - Delta do resultado
input bool usa_ff = false;
