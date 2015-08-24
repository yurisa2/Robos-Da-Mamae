//+------------------------------------------------------------------+
//|                                             FuncoesBenderDef.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"
#property version   "2.05"

#include <basico.mqh>



input int Lotes =1;
input double StopLossPositivo =9;
input double StopGainPositivo = 9;
input double StopLossNegativo = 9;
input double StopGainNegativo = 9;

input int HoraDeInicio = 9;
input int MinutoDeInicio = 0;

       
string HorarioInicio = IntegerToString(HoraDeInicio,2,'0') + ":" + IntegerToString(MinutoDeInicio,2,'0');



input ENUM_TIMEFRAMES TimeFrame = PERIOD_M30;


double ValorStopLoss = 0;
double ValorStopGain = 0;

bool     JaPegouHistorico = false;
double   MinReferencia;
double   MaxReferencia;
bool     PosicaoAberta = false;
bool     JaZerou = false;
bool     JaDeuFinal = false;

double PrecoOperacao = 0;
ENUM_ORDER_TYPE TipoOp = 0;
double MaxPrimeiraHora = 0;
double MinPrimeiraHora = 0;
double MinOuMax = 0;
string ResumoNeg;
string ResumoPos;
int    Operacoes = 0;
string Resumo = "";

bool JaFez = false;



/////////////// Inicio do Dia
void InicioDoDia ()
{

      if(JaZerou==false && TaDentroDoHorario("09:00","09:00")==true )
              {
              JaZerou = true;
              JaPegouHistorico = false;
              PosicaoAberta = false;
              JaDeuFinal = false;
              JaFez = false;
              
              
               PrecoOperacao = 0;
               TipoOp = 0;
               MaxPrimeiraHora = 0;
               MinPrimeiraHora = 0;
               MinOuMax = 0;
               MinReferencia = 0;
               MaxReferencia = 0;
               Resumo = "";
               
               ValorStopGain = 0;
               ValorStopLoss = 0;
               
              
              Print("Bom dia! Vamos fazer um dinheiro!!!");
              SendMail("Bender Ativando","Acorrrrrrrda! Vamos fazer um dinheiro!");
              SendNotification("Bom dia Sr.! Bender acordado e funcionando!");
              
              Print("String Preenchida: ",HorarioInicio);



              }
       }

///////////////////////////////////////////////////


////////////////////////////


//////////////////////// DAOTICK ///////////€
////// Função Pega Tick e devolve a hora e o valor da porra do ativo
string daotick (string entradadaotick)
{

string daotickHora;
string daotickPreco;
string retornoTick;

   MqlTick last_tick;
   
if(SymbolInfoTick(_Symbol,last_tick))
     {
     // Print(last_tick.time,": Bid = ",last_tick.bid,
          //  " Ask = ",last_tick.ask,"  Volume = ",last_tick.volume); //total e completo
     }
     else Print("SymbolInfoTick() failed, error = ",GetLastError());
   
   daotickHora = TimeToString(last_tick.time);
   daotickPreco = DoubleToString(last_tick.last);

   if(entradadaotick=="hora") retornoTick = daotickHora;
   if(entradadaotick=="preco") retornoTick = daotickPreco;
     
     return(retornoTick);
    
}
   

////////////////// Fecha o PEGA O TICK

////////////////////  TaDentroDoHorario //////////////

   string DiaHoje;
   datetime Agora;

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

/////////////////////////////////////////////////////////////////////
///////////////////// Pega o Historico

void EntregaDados ()

{
if(TaDentroDoHorario(HorarioInicio,"17:30")==true && JaPegouHistorico==false)
   {
   
   Print("Entrega Dados");
   JaPegouHistorico = true;
   PosicaoAberta = false;
      

   MqlRates rates [];
   ArraySetAsSeries(rates,true);
   int copied=CopyRates(Symbol(),TimeFrame,0,100,rates);

   MaxReferencia = rates[0].high;
   MinReferencia = rates[0].low;
   
   Print("Max: ",rates[0].high," | Min: ",rates[0].low);
   
   long cid=ChartID();
   
   ResetLastError();
   if(!ObjectCreate(cid,"Maxima",OBJ_HLINE,0,0,rates[0].high) || GetLastError()!=0)
      Print("Error creating object: ",GetLastError());
   else
      ChartRedraw(cid);
   
      if(!ObjectCreate(cid,"Minima",OBJ_HLINE,0,0,rates[0].low) || GetLastError()!=0)
      Print("Error creating object: ",GetLastError());
   else
      ChartRedraw(cid);
  
   
   /*
   
   if(copied>0)
         {
          Print("Bars copied:"+copied);
          string format="open=%G, high=%G, low=%G, close=%G, volume=%d";
          string out;
          //-- We will print only the 10 first point (or less)
          int size=fmin(copied,1);
          for(int i=0;i<size;i++)
                {
                 out=i+":"+TimeToString(rates[i].time);
                 out=out+" "+StringFormat(format,
                                rates[i].open,
                                rates[i].high,
                                rates[i].low,
                                rates[i].close,
                                rates[i].tick_volume);
                 Print(out);
                }
         }
   else Print("Failed to get history data for the symbol",Symbol());
*/
//+------------------------------------------------------------------+
      
    }  //FIM DO IF TaDentroDoHorario 
   }   
   
   
   /////////////////////////////PEga Historico
   
   
   
   
   //////// Abre Posicao Positiva
void PosicaoPositiva ()
{   

if(TaDentroDoHorario(HorarioInicio,"17:30")==true && StringToDouble(daotick("preco")) > MaxReferencia && Operacoes ==0 && JaPegouHistorico==true && JaFez == false)
   {
            JaFez = true;
            PosicaoAberta = true;
            PrecoOperacao = StringToDouble(daotick("preco"));
            Operacoes = Operacoes +1;

            TipoOp = ORDER_TYPE_BUY;
            MontarRequisicao();
            
            ValorStopLoss = StringToDouble(daotick("preco"))-StopLossPositivo;
            ValorStopGain = StringToDouble(daotick("preco"))+StopGainPositivo;
            
            Print("Stops SL: ",ValorStopLoss," SG: ",ValorStopGain);
            
            ResumoPos = "Compra - Modo positivo - Hora da Compra: "+daotick("hora")+" | Preco Compra: "+daotick("preco")+" | StopLoss: "+DoubleToString(ValorStopLoss)+" | StopGain: "+DoubleToString(ValorStopGain);
            Resumo = ResumoPos;
            Print(ResumoPos);
            
            SendMail("Bender Modo Positivo",ResumoPos);
         
    }
   }



//////////////////////

//////// Abre Posicao Negativa

void PosicaoNegativa ()
{


if(TaDentroDoHorario(HorarioInicio,"17:30")==true && StringToDouble(daotick("preco")) < MinReferencia && Operacoes ==0 && JaPegouHistorico==true && JaFez == false)
      {
            JaFez = true;
            PosicaoAberta = true;

            Operacoes = Operacoes -1; 
            TipoOp = ORDER_TYPE_SELL;
            MontarRequisicao();             
            
            ValorStopLoss = StringToDouble(daotick("preco"))+StopLossNegativo;
            ValorStopGain = StringToDouble(daotick("preco"))-StopGainNegativo; 
            Print("Stops SL: ",ValorStopLoss," SG: ",ValorStopGain);          
            
            PrecoOperacao = StringToDouble(daotick("preco"));
            Print("Preço Operacao: ",PrecoOperacao);
            ResumoNeg = "Venda - Modo Negativo - Hora da Venda: "+daotick("hora")+" | Preco Venda: "+daotick("preco")+" | StopLoss: "+DoubleToString(ValorStopLoss)+" | StopGain: "+DoubleToString(ValorStopGain);
            Resumo = ResumoNeg;
            Print(ResumoNeg);    
            SendMail("Bender Modo Negativo",ResumoNeg);     

         }
   }
  

void MontarRequisicao ()
   {
   

         MqlTradeRequest Req;     
         MqlTradeResult Res;     
         ZeroMemory(Req);     
         ZeroMemory(Res);     
         Req.symbol       = Symbol();
         Req.volume       = Lotes;
         Req.type_filling = ORDER_FILLING_RETURN;                 
         Req.action=TRADE_ACTION_DEAL; 
         Req.type=TipoOp; 
         Req.comment="Ordem do Bender";     
         Req.tp=0;
         Req.sl=0;
         
         

   if(OrderSend(Req,Res)) Print("Ordem Enviada com Sucesso"); else Print("Deu Pau, Verifique com pressão");
   
   
   }
   
   
//////////////////////////////////
//////////////////////////////////

////////////////////// STOPS
void StopLoss ()
{


   if(TaDentroDoHorario(HorarioInicio,"17:30")==true && Operacoes >0 && ValorStopLoss!=0 && StringToDouble(daotick("preco"))< ValorStopLoss && PosicaoAberta==true)
         {
         PosicaoAberta = false;
         Operacoes = Operacoes -1;
         TipoOp = ORDER_TYPE_SELL;
         MontarRequisicao();
         Print("Bender Stop Loss Ativado: ",ValorStopLoss); 

         }
      
   if(TaDentroDoHorario(HorarioInicio,"17:30")==true && Operacoes <0 && ValorStopLoss!=0 && StringToDouble(daotick("preco"))> ValorStopLoss && PosicaoAberta==true)
         {
         PosicaoAberta = false;
         Operacoes = Operacoes +1;           
         TipoOp = ORDER_TYPE_BUY;
         MontarRequisicao();
         Print("Bender Stop Loss Ativado: ",ValorStopLoss); 
        

         }      
      
}


void StopGain ()
{


   if(TaDentroDoHorario(HorarioInicio,"17:30")==true && Operacoes >0 && ValorStopGain!=0 && StringToDouble(daotick("preco"))> ValorStopGain && PosicaoAberta==true)
         {
         PosicaoAberta = false;
         Operacoes = Operacoes -1;
         TipoOp = ORDER_TYPE_SELL;
         MontarRequisicao();     
         
         Print("Bender Stop Gain Ativado: ",ValorStopGain);       

         }
      
   if(TaDentroDoHorario(HorarioInicio,"17:30")==true && Operacoes <0 && ValorStopGain!=0 && StringToDouble(daotick("preco"))< ValorStopGain && PosicaoAberta==true)
         {
         PosicaoAberta = false;
         Operacoes = Operacoes +1;           
         TipoOp = ORDER_TYPE_BUY;
         MontarRequisicao();
         
         Print("Bender Stop Gain Ativado: ",ValorStopGain);  
                  
         }      
      
}

////////////////////////////// fIM DOS STOPS