/* -*- C++ -*- */

class Bucareste
{

public:
int Bucareste_Direcao();
void Bucareste_Comentario();
void Avalia();
int Bucareste_Mudanca();

};

int Bucareste::Bucareste_Direcao()
{
HiLo_OO *hilo = new HiLo_OO(BucaresteV2_HiLo_Periodos);


return hilo.Direcao();
delete(hilo);
}

void Bucareste::Bucareste_Comentario()
{
  Comentario_Robo = "\n Direcao BucaresteV2: " + Bucareste_Direcao();
}

void Bucareste::Avalia()
{

}

int Bucareste::Bucareste_Mudanca()
{




return 0;

}
