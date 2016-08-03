#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

input bool OperacaoLogoDeCara = false;                                     //Opera assim que o hor�rio liberar, sem virada de tendencia


input string Indicadores = "-------------------------------------";
input bool SaiPeloIndicador = true;                                        //Saida pelo indicador
input bool IndicadorTempoReal = false;                                     //Indicador em tempo real

input string Configs_HiLo = "-------------------------------------";
input bool Usa_Hilo = 1;                                                   //Usar HiLo
input int Periodos =  4;                                                   //Periodos do HiLo (4)

input string Configs_Ozy = "-------------------------------------";
input bool Usa_Ozy = 0;                                                    //Usar Ozymandias
input ENUM_MA_METHOD Ozy_MM =  MODE_SMA;                                   //Tipo de MM Ozymandias (badOtim)
input int Ozy_Shift = 0;                                                   //Shift Ozymandias (0)
input int Ozy_length = 2;                                                  //Length Ozymandias (2)

input string Configs_PSAR = "-------------------------------------";
input bool Usa_PSar = 0;                                                   //Usar Parabolic SAR
input double PSAR_Step = 0.02;                                             //Parabolic SAR Step (0.02)
input double PSAR_Max_Step = 0.2;                                          //Parabolic SAR Max Step (0.2)

input string Configs_Fractals = "-------------------------------------";
input bool Usa_Fractal = 0;                                                //Usar Fractals (Bill Williams)
input int   Frac_Candles_Espera = 3;                                       //Quantos candles esperar o sinal (3)

input string Configs_BSI = "-------------------------------------";
input bool Usa_BSI = 0;                                                   //Usar BSI (Wyckoff)
input int BSI_RangePeriod = 20;                                           //Range Period (20)
input int BSI_Slowing = 3;                                                //Slowing (3)
input int BSI_Avg_Period = 3;                                             //Periodo Media (3)
