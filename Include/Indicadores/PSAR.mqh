﻿/* -*- C++ -*- */

#property copyright "PetroSa, Robï¿½s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

int CondicaoPsar = 0; //TEMP

///////////////////VALORES DO PSAR
bool CalculaPSar ()
{
  double PSar_Array[];
  ArraySetAsSeries(PSar_Array, true);
  int copiedPSar=CopyBuffer(HandlePSar,0,0,100,PSar_Array);

  //--- Dï¿½ uns prints sï¿½ pra ver //--- Print("Valor do PSAR: ",PSar_Array[0]," Preï¿½o: ",daotick_geral);
  if(PSar_Array[0] > daotick_venda)     CondicaoPsar = -1;
  if(PSar_Array[0] < daotick(1))     CondicaoPsar = 1;

  if(Direcao!=CondicaoPsar)
  {
    //Print("Mudou Hein");
    return true;
  }

  //   Print("Operacoes: ",Operacoes);
  Direcao = CondicaoPsar;
  return false;
}

void PSar ()
{
  if(TaDentroDoHorario_RT==true && JaZerou)
  {
    double PSar_Array[];
    ArraySetAsSeries(PSar_Array, true);
    int copiedPSar=CopyBuffer(HandlePSar,0,0,100,PSar_Array);

    //--- Dï¿½ uns prints sï¿½ pra ver //--- Print("Valor do PSAR: ",PSar_Array[0]," Preï¿½o: ",daotick_geral);
    if(PSar_Array[0] >daotick_geral)     CondicaoPsar = -1;
    if(PSar_Array[0] <daotick_geral)     CondicaoPsar = 1;

    if(Direcao!=CondicaoPsar)
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
    Direcao = CondicaoPsar;

  }   //FIM DO IF TaDentroDoHorario

}

bool Zerado_PSAR ()   //Se o switch estiver FALSE e a soma for maior que 0 ele dï¿½ false
{

  double soma_params = PSAR_Step + PSAR_Max_Step;
  if(soma_params > 0) return true; else return false ;


}
