/* -*- C++ -*- */
input string Xus_Label = "Configs do Xus";  // -----------X-U-S----------------
input int xus_delta_ativacao = 60; // Delta Ativacao (TickSize s)
input double xus_multiplicador_vendetta = 1.5;


int last_day_integer = 0;
int last_day_trade = 0;
double xus_delta_ativacao_value = xus_delta_ativacao * Tick_Size;
