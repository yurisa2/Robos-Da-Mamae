#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

// Petrokas veio com umas de ordem start, comparando com o Duran, Abandonando projeto.

int HandleHiLoMediaAlta = iMA(NULL,TimeFrame,Periodos,0,MODE_SMA,PRICE_HIGH);
int HandleHiLoMediaBaixa = iMA(NULL,TimeFrame,Periodos,0,MODE_SMA,PRICE_LOW);

double RetornaTendencia = 0;

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

if(rates[0].close > MediaAlta[0])
  {
   RetornaTendencia = 1;
   //Print("Tendencia Compra");
  }
if(rates[0].close < MediaBaixa[0])
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

