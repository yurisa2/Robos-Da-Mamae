//+------------------------------------------------------------------+
//|                                                 VerificaInit.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

ENUM_INIT_RETCODE VerificaInit ()
{

  if(HoraDeInicio==9 && MinutoDeInicio==0)
  {
    MessageBox("Comece a partir de 09:01","Erro de Inicialização",MB_OK);
    Print("Comece a partir de 09:01","Erro de Inicialização");
    return(INIT_PARAMETERS_INCORRECT);
  }

  if(Trailing_stop + Trailing_stop_start > TakeProfit && TakeProfit>0)
  {
    MessageBox("Trailing Stop Maior que o TP... Pense nisso.","Erro de Inicialização",MB_OK);
    Print("Trailing Stop Maior que o TP... Pense nisso.","Erro de Inicialização");
    return(INIT_PARAMETERS_INCORRECT);
  }

  if(HoraDeInicio>HoraDeFim)
  {
    MessageBox("Hora de início depois da Hora de Fim","Erro de Inicialização",MB_OK);
    Print("Hora de início depois da Hora de Fim","Erro de Inicialização");
    return(INIT_PARAMETERS_INCORRECT);
  }


  if(HoraDeInicio==HoraDeFim && MinutoDeInicio >= MinutoDeFim)
  {
    MessageBox("Hora de início depois da Hora de Fim","Erro de Inicialização",MB_OK);
    Print("Hora de início depois da Hora de Fim","Erro de Inicialização");
    return(INIT_PARAMETERS_INCORRECT);
  }


  if(HoraDeInicio == HoraDeFim && (MinutoDeFim-MinutoDeInicio<10))
  {
    MessageBox("Nem vou operar menos que 10 minutos, falou","Erro de Inicialização",MB_OK);
    Print("Nem vou operar menos que 10 minutos, falou","Erro de Inicialização");
    return(INIT_PARAMETERS_INCORRECT);
  }

  if(StopLoss <0 || TakeProfit <0|| Lotes <= 0)
  {
    MessageBox("Erro nos parametros de grana ou técnicos","Erro de Inicialização",MB_OK);
    Print("Erro nos parametros de grana ou técnicos","Erro de Inicialização");
    return(INIT_PARAMETERS_INCORRECT);
  }

  if(PontoDeMudancaSL > MoverSL || (MoverSL==0 && PontoDeMudancaSL <0))
  {
    MessageBox("PontoDeMudancaSL > MoverSL ou Mover Desligado e PMSL menor que zero","Erro de Inicialização",MB_OK);
    Print("PontoDeMudancaSL > MoverSL"," - Erro de Inicialização");
    return(INIT_PARAMETERS_INCORRECT);
  }


  return INIT_SUCCEEDED;

}
