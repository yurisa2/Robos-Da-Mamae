#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

void Inicializa_BSI ()
{
  HandleBSI = iCustom(NULL,TimeFrame,"bsi",BSI_RangePeriod,BSI_Slowing,BSI_Avg_Period);
  // ChartIndicatorAdd(0,1,HandleBSI);

  if(HandleBSI== 0 )
  {
    ExpertRemove();
  }
}

bool CalculaBSI ()
{

  double BSI[];

  ArraySetAsSeries(BSI, true);

  int copied=CopyBuffer(HandleBSI,3,0,100,BSI);

  if(BSI[0] == 2) CondicaoBSI = 1;
  if(BSI[0] == 0) CondicaoBSI = -1;

  if(Direcao!=CondicaoBSI)
  {
    //Print("Mudou Hein");
    return true;
  }
  Direcao = CondicaoBSI;
  return false;
}

void BSI ()
{

  if(TaDentroDoHorario_RT==true && JaZerou)
  {

    double BSI[];

    ArraySetAsSeries(BSI, true);
    int copied=CopyBuffer(HandleBSI,3,0,100,BSI);

    if(BSI[0] == 2) CondicaoBSI = 1;
    if(BSI[0] == 0) CondicaoBSI = -1;

    if(Direcao!=CondicaoBSI)
    {
      //Print("Mudou Hein");
      DeuStopLoss = false;
      DeuTakeProfit = false;
      Ordem = false;


      if(Direcao==1 && Ordem==false)
      {
        Print("Opera��es Antes da venda: ",Operacoes," VENDE! ");
        //Print("Periodo: ",ChartPeriod()," Estranho", PeriodSeconds());
        VendaIndicador("Venda por BSI","Entrada");
        Ordem = true;
      }

      if(Direcao==-1 && Ordem==false)
      {
        Print("Opera��es Antes da compra: ",Operacoes," COMPRA! ");
        CompraIndicador("Compra por BSI","Entrada");
        Ordem = true;
      }
    }

    Direcao = CondicaoBSI;

  }   //FIM DO IF TaDentroDoHorario
}
//////////////////////////////////////////////////////

bool Zerado_BSI ()   //Se o switch estiver FALSE e a soma for maior que 0 ele d� false
{

  int soma_params = BSI_RangePeriod + BSI_Slowing + BSI_Avg_Period;

  if(soma_params > 0) return true; else return false ;


}
