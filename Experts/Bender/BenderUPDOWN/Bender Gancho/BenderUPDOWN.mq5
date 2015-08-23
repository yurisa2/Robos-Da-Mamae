//+------------------------------------------------------------------+
//|                                                     BenderV2.mq5 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <funcoesbender.mqh>


////////////////////// INPUTS
input double stoploss;
input double stopgain;
input int lotes;
input bool ModoPositivo;
input bool ModoNegativo;


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
  if(TaDentroDoHorario("08:55","09:00")==true)
  {
  
  //Print(MaxPrecoAte930);
  Print("Bom Dia, Hoje é um Novo Dia para lucrar!!!");
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
  }
  
    }
  
  /////////////////////////////////////////
  
  
  
  
  
///////////// GATHERING DE DADOS /////////////
if(TaDentroDoHorario("09:00","09:30")==true)
   {
      if(MaxPrecoAte930<StringToDouble(daotick("preco"))) MaxPrecoAte930=StringToDouble(daotick("preco")); //Pega Preço POSITIVO
      if(MinPrecoAte930>StringToDouble(daotick("preco"))) MinPrecoAte930=StringToDouble(daotick("preco")); //Pega Preço NEGATIVO
   //   Print("Valor Minimo Atingido para venda: ",MinPrecoAte930,"  -- Valor do TICK: ",StringToDouble(daotick("preco")));  
   }   
   

//////////////////////////////////////////////

//////////////////////// Decisão De qual usar ___ REFAZER POIS ISSO AQUI ESTA ERRADO E SO FALTA ISSO
if(JaEscolhido==false)
  {
if(TaDentroDoHorario("09:31","17:30")==true)
   {
   if(ModoPositivo==1)
     {
     if(MaxPrecoAte930<StringToDouble(daotick("preco")))
     {
     QualUsar = 1;
     JaEscolhido = true;
  //   Print("Escolheu o Positivo - preco atual: ",StringToDouble(daotick("preco"))," Preco Min930: ",MaxPrecoAte930," - Ja Escolhido = ",JaEscolhido);
     
     }
     }
   if(ModoNegativo==1)
     {
     if(MinPrecoAte930>StringToDouble(daotick("preco")))
     {
     QualUsar = 2;
     JaEscolhido = true;
 //    Print("Escolheu o negativo - preco atual: ",StringToDouble(daotick("preco"))," Preco Min930: ",MinPrecoAte930);
     }
     }
   }
   }
/////////////////////////////////////////////

//////////// ROTINA DO DIA POSITIVO //////////////

if(QualUsar==1)
  {
if(TaDentroDoHorario("09:31","17:30")==true)
   {
     if(MaxPrecoAte930<StringToDouble(daotick("preco")))
     {
     Compra(lotes,"WDO$N","COMPRA - ROMPIMENTO POSITIVO");
     VlrCompraPos = StringToDouble(daotick("preco"));
  
     }
      
      if(StringToDouble(daotick("preco"))<=PrecoCompra-stoploss)
      {
      Venda(lotes,"WDO$N","VENDA - STOPLOSS - MODO POSITIVO");
      VlrVendaPos = StringToDouble(daotick("preco"));
      }
      
      /*
      if(StringToDouble(daotick("preco"))>=PrecoCompra+stopgain)
      {
      Venda(lotes,"WDO$N","VENDA - STOPGAIN - MODO POSITIVO");
      VlrVendaPos = StringToDouble(daotick("preco"));
      }
      */
      
      /*
      if(GanchoPositivoVender(VlrVendaPos)==true)
      {
      Venda(lotes,"WDO$N","VENDA - STOPGAIN - MODO POSITIVO");
      VlrVendaPos = StringToDouble(daotick("preco"));
      }
      */
      
      
      ///////////////// GANCHO PARA VENDA
      if(JaComprou==true)
     {
      if(MaxValorGanchoPos<StringToDouble(daotick("preco"))) MaxValorGanchoPos=StringToDouble(daotick("preco")); //Pega Preço Max
    //Print("Tick: ",daotick("preco")," - Max: ",MaxValorGanchoPos);

         if(StringToDouble(daotick("preco"))<MaxValorGanchoPos-12)
         {
         
         Venda(lotes,"WDO$N","VENDA - GANCHO COM 3 - MODO POSITIVO");
      VlrVendaPos = StringToDouble(daotick("preco"));
      //   Print("Gancho Virou Valor do Tick: ",StringToDouble(daotick("preco"))," - Valor do Max: ",MaxValorGanchoPos);
         }
         
         }
   }


/////////////////////////////////////////


//////////// Finaliza o Dia (Zerar Posição) ///////////////

if(TaDentroDoHorario("17:31","17:35")==true)

{

Venda(lotes,"WDO$N","VENDA - FIM DO DIA - Modo Positivo");
VlrVendaPos = StringToDouble(daotick("preco"));



}

}

///////////////////////////////////////////////////////////

/* ////////////////////////////////////////////////////////////////

         BENDER NEGATIVO

/////////////////////////////////////////////////////////////////*/

  if(QualUsar==2)
  {
   
   
   
   //////////// ROTINA DO DIA //////////////



if(TaDentroDoHorario("09:31","17:30")==true)
   {
     if(MinPrecoAte930<StringToDouble(daotick("preco")))
     {
     VendaNeg(lotes,"WDO$N","VENDA - ROMPIMENTO NEGATIVO");
      VlrVendaNeg = StringToDouble(daotick("preco"));
     }
      
      if(StringToDouble(daotick("preco"))<=PrecoVenda-stoploss)
      {
      CompraNeg(lotes,"WDO$N","Compra - STOPGAIN - Modo Negativo");
      VlrCompraNeg = StringToDouble(daotick("preco"));
      }
      
      
      if(StringToDouble(daotick("preco"))>=PrecoVenda+stopgain)
      {
      CompraNeg(lotes,"WDO$N","Compra - STOPLOSS - Modo Negativo");
      VlrCompraNeg = StringToDouble(daotick("preco"));
      }
      
      
   }


/////////////////////////////////////////


//////////// Finaliza o Dia (Zerar Posição) ///////////////



if(TaDentroDoHorario("17:31","17:35")==true)

{

CompraNeg(lotes,"WDO$N","Compra - FIM DO DIA - Modo Negativo");
VlrCompraNeg = StringToDouble(daotick("preco"));


   }
   
   
   

}
///////////////////////////////////////////////////////////
   
////////////////////// ROTINA DO FIM DO DIA   

   if(TaDentroDoHorario("17:36","17:40")==true)
      JaZerou = false;
      if(JaEscolhido==true)
         {
         if(QualUsar==1)
           {
     //       Print("Saldo do Dia: ",VlrCompraPos-VlrVendaPos);   // Estudar como fazer um saldo verbose
           }
         
         if(QualUsar==2)
           {
         //   Print("Saldo do Dia: ",VlrVendaNeg-VlrCompraPos);   // Estudar como fazer um saldo verbose
           }
         
         }
      
      
      
      
   }
////////////////////////////////////////////   
 
//+------------------------------------------------------------------+
