//+------------------------------------------------------------------+
//|                                                     Graficos.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

////// Bot�o

int broadcastEventID=5000; 


void OnChartEvent(const int id, 
                  const long &lparam, 
                  const double &dparam, 
                  const string &sparam) 
  { 
//--- Verifique o evento pressionando um bot�o do mouse 
   if(id==CHARTEVENT_OBJECT_CLICK) 
     { 
      string clickedChartObject=sparam; 
      //--- Se voc� clicar sobre o objeto com o nome buttonID 
      if(clickedChartObject=="BTN_ABORTAR") 
        { 
         if(Operacoes>0)  VendaStop(" Abortado pelo bot�o");
         if(Operacoes<0)  CompraStop(" Abortado pelo bot�o");   
         //--- Estado do bot�o - pressionado ou n�o 
         // bool selected=ObjectGetInteger(0,"BTN_ABORTAR",OBJPROP_STATE); 
         //--- registrar uma mensagem de depura��o 
         //Print("Bot�o pressionado = ",selected);
         
          
         // int customEventID; // N�mero do evento personalizado para enviar 
         //string message;    // Mensagem a ser enviada no caso 
         //--- Se o bot�o for pressionado 
         //if(selected) 
         //  { 
         //   message="Bot�o pressionado"; 
         //   customEventID=CHARTEVENT_CUSTOM+1; 
         //  } 
         //else // Bot�o n�o est� pressionado 
         //  { 
         //   message="Bot�o n�o est� pressionado"; 
         //   customEventID=CHARTEVENT_CUSTOM+999; 
         //  } 
        } 
        if(clickedChartObject=="Botao_Operar") 
        { 
         if(Mudanca>0)  VendaStop("Iniciado pelo bot�o");
         if(Mudanca<0)  CompraStop("Iniciado pelo bot�o");   

          
         //int customEventID; // N�mero do evento personalizado para enviar 
         //string message;    // Mensagem a ser enviada no caso 
         //--- Se o bot�o for pressionado 
         //if(selected) 
         //  { 
         //   message="Bot�o pressionado"; 
         //   customEventID=CHARTEVENT_CUSTOM+1; 
         //  } 
         //else // Bot�o n�o est� pressionado 
         //  { 
         //   message="Bot�o n�o est� pressionado"; 
         //   customEventID=CHARTEVENT_CUSTOM+999; 
         //  } 
        } 
      ChartRedraw();// Redesenho for�ado de todos os objetos de gr�fico 
     } 
  

  } 
  
  
///////////////////GRAFICOS 

void CriaLinhas ()
{
if(Operacoes>0) ObjectCreate(0,"StopLossCompra",OBJ_HLINE,0,0,StopLossValorCompra);
if(Operacoes<0) ObjectCreate(0,"StopLossVenda",OBJ_HLINE,0,0,StopLossValorVenda);
if(Operacoes>0) ObjectCreate(0,"TakeProfitCompra",OBJ_HLINE,0,0,TakeProfitValorCompra);
if(Operacoes<0) ObjectCreate(0,"TakeProfitVenda",OBJ_HLINE,0,0,TakeProfitValorVenda);

}

void CriaLinhaTS (double NivelTS)
{
ObjectCreate(0,"TS",OBJ_HLINE,0,0,NivelTS);
}

void AtualizaLinhas ()
{
if(Operacoes>0) ObjectSetInteger(0,"StopLossCompra",OBJPROP_STYLE,STYLE_DASHDOT); 
if(Operacoes>0) ObjectSetInteger(0,"StopLossCompra",OBJPROP_COLOR,clrRed); 
if(Operacoes>0) ObjectSetString(0,"StopLossCompra",OBJPROP_LEVELTEXT,"StopLoss: "+DoubleToString(StopLossValorCompra));
if(Operacoes>0) ObjectSetString(0,"StopLossCompra",OBJPROP_TEXT,"StopLoss: "+DoubleToString(StopLossValorCompra));
if(Operacoes>0) ObjectSetString(0,"StopLossCompra",OBJPROP_TOOLTIP,"StopLoss: "+DoubleToString(StopLossValorCompra));


if(Operacoes<0) ObjectSetInteger(0,"StopLossVenda",OBJPROP_STYLE,STYLE_DASHDOT); 
if(Operacoes<0) ObjectSetInteger(0,"StopLossVenda",OBJPROP_COLOR,clrRed); 
if(Operacoes<0) ObjectSetString(0,"StopLossVenda",OBJPROP_LEVELTEXT,"StopLoss: "+DoubleToString(StopLossValorVenda));
if(Operacoes<0) ObjectSetString(0,"StopLossVenda",OBJPROP_TEXT,"StopLoss: "+DoubleToString(StopLossValorVenda));
if(Operacoes<0) ObjectSetString(0,"StopLossVenda",OBJPROP_TOOLTIP,"StopLoss: "+DoubleToString(StopLossValorVenda));


if(Operacoes>0) ObjectSetInteger(0,"TakeProfitCompra",OBJPROP_STYLE,STYLE_DASHDOT); 
if(Operacoes>0) ObjectSetInteger(0,"TakeProfitCompra",OBJPROP_COLOR,clrBlue); 
if(Operacoes>0) ObjectSetString(0,"TakeProfitCompra",OBJPROP_LEVELTEXT,"TakeProfit: "+DoubleToString(TakeProfitValorCompra));
if(Operacoes>0) ObjectSetString(0,"TakeProfitCompra",OBJPROP_TEXT,"TakeProfit: "+DoubleToString(TakeProfitValorCompra));
if(Operacoes>0) ObjectSetString(0,"TakeProfitCompra",OBJPROP_TOOLTIP,"TakeProfit: "+DoubleToString(TakeProfitValorCompra));


if(Operacoes<0) ObjectSetInteger(0,"TakeProfitVenda",OBJPROP_STYLE,STYLE_DASHDOT); 
if(Operacoes<0) ObjectSetInteger(0,"TakeProfitVenda",OBJPROP_COLOR,clrBlue); 
if(Operacoes<0) ObjectSetString(0,"TakeProfitVenda",OBJPROP_LEVELTEXT,"TakeProfit: "+DoubleToString(TakeProfitValorVenda));
if(Operacoes<0) ObjectSetString(0,"TakeProfitVenda",OBJPROP_TEXT,"TakeProfit: "+DoubleToString(TakeProfitValorVenda));
if(Operacoes<0) ObjectSetString(0,"TakeProfitVenda",OBJPROP_TOOLTIP,"TakeProfit: "+DoubleToString(TakeProfitValorVenda));

}

void AtualizaLinhaTS (double NivelTS)
{

ObjectMove(0,"TS",0,0,NivelTS);
ObjectSetInteger(0,"TS",OBJPROP_STYLE,STYLE_DASHDOT); 
ObjectSetInteger(0,"TS",OBJPROP_COLOR,clrYellow); 
ObjectSetString(0,"TS",OBJPROP_LEVELTEXT,"TS: "+DoubleToString(NivelTS));
ObjectSetString(0,"TS",OBJPROP_TEXT,"TS: "+DoubleToString(NivelTS));
ObjectSetString(0,"TS",OBJPROP_TOOLTIP,"TS: "+DoubleToString(NivelTS));
}


///////////////////// FIM DOS GRAFICOS


/////////////////////
void Cria_Botao_Abortar ()
{
//--- criar o bot�o 
ObjectCreate(0,"BTN_ABORTAR",OBJ_BUTTON,0,0,0,0,0);
Botao_Abortar();
}

void Botao_Abortar ()                // prioridade para clicar no mouse 
  {
//--- definir coordenadas do bot�o 
   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_XDISTANCE,150); 
   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_YDISTANCE,0); 
//--- definir tamanho do bot�o 
   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_XSIZE,100); 
   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_YSIZE,18); 
//--- determinar o canto do gr�fico onde as coordenadas do ponto s�o definidas 
   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_CORNER,CORNER_LEFT_UPPER); 
//--- definir o texto 
   ObjectSetString(0,"BTN_ABORTAR",OBJPROP_TEXT,"!!!Aborta a Trade!!!"); 
//--- definir o texto fonte 
   ObjectSetString(0,"BTN_ABORTAR",OBJPROP_FONT,"Arial"); 
//--- definir tamanho da fonte 
   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_FONTSIZE,8); 
//--- definir a cor do texto 
   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_COLOR,clrWhite); 
//--- definir a cor de fundo 
   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_BGCOLOR,clrRed); 
//--- definir a cor da borda 
   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_BORDER_COLOR,clrBlack); 
//--- exibir em primeiro plano (false) ou fundo (true) 
   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_BACK,false); 
//--- set button state 
 //  ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_STATE,false); 
//--- habilitar (true) ou desabilitar (false) o modo do movimento do bot�o com o mouse 
   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_SELECTABLE,false); 
   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_SELECTED,false); 
//--- ocultar (true) ou exibir (false) o nome do objeto gr�fico na lista de objeto  
   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_HIDDEN,false); 
//--- definir a prioridade para receber o evento com um clique do mouse no gr�fico 
//   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_ZORDER,1); 
//--- sucesso na execu��o 
}


void Cria_Botao_Operar ()
{
//--- criar o bot�o 
ObjectCreate(0,"Botao_Operar",OBJ_BUTTON,0,0,0,0,0);
Botao_Operar();
}

void Botao_Operar ()                // prioridade para clicar no mouse 
  {
//--- definir coordenadas do bot�o 
   ObjectSetInteger(0,"Botao_Operar",OBJPROP_XDISTANCE,150); 
   ObjectSetInteger(0,"Botao_Operar",OBJPROP_YDISTANCE,0); 
//--- definir tamanho do bot�o 
   ObjectSetInteger(0,"Botao_Operar",OBJPROP_XSIZE,100); 
   ObjectSetInteger(0,"Botao_Operar",OBJPROP_YSIZE,18); 
//--- determinar o canto do gr�fico onde as coordenadas do ponto s�o definidas 
   ObjectSetInteger(0,"Botao_Operar",OBJPROP_CORNER,CORNER_LEFT_UPPER); 
//--- definir o texto 
   ObjectSetString(0,"Botao_Operar",OBJPROP_TEXT,"!!!For�a Trade!!!"); 
//--- definir o texto fonte 
   ObjectSetString(0,"Botao_Operar",OBJPROP_FONT,"Arial"); 
//--- definir tamanho da fonte 
   ObjectSetInteger(0,"Botao_Operar",OBJPROP_FONTSIZE,8); 
//--- definir a cor do texto 
   ObjectSetInteger(0,"Botao_Operar",OBJPROP_COLOR,clrWhite); 
//--- definir a cor de fundo 
   ObjectSetInteger(0,"Botao_Operar",OBJPROP_BGCOLOR,clrGray); 
//--- definir a cor da borda 
   ObjectSetInteger(0,"Botao_Operar",OBJPROP_BORDER_COLOR,clrBlack); 
//--- exibir em primeiro plano (false) ou fundo (true) 
   ObjectSetInteger(0,"Botao_Operar",OBJPROP_BACK,false); 
//--- set button state 
 //  ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_STATE,false); 
//--- habilitar (true) ou desabilitar (false) o modo do movimento do bot�o com o mouse 
   ObjectSetInteger(0,"Botao_Operar",OBJPROP_SELECTABLE,false); 
   ObjectSetInteger(0,"Botao_Operar",OBJPROP_SELECTED,false); 
//--- ocultar (true) ou exibir (false) o nome do objeto gr�fico na lista de objeto  
   ObjectSetInteger(0,"Botao_Operar",OBJPROP_HIDDEN,false); 
//--- definir a prioridade para receber o evento com um clique do mouse no gr�fico 
//   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_ZORDER,1); 
//--- sucesso na execu��o 
}
/*
string Desc_Robo (string Desc_A_Mao)
{



}
*/