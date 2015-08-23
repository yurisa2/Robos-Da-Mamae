//+------------------------------------------------------------------+
//|                                                     BenderV2.mq5 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"
#property version   "1.22"

#include <funcoesbender.mqh>


////////////////////// INPUTS
input int Lotes =1;
input bool ModoPositivo = true;
input double StopLossPositivo =9;
input double StopGainPositivo = 9;
input bool ModoNegativo = true;
input double StopLossNegativo = 9;
input double StopGainNegativo = 9;




//////////////////////////////


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   iniciaconexao();
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
  
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
/* Estrutura de TESTE 
bool jafez = false;
string data;
string valor;
void OnTick()
  {
 if(jafez==false)
     {
      Print(daotick("hora"));
      jafez=true;
     }

   
  }
  
  */
  
  void OnTick()
  {
  ///////////////// Zera Variaveis do Dia
  if(JaZerou==false)
    {
  if(TaDentroDoHorario("09:00","09:01")==true)
  {
  
  //Print(MaxPrecoAte930);
  Print("Novo Dia - ", TimeToString(TimeCurrent(),TIME_DATE));
  SendNotification("Novo Dia - Zerando Variáveis");
   MinPrecoAte930 = 10000;
   PrecoVenda = 0;
   JaComprouNeg = false;
   JaVendeuNeg = false;
   QualUsar = 0;
   JaEscolhido = false;
   MaxPrecoAte930 = 0;
   PrecoCompra = 0;
   JaComprou = false;
   JaVendeu = false;
   JaZerou = true;
   VlrCompraPos = 0;
   VlrVendaPos = 0;
   VlrVendaNeg = 0;
   VlrCompraNeg = 0;
   JaDeuSaldo = false;

  } //FIM DO IF TaDentroDoHorario
  
    } // Fim do IF JA ZEROU
  
  /////////////////////////////////////////
  
  
  
//  Print("Tick = ",daotick("preco"));
  
///////////// GATHERING DE DADOS /////////////
if(TaDentroDoHorario("09:02","09:27")==true)
   {
      if(MaxPrecoAte930<StringToDouble(daotick("preco"))) MaxPrecoAte930=StringToDouble(daotick("preco")); //Pega Preço POSITIVO
      if(MinPrecoAte930>StringToDouble(daotick("preco"))) MinPrecoAte930=StringToDouble(daotick("preco")); //Pega Preço NEGATIVO
   //   Print("Valor Minimo Atingido para venda: ",MinPrecoAte930,"  -- Valor do TICK: ",StringToDouble(daotick("preco")));  

   }   //FIM DO IF TaDentroDoHorario
   

//////////////////////////////////////////////

//////////////////////// Decisão De qual usar ___ REFAZER POIS ISSO AQUI ESTA ERRADO E SO FALTA ISSO
if(JaEscolhido==false)
  {
if(TaDentroDoHorario("09:30","09:31")==true)
   {
   if(ModoPositivo==1)
     {
     if(MaxPrecoAte930<StringToDouble(daotick("preco")))
     {
     QualUsar = 1;
     JaEscolhido = true;
  //   Print("Escolheu o Positivo - preco atual: ",StringToDouble(daotick("preco"))," Preco Min930: ",MaxPrecoAte930," - Ja Escolhido = ",JaEscolhido);
     SendNotification("Modo POSITIVO Escolhido");
     }
     }
   if(ModoNegativo==1)
     {
     if(MinPrecoAte930>StringToDouble(daotick("preco")))
     {
     QualUsar = 2;
     JaEscolhido = true;
 //    Print("Escolheu o negativo - preco atual: ",StringToDouble(daotick("preco"))," Preco Min930: ",MinPrecoAte930);
     SendNotification("Modo NEGATIVO Escolhido");
     }
     }
   }
   } //Fim do If Ja Escolhido

/////////////////////////////////////////////

//////////// ROTINA DO DIA POSITIVO //////////////

if(QualUsar==1)
  {
if(TaDentroDoHorario("09:30","09:31")==true)
   {
   Print("Tick Last: ",daotick("preco"));
     if(MaxPrecoAte930<=StringToDouble(daotick("preco")))
     {
     Compra(Lotes,_Symbol,"ROMPIMENTO POSITIVO");
     SendNotification("COMRA - ROMPIMENTO POSITIVO");

     }
      
      if(StringToDouble(daotick("preco"))<=PrecoCompra-StopLossPositivo)
      {
      Venda(Lotes,_Symbol,"STOPLOSS - MODO POSITIVO");
      SendNotification("STOPLOSS - MODO POSITIVO");
      }
      
      
      if(StringToDouble(daotick("preco"))>=PrecoCompra+StopGainPositivo)
      {
      Venda(Lotes,_Symbol,"STOPGAIN - MODO POSITIVO");
      SendNotification("STOPGAIN - MODO POSITIVO");
      }
      
   }   
   }


/////////////////////////////////////////


//////////// Finaliza o Dia (Zerar Posição) ///////////////

if(TaDentroDoHorario("17:31","17:35")==true)

{

Venda(Lotes,_Symbol,"FIM DO DIA - Modo Positivo");     
SendNotification("Zerou Posição NO FIM DO DIA - Modo POSITIVO");
//VlrVendaPos = StringToDouble(daotick("preco"));

}



///////////////////////////////////////////////////////////

/* ////////////////////////////////////////////////////////////////

         BENDER NEGATIVO

/////////////////////////////////////////////////////////////////*/


   
   
   
   //////////// ROTINA DO DIA NEGATIVO //////////////


  if(QualUsar==2)
  {
if(TaDentroDoHorario("09:30","09:31")==true)
   {
     if(MinPrecoAte930>=StringToDouble(daotick("preco")))
     {
     VendaNeg(Lotes,_Symbol,"VENDA - ROMPIMENTO NEGATIVO");
//     VlrVendaNeg = StringToDouble(daotick("preco")) ;
     SendNotification("VENDA - ROMPIMENTO NEGATIVO");

     }
      
      if(StringToDouble(daotick("preco"))>=PrecoVenda+StopLossNegativo)
      {
      CompraNeg(Lotes,_Symbol,"STOPLOSS - MODO NEGATIVO");
      SendNotification("COMPRA - STOPLOSS - MODO NEGATIVO");
      }
      
      
      if(StringToDouble(daotick("preco"))<=PrecoVenda-StopGainNegativo)
      {
      CompraNeg(Lotes,_Symbol,"STOPGAIN - MODO NEGATIVO");
      SendNotification("COMPRA - STOPGAIN - MODO NEGATIVO");
      }
      
      
   } // Fim do IF Ta Dentro Do Horario


/////////////////////////////////////////


//////////// Finaliza o Dia (Zerar Posição) ///////////////



if(TaDentroDoHorario("17:31","17:35")==true)

   {

CompraNeg(Lotes,_Symbol,"FIM DO DIA - Modo Negativo");
//VlrCompraNeg = StringToDouble(daotick("preco"));

SendNotification("Zerou Posição NO FIM DO DIA - Modo NEGATIVO");


   }
   
 } // FIM DO IF QUAL USAR

///////////////////////////////////////////////////////////
   
////////////////////// ROTINA DO FIM DO DIA   GERAL

if(JaDeuSaldo==false)
  {
  
   if(TaDentroDoHorario("17:36","17:40")==true)
   {
      JaZerou = false;
      {
      if(JaEscolhido==true)
         {
         if(QualUsar==1)
           {
           // Print("Saldo do Dia: ",VlrCompraPos-VlrVendaPos);   // Estudar como fazer um saldo verbose
           //Print("PrecoCompra: ",PrecoCompra);
           //Print("VlrVendaPos: ",VlrVendaPos);
           //Print("Final do dia de negociaçao, MODO POSITIVO Saldo: ",VlrVendaPos-PrecoCompra);
            
            
           Print("Final do dia, MODO POSITIVO | Hora da Compra: " ,HoraCompraPos," | Preço Compra: ", PrecoCompra," | Hora da Venda: ", HoraVendaPos," | Preco Venda: ", VlrVendaPos," | Motivo Encerramento: ",MotivoEncerramento);  
           JaDeuSaldo = true;
           }
         
         if(QualUsar==2)
           {
          //  Print("Saldo do Dia: ",VlrVendaNeg-VlrCompraPos);   // Estudar como fazer um saldo verbose
           Print("Final do dia, MODO NEGATIVO | Hora da Venda: ", HoraVendaNeg," | Preco Venda: ", VlrVendaNeg," | Hora da Compra: " ,HoraCompraNeg," | Preço Compra: ", VlrCompraNeg," | Motivo Encerramento: ",MotivoEncerramento);  
           //Print("Marco",QualUsar);
           JaDeuSaldo = true;
           }
           if(QualUsar==0)
           Print("Nada Rolou");
           
           
       }  // FIM DO IF JA ESCOLHIDO
   
         } // FIM DO IF JA ZEROU

   }  // FIM DO IF TADENTRO DO HORARIO
                
  } // FIM DO IF JA DEU SALDO
   
      
     
      
      
   }   // FIM DO OnTICK()
////////////////////////////////////////////   
 
//+------------------------------------------------------------------+
