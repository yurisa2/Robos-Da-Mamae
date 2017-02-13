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

Comentario_Robo += "soma_negativo: " + DoubleToString(soma_negativo,1);
Comentario_Robo += "\n";
Comentario_Robo += "soma_positivo: " + DoubleToString(soma_positivo,1);
Comentario_Robo += "\n";

Comentario_Robo += "soma_direcao: " + DoubleToString(soma_direcao,0);
Comentario_Robo += "\n";

Comentario_Robo += "soma_diferenca: " + DoubleToString(soma_diferenca,1);
Comentario_Robo += "\n";
Direcao = soma_direcao;   //Achar lugar melhor pra isso, outro pedaço do objeto

if(Operacoes == 0 && soma_direcao < 0 && soma_diferenca > golem_limite_de_operacao) Venda_Golem("Diferenca de negocios " + soma_diferenca);
if(Operacoes == 0 && soma_direcao > 0 && soma_diferenca > golem_limite_de_operacao) Compra_Golem("Diferenca de negocios " + soma_diferenca);

  }



  void Compra_Golem (string Desc,string IO = "Neutro")
  {
    if(IO == "Entrada") EM_Contador_Picote = 0;

    if(EM_Picote_Tipo==55) Valor_Escalpe = Tick_Size * Tamanho_Picote;    //Para fazer funcionar o EM   - fixo
    if(EM_Picote_Tipo==471) Valor_Escalpe = Prop_Delta() * Tamanho_Picote;  //Para fazer funcionar o EM - proporcional

    Print(Descricao_Robo+" "+Desc);

    if(Operacoes<0)
    {
      MontarRequisicao(ORDER_TYPE_BUY,Desc);
    }
    if(Operacoes==0 && OperacoesFeitas < (Limite_Operacoes*2) && Saldo_Dia_Permite() == true &&  (  (Usa_Prop == true && Prop_Delta() > Prop_Limite_Minimo) || Usa_Fixos == true ) )
    {
      MontarRequisicao(ORDER_TYPE_BUY,Desc);
      DeuStopLoss = false;
      DeuTakeProfit = false;
    }
  }

  void Venda_Golem (string Desc,string IO = "Neutro")
{
  if(IO == "Entrada") EM_Contador_Picote = 0;

  if(EM_Picote_Tipo==55) Valor_Escalpe = Tick_Size * Tamanho_Picote;    //Para fazer funcionar o EM   - fixo
  if(EM_Picote_Tipo==471) Valor_Escalpe = Prop_Delta() * Tamanho_Picote;  //Para fazer funcionar o EM - proporcional

  Print(Descricao_Robo+" "+Desc);
  if(Operacoes>0)
  {
    MontarRequisicao(ORDER_TYPE_SELL,Desc);

  }
  if(Operacoes==0 && OperacoesFeitas < (Limite_Operacoes*2) && Saldo_Dia_Permite() == true &&  (  (Usa_Prop == true && Prop_Delta() > Prop_Limite_Minimo) || Usa_Fixos == true ) )
  {
    MontarRequisicao(ORDER_TYPE_SELL,Desc);
    DeuStopLoss = false;
    DeuTakeProfit = false;
  }
}
