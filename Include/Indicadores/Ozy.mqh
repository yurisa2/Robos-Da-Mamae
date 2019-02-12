/* -*- C++ -*- */
#property copyright "PetroSa, Robï¿½s feitos na hora, quentinhos, tragam vasilhas."
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

bool Calcula_Ozy ()
{
  if(Direcao!=Ozy(0))
  {
    //Print("Mudou Hein");

    return true;

    // if(Direcao==1 && Ordem==false)
    // {
    //   Print("Operaï¿½ï¿½es Antes da venda: ",Operacoes," VENDE! ");
    //   //Print("Periodo: ",ChartPeriod()," Estranho", PeriodSeconds());
    //   return true;
    //   Ordem = true;
    // }
    //
    // if(Direcao==-1 && Ordem==false)
    // {
    //   Print("Operaï¿½ï¿½es Antes da compra: ",Operacoes," COMPRA! ");
    //   return true;
    //   Ordem = true;
    // }
  }
  Direcao = Ozy(0);
  return false;
}

void Ozy_Opera ()
{

  if(TaDentroDoHorario_RT==true && JaZerou)
  {

    if(Direcao!=Ozy(0))
    {
      //Print("Mudou Hein");
      DeuStopLoss = false;
      DeuTakeProfit = false;
      Ordem = false;

      if(Direcao==1 && Ordem==false)
      {
        Print("Operaï¿½ï¿½es Antes da venda: ",Operacoes," VENDE! ");
        //Print("Periodo: ",ChartPeriod()," Estranho", PeriodSeconds());
        VendaIndicador("Venda por Ozy","Entrada");
        Ordem = true;
      }

      if(Direcao==-1 && Ordem==false)
      {
        Print("Operaï¿½ï¿½es Antes da compra: ",Operacoes," COMPRA! ");
        CompraIndicador("Compra por Ozy","Entrada");
        Ordem = true;
      }
    }
    Direcao = Ozy(0);

  }   //FIM DO IF TaDentroDoHorario
}

bool Zerado_Ozy ()   //Se o switch estiver FALSE e a soma for maior que 0 ele dï¿½ false
{

  int soma_params = Ozy_Shift + Ozy_length;

  if(soma_params > 0) return true; else return false ;


}
