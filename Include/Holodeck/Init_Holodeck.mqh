/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             SA2 - Investment soft|
//+------------------------------------------------------------------+
#property copyright "Sa2, pq saum soh dois na empresa agora."
#property link      "http://www.sa2.com.br"


void Init_Holo ()
{

  ChartIndicatorAdd(0,0,Handle_Holo_BB);
}

ENUM_INIT_RETCODE Verifica_Init_Holo ()
{
      if(Holo_Mediana && Holo_Distancia > 0)
      {
        MessageBox("Mais de um método de entrada","Erro de Inicialização",MB_OK);
        Print("Mais de um método de entrada","Erro de Inicialização");
        return(INIT_PARAMETERS_INCORRECT);
      }

      if(!Holo_Mediana && Holo_Distancia < 1)
      {
        MessageBox("Nao foi escolhido um método de entrada","Erro de Inicialização",MB_OK);
        Print("Nao foi escolhido um método de entrada","Erro de Inicialização");
        return(INIT_PARAMETERS_INCORRECT);
      }

      if(Holo_Menor_TP && Usa_Prop){
        MessageBox("Mexe Com isso agora nao vai...","Erro de Inicialização",MB_OK);
        Print("Mexe Com isso agora nao vai...","Erro de Inicialização");
        return(INIT_PARAMETERS_INCORRECT);
      }

      return INIT_SUCCEEDED;
}
