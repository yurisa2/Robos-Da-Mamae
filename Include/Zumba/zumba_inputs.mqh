﻿/* -*- C++ -*- */


input string Zumba_Label = "Configs do Zumba";  // -----------Zumba--------------
input TFs Zumba_BBPP_TF_ = _M1;


ENUM_TIMEFRAMES Zumba_BBPP_TF = defMarcoTiempo(Zumba_BBPP_TF_);

ENUM_TIMEFRAMES Zumba_IGOR_TF = TimeFrame;
input double Zumba_limite_superior = 83;
input double Zumba_limite_inferior = 17;
input bool Zumba_sair_indicador = true;
input double Zumba_dist_sair = 10;
input bool Zumba_Tempo_real = false;
input double Zumba_Agressao_Igor = 0; //AgressÃ£o Igor MAX 10
input double Zumba_Agressao_BBPP = 0; //AgressÃ£o BBPP MAX 20
