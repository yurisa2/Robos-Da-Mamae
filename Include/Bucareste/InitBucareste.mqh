//+------------------------------------------------------------------+
//|                                                 VerificaInit.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

ENUM_INIT_RETCODE InitBucareste () {


    if(SaiPeloIndicador==true && IndicadorTempoReal == true)
    {
      MessageBox("Se o Indicador está em tempo real, não dá pra sair pelo mesmo, chuva de ordens","Erro de Inicialização",MB_OK);
      Print("Se o Indicador está em tempo real, não dá pra sair pelo mesmo, chuva de ordens","Erro de Inicialização");
      return(INIT_PARAMETERS_INCORRECT);
    }

//  int Verifica_Indicadores = Usa_Fractal + Usa_Hilo + Usa_PSar + Usa_Ozy + Usa_BSI; //STRIPPED
  int Verifica_Indicadores = Usa_Hilo + Usa_PSar ;
  if(Verifica_Indicadores != 1)
  {
    MessageBox("Erro de Indicadores (mais de um ou nenhum escolhido)...","Erro de Inicialização",MB_OK);
    Print("Erro de Indicadores (mais de um ou nennum escolhido)...","Erro de Inicialização");
    return(INIT_PARAMETERS_INCORRECT);
  }

  if(Otimizacao)
  {
      if(Usa_Hilo)
      {
      //  if(Zerado_BSI()+Zerado_Fractals()+Zerado_Ozy()+Zerado_PSAR()>0)  //STRIPPED
        if(Zerado_PSAR()>0)
        {
          MessageBox("Algum Parametro Não zerado dos outros indicadores","Erro de Inicialização",MB_OK);
          Print("Algum Parametro Não zerado dos outros indicadores","Erro de Inicialização");
          return(INIT_PARAMETERS_INCORRECT);
        }

        if(Periodos < 2)
        {
          MessageBox("Algum Parametro zerado dos outros indicadores","Erro de Inicialização",MB_OK);
          Print("Algum Parametro Não zerado dos outros indicadores","Erro de Inicialização");
          return(INIT_PARAMETERS_INCORRECT);
        }
      }

      // if(Usa_BSI)
      // {
      //   if(Zerado_HiLo()+Zerado_Fractals()+Zerado_Ozy()+Zerado_PSAR()>0)
      //   {
      //     MessageBox("Algum Parametro Não zerado dos outros indicadores","Erro de Inicialização",MB_OK);
      //     Print("Algum Parametro Não zerado dos outros indicadores","Erro de Inicialização");
      //     return(INIT_PARAMETERS_INCORRECT);
      //   }
      //
      //   if(BSI_RangePeriod==0 || BSI_Slowing ==0 || BSI_Avg_Period == 0)
      //   {
      //     MessageBox("Algum Parametro zerado dos outros indicadores","Erro de Inicialização",MB_OK);
      //     Print("Algum Parametro Não zerado dos outros indicadores","Erro de Inicialização");
      //     return(INIT_PARAMETERS_INCORRECT);
      //   }
      //
      // }

      // if(Usa_Fractal)
      // {
      //   if(Zerado_HiLo()+Zerado_BSI()+Zerado_Ozy()+Zerado_PSAR()>0)
      //   {
      //     MessageBox("Algum Parametro Não zerado dos outros indicadores","Erro de Inicialização",MB_OK);
      //     Print("Algum Parametro Não zerado dos outros indicadores","Erro de Inicialização");
      //     return(INIT_PARAMETERS_INCORRECT);
      //   }
      //
      //   if(Frac_Candles_Espera == 0)
      //   {
      //     MessageBox("Algum Parametro zerado dos outros indicadores","Erro de Inicialização",MB_OK);
      //     Print("Algum Parametro Não zerado dos outros indicadores","Erro de Inicialização");
      //     return(INIT_PARAMETERS_INCORRECT);
      //   }
      //
      // }
      //
      // if(Usa_Ozy)
      // {
      //   if(Zerado_HiLo()+Zerado_BSI()+Zerado_Fractals()+Zerado_PSAR()>0)
      //   {
      //     MessageBox("Algum Parametro Não zerado dos outros indicadores","Erro de Inicialização",MB_OK);
      //     Print("Algum Parametro Não zerado dos outros indicadores","Erro de Inicialização");
      //     return(INIT_PARAMETERS_INCORRECT);
      //   }
      //
      //   if(Ozy_length == 0)
      //   {
      //     MessageBox("Algum Parametro zerado dos outros indicadores","Erro de Inicialização",MB_OK);
      //     Print("Algum Parametro Não zerado dos outros indicadores","Erro de Inicialização");
      //     return(INIT_PARAMETERS_INCORRECT);
      //   }
      //
      // }

      if(Usa_PSar)
      {
      //  if(Zerado_HiLo()+Zerado_BSI()+Zerado_Fractals()+Zerado_Ozy()>0)  //STRIPPED
        if(Zerado_HiLo() > 0)
        {
          MessageBox("Algum Parametro Não zerado dos outros indicadores","Erro de Inicialização",MB_OK);
          Print("Algum Parametro Não zerado dos outros indicadores","Erro de Inicialização");
          return(INIT_PARAMETERS_INCORRECT);
        }

        if(PSAR_Step == 0 || PSAR_Max_Step == 0)
        {
          MessageBox("Algum Parametro zerado dos outros indicadores","Erro de Inicialização",MB_OK);
          Print("Algum Parametro Não zerado dos outros indicadores","Erro de Inicialização");
          return(INIT_PARAMETERS_INCORRECT);
        }
      }
    }
      return INIT_SUCCEEDED;
}
