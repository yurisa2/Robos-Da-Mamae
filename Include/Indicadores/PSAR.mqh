#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

///////////////////VALORES DO PSAR
bool CalculaPSar ()
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
    return true;
  }

  //   Print("Operacoes: ",Operacoes);
  Mudanca = CondicaoPsar;
  return false;
}

void PSar ()
{
  if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && JaZerou)
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
        VendaIndicador("Venda por Inversão de PSAR","Entrada");
        Ordem = true;
      }

      if(Mudanca==-1 && Ordem==false)
      {
        Print("Operações Antes da compra: ",Operacoes," COMPRA! ");
        CompraIndicador("Compra por Inversão de PSAR","Entrada");
        Ordem = true;
      }

    }
    Mudanca = CondicaoPsar;

  }   //FIM DO IF TaDentroDoHorario

}

bool Zerado_PSAR ()   //Se o switch estiver FALSE e a soma for maior que 0 ele dá false
{

  double soma_params = PSAR_Step + PSAR_Max_Step;
  if(soma_params > 0) return true; else return false ;


}
