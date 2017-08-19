/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

void Escalpelador_Maluco ()
{


   if(Usa_EM && Operacoes > 0 && daotick_geral >= PrecoCompra + Valor_Escalpe)
   {

      EM_Contador_Picote++;
      VendaImediata("EM - Venda Picote - Fecha");
      if(EM_Contador_Picote <= EM_Vezes_Picote) CompraImediata("EM - Compra Picote - Abre");

   }

   if(Usa_EM && Operacoes < 0 && daotick_geral <= PrecoVenda - Valor_Escalpe)
   {

      EM_Contador_Picote++;
      CompraImediata("EM - Compra Picote - Fecha");
      if(EM_Contador_Picote <= EM_Vezes_Picote) VendaImediata("EM -  Venda Picote - Abre");

   }

}
