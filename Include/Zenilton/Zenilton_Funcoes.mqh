/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             SA2 - Investment soft|
//+------------------------------------------------------------------+


void Zenilton_No_Tick()
{

ZComments *Zenilton_Com = new ZComments;
delete(Zenilton_Com);

Zenilton *zenilton = new Zenilton;
zenilton.Avalia();
delete(zenilton);


}

void Zenilton_No_Timer()
{
  //
  // Banda = Xavier_BB_Tamanho_Porcent();
  // Rsi = CalculaRSI();
  Comentario_Robo = "\n Xavier_BB_Tamanho_Porcent BB: ";
  Comentario_Robo = Comentario_Robo + "\n CalculaRSI: ";
  Comentario_Robo = Comentario_Robo + "\n Fuzzy_Respo(): ";
Xavier_Avalia();

}

//Inicio do Joguete BB

void Xavier_Avalia()
{

}
