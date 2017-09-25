/* -*- C++ -*- */

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
  // Comentario_Robo = "\n Direcao BucaresteV2: " + Bucareste_Direcao();
}

void Bucareste::Avalia()
{
  int mudanca = 0;
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  if(Condicoes.Horario())
  {
    HiLo_OO *hilo = new HiLo_OO(BucaresteV2_HiLo_Periodos);
    Opera_Mercado *opera = new Opera_Mercado;

    mudanca = hilo.Mudanca();

    if(mudanca != 0 && O_Stops.Tipo_Posicao() != mudanca &&  O_Stops.Tipo_Posicao() == 0)   opera.AbrePosicao(mudanca,"BucaresteV2: ");
    if(mudanca != 0 && O_Stops.Tipo_Posicao() != mudanca &&  O_Stops.Tipo_Posicao() != 0 && Buca_Encerra_Indicador)   opera.FechaPosicao();

    delete(opera);
    delete(hilo);
  }

  delete(Condicoes);
}