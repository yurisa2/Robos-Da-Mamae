//+------------------------------------------------------------------+
//|                                             FuncoesBenderDef.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"
#property version   "2.00"
#include <basico.mqh>

/////////////////////////////////////// Inoputs

input int Lotes = 1;
input ENUM_TIMEFRAMES TimeFrame = PERIOD_M10;
input int Periodos =  4;
input double StopLoss = 0;
input double TakeProfit = 0;

input int HoraDeInicio = 9;
input int MinutoDeInicio = 0;
input int HoraDeFim = 17;
input int MinutoDeFim = 27;

       
string HorarioFim = IntegerToString(HoraDeFim,2,'0') + ":" + IntegerToString(MinutoDeFim,2,'0');
string HorarioInicio = IntegerToString(HoraDeInicio,2,'0') + ":" + IntegerToString(MinutoDeInicio,2,'0');

input bool   ZerarFinalDoDia = true;

input bool OperacaoLogoDeCara = true;





///////////////////////////////// Variaveis

datetime Agora;
string DiaHoje ;

double   Mudanca = 0;
bool     Ordem = false;
int      Operacoes = 0;

int      HandleGHL = 0;

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

ENUM_ORDER_TYPE TipoOp = 0;

int Mudou = 0;


///////////////////////////////////////////

//////////////////////////////////// Funcoes

////////////////////  TaDentroDoHorario //////////////
bool TaDentroDoHorario (string HoraInicio, string HoraFim)
   {
   string DiaHoraInicio;
   string DiaHoraFim;
   bool RetornoHorario =false;
   
   Agora = TimeCurrent();
   
   DiaHoje = TimeToString(TimeCurrent(),TIME_DATE);

   DiaHoraInicio = DiaHoje + " " + HoraInicio;
   DiaHoraFim = DiaHoje + " " + HoraFim;
   
   // Se Agora > String Dia + String Hora OK.
   //   Print("DiaHoje ",DiaHoje);
   if(Agora>=StringToTime(DiaHoraInicio))
     {
      if(Agora<=StringToTime(DiaHoraFim))
      {
      RetornoHorario = true;
      }
     }
   
   return(RetornoHorario);
   
   
   }
////////////////////////////////////////////////////////////////



//////////////////////// DAOTICK ///////////�
////// Fun��o Pega Tick e devolve a hora e o valor da porra do ativo
double daotick ()
{

double retornoTick;

   MqlTick last_tick;
   
if(SymbolInfoTick(_Symbol,last_tick))
     {
     // Print(last_tick.time,": Bid = ",last_tick.bid,
          //  " Ask = ",last_tick.ask,"  Volume = ",last_tick.volume); //total e completo
    
     }
     else Print("SymbolInfoTick() failed, error = ",GetLastError());
   
     retornoTick = last_tick.ask;

     return(retornoTick);
    
}
   

////////////////// Fecha o PEGA O TICK



///////////////// COMPRA

void CompraHiLo ()
{
Print("Compra HiLo");
CalculaStops();

if(Operacoes<0)
{

TipoOp = ORDER_TYPE_BUY;
MontarRequisicao();

Operacoes = Operacoes + 1;
PrecoCompra = daotick();
SendMail("Bucareste: COMPROU no HiLo","Bucareste fez um monte de conta e resolveu que ia comprar no HiLo | Valor da compra: " + DoubleToString(NormalizeDouble(daotick(),2)) + " | Hora: "+TimeToString(TimeCurrent(),TIME_SECONDS));

}

if(Operacoes==0)
{
//trade.Buy(Lotes,NULL,daotick(),NULL,NULL,"Compra do Buca!");
TipoOp = ORDER_TYPE_BUY;
MontarRequisicao();

Operacoes = Operacoes + 1;
PrecoCompra = daotick();
SendMail("Bucareste: COMPROU no HiLo","Bucareste fez um monte de conta e resolveu que ia comprar no HiLo | Valor da compra: " + DoubleToString(NormalizeDouble(daotick(),2)) + " | Hora: "+TimeToString(TimeCurrent(),TIME_SECONDS));

}

}

//////////////////////////

///////////// Venda
void VendaHiLo ()
{

CalculaStops();

if(Operacoes>0) 
{
Print("Venda HiLo");

TipoOp = ORDER_TYPE_SELL;
MontarRequisicao();

Operacoes = Operacoes - 1;
PrecoVenda = daotick();
SendMail("Bucareste: VENDEU no HiLo","Bucareste fez um monte de conta e resolveu que ia VENDER no HiLo | Valor da venda: " + DoubleToString(NormalizeDouble(daotick(),2)) + " | Hora: "+TimeToString(TimeCurrent(),TIME_SECONDS));

}


if(Operacoes==0) 
{

TipoOp = ORDER_TYPE_SELL;
MontarRequisicao();

Operacoes = Operacoes - 1;
PrecoVenda = daotick();
SendMail("Bucareste: VENDEU no HiLo","Bucareste fez um monte de conta e resolveu que ia VENDER no HiLo | Valor da venda: " + DoubleToString(NormalizeDouble(daotick(),2)) + " | Hora: "+TimeToString(TimeCurrent(),TIME_SECONDS));

}

}


/////////////////////// PEGA O VALOR DO HI LO 

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

   Print("Indicador do Hilo: ;",_ma1[0],"; | Media Max(NMax): ;",NormalizeDouble(NMax[0],2),"; | Media Min(NMin): ;",NormalizeDouble(NMin[0],2)," | Preco: ;",daotick(),"; | Valor do HiLo: ;",NormalizeDouble(ValorHilo[0],2));
   
   
 //  if(_ma1[0]==NMin[0]) Print("Compra");
 //  if(_ma1[0]==NMax[0]) Print("Vende");
   
                   
                    //Print(_ma1[i]);
                    

                    
                    if(Mudanca!=_ma1[0]) 
                    {
                    //Print("Mudou Hein");
                    DeuStopLoss = false;
                    DeuTakeProfit = false;                   
                    Ordem = false;
                      
                      
                    if(Mudanca==1 && Ordem==false) 
                    {
                    Print("VENDE! ",Operacoes);
                    //Print("Periodo: ",ChartPeriod()," Estranho", PeriodSeconds());
                    VendaHiLo();
                    Ordem = true;
                    }
                    
                    if(Mudanca==-1 && Ordem==false) 
                    {
                    Print("COMPRA! ",Operacoes);
                    CompraHiLo();
                    Ordem = true;
                    }
                      
                    }
                    
//   Print("Operacoes: ",Operacoes);
   Mudanca = _ma1[0];
   
   Mudou = 0;
//     if(Debug==true) Print("Indicador do Hilo: ",_ma1[0]," | Media Max(NMax): ",NMax[0]," | Media Min(NMin): ",NMin[0]);

   }   //FIM DO IF TaDentroDoHorario

}
//////////////////////////////////////////////////////


////////////////////////// Calcula STOPS

void CalculaStops ()

{
           if(StopLoss==0)
              {
              StopLossValorCompra = NULL;
              StopLossValorVenda = NULL;
              }
           else
             {
              StopLossValorVenda = PrecoVenda+StopLoss;
              StopLossValorCompra = PrecoCompra-StopLoss;              
              
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
             }             
             

}
//////////////////////////////////////////////////////////////////////////

////////////////////////// StopLoss   - Teste Bazaar

void StopLossCompra ()
{


 if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && DeuStopLoss == false && Operacoes!=0 && Operacoes >0 && StopLoss != 0)
   {
   CalculaStops();
   
      if(daotick()<=StopLossValorCompra)
        {
         
         Print("Deu TakeProfit COMPRADO | Venda �: ",daotick()," Valor do StopLoss: ",StopLossValorCompra);
         Print("VENDA! ",Operacoes);

         VendaHiLoStop();
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
   CalculaStops();
   
      if(daotick()>=StopLossValorVenda)
        {
         
         Print("Deu StopLoss VENDIDO | Compra �: ",daotick()," Valor do Stop: ",StopLossValorVenda);
         Print("COMPRA! ",Operacoes);
         DeuStopLoss = true;
         CompraHiLoStop();
         
        }
   
   }


}
//////////////////////////////////////////////

/////////////////// Take Profit Compra

void TakeProfitCompra ()
{


 if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && DeuTakeProfit == false && Operacoes!=0 && Operacoes >0 && TakeProfit != 0)
   {
   CalculaStops();
   
      if(daotick()>=TakeProfitValorCompra)
        {
         
         Print("Deu TakeProfit COMPRADO | VENDA �: ",daotick()," Valor do TakeProfit: ",TakeProfitValorCompra);
         VendaHiLoStop();
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
   CalculaStops();
   
      if(daotick()<=TakeProfitValorVenda)
        {
         
         Print("Deu TakeProfit VENDIDO | Compra �: ",daotick()," Valor do TakeProfit: ",TakeProfitValorVenda);
         CompraHiLoStop();
         DeuTakeProfit = true;
        }
   
   }


}
//////////////////////////////////////////////


///////////// Venda Do Stop
void VendaHiLoStop ()
{
Print("Venda HILO Stop");

TipoOp = ORDER_TYPE_SELL;
MontarRequisicao();

Operacoes = Operacoes - 1;
PrecoVenda = daotick();
SendMail("Bucareste: VENDEU no HiLo","Bucareste fez um monte de conta e resolveu que ia VENDER no HiLo | Valor da venda: " + DoubleToString(NormalizeDouble(daotick(),2)) + " | Hora: "+TimeToString(TimeCurrent(),TIME_SECONDS));


}
///////////////////////////////

/////////////////////////// Compra Hilo STOP
void CompraHiLoStop ()
{

Print("Compra HILO Stop");

TipoOp = ORDER_TYPE_BUY;
MontarRequisicao();

Operacoes = Operacoes + 1;
PrecoCompra = daotick();
SendMail("Bucareste: COMPROU no HiLo","Bucareste fez um monte de conta e resolveu que ia comprar no HiLo | Valor da compra: " + DoubleToString(NormalizeDouble(daotick(),2)) + " | Hora: "+TimeToString(TimeCurrent(),TIME_SECONDS));


}

//////////////////////////// Primeira Opera��o

////////////////// Zerar o dia
void ZerarODia ()
{

 if(TaDentroDoHorario(HorarioFim,"17:40")==true && JaDeuFinal==false)
   {
      JaDeuFinal = true;
      JaZerou = false;
      PrimeiraOp = false;
      Print("Final do Dia! Opera��es: ",Operacoes);
      SendNotification("Bucareste encerrando");
    
    if(Operacoes<0) 
    {
    
    
    TipoOp = ORDER_TYPE_BUY;
    MontarRequisicao();  
    
    Operacoes = Operacoes +1;
    SendMail("Bucareste: Compra para zerar o dia","Finalizando o dia com uma comprinha...");
    }
    
    
    if(Operacoes>0) 
   {
   

      TipoOp = ORDER_TYPE_SELL;
      MontarRequisicao();

       Operacoes = Operacoes -1;

           SendMail("Bucareste: Venda para zerar o dia","Finalizando o dia com uma venda, e tal...");
   }
   
   
         Print("Depois da Ultima Opera��o: ",Operacoes);
   }

   
  }  
//+------------------------------------------------------------------+

/////////////////////


/////////////////////////// Req de Opera��o


void MontarRequisicao ()
   {

         MqlTradeRequest Req;     
         MqlTradeResult Res;     
         ZeroMemory(Req);     
         ZeroMemory(Res);     
         Req.symbol       = Symbol();
         Req.volume       = Lotes;
         Req.magic = 646572;
         Req.type_filling = ORDER_FILLING_RETURN;                 
         Req.action=TRADE_ACTION_DEAL; 
         Req.type=TipoOp; 
         Req.comment="Bucareste Operando";     
         Req.tp=0;
         Req.sl=0;
         
   if(OrderSend(Req,Res)) Print("If positivo"); else Print("Deu Pau, Verifique com press�o");
   
   
   }
   
   
   
   /////////////////////////////////////////// Final da req.
   
   //////////////////////////////// Primeira Opera��o
   
   void PrimeiraOperacao ()
{
       if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && PrimeiraOp==false)
       {
       
       Print("Horario Setup: ",HorarioInicio);
       Print("Mudanca Inicio dia: ",Mudanca);
       
       PrimeiraOp = true;
       
       if(Mudanca>0) CompraHiLoStop();
       if(Mudanca<0) VendaHiLoStop();
       
       }
       
 }
 
 
 //////////////// Fim Primeira Opera��o