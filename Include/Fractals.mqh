#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"
//////////////////Calcula Fractals

int EstadoFractal = 0;

void CalculaFractal ()
{

   double _Fractal1[];
   double _Fractal2[];

   ArraySetAsSeries(_Fractal1, true);
   ArraySetAsSeries(_Fractal2, true);

   int copied=CopyBuffer(HandleFrac,0,0,100,_Fractal1);
   int copied2=CopyBuffer(HandleFrac,1,0,100,_Fractal2);


for(int x=0;x<Frac_Candles_Espera;x++)
       {
           double A1 = _Fractal1[x];
           
           if (A1!=EMPTY_VALUE) 
           {
           Print("Venda ["+IntegerToString(x)+"] = " + DoubleToString(A1));
           EstadoFractal = 1;
           }
            //else Print("A1 ["+IntegerToString(x)+"] = EMPTY_VALUE");
       }

for(int x=0;x<Frac_Candles_Espera;x++)
       {
           double A1 = _Fractal2[x];
           if (A1!=EMPTY_VALUE) 
           {
           Print("Compra ["+IntegerToString(x)+"] = " + DoubleToString(A1));
           EstadoFractal = -1;          
           }
           
            //else Print("A1 ["+IntegerToString(x)+"] = EMPTY_VALUE");
       }

                    if(Mudanca!=EstadoFractal) 
                    {
                    //Print("Mudou Hein");
                    DeuStopLoss = false;
                    DeuTakeProfit = false;                   
                    Ordem = false; 
                    }



}

//////////////////////


void Fractal ()
{
if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true)
   {
   double _Fractal1[];
   double _Fractal2[];

   ArraySetAsSeries(_Fractal1, true);
   ArraySetAsSeries(_Fractal2, true);

   int copied=CopyBuffer(HandleFrac,0,0,100,_Fractal1);
   int copied2=CopyBuffer(HandleFrac,1,0,100,_Fractal2);

for(int x=0;x<Frac_Candles_Espera;x++)
       {
           double A1 = _Fractal1[x];
           
           if (A1!=EMPTY_VALUE) 
           {
           //Print("Venda ["+IntegerToString(x)+"] = " + DoubleToString(A1));
           EstadoFractal = 1;
           }
            //else Print("A1 ["+IntegerToString(x)+"] = EMPTY_VALUE");
       }

for(int x=0;x<Frac_Candles_Espera;x++)
       {
           double A1 = _Fractal2[x];
           if (A1!=EMPTY_VALUE) 
           {
           //Print("Compra ["+IntegerToString(x)+"] = " + DoubleToString(A1));
           EstadoFractal = -1;          
           }
           
            //else Print("A1 ["+IntegerToString(x)+"] = EMPTY_VALUE");
       }

                    if(Mudanca!=EstadoFractal) 
                    {
                    //Print("Mudou Hein | Estado Fractal: ",EstadoFractal);
                    DeuStopLoss = false;
                    DeuTakeProfit = false;                   
                    Ordem = false;
                      
                      
                    if(Mudanca==-1 && Ordem==false)
                    {
                    Print("Operações Antes da venda: ",Operacoes," VENDE! ");
                    //Print("Periodo: ",ChartPeriod()," Estranho", PeriodSeconds());
                    VendaIndicador("Venda por Fractal");
                    Ordem = true;
                    }
                    
                    if(Mudanca==1 && Ordem==false) 
                    {
                    Print("Operações Antes da compra: ",Operacoes," COMPRA! ");
                    CompraIndicador("Compra por Fractal");
                    Ordem = true;
                    }
                    
                    }
                    
                       Mudanca =EstadoFractal;


   }   //FIM DO IF TaDentroDoHorario
}

//////////////////////
