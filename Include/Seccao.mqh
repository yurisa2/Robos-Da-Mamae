#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"



void Escalpelador_Maluco ()
{


if(Usa_EM && Operacoes > 0 && daotick() >= PrecoCompra + Valor_Escalpe )
{

VendaStop("EM - Venda Picote - Fecha");
CompraStop("EM - Compra Picote - Abre");

}

if(Usa_EM && Operacoes < 0 && daotick() <= PrecoCompra - Valor_Escalpe )
{

CompraStop("EM - Compra Picote - Fecha");
VendaStop("EM -  Venda Picote - Abre");

}



}