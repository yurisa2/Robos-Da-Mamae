/* -*- C++ -*- */

class Bucareste
{

public:
int Bucareste_Direcao();
void Bucareste_Comentario();

};

int Bucareste_Direcao()
{
HiLo_OO *hilo = new HiLo_OO(BucaresteV2_HiLo_Periodos);


return hilo.Direcao();
delete(hilo);
}

void Bucareste_Comentario()
{

  Comentario_Robo = "\n Direcao BucaresteV2: " + Bucareste_Direcao();



}
