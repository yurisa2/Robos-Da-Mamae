/* -*- C++ -*- */
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

////// Botão

int broadcastEventID=5000;

class Graficos
{
  private:
  bool botao_operar_presente;
  bool botao_abortar_presente;

  public:
  Graficos();
  void monitor_graficos();
  void Cria_Botao_Abortar();
  void Cria_Botao_Operar();
  void Cria_Botao_Compra();
  void Cria_Botao_Venda();
  void Apaga_Botoes();

  };

  void Graficos::Graficos()
  {

      Cria_Botao_Compra();
      Cria_Botao_Venda();

  }

void Graficos::monitor_graficos()
{
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  if(Condicoes.Operacao_Em_Curso() && !botao_abortar_presente)  Cria_Botao_Abortar();
  if(!Condicoes.Operacao_Em_Curso() && !botao_operar_presente)  Cria_Botao_Operar();
  delete(Condicoes);

}


  /////////////////////
  void Graficos::Cria_Botao_Abortar ()
  {
    Apaga_Botoes();
    //--- criar o botão
    ObjectCreate(0,"BTN_ABORTAR",OBJ_BUTTON,0,0,0,0,0);

    //--- definir coordenadas do botão
    ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_XDISTANCE,150);
    ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_YDISTANCE,0);
    //--- definir tamanho do botão
    ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_XSIZE,100);
    ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_YSIZE,18);
    //--- determinar o canto do gráfico onde as coordenadas do ponto são definidas
    ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_CORNER,CORNER_LEFT_UPPER);
    //--- definir o texto
    ObjectSetString(0,"BTN_ABORTAR",OBJPROP_TEXT,"!!!Aborta a Trade!!!");
    //--- definir o texto fonte
    ObjectSetString(0,"BTN_ABORTAR",OBJPROP_FONT,"Arial");
    //--- definir tamanho da fonte
    ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_FONTSIZE,8);
    //--- definir a cor do texto
    ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_COLOR,clrWhite);
    //--- definir a cor de fundo
    ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_BGCOLOR,clrRed);
    //--- definir a cor da borda
    ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_BORDER_COLOR,clrBlack);
    //--- exibir em primeiro plano (false) ou fundo (true)
    ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_BACK,false);
    //--- set button state
    //  ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_STATE,false);
    //--- habilitar (true) ou desabilitar (false) o modo do movimento do botão com o mouse
    ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_SELECTABLE,false);
    ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_SELECTED,false);
    //--- ocultar (true) ou exibir (false) o nome do objeto gráfico na lista de objeto
    ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_HIDDEN,false);
    //--- definir a prioridade para receber o evento com um clique do mouse no gráfico
    //   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_ZORDER,1);
    //--- sucesso na execução
    botao_abortar_presente = true;
  }

  void Graficos::Cria_Botao_Compra ()
  {
    ObjectCreate(0,"BTN_COMPRA",OBJ_BUTTON,0,0,0,0,0);
    ObjectSetInteger(0,"BTN_COMPRA",OBJPROP_XDISTANCE,260);
    ObjectSetInteger(0,"BTN_COMPRA",OBJPROP_YDISTANCE,0);
    ObjectSetInteger(0,"BTN_COMPRA",OBJPROP_XSIZE,25);
    ObjectSetInteger(0,"BTN_COMPRA",OBJPROP_YSIZE,18);
    ObjectSetInteger(0,"BTN_COMPRA",OBJPROP_CORNER,CORNER_LEFT_UPPER);
    ObjectSetString(0,"BTN_COMPRA",OBJPROP_TEXT,"^");
    ObjectSetString(0,"BTN_COMPRA",OBJPROP_FONT,"Arial");
    ObjectSetInteger(0,"BTN_COMPRA",OBJPROP_FONTSIZE,12);
    ObjectSetInteger(0,"BTN_COMPRA",OBJPROP_COLOR,clrWhite);
    ObjectSetInteger(0,"BTN_COMPRA",OBJPROP_BGCOLOR,clrBlue);
    ObjectSetInteger(0,"BTN_COMPRA",OBJPROP_BORDER_COLOR,clrBlack);
    ObjectSetInteger(0,"BTN_COMPRA",OBJPROP_BACK,false);
    ObjectSetInteger(0,"BTN_COMPRA",OBJPROP_SELECTABLE,false);
    ObjectSetInteger(0,"BTN_COMPRA",OBJPROP_SELECTED,false);
    ObjectSetInteger(0,"BTN_COMPRA",OBJPROP_HIDDEN,false);
  }

  void Graficos::Cria_Botao_Venda ()
  {
    ObjectCreate(0,"BTN_VENDA",OBJ_BUTTON,0,0,0,0,0);
    ObjectSetInteger(0,"BTN_VENDA",OBJPROP_XDISTANCE,290);
    ObjectSetInteger(0,"BTN_VENDA",OBJPROP_YDISTANCE,0);
    ObjectSetInteger(0,"BTN_VENDA",OBJPROP_XSIZE,25);
    ObjectSetInteger(0,"BTN_VENDA",OBJPROP_YSIZE,18);
    ObjectSetInteger(0,"BTN_VENDA",OBJPROP_CORNER,CORNER_LEFT_UPPER);
    ObjectSetString(0,"BTN_VENDA",OBJPROP_TEXT,"v");
    ObjectSetString(0,"BTN_VENDA",OBJPROP_FONT,"Arial");
    ObjectSetInteger(0,"BTN_VENDA",OBJPROP_FONTSIZE,8);
    ObjectSetInteger(0,"BTN_VENDA",OBJPROP_COLOR,clrWhite);
    ObjectSetInteger(0,"BTN_VENDA",OBJPROP_BGCOLOR,clrBlue);
    ObjectSetInteger(0,"BTN_VENDA",OBJPROP_BORDER_COLOR,clrBlack);
    ObjectSetInteger(0,"BTN_VENDA",OBJPROP_BACK,false);
    ObjectSetInteger(0,"BTN_VENDA",OBJPROP_SELECTABLE,false);
    ObjectSetInteger(0,"BTN_VENDA",OBJPROP_SELECTED,false);
    ObjectSetInteger(0,"BTN_VENDA",OBJPROP_HIDDEN,false);
  }

  void Graficos::Cria_Botao_Operar ()
  {
    Apaga_Botoes();
    //--- criar o botão
    ObjectCreate(0,"Botao_Operar",OBJ_BUTTON,0,0,0,0,0);

    //--- definir coordenadas do botão
    ObjectSetInteger(0,"Botao_Operar",OBJPROP_XDISTANCE,150);
    ObjectSetInteger(0,"Botao_Operar",OBJPROP_YDISTANCE,0);
    //--- definir tamanho do botão
    ObjectSetInteger(0,"Botao_Operar",OBJPROP_XSIZE,100);
    ObjectSetInteger(0,"Botao_Operar",OBJPROP_YSIZE,18);
    //--- determinar o canto do gráfico onde as coordenadas do ponto são definidas
    ObjectSetInteger(0,"Botao_Operar",OBJPROP_CORNER,CORNER_LEFT_UPPER);
    //--- definir o texto
    ObjectSetString(0,"Botao_Operar",OBJPROP_TEXT,"!!!Força Trade!!!");
    //--- definir o texto fonte
    ObjectSetString(0,"Botao_Operar",OBJPROP_FONT,"Arial");
    //--- definir tamanho da fonte
    ObjectSetInteger(0,"Botao_Operar",OBJPROP_FONTSIZE,8);
    //--- definir a cor do texto
    ObjectSetInteger(0,"Botao_Operar",OBJPROP_COLOR,clrWhite);
    //--- definir a cor de fundo
    ObjectSetInteger(0,"Botao_Operar",OBJPROP_BGCOLOR,clrGray);
    //--- definir a cor da borda
    ObjectSetInteger(0,"Botao_Operar",OBJPROP_BORDER_COLOR,clrBlack);
    //--- exibir em primeiro plano (false) ou fundo (true)
    ObjectSetInteger(0,"Botao_Operar",OBJPROP_BACK,false);
    //--- set button state
    //  ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_STATE,false);
    //--- habilitar (true) ou desabilitar (false) o modo do movimento do botão com o mouse
    ObjectSetInteger(0,"Botao_Operar",OBJPROP_SELECTABLE,false);
    ObjectSetInteger(0,"Botao_Operar",OBJPROP_SELECTED,false);
    //--- ocultar (true) ou exibir (false) o nome do objeto gráfico na lista de objeto
    ObjectSetInteger(0,"Botao_Operar",OBJPROP_HIDDEN,false);
    //--- definir a prioridade para receber o evento com um clique do mouse no gráfico
    //   ObjectSetInteger(0,"BTN_ABORTAR",OBJPROP_ZORDER,1);
    //--- sucesso na execução
    botao_operar_presente = true;
  }

  void Graficos::Apaga_Botoes()
  {
    ObjectDelete(0,"Botao_Operar");
    ObjectDelete(0,"BTN_ABORTAR");
    botao_operar_presente = false;
    botao_abortar_presente = false;
  }

  void OnChartEvent(const int id,
    const long &lparam,
    const double &dparam,
    const string &sparam)
    {
      Opera_Mercado *opera = new Opera_Mercado;

      //--- Verifique o evento pressionando um botão do mouse
      if(id==CHARTEVENT_OBJECT_CLICK)
      {
        string clickedChartObject=sparam;
        //--- Se você clicar sobre o objeto com o nome buttonID
        if(clickedChartObject=="BTN_ABORTAR")
        {
          Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

          if(Condicoes.Operacao_Em_Curso())  opera.FechaPosicao();
          delete(Condicoes);


        }

        if(clickedChartObject=="BTN_VENDA")
        {
          opera.AbrePosicao(-1,"Forca Botao" );

          // Alert("VENDA");
        }

        if(clickedChartObject=="BTN_COMPRA")
        {

          opera.AbrePosicao(1,"Forca Botao" );

          // Alert("COMPRA");
        }


        // ARRUMAR ISSO, esta com heranca do buca
        if(clickedChartObject=="Botao_Operar")
        {

        }
        ChartRedraw();// Redesenho forçado de todos os objetos de gráfico
        delete(opera);

      }
    }
