/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                funcoesbender.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"


void Operacoes_No_tick()
{
  //Variaveis Atualizadas Globalmente

  Calcula_Spread_RT = Calcula_Spread();
  daotick_geral = daotick()-Calcula_Spread_RT; //Legacy
  daotick_venda = daotick(-1);
  daotick_compra = daotick(1);
//  Saldo_Do_Dia_RT = Saldo_Dia_Valor();

//  Saldo_Dia_Permite_RT = Saldo_Dia_Permite();

  //Fim das Vars Atualizadas Globalmente

  /////////////////////// Funçoes de STOP

  O_Stops.No_Tick();

    
  /////////////////////////////////////////////////

  DetectaNovaBarra();

}
