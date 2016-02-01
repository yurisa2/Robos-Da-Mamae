//+------------------------------------------------------------------+
//|                                                         HiLo.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"

int HandleHiLoMediaAlta = iMA(NULL,TimeFrame,Periodos,0,MODE_SMA,PRICE_HIGH);
int HandleHiLoMediaBaixa = iMA(NULL,TimeFrame,Periodos,0,MODE_SMA,PRICE_LOW);

double RetornaTendencia = 0;

double DevolveHiLo ()
{

double MediaAlta[];
double MediaBaixa[];

ArraySetAsSeries(MediaAlta,true);
ArraySetAsSeries(MediaBaixa,true);

int copiaMediaAlta = CopyBuffer(HandleHiLoMediaAlta,0,0,1,MediaAlta);
int copiaMediaBaixa = CopyBuffer(HandleHiLoMediaBaixa,0,0,1,MediaBaixa);

if(daotick() > MediaAlta[0])
  {
   RetornaTendencia = -1;
   Print("Tendencia Compra");
  }

if(daotick() < MediaBaixa[0])
  {
   RetornaTendencia = 1;
   Print("Tendencia Venda");
  }

return RetornaTendencia;

}