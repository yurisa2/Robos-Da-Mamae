/* -*- C++ -*- */
#property copyright "PetroSa, Robï¿½s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

///////////////////VALORES DO PSAR
bool CalculaPSar ()
{
  int DirecaoPsar0 = 0;
  int DirecaoPsar1 = 0;

  double PSar_Array[];
  ArraySetAsSeries(PSar_Array, true);
  int copiedPSar=CopyBuffer(HandlePSar,0,0,100,PSar_Array);

  //--- Dï¿½ uns prints sï¿½ pra ver //--- Print("Valor do PSAR: ",PSar_Array[0]," Preï¿½o: ",daotick_geral);
  if(PSar_Array[0] > daotick_venda)       DirecaoPsar0 = -1;
  if(PSar_Array[0] < daotick(1))        DirecaoPsar0 = 1;
  if(PSar_Array[1] > daotick_venda)       DirecaoPsar1 = -1;
  if(PSar_Array[1] < daotick(1))        DirecaoPsar1 = 1;

  if(DirecaoPsar0!=DirecaoPsar1)
  {
    //Print("Mudou Hein");
    return true;
  }
  //   Print("Operacoes: ",Operacoes);
  Direcao = DirecaoPsar0;
  return false;
}

void PSar ()
{
  if(TaDentroDoHorario_RT==true && JaZerou)
  {
    if(CalculaPSar())
    {
      //Print("Mudou Hein");
      DeuStopLoss = false;
      DeuTakeProfit = false;
      Ordem = false;

      if(Direcao==1 && Ordem==false)
      {
        Print("Operaï¿½ï¿½es Antes da venda: ",Operacoes," VENDE! ");
        VendaIndicador("Venda por Inversï¿½o de PSAR","Entrada");
        Ordem = true;
      }
      if(Direcao==-1 && Ordem==false)
      {
        Print("Operaï¿½ï¿½es Antes da compra: ",Operacoes," COMPRA! ");
        CompraIndicador("Compra por Inversï¿½o de PSAR","Entrada");
        Ordem = true;
      }
    }
    CalculaPSar();
  }   //FIM DO IF TaDentroDoHorario
}

bool Zerado_PSAR ()   //Se o switch estiver FALSE e a soma for maior que 0 ele dï¿½ false  // FUNCAO PARA VERIFICACAO DE INIT
{

  double soma_params = PSAR_Step + PSAR_Max_Step;
  if(soma_params > 0) return true; else return false ;


}
