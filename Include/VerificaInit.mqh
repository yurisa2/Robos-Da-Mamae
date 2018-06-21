//+------------------------------------------------------------------+
//|                                                 VerificaInit.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

ENUM_INIT_RETCODE VerificaInit ()
{

  if(Tipo_Limite == 471 && SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL) == 0)
  {
    MessageBox("Nesse Mododo de Limite","Erro de Inicializao",MB_OK);
    Print("Nesse Mododo de Limite","Erro de Inicializao");
    return(INIT_PARAMETERS_INCORRECT);
  }


  if(HoraDeInicio==9 && MinutoDeInicio==0)
  {
    MessageBox("Comece a partir de 09:01","Erro de Inicializao",MB_OK);
    Print("Comece a partir de 09:01","Erro de Inicializao");
    return(INIT_PARAMETERS_INCORRECT);
  }

  if(Trailing_stop + Trailing_stop_start > TakeProfit && TakeProfit>0)
  {
    MessageBox("Trailing Stop Maior que o TP... Pense nisso.","Erro de Inicializao",MB_OK);
    Print("Trailing Stop Maior que o TP... Pense nisso.","Erro de Inicializao");
    return(INIT_PARAMETERS_INCORRECT);
  }

  if(HoraDeInicio>HoraDeFim)
  {
    MessageBox("Hora de incio depois da Hora de Fim","Erro de Inicializao",MB_OK);
    Print("Hora de incio depois da Hora de Fim","Erro de Inicializao");
    return(INIT_PARAMETERS_INCORRECT);
  }


  if(HoraDeInicio==HoraDeFim && MinutoDeInicio >= MinutoDeFim)
  {
    MessageBox("Hora de incio depois da Hora de Fim","Erro de Inicializao",MB_OK);
    Print("Hora de incio depois da Hora de Fim","Erro de Inicializao");
    return(INIT_PARAMETERS_INCORRECT);
  }


  if(HoraDeInicio == HoraDeFim && (MinutoDeFim-MinutoDeInicio<10))
  {
    MessageBox("Nem vou operar menos que 10 minutos, falou","Erro de Inicializao",MB_OK);
    Print("Nem vou operar menos que 10 minutos, falou","Erro de Inicializao");
    return(INIT_PARAMETERS_INCORRECT);
  }

  if(StopLoss <0 || TakeProfit <0|| Lotes <= 0)
  {
    MessageBox("Erro nos parametros de grana ou tcnicos","Erro de Inicializao",MB_OK);
    Print("Erro nos parametros de grana ou tcnicos","Erro de Inicializao");
    return(INIT_PARAMETERS_INCORRECT);
  }

  // if(PontoDeMudancaSL > MoverSL || (MoverSL==0 && PontoDeMudancaSL <0))
  // {
  //   MessageBox("PontoDeMudancaSL > MoverSL ou Mover Desligado e PMSL menor que zero","Erro de Inicializao",MB_OK);
  //   Print("PontoDeMudancaSL > MoverSL"," - Erro de Inicializao");
  //   return(INIT_PARAMETERS_INCORRECT);
  // }

// Inicio da verificao de TakeProfit2

if((TakeProfit_Volume + TakeProfit_Volume2 + TakeProfit_Volume3) != 0 && Lotes != (TakeProfit_Volume + TakeProfit_Volume2 + TakeProfit_Volume3))
{
  MessageBox("Volume de Take Profit no bate com o Volume de entrada ","Erro de Inicializao",MB_OK);
  Print("Volume de Take Profit no bate com o Volume de entrada  "," - Erro de Inicializao");
  return(INIT_PARAMETERS_INCORRECT);
}

if(TakeProfit3 != 0 && TakeProfit3 <= TakeProfit2)
{
  MessageBox("Erro no TP3 ","Erro de Inicializao",MB_OK);
  Print("Erro no TP3   "," - Erro de Inicializao");
  return(INIT_PARAMETERS_INCORRECT);
}

if(TakeProfit2 != 0 && TakeProfit2 <= TakeProfit)
{
  MessageBox("Erro no TP2 ","Erro de Inicializao",MB_OK);
  Print("Erro no TP2   "," - Erro de Inicializao");
  return(INIT_PARAMETERS_INCORRECT);
}


  return INIT_SUCCEEDED;

}
