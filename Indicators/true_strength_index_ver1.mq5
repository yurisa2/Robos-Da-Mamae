﻿//+------------------------------------------------------------------+
//|                                          True Strength Index.mq5 |
//|                        Copyright 2009, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "2009, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers 7
#property indicator_plots   1
//--- incluir funções de média a partir do arquivo MovingAverages.mqh 
#include <MovingAverages.mqh>
//---- desenhar TSI
#property indicator_label1  "TSI"
#property indicator_type1   DRAW_LINE
#property indicator_color1  Blue
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- incluir parâmetros
input int      r=25;
input int      s=13;
//--- buffers do indicador
double         TSIBuffer[];
double         MTMBuffer[];
double         AbsMTMBuffer[];
double         EMA_MTMBuffer[];
double         EMA2_MTMBuffer[];
double         EMA_AbsMTMBuffer[];
double         EMA2_AbsMTMBuffer[];
//+------------------------------------------------------------------+
//| Função de inicialização do indicador personalizado               |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- mapeamento de buffers do indicador
   SetIndexBuffer(0,TSIBuffer,INDICATOR_DATA);
   SetIndexBuffer(1,MTMBuffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(2,AbsMTMBuffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(3,EMA_MTMBuffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(4,EMA2_MTMBuffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(5,EMA_AbsMTMBuffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(6,EMA2_AbsMTMBuffer,INDICATOR_CALCULATIONS);
//---
   return(0);
  }
//+------------------------------------------------------------------+
//| Função de iteração do indicador personalizado                    |
//+------------------------------------------------------------------+
int OnCalculate (const int rates_total,    // tamanho da série price[];
                 const int prev_calculated,// número de barras disponíveis;
                 // na chamada anterior;
                 const int begin,// e onde os dados 
                 // do price[] começa;
                 const double &price[]) // array em que o indicador será calculado;
  {
//--- se o tamanho de price[] é muito pequeno
  if(rates_total<r+s) return(0); // não calcula ou desenha alguma coisa
//--- se este é o primeiro cálculo
   if(prev_calculated==0)
     {
      //--- coloque zero no inicio
      MTMBuffer[0]=0.0;
      AbsMTMBuffer[0]=0.0;
     }

//--- calcula os valores de mtm e |mtm|
   int start;
   if(prev_calculated==0) start=1;  // comece a preencher MTMBuffer[] e AbsMTMBuffer[] do índice 1
   else start=prev_calculated-1;    // define o início igual ao último índice nas matrizes
   for(int i=start;i<rates_total;i++)
     {
      MTMBuffer[i]=price[i]-price[i-1];
      AbsMTMBuffer[i]=fabs(MTMBuffer[i]);
     }

//--- calcula a primeira média móvel
   ExponentialMAOnBuffer(rates_total,prev_calculated,
                         1,     // índice, a partir do qual os dados estão disponíveis para suavizar
                         r,     // período da média exponencial
                         MTMBuffer,       // buffer para calcular a média
                         EMA_MTMBuffer);  // buffer para colocar a média calculada
   ExponentialMAOnBuffer(rates_total,prev_calculated,
                         1,r,AbsMTMBuffer,EMA_AbsMTMBuffer);

//--- calcula a segunda média móvel
   ExponentialMAOnBuffer(rates_total,prev_calculated,
                         r,s,EMA_MTMBuffer,EMA2_MTMBuffer);
   ExponentialMAOnBuffer(rates_total,prev_calculated,
                         r,s,EMA_AbsMTMBuffer,EMA2_AbsMTMBuffer);

//--- calcula os valores do indicador
   if(prev_calculated==0) start=r+s-1; // define o início do índice nas matrizes
   else start=prev_calculated-1;     // define o início igual ao último índice nas matrizes
   for(int i=start;i<rates_total;i++)
     {
      TSIBuffer[i]=100*EMA2_MTMBuffer[i]/EMA2_AbsMTMBuffer[i];
     }
//--- retorna o valor de prev_calculated para o próximo uso
   return(rates_total);
  }
//+------------------------------------------------------------------+
