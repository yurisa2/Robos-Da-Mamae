//+------------------------------------------------------------------+
//|                                             FuncoesBenderDef.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

//////////////////////////////////// Funcoes

void OnNewBar()
{
   if(IndicadorTempoReal == false && Usa_Hilo == true)      HiLo();
   if(IndicadorTempoReal == false && Usa_PSar == true)      PSar();
   if(IndicadorTempoReal == false && Usa_Ozy == true)       Ozy_Opera();
   if(IndicadorTempoReal == false && Usa_Fractal == true)   Fractal();
   if(IndicadorTempoReal == false && Usa_BSI == true)       BSI();   
}

void Inicializa_Funcs ()
{

   Tick_Size = SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_SIZE);
   
   if(Usa_PSar == true) HandlePSar = iSAR(NULL,TimeFrame,PSAR_Step,PSAR_Max_Step);
   if(Usa_Ozy == true) HandleOzy = iCustom(NULL,TimeFrame,"ozymandias_lite",Ozy_length,Ozy_MM,Ozy_Shift);
   if(Usa_Fractal == true) HandleFrac = iFractals(NULL,TimeFrame);
   if(Usa_Prop == true) Inicializa_Prop();
   if(Usa_Hilo == true) Inicializa_HiLo();
   if(Usa_BSI == true)  Inicializa_BSI();

   if(Usa_Hilo == true) CalculaHiLo();
   if(Usa_PSar == true) CalculaPSar();
   if(Usa_BSI == true) CalculaBSI();   
   
   if(Usa_Fractal == true) CalculaFractal();

   if(Usa_PSar == true)  ChartIndicatorAdd(0,0,HandlePSar);
   if(Usa_Ozy == true) ChartIndicatorAdd(0,0,HandleOzy);
   if(Usa_Fractal == true) ChartIndicatorAdd(0,0,HandleFrac);   
   
   Cria_Botao_Operar();
  
   ArrumaMinutos();

}

bool Saldo_Dia ()
{
   if(conta.Equity() == liquidez_inicio) return true;
   if(
   (conta.Equity() > liquidez_inicio && lucro_dia >= conta.Equity() - liquidez_inicio -  OperacoesFeitas*custo_operacao)
   ||
   (conta.Equity() < liquidez_inicio && (-1 * preju_dia) <= conta.Equity() - liquidez_inicio -  OperacoesFeitas*custo_operacao)
   ) return true; 

return false;
  

}

