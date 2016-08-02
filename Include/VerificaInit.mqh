//+------------------------------------------------------------------+
//|                                                 VerificaInit.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"




ENUM_INIT_RETCODE VerificaInit ()
{

   if(HoraDeInicio==9 && MinutoDeInicio==0) 
   {
   MessageBox("Comece a partir de 09:01","Erro de Inicializa��o",MB_OK);
   Print("Comece a partir de 09:01","Erro de Inicializa��o");
   return(INIT_PARAMETERS_INCORRECT);
   }
   
   if(Trailing_stop + Trailing_stop_start > TakeProfit && TakeProfit>0)
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
   
   int Verifica_Indicadores = Usa_Fractal + Usa_Hilo + Usa_PSar + Usa_Ozy + Usa_BSI;
   if(Verifica_Indicadores != 1)
   {
   MessageBox("Erro de Indicadores (mais de um ou nenhum escolhido)...","Erro de Inicializa��o",MB_OK);
   Print("Erro de Indicadores (mais de um ou nennum escolhido)...","Erro de Inicializa��o");
   return(INIT_PARAMETERS_INCORRECT);
   }
   
   if(StopLoss <0 || TakeProfit <0|| Lotes <= 0) 
   {
   MessageBox("Erro nos parametros de grana ou t�cnicos","Erro de Inicializa��o",MB_OK); 
   Print("Erro nos parametros de grana ou t�cnicos","Erro de Inicializa��o");
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
   MessageBox("Escolha o tipo de limite novamente.","Erro de Inicializa��o",MB_OK);     
   Print("Escolha o tipo de limite novamente."," - Erro de Inicializa��o");
   return(INIT_PARAMETERS_INCORRECT);
   }
   
   if(Prop_MoverSL > Prop_TakeProfit && Prop_TakeProfit >0)
   {
   MessageBox("Mover SL maior que TP.","Erro de Inicializa��o",MB_OK);     
   Print("Mover SL maior que TP."," - Erro de Inicializa��o");
   return(INIT_PARAMETERS_INCORRECT);
   }
   
   if(Prop_Trailing_stop + Prop_Trailing_stop_start > Prop_TakeProfit && Prop_TakeProfit>0)
   {
   MessageBox("Trailing Stop Maior que o TP... Pense nisso.","Erro de Inicializa��o",MB_OK);
   Print("Trailing Stop Maior que o TP... Pense nisso.","Erro de Inicializa��o");
   return(INIT_PARAMETERS_INCORRECT);  
   }



   // Verificador de params para otimiza��o
   
   if(Otimizacao)
   {
   
   


      if(Usa_Prop)
      {                                            
         if(Prop_StopLoss + Prop_MoverSL + Prop_PontoDeMudancaSL + Prop_TakeProfit + Prop_Trailing_stop + Prop_Trailing_stop_start ==0 )
         {
         MessageBox("T� prop e t� tudo zerado","Erro de Inicializa��o",MB_OK);
         Print("T� prop e t� tudo zerado","Erro de Inicializa��o");
         return(INIT_PARAMETERS_INCORRECT);  
         }
      }
   
      if(Usa_Fixos)
      {
         if(StopLoss + MoverSL + PontoDeMudancaSL + TakeProfit + Trailing_stop + Trailing_stop_start ==0)   
          {
         MessageBox("T� Fixo e t� tudo zerado","Erro de Inicializa��o",MB_OK);
         Print("T� Fixo e t� tudo zerado","Erro de Inicializa��o");
         return(INIT_PARAMETERS_INCORRECT);  
         }
         
         
      }
      
      


     
      
      if(Usa_Hilo)
      {
         if(Zerado_BSI()+Zerado_Fractals()+Zerado_Ozy()+Zerado_PSAR()>0)
         {
         MessageBox("Algum Parametro N�o zerado dos outros indicadores","Erro de Inicializa��o",MB_OK);
         Print("Algum Parametro N�o zerado dos outros indicadores","Erro de Inicializa��o");
         return(INIT_PARAMETERS_INCORRECT);  
         }
         
         if(Periodos < 2)
         {
         MessageBox("Algum Parametro zerado dos outros indicadores","Erro de Inicializa��o",MB_OK);
         Print("Algum Parametro N�o zerado dos outros indicadores","Erro de Inicializa��o");
         return(INIT_PARAMETERS_INCORRECT);  
         }         
         
      }
      
      if(Usa_BSI)
      {
         if(Zerado_HiLo()+Zerado_Fractals()+Zerado_Ozy()+Zerado_PSAR()>0)
         {
         MessageBox("Algum Parametro N�o zerado dos outros indicadores","Erro de Inicializa��o",MB_OK);
         Print("Algum Parametro N�o zerado dos outros indicadores","Erro de Inicializa��o");
         return(INIT_PARAMETERS_INCORRECT);  
         }
         
         if(BSI_RangePeriod==0 || BSI_Slowing ==0 || BSI_Avg_Period == 0)
         {
         MessageBox("Algum Parametro zerado dos outros indicadores","Erro de Inicializa��o",MB_OK);
         Print("Algum Parametro N�o zerado dos outros indicadores","Erro de Inicializa��o");
         return(INIT_PARAMETERS_INCORRECT);  
         }   
         
      }
      
       if(Usa_Fractal)
      {
         if(Zerado_HiLo()+Zerado_BSI()+Zerado_Ozy()+Zerado_PSAR()>0)
         {
         MessageBox("Algum Parametro N�o zerado dos outros indicadores","Erro de Inicializa��o",MB_OK);
         Print("Algum Parametro N�o zerado dos outros indicadores","Erro de Inicializa��o");
         return(INIT_PARAMETERS_INCORRECT);  
         }
         
         if(Frac_Candles_Espera == 0)
         {
         MessageBox("Algum Parametro zerado dos outros indicadores","Erro de Inicializa��o",MB_OK);
         Print("Algum Parametro N�o zerado dos outros indicadores","Erro de Inicializa��o");
         return(INIT_PARAMETERS_INCORRECT);  
         }   
         
      }  
   
       if(Usa_Ozy)
      {
         if(Zerado_HiLo()+Zerado_BSI()+Zerado_Fractals()+Zerado_PSAR()>0)
         {
         MessageBox("Algum Parametro N�o zerado dos outros indicadores","Erro de Inicializa��o",MB_OK);
         Print("Algum Parametro N�o zerado dos outros indicadores","Erro de Inicializa��o");
         return(INIT_PARAMETERS_INCORRECT);  
         }
         
         if(Ozy_length == 0)
         {
         MessageBox("Algum Parametro zerado dos outros indicadores","Erro de Inicializa��o",MB_OK);
         Print("Algum Parametro N�o zerado dos outros indicadores","Erro de Inicializa��o");
         return(INIT_PARAMETERS_INCORRECT);  
         }           
         
      }     
   
        if(Usa_PSar)
      {
         if(Zerado_HiLo()+Zerado_BSI()+Zerado_Fractals()+Zerado_Ozy()>0)
         {
         MessageBox("Algum Parametro N�o zerado dos outros indicadores","Erro de Inicializa��o",MB_OK);
         Print("Algum Parametro N�o zerado dos outros indicadores","Erro de Inicializa��o");
         return(INIT_PARAMETERS_INCORRECT);  
         }
         
         if(PSAR_Step == 0 || PSAR_Max_Step == 0)
         {
         MessageBox("Algum Parametro zerado dos outros indicadores","Erro de Inicializa��o",MB_OK);
         Print("Algum Parametro N�o zerado dos outros indicadores","Erro de Inicializa��o");
         return(INIT_PARAMETERS_INCORRECT);  
         }   
         
      }    
   
   
   
   
   
   
   }
   // Verificador de params para otimiza��o
   
   
return INIT_SUCCEEDED;

}