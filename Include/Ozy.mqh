#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

int retorno_ozy = 0;

double Ozy (int candle)
{


double Ozy_0[];
double Ozy_1[];


ArraySetAsSeries(Ozy_0,true);
ArraySetAsSeries(Ozy_1,true);


int copiaOzy_0 = CopyBuffer(HandleOzy,0,0,3,Ozy_0);
int copiaOzy_1 = CopyBuffer(HandleOzy,1,0,3,Ozy_1);


if(Ozy_0[0] > Ozy_0[1]) retorno_ozy = 1;
if(Ozy_0[0] < Ozy_0[1]) retorno_ozy = -1;



//Print("Ozy ZERO: ",Ozy_0[0]);
//Print("Ozy HUM: ",Ozy_1[0]);

//return Ozy_1[candle];

return retorno_ozy;
}

void Ozy_Opera ()
{

if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true)
   {
   
                    if(Mudanca!=Ozy(0)) 
                    {
                    //Print("Mudou Hein");
                    DeuStopLoss = false;
                    DeuTakeProfit = false;                   
                    Ordem = false;

                    if(Mudanca==1 && Ordem==false)
                    {
                    Print("Operações Antes da venda: ",Operacoes," VENDE! ");
                    //Print("Periodo: ",ChartPeriod()," Estranho", PeriodSeconds());
                    VendaIndicador("Venda por Ozy");
                    Ordem = true;
                    }
                    
                    if(Mudanca==-1 && Ordem==false) 
                    {
                    Print("Operações Antes da compra: ",Operacoes," COMPRA! ");
                    CompraIndicador("Compra por Ozy");
                    Ordem = true;
                    }
                    }
   Mudanca = Ozy(0);
   Mudou = 0;

   }   //FIM DO IF TaDentroDoHorario
} 