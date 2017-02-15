/* -*- C++ -*- */

#property link      "http://www.sa2.com.br"


void Inicializa_Funcs ()
{
  MarketBookAdd(Symbol());
}


void Evento_Book ()
  {
    MqlBookInfo book[];
    MarketBookGet(Symbol(), book);

    double soma_positivo = 0;
    double soma_negativo = 0;
    int soma_direcao = 0;
    double soma_diferenca = 0;

    // if(ArraySize(book) == 0)
    // {
    //    printf("Failed load market book price. Reason: " + (string)GetLastError());
    //    return;
    // }

    Comentario_Robo = "\n Size: " + IntegerToString(ArraySize(book)) + "; \n";
    for(int i=0;i<ArraySize(book); i++)
    {

      if(book[i].type == 2) soma_positivo = soma_positivo + book[i].volume;
      if(book[i].type == 1) soma_negativo = soma_negativo + book[i].volume;

      if(soma_positivo > soma_negativo)
      {
        soma_direcao = -1;
        soma_diferenca = soma_positivo - soma_negativo;
      }

      if(soma_positivo < soma_negativo)
      {
        soma_direcao = 1;
        soma_diferenca = soma_negativo - soma_positivo;
      }
      if(soma_positivo == soma_negativo) soma_direcao = 0;


      // Comentario_Robo += "Price: " + DoubleToString(book[i].price, Digits()) + "; ";
      // Comentario_Robo += "Volume: " + (string)book[i].volume + "; ";
      // Comentario_Robo += "Type: " + EnumToString(book[i].type);
      // Comentario_Robo += "\n";
    }

    Comentario_Robo += "Trade Ativa: " +  PositionSelect(Symbol());
    Comentario_Robo += "\n";



Comentario_Robo += "soma_negativo: " + DoubleToString(soma_negativo,1);
Comentario_Robo += "\n";
Comentario_Robo += "soma_positivo: " + DoubleToString(soma_positivo,1);
Comentario_Robo += "\n";

Comentario_Robo += "soma_direcao: " + DoubleToString(soma_direcao,0);
Comentario_Robo += "\n";

Comentario_Robo += "soma_diferenca: " + DoubleToString(soma_diferenca,1);
Comentario_Robo += "\n";
Direcao = soma_direcao;   //Achar lugar melhor pra isso, outro pedaço do objeto

Comentario_Robo += "\n";
Comentario_Robo += "\n";



int Array_Mais_Um = ArraySize(golem_media_array) + 1;

ArrayResize(golem_media_array,Array_Mais_Um);

for(int i=0; i < ArraySize(golem_media_array)-1; i++)
{
golem_media_array[i] = golem_media_array[i+1];
}

golem_media_array[Array_Mais_Um-1] = soma_diferenca;

ArrayResize(golem_media_array,golem_tamanho_lista);

double soma_array = 0;

for(int i = 0; i < ArraySize(golem_media_array); i++)
{
  soma_array = soma_array + golem_media_array[i];
  // Comentario_Robo += "\n";
  // Comentario_Robo += i + " = " + golem_media_array[i];
}

double media_array = soma_array/ArraySize(golem_media_array);

// Comentario_Robo += "\n";
// Comentario_Robo += " soma_array = " + soma_array;
// Comentario_Robo += "\n";
// Comentario_Robo += " Media_Array = " + DoubleToString(media_array,0);


double desvio_cima = 0;
double desvio_padrao = 0;

for(int i = 0; i < ArraySize(golem_media_array); i++)
{
  double conta_elemento =  (golem_media_array[i] - media_array)*(golem_media_array[i] - media_array);
  desvio_cima = desvio_cima + conta_elemento;
  // Comentario_Robo += "\n";
  // Comentario_Robo += i + " = " + golem_media_array[i];
}
desvio_padrao = MathSqrt(desvio_cima/(ArraySize(golem_media_array)-1)) ;

Comentario_Robo += "\n";
Comentario_Robo += "desvio_padrao: " + DoubleToString(desvio_padrao,0);

int itens_acima_do_desvio = 0;
for(int i = 0; i < ArraySize(golem_media_array); i++)
{
  if(golem_media_array[i] > (media_array + desvio_padrao)) itens_acima_do_desvio++;
}
Comentario_Robo += "\n";
Comentario_Robo += " Acima do desvio: " + itens_acima_do_desvio;

Comentario_Robo += "\n";
Comentario_Robo += "\n";

// if(soma_direcao < 0 && soma_diferenca > golem_limite_de_operacao && PositionSelect(Symbol()) == 0) Venda_Golem("Diferenca de negocios " + soma_diferenca);
// if(soma_direcao > 0 && soma_diferenca > golem_limite_de_operacao && PositionSelect(Symbol()) == 0) Compra_Golem("Diferenca de negocios " + soma_diferenca);

  }



  void Compra_Golem (string Desc,string IO = "Neutro")
  {

        Print(Descricao_Robo+" "+Desc);

    if(OperacoesFeitas < (Limite_Operacoes*2) &&
      Saldo_Dia_Permite() == true &&
      (
      (Usa_Prop == true && Prop_Delta() > Prop_Limite_Minimo)
      || Usa_Fixos == true
    )
  )
    {
      MontarPosicao(ORDER_TYPE_BUY,Desc);
      OperacoesFeitas = OperacoesFeitas + 2;

    }
  }

  void Venda_Golem (string Desc,string IO = "Neutro")
{

      Print(Descricao_Robo+" "+Desc);

      if(OperacoesFeitas < (Limite_Operacoes*2) &&
        Saldo_Dia_Permite() == true &&
        (
        (Usa_Prop == true && Prop_Delta() > Prop_Limite_Minimo)
        || Usa_Fixos == true
      ))
      {
        MontarPosicao(ORDER_TYPE_SELL,Desc);
        OperacoesFeitas = OperacoesFeitas + 2;

      }
}

double Constroi_Media_Book (int soma_diferenca)
{
  ArraySetAsSeries(golem_media_array,true);

return 0;



}
