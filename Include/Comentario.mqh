/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"


void Comentario_Debug_funcao ()
{


Comentario_Debug = Comentario_Avancado +

"\n\nCondicoes_Basicas_Gerais: " + IntegerToString(Condicoes_Basicas_Gerais()) +
"\nJaZerou: " + IntegerToString(JaZerou) +
"\nJaDeuFinal: " + IntegerToString(JaDeuFinal) +
"\nOperacoes: " + IntegerToString(Operacoes) +
"\nDeuTakeProfit: " + IntegerToString(DeuTakeProfit) +
"\nDeuStopLoss: " + IntegerToString(DeuStopLoss) +
"\n---------------------- "  +
// "\nUsa_Fixos: " + IntegerToString(Usa_Fixos) +
"\nTaDentroDoHorario: " + IntegerToString(TaDentroDoHorario_RT) +
"\nSaldo_Dia_Permite: " + IntegerToString(Saldo_Dia_Permite_RT) +
"\nDirecao: " + DoubleToString(Direcao,0) +
"\n---------------------- " +
"\nBid: " + DoubleToString(daotick_venda) +
"\nTick Size: "+ DoubleToString(Tick_Size) +
"\nAsk: " + DoubleToString(daotick_compra) +
"\nSpread: " + DoubleToString(Calcula_Spread_RT) +
"\n---------------------- " +
"\nliquidez_inicio: " + DoubleToString(liquidez_inicio) +
"\nLiq Project: " + DoubleToString(Saldo_Do_Dia_RT - (custo_operacao * Lotes)) +
"\nMagic #: " + IntegerToString(TimeMagic) +
"\n---------------------- " +
"\nStops::Tipo_Posicao(): " + IntegerToString(O_Stops.Tipo_Posicao()) +

// "\nUltimo Valor: " + PrecoNegocio //NAO FUNFA NEM NA RICO NEM NA XP.... FX OK
"\n---------------------- "
;


}
