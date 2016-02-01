//+------------------------------------------------------------------+
//|                                                 VerificaInit.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

int VerificaInit ()
{

   if(HoraDeInicio==9 && MinutoDeInicio==0) 
   {
   MessageBox("Comece a partir de 09:01","Erro de Inicializa��o",MB_OK);
   Print("Comece a partir de 09:01","Erro de Inicializa��o");
   return(INIT_PARAMETERS_INCORRECT);
   }
   
   if(Trailing_stop > TakeProfit && TakeProfit>0)
   {
   MessageBox("Trailing Stop Maior que o TP... Pense nisso.","Erro de Inicializa��o",MB_OK);
   Print("Trailing Stop Maior que o TP... Pense nisso.","Erro de Inicializa��o");
   return(INIT_PARAMETERS_INCORRECT);  
   }
   
   if(HoraDeInicio>HoraDeFim) 
   {
   MessageBox("Hora de in�cio depois da Hora de Fim","Erro de Inicializa��o",MB_OK);
   Print("Hora de in�cio depois da Hora de Fim","Erro de Inicializa��o");
   return(INIT_PARAMETERS_INCORRECT);
   }
   
   if(Usa_PSar == true && Periodos>0) 
   {
   MessageBox("Psar Nao Usa Periodos","Erro de Inicializa��o",MB_OK);
   Print("Psar Nao Usa Periodos","Erro de Inicializa��o");
   return(INIT_PARAMETERS_INCORRECT);
   }
   
   if(Usa_Hilo == true && (PSAR_Max_Step > 0 || PSAR_Step >0))
   {
   MessageBox("HiLo Nao Usar Steps","Erro de Inicializa��o",MB_OK);
   Print("HiLo Nao Usar Steps","Erro de Inicializa��o");
   return(INIT_PARAMETERS_INCORRECT);
   }


   if(HoraDeInicio==HoraDeFim && MinutoDeInicio >= MinutoDeFim) 
    {
   MessageBox("Hora de in�cio depois da Hora de Fim","Erro de Inicializa��o",MB_OK); 
   Print("Hora de in�cio depois da Hora de Fim","Erro de Inicializa��o");
   return(INIT_PARAMETERS_INCORRECT);

   }
   
   if(SaiPeloIndicador==true && IndicadorTempoReal == true) 
    {
   MessageBox("Se o Indicador est� em tempo real, n�o d� pra sair pelo mesmo, chuva de ordens","Erro de Inicializa��o",MB_OK);
   Print("Se o Indicador est� em tempo real, n�o d� pra sair pelo mesmo, chuva de ordens","Erro de Inicializa��o");
   return(INIT_PARAMETERS_INCORRECT);
   }
   
   if(HoraDeInicio == HoraDeFim && (MinutoDeFim-MinutoDeInicio<10))
    {
   MessageBox("Nem vou operar menos que 10 minutos, falou","Erro de Inicializa��o",MB_OK);
   Print("Nem vou operar menos que 10 minutos, falou","Erro de Inicializa��o");
   return(INIT_PARAMETERS_INCORRECT);
   }
   //if(Usa_PSar == false && Usa_Hilo == false && Usa_Fractal== false)
   // {
   //MessageBox("Um dos indicadores c te que usar n� amig�o...","Erro de Inicializa��o",MB_OK);
   //Print("Um dos indicadores c te que usar n� amig�o...","Erro de Inicializa��o");
   //return(INIT_PARAMETERS_INCORRECT);
   //}
    if(StopLoss <0 || TakeProfit <0|| Lotes <= 0 || (Usa_Hilo == true && Periodos <=1) ) 
     {
   MessageBox("Erro nos parametros de grana ou t�cnicos","Erro de Inicializa��o",MB_OK); 
   Print("Erro nos parametros de grana ou t�cnicos","Erro de Inicializa��o");
   return(INIT_PARAMETERS_INCORRECT);
   }
   
    if(Usa_Hilo == true && Usa_PSar == true) 
     {

   MessageBox("Ainda n�o fazemos 2 indicadores juntos","Erro de Inicializa��o",MB_OK);     
   Print("Ainda n�o fazemos 2 indicadores juntos","Erro de Inicializa��o");
      return(INIT_PARAMETERS_INCORRECT);
   }
   
   
   if(PontoDeMudancaSL > MoverSL || (MoverSL==0 && PontoDeMudancaSL <0)) 
     {
   MessageBox("PontoDeMudancaSL > MoverSL ou Mover Desligado e PMSL menor que zero","Erro de Inicializa��o",MB_OK);     
   Print("PontoDeMudancaSL > MoverSL"," - Erro de Inicializa��o");
   return(INIT_PARAMETERS_INCORRECT);
   }
   
   
      if((Usa_Prop == true && Usa_Fixos == true) ||(Usa_Prop == false && Usa_Fixos == false)) 
     {
   MessageBox("Escolha o timo de limite novamente.","Erro de Inicializa��o",MB_OK);     
   Print("Escolha o timo de limite novamente."," - Erro de Inicializa��o");
   return(INIT_PARAMETERS_INCORRECT);
   }
 


}