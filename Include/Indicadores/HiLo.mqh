#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

// Petrokas veio com umas de ordem start, comparando com o Duran, Abandonando projeto.

void Inicializa_HiLo ()
{


   //HandleHiLoMediaAlta = iMA(NULL,TimeFrame,Periodos,0,MODE_SMA,PRICE_HIGH);
   //HandleHiLoMediaBaixa = iMA(NULL,TimeFrame,Periodos,0,MODE_SMA,PRICE_LOW);
   HandleGHL = iCustom(NULL,TimeFrame,"gann_hi_lo_activator_ssl",Periodos,MODE_SMA);
   ChartIndicatorAdd(0,0,HandleGHL);
   
   if(HandleGHL== 0 )
     {
       ExpertRemove();
     }
}



/*
double DevolveHiLo ()
{

double MediaAlta[];
double MediaBaixa[];

ArraySetAsSeries(MediaAlta,true);
ArraySetAsSeries(MediaBaixa,true);

int copiaMediaAlta = CopyBuffer(HandleHiLoMediaAlta,0,0,3,MediaAlta);
int copiaMediaBaixa = CopyBuffer(HandleHiLoMediaBaixa,0,0,3,MediaBaixa);

   MqlRates rates[]; 
   ArraySetAsSeries(rates,true);
   int copied=CopyRates(NULL,0,0,2,rates);

if(rates[0].close > MediaAlta[1])
  {
   RetornaTendencia = 1;
   //Print("Tendencia Compra");
  }
if(rates[0].close < MediaBaixa[1])
  {
   RetornaTendencia = -1;
   //Print("Tendencia Venda");
  }

return RetornaTendencia;

}


////////////////////////////////////////////////////////////  TESTE DO HILO NOVO


void CalculaHiLo ()
{
if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true)
   {
   
   

                    if(Mudanca!=DevolveHiLo()) 
                    {
                    //Print("Mudou Hein");
                    DeuStopLoss = false;
                    DeuTakeProfit = false;                   
                    Ordem = false;
                    }
   Mudanca = DevolveHiLo();
   Mudou = 0;
   }   //FIM DO IF TaDentroDoHorario
}

void HiLo ()
{

if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true)
   {
   
   
                    
                    if(Mudanca!=DevolveHiLo()) 
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

   Mudanca = DevolveHiLo();
   Mudou = 0;

   }   //FIM DO IF TaDentroDoHorario

}
*/



//HILO DE TERCEIROS


void CalculaHiLo ()
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
                    }
   Mudanca = _ma1[0];
   Mudou = 0;
}

void HiLo ()
{

if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && JaZerou)
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
                    VendaIndicador("Venda por HiLo","Entrada");
                    Ordem = true;
                    }
                    
                    if(Mudanca==-1 && Ordem==false) 
                    {
                    Print("Operações Antes da compra: ",Operacoes," COMPRA! ");
                    CompraIndicador("Compra por HiLo","Entrada");
                    Ordem = true;
                    }
                    }

   Mudanca = _ma1[0];
   Mudou = 0;

   }   //FIM DO IF TaDentroDoHorario

}


//////////////////////////////////////////////////////

bool Zerado_HiLo ()   //Se o switch estiver FALSE e a soma for maior que 0 ele dá false
{

if(Frac_Candles_Espera > 0) return false; else return true;


}