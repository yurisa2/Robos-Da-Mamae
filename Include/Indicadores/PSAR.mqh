/* -*- C++ -*- */
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

///////////////////VALORES DO PSAR
bool CalculaPSar ()
{
  int DirecaoPsar0 = 0;
  int DirecaoPsar1 = 0;

  double PSar_Array[];
  ArraySetAsSeries(PSar_Array, true);
  int copiedPSar=CopyBuffer(HandlePSar,0,0,100,PSar_Array);

  //--- Dá uns prints só pra ver //--- Print("Valor do PSAR: ",PSar_Array[0]," Preço: ",daotick());
  if(PSar_Array[0] >daotick())     DirecaoPsar0 = -1;
  if(PSar_Array[0] <daotick())     DirecaoPsar0 = 1;
  if(PSar_Array[1] >daotick())     DirecaoPsar1 = -1;
  if(PSar_Array[1] <daotick())     DirecaoPsar1 = 1;

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
  if(TaDentroDoHorario(HorarioInicio,HorarioFim)==true && JaZerou)
  {
    if(CalculaPSar())
    {
      //Print("Mudou Hein");
      DeuStopLoss = false;
      DeuTakeProfit = false;
      Ordem = false;

      if(Direcao==1 && Ordem==false)
      {
        Print("Operações Antes da venda: ",Operacoes," VENDE! ");
        VendaIndicador("Venda por Inversão de PSAR","Entrada");
        Ordem = true;
      }
      if(Direcao==-1 && Ordem==false)
      {
        Print("Operações Antes da compra: ",Operacoes," COMPRA! ");
        CompraIndicador("Compra por Inversão de PSAR","Entrada");
        Ordem = true;
      }
    }
    CalculaPSar();
  }   //FIM DO IF TaDentroDoHorario
}

bool Zerado_PSAR ()   //Se o switch estiver FALSE e a soma for maior que 0 ele dá false  // FUNCAO PARA VERIFICACAO DE INIT
{

  double soma_params = PSAR_Step + PSAR_Max_Step;
  if(soma_params > 0) return true; else return false ;


}
