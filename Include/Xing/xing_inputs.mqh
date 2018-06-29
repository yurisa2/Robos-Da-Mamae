/* -*- C++ -*- */




input string Xing_Label = "Configs do Xing";  // -------------------XING-----------------
input int xing_desloc = 2;
bool xing_tempo_real = false; //Tempo Real (onTick - true) vs Candle (false)
input int xing_limite_inferior = 20; //Distancia para compra (TickSize)
input int xing_limite_superior = 80; //Distancia para venda (TickSize)

input bool xing_invert = 1; //Inverte a direcao da trade (Depende muito do TimeFrame)
