/* -*- C++ -*- */




input string Xeon_Label = "Configs do Xeon";  // -------------------XING-----------------
input int xeon_desloc = 2;
bool xeon_tempo_real = false; //Tempo Real (onTick - true) vs Candle (false)
input int xeon_limite_inferior = 20; //Distancia para compra (TickSize)
input int xeon_limite_superior = 80; //Distancia para venda (TickSize)
input int xeon_limite_spread_max = 80; //Spread Max
input int xeon_count_periods = 100;
input string xeon_url = "http://localhost:8000/writecsv";

input bool xeon_encerra_zero = 1; //Encerra em Zero no candle
