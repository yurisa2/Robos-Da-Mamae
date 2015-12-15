//+------------------------------------------------------------------+
//|                                             FuncoesBenderDef.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"
#property version   "1.25"
#include <basico.mqh>


/////////////////////////////////////// Inputs

input double lucro_dia = 1000000;

input int Lotes = 1;
input ENUM_TIMEFRAMES TimeFrame = PERIOD_M10;

input bool Usa_Hilo = 1;
input bool Usa_PSar = 0;
input int Periodos =  4;
input double PSAR_Step = 0.02;
input double PSAR_Max_Step = 0.2;

input double StopLoss = 0;
input double TakeProfit = 0;
input double Trailing_stop =0;
input double Trailing_stop_start = 0;

//--- input bool  SaiPeloHilo = true;
input bool SaiPeloIndicador = true;
//--- input bool  HiLoTempoReal = false;
input bool IndicadorTempoReal = false;


input int HoraDeInicio = 9;
input int MinutoDeInicio = 1;
input int HoraDeFim = 17;
input int MinutoDeFim = 27;

input int Limite_Operacoes = 9999;

string HorarioInicio = IntegerToString(HoraDeInicio,2,'0') + ":" + IntegerToString(MinutoDeInicio,2,'0');
int MinutoDeFimMenos1;
string HorarioFim;
string HorarioFimMais1;

input bool   ZerarFinalDoDia = true;

input bool OperacaoLogoDeCara = false;
input string Descricao_Robo = "";
input ENUM_ORDER_TYPE_FILLING TipoDeOrdem = ORDER_FILLING_RETURN;


////// Botão

int broadcastEventID=5000; 

///////////////////////////////// Variaveis

datetime Agora;
string DiaHoje ;

double   Mudanca = 0;
bool     Ordem = false;
int      Operacoes = 0;

bool     JaDeuFinal = false;
bool     JaZerou = false;

double StopLossValorCompra =-9999999999;
double TakeProfitValorCompra = 999999999;
double StopLossValorVenda =99999999999;
double TakeProfitValorVenda = -999999999;
double PrecoCompra = 0;
double PrecoVenda = 0;
bool   DeuTakeProfit = true;
bool   DeuStopLoss = true;
bool   PrimeiraOp = false;

int Mudou = 0;

int TimeMagic;
bool DaResultado;
double Acumulado = 0;
uint num_ordem_tiquete;
datetime Data_Hoje;


double TS_ValorCompra = 0;
double TS_ValorVenda = 999999999;

double TS_ValorVenda_atual = 9999999;
double TS_ValorCompra_atual = 0;        

string Desc_Req = "";

int OperacoesFeitas = 0;

int HandleGHL;
int HandlePSar;
int CondicaoPsar;

double liquidez_inicio=0;

///////////////////////////////////////////

//////////////////////////////////// Funcoes








///////////////// COMPRA

void CompraIndicador (string Desc)
{

Print(Descricao_Robo+" "+Desc);


if(Operacoes<0 && SaiPeloIndicador==true)
{
MontarRequisicao(ORDER_TYPE_BUY,Desc);
}

if(Operacoes==0 && OperacoesFeitas < (Limite_Operacoes*2) && conta.Equity() < liquidez_inicio + lucro_dia)
{
MontarRequisicao(ORDER_TYPE_BUY,Desc);
}

}

//////////////////////////

///////////// Venda
void VendaIndicador (string Desc)
{

Print(Descricao_Robo+" "+Desc);

if(Operacoes>0 && SaiPeloIndicador==true) 
{
MontarRequisicao(ORDER_TYPE_SELL,Desc);
}

if(Operacoes==0 && OperacoesFeitas < (Limite_Operacoes*2) && conta.Equity() < liquidez_inicio + lucro_dia) 
{
MontarRequisicao(ORDER_TYPE_SELL,Desc);
}

}


/////////////////////// PEGA O VALOR DO HI LO 


void CalculaHiLo ()

{
if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true)
   {
   
   double _ma1[];
   double NMax[];
   double NMin[];
   double ValorHilo[];

   ArraySetAsSeries(_ma1, true);
   ArraySetAsSeries(NMax, true);
   ArraySetAsSeries(NMin, true);   
   ArraySetAsSeries(ValorHilo, true);

   int copied=CopyBuffer(HandleGHL,4,0,100,_ma1);
   int copiadoNmax=CopyBuffer(HandleGHL,2,0,100,NMax);
   int copiadoNmin=CopyBuffer(HandleGHL,3,0,100,NMin);
   int copiadoValorHilo=CopyBuffer(HandleGHL,0,0,100,ValorHilo);

//   Print("Indicador do Hilo: ;",_ma1[0],"; | Media Max(NMax): ;",NormalizeDouble(NMax[0],2),"; | Media Min(NMin): ;",NormalizeDouble(NMin[0],2),"; | Preco: ;",daotick(),"; | Valor do HiLo: ;",NormalizeDouble(ValorHilo[0],2));
   
   
 //  if(_ma1[0]==NMin[0]) Print("Compra");
 //  if(_ma1[0]==NMax[0]) Print("Vende");
   
                   
                    //Print(_ma1[i]);
                    

                    
                    if(Mudanca!=_ma1[0]) 
                    {
                    //Print("Mudou Hein");
                    DeuStopLoss = false;
                    DeuTakeProfit = false;                   
                    Ordem = false;
                    }
                    
//   Print("Operacoes: ",Operacoes);
   Mudanca = _ma1[0];
   
   Mudou = 0;
//     if(Debug==true) Print("Indicador do Hilo: ",_ma1[0]," | Media Max(NMax): ",NMax[0]," | Media Min(NMin): ",NMin[0]);

   }   //FIM DO IF TaDentroDoHorario
}

void HiLo ()
{

if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true)
   {
   
   double _ma1[];
   double NMax[];
   double NMin[];
   double ValorHilo[];
   
   ArraySetAsSeries(_ma1, true);
   ArraySetAsSeries(NMax, true);
   ArraySetAsSeries(NMin, true);   
   ArraySetAsSeries(ValorHilo, true);

   int copied=CopyBuffer(HandleGHL,4,0,100,_ma1);
   int copiadoNmax=CopyBuffer(HandleGHL,2,0,100,NMax);
   int copiadoNmin=CopyBuffer(HandleGHL,3,0,100,NMin);
   int copiadoValorHilo=CopyBuffer(HandleGHL,0,0,100,ValorHilo);
                    
                    if(Mudanca!=_ma1[0]) 
                    {
                    //Print("Mudou Hein");
                    DeuStopLoss = false;
                    DeuTakeProfit = false;                   
                    Ordem = false;
                      
                      
                    if(Mudanca==1 && Ordem==false) 
                    {
                    Print("Operações Antes da venda: ",Operacoes," VENDE! ");
                    //Print("Periodo: ",ChartPeriod()," Estranho", PeriodSeconds());
                    VendaIndicador("Venda por HiLo");
                    Ordem = true;
                    }
                    
                    if(Mudanca==-1 && Ordem==false) 
                    {
                    Print("Operações Antes da compra: ",Operacoes," COMPRA! ");
                    CompraIndicador("Compra por HiLo");
                    Ordem = true;
                    }
                      
                    }
                    
//   Print("Operacoes: ",Operacoes);
   Mudanca = _ma1[0];
   
   Mudou = 0;

   }   //FIM DO IF TaDentroDoHorario

}
//////////////////////////////////////////////////////

///////////////////VALORES DO PSAR
void CalculaPSar ()
{

if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true)
   {
   double PSar_Array[];
   ArraySetAsSeries(PSar_Array, true);
   int copiedPSar=CopyBuffer(HandlePSar,0,0,100,PSar_Array);

  //--- Dá uns prints só pra ver //--- Print("Valor do PSAR: ",PSar_Array[0]," Preço: ",daotick());
    if(PSar_Array[0] >daotick())     CondicaoPsar = -1;
    if(PSar_Array[0] <daotick())     CondicaoPsar = 1;

                    if(Mudanca!=CondicaoPsar) 
                    {
                    //Print("Mudou Hein");
                    DeuStopLoss = false;
                    DeuTakeProfit = false;                   
                    Ordem = false;
                      
                    }
                    
//   Print("Operacoes: ",Operacoes);
   Mudanca = CondicaoPsar;
   Mudou = 0;

   }   //FIM DO IF TaDentroDoHorario

}

void PSar ()
{

if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true)
   {
   double PSar_Array[];
   ArraySetAsSeries(PSar_Array, true);
   int copiedPSar=CopyBuffer(HandlePSar,0,0,100,PSar_Array);

  //--- Dá uns prints só pra ver //--- Print("Valor do PSAR: ",PSar_Array[0]," Preço: ",daotick());
    if(PSar_Array[0] >daotick())     CondicaoPsar = -1;
    if(PSar_Array[0] <daotick())     CondicaoPsar = 1;

                    if(Mudanca!=CondicaoPsar) 
                    {
                    //Print("Mudou Hein");
                    DeuStopLoss = false;
                    DeuTakeProfit = false;                   
                    Ordem = false;
                      
                    if(Mudanca==1 && Ordem==false) 
                    {
                    Print("Operações Antes da venda: ",Operacoes," VENDE! ");
                    VendaIndicador("Venda por Inversão de PSAR");
                    Ordem = true;
                    }
                    
                    if(Mudanca==-1 && Ordem==false) 
                    {
                    Print("Operações Antes da compra: ",Operacoes," COMPRA! ");
                    CompraIndicador("Compra por Inversão de PSAR");
                    Ordem = true;
                    }
                      
                    }
                    
//   Print("Operacoes: ",Operacoes);
   Mudanca = CondicaoPsar;
   Mudou = 0;

   }   //FIM DO IF TaDentroDoHorario

}

//////////////////////////////////




////////////////////////// Calcula STOPS

void CalculaStops ()

{
string DeclaraStops = "";
StopLossValorCompra =-9999999999;
TakeProfitValorCompra = 999999999;
StopLossValorVenda =99999999999;
TakeProfitValorVenda = -999999999;

           if(StopLoss==0)
              {
              StopLossValorCompra = NULL;
              StopLossValorVenda = NULL;
              }
           else
             {
              StopLossValorVenda = PrecoVenda+StopLoss;
              StopLossValorCompra = PrecoCompra-StopLoss;
              //Print(Descricao_Robo+" "+"SL Compra: ",StopLossValorCompra," SL Venda: ",StopLossValorVenda);
              if(Operacoes>1) DeclaraStops = DeclaraStops +" "+"SL Compra: "+DoubleToString(StopLossValorCompra);
              if(Operacoes<1) DeclaraStops = DeclaraStops +" "+"SL Venda: "+DoubleToString(StopLossValorVenda);                
             }
             
             
           if(TakeProfit==0)
              {
              TakeProfitValorVenda = NULL;
              TakeProfitValorCompra = NULL;
              }
           else
             {
              TakeProfitValorVenda = PrecoVenda-TakeProfit;
              TakeProfitValorCompra = PrecoCompra+TakeProfit;
              //Print(Descricao_Robo+" "+"TP Compra: ",TakeProfitValorCompra," TP Venda: ",TakeProfitValorVenda);   
              if(Operacoes>1) DeclaraStops = DeclaraStops +" "+"TP Compra: "+DoubleToString(TakeProfitValorCompra);
              if(Operacoes<1) DeclaraStops = DeclaraStops +" "+"TP Venda: "+DoubleToString(TakeProfitValorVenda);           
             }             
             Print(DeclaraStops);

}
//////////////////////////////////////////////////////////////////////////

////////////////////////// StopLoss   - Teste Bazaar

void StopLossCompra ()
{


 if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && DeuStopLoss == false && Operacoes!=0 && Operacoes >0 && StopLoss != 0)
   {
   
      if(daotick()<=StopLossValorCompra)
        {
         Print(Descricao_Robo+" Deu StopLoss COMPRADO | Venda: ",daotick()," Valor do StopLoss: ",StopLossValorCompra);
         Print(Descricao_Robo+" VENDA! ",Operacoes);

         VendaStop("Venda SL: "+DoubleToString(daotick(),2));
         DeuStopLoss = true;
         
        }
   
   }


}


/////////////////////////////////////////////////

/////////////////// STOP LOSS VENDA

void StopLossVenda ()
{
if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && DeuStopLoss == false && Operacoes!=0 && Operacoes <0 && StopLoss != 0)
   {
      if(daotick()>=StopLossValorVenda)
        {
         Print(Descricao_Robo+" Deu StopLoss VENDIDO | Compra r: ",daotick()," Valor do Stop: ",StopLossValorVenda);
         Print(Descricao_Robo+" COMPRA! ",Operacoes);
         DeuStopLoss = true;
         CompraStop("Compra SL: "+DoubleToString(daotick(),2));
        }
   
   }


}
//////////////////////////////////////////////

/////////////////// Take Profit Compra

void TakeProfitCompra ()
{
if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && DeuTakeProfit == false && Operacoes!=0 && Operacoes >0 && TakeProfit != 0)
   {
      if(daotick()>TakeProfitValorCompra)
        {
         Print(Descricao_Robo+" Deu TakeProfit COMPRADO | VENDA: ",daotick()," Valor do TakeProfit: ",TakeProfitValorCompra);
         VendaStop("Venda TP: "+DoubleToString(daotick(),2));
         DeuTakeProfit = true;
        }
   }
}
//////////////////////////////////////////////

/////////////////// Take Profit Venda

void TakeProfitVenda ()
{
 if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true  && DeuTakeProfit == false && Operacoes!=0 && Operacoes <0 && TakeProfit !=0)
   {
      if(daotick()<TakeProfitValorVenda)
        {
         Print(Descricao_Robo+" Deu TakeProfit VENDIDO | Compra: ",daotick()," Valor do TakeProfit: ",TakeProfitValorVenda);
         CompraStop("Compra TP "+DoubleToString(daotick(),2));
         DeuTakeProfit = true;
        }
   }
}
//////////////////////////////////////////////


///////////// Venda Do Stop
void VendaStop (string Desc)
{
Print(Descricao_Robo+" "+Desc);
MontarRequisicao(ORDER_TYPE_SELL,Desc);
}
///////////////////////////////

/////////////////////////// Compra Hilo STOP
void CompraStop (string Desc)
{
Print(Descricao_Robo+" "+Desc);
MontarRequisicao(ORDER_TYPE_BUY,Desc);
}

//////////////////////////// Primeira Operaçao
/////////////////////////// Req de Operaçao

void MontarRequisicao (ENUM_ORDER_TYPE order_type, string comentario_req)
   {
         if(order_type==ORDER_TYPE_SELL) 
         {
            PrecoVenda = daotick();
            Operacoes = Operacoes -1;
         }
         if(order_type==ORDER_TYPE_BUY)  
         {
            PrecoCompra = daotick();   
            Operacoes = Operacoes +1;
         }   
            
         StopLossValorCompra =-9999999999;
         TakeProfitValorCompra = 999999999;
         StopLossValorVenda =99999999999;
         TakeProfitValorVenda = -999999999;
         TS_ValorVenda = 99999999;
         TS_ValorCompra = 0;
         OperacoesFeitas++;
         
         CalculaStops();

         MqlTradeRequest Req;     
         MqlTradeResult Res;     
         ZeroMemory(Req);     
         ZeroMemory(Res);     
         Req.symbol       = Symbol();
         Req.volume       = Lotes;
         Req.magic = TimeMagic;
         Req.type_filling = TipoDeOrdem;                 
         Req.action=TRADE_ACTION_DEAL; 
         Req.type=order_type; 
         Req.comment=Descricao_Robo+" "+comentario_req;     
         Req.tp=0;
         Req.sl=0;
         
               if(OrderSend(Req,Res)) Print(Descricao_Robo," - Ordem Enviada |",comentario_req); 
               else 
                  {
                  Print(Descricao_Robo+" Deu Pau, Verifique com pressao");
                  SendNotification("ERRO GRAVE, VERIFIQUE: "+IntegerToString(GetLastError()));
                  ExpertRemove();
                  }

         DaResultado = true;
   ObjectsDeleteAll(0,0,-1);
   CriaLinhaTS(0);
   Cria_Botao_Abortar();
   CriaLinhas();
   AtualizaLinhas();
   Print("Operacoes no fim da req: ",Operacoes);
   }
   /////////////////////////////////////////// Final da req.
   
   //////////////////////////////// Primeira Operaçao
   
   void PrimeiraOperacao ()
{
       if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && PrimeiraOp==false)
       {
       Print(Descricao_Robo+" Horario Setup: ",HorarioInicio);
       Print(Descricao_Robo+" Mudanca Inicio dia: ",Mudanca);
       
       PrimeiraOp = true;
       
       if(Mudanca>0) CompraStop("Compra OperaLogoDeCara");
       if(Mudanca<0) VendaStop("Venda OperaLogoDeCara");
       }
 }
//////////////// Fim Primeira Operaçao
 
////////////// Avaliação do TS
void TS ()
   {
      if(Operacoes>0 && Trailing_stop >0 && daotick() > PrecoCompra + Trailing_stop + Trailing_stop_start)
        {
        TS_ValorCompra_atual = daotick()-Trailing_stop;
         if(TS_ValorCompra<TS_ValorCompra_atual)
           {
            TS_ValorCompra = TS_ValorCompra_atual;
            AtualizaLinhaTS(TS_ValorCompra);
           }
        }    
      if(Operacoes<0 && Trailing_stop >0&& daotick() < PrecoVenda - Trailing_stop - Trailing_stop_start)
        {
        TS_ValorVenda_atual = daotick()+Trailing_stop;  
         if(TS_ValorVenda>TS_ValorVenda_atual)
           {
            TS_ValorVenda = TS_ValorVenda_atual;
            AtualizaLinhaTS(TS_ValorVenda);
           }
        }
  
      if(Operacoes>0 && Trailing_stop >0 && daotick()<= TS_ValorCompra)      
        {
         VendaStop("Venda TrailingStop");
         Print(Descricao_Robo+" TrailingStopCompra Ativado, Valor daotick: ",daotick());
         ObjectDelete(0,"TS");
        }
   
      if(Operacoes<0 && Trailing_stop >0 && daotick()>= TS_ValorVenda)      
        {
         CompraStop("Compra TrailingStop");
         Print(Descricao_Robo+" TrailingStopVenda Ativado, Valor daotick: ",daotick());
         ObjectDelete(0,"TS");
        }   
   }
/////////////////////////////////
void DetectaNovaBarra ()
{
//---
   int period_seconds=PeriodSeconds(_Period);                     // Number of seconds in current chart period
   datetime new_time=TimeCurrent()/period_seconds*period_seconds; // Time of bar opening on current chart
   if(grafico_atual.isNewBar(new_time)) OnNewBar();
}
void OnNewBar()
{
   if(IndicadorTempoReal == false && Usa_Hilo == true)      HiLo();
   if(IndicadorTempoReal == false && Usa_PSar == true)      PSar();
}

void IniciaDia ()
{
        if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && JaZerou==false)
        {
        
        CalculaHiLo();
        CalculaPSar();
        
        PrecoCompra =0;
        PrecoVenda =0;
        
        OperacoesFeitas =0;
        
        StopLossValorCompra =-9999999999;
        TakeProfitValorCompra = 999999999;
        StopLossValorVenda =99999999999;
        TakeProfitValorVenda = -999999999;
                 
        JaZerou = true;
        JaDeuFinal = false;
        Operacoes = 0;
        Ordem = false;
        PrimeiraOp = false;
        DeuTakeProfit = true;
        DeuStopLoss = true;

        Print("Bom dia! Bucareste as ordens, segura o coraçao pq o role é monstro!!!");
        SendMail(Descricao_Robo + "Inicio das operaçoes Bucareste","Bom dia! Bucareste: "+Descricao_Robo+" às ordens, segura o coraçao pq o role é monstro!!!");
        SendNotification("Bom dia! Bucareste: "+Descricao_Robo+" às ordens, segura o coraçao pq o role é monstro!!!");
        
        Print("Indicador HiLo inicio do dia: ",Mudanca);
        
        liquidez_inicio = conta.Equity();
        }
Sleep(1000);
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


////////////////// Zerar o dia 
void ZerarODia ()
{
       if(TaDentroDoHorario(HorarioFim,HorarioFimMais1)==true && JaDeuFinal==false)
         {
            JaDeuFinal = true;
            JaZerou = false;
            PrimeiraOp = false;
            Print(Descricao_Robo+"Final do Dia! Operaçoes: ",Operacoes);
            SendNotification(Descricao_Robo+" encerrando");
          
                   if(Operacoes<0) 
                      {
                      MontarRequisicao(ORDER_TYPE_BUY,"Compra para zerar o dia");  
                      Sleep(1000);
                      }
                   if(Operacoes>0) 
                     {
                     MontarRequisicao(ORDER_TYPE_SELL,"Venda para zerar o dia");
                     Sleep(1000);
                     SendMail(Descricao_Robo+"Bucareste: Venda para zerar o dia","Finalizando o dia com uma venda, e tal...");
                     }
               Print(Descricao_Robo+"Depois da Ultima Operaçao: ",Operacoes);
         }
   Sleep(1000);
  }  

/////////////////////
void Cria_Botao_Abortar ()
{
//--- criar o botão 
ObjectCreate(0,"BTN_ABORTAR",OBJ_BUTTON,0,0,0,0,0);
Botao_Abortar();
}

void Botao_Abortar ()                // prioridade para clicar no mouse 
  {
//--- definir coordenadas do botão 
   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_XDISTANCE,150); 
   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_YDISTANCE,0); 
//--- definir tamanho do botão 
   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_XSIZE,100); 
   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_YSIZE,18); 
//--- determinar o canto do gráfico onde as coordenadas do ponto são definidas 
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
//--- habilitar (true) ou desabilitar (false) o modo do movimento do botão com o mouse 
   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_SELECTABLE,false); 
   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_SELECTED,false); 
//--- ocultar (true) ou exibir (false) o nome do objeto gráfico na lista de objeto  
   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_HIDDEN,false); 
//--- definir a prioridade para receber o evento com um clique do mouse no gráfico 
//   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_ZORDER,1); 
//--- sucesso na execução 
}

