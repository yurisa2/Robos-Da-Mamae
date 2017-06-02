/* -*- C++ -*- */
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

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

bool CalculaHiLo ()
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

  if(Direcao!=_ma1[0])
  {
    //Print("Mudou Hein");
    return true;
  }

  Direcao = _ma1[0];
  return false;
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

    if(_ma1[1]!=_ma1[2])
    {
      //Print("Mudou Hein");
      DeuStopLoss = false;
      DeuTakeProfit = false;
      Ordem = false;

      if(Direcao==1 && Ordem==false)
      {
        Print("Operações Antes da venda: ",Operacoes," VENDE! ");
        //Print("Periodo: ",ChartPeriod()," Estranho", PeriodSeconds());
        VendaIndicador("Venda por HiLo","Entrada");
        Ordem = true;
      }

      if(Direcao==-1 && Ordem==false)
      {
        Print("Operações Antes da compra: ",Operacoes," COMPRA! ");
        CompraIndicador("Compra por HiLo","Entrada");
        Ordem = true;
      }
    }

    Direcao = _ma1[0];

  }   //FIM DO IF TaDentroDoHorario
}

//////////////////////////////////////////////////////

bool Zerado_HiLo ()   //Se o switch estiver FALSE e a soma for maior que 0 ele dá false
{
  if(Periodos > 0) return true; else return false ;
}
