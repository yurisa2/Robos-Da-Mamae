﻿/* -*- C++ -*- */

class Bucareste
{

  public:
  int Bucareste_Direcao();
  void Bucareste_Comentario();
  void Avalia();

};

int Bucareste::Bucareste_Direcao()
{



  int direcao = 0;
  HiLo_OO *hilo = new HiLo_OO(BucaresteV2_HiLo_Periodos);
  direcao = hilo.Direcao();
  delete(hilo);
  return direcao;
}

void Bucareste::Bucareste_Comentario()
{
  if(!Otimizacao && Tipo_Comentario != 0)
  {
  }
// }
}

void Bucareste::Avalia()
{
  int mudanca = 0;
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  if(Condicoes.Horario())
  {
    HiLo_OO *hilo = new HiLo_OO(BucaresteV2_HiLo_Periodos);
    Opera_Mercado *opera = new Opera_Mercado;

    if(!Buca_Entra_Sem_Mudanca) mudanca = hilo.Mudanca();
    if(Buca_Entra_Sem_Mudanca) mudanca = hilo.Direcao();

    //if(mudanca != 0 ) Print("Mudanca: " + mudanca); //DEBUG


    if(mudanca != 0 && O_Stops.Tipo_Posicao() != mudanca &&  O_Stops.Tipo_Posicao() == 0)
    {
      // if(rna_filtros_on) machine_learning.Processa_RNA(resposta_y,machine_learning.rede_obj,x_entrada);
      //
      //
      // double ml_p = resposta_y[1];
      // if(!rna_filtros_on) ml_p = 1;
      // Print("ml_p "+ DoubleToString(ml_p));

      if((mudanca == Buca_Compra_Venda || Buca_Compra_Venda == 0)) opera.AbrePosicao(mudanca,"BucaresteV2: ");
    }

    if(mudanca != 0 && O_Stops.Tipo_Posicao() != mudanca &&  O_Stops.Tipo_Posicao() != 0 && Buca_Encerra_Indicador)   opera.FechaPosicao();

    delete(opera);
    delete(hilo);
  }

  delete(Condicoes);
}
