/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             SA2 - Investment soft|
//+------------------------------------------------------------------+

void Zenilton_No_Tick()
{
  if(!Otimizacao)
  {
    ZComments *Zenilton_Com = new ZComments;
    delete(Zenilton_Com);
  }

  Zenilton *zenilton = new Zenilton;
  zenilton.Avalia();
  delete(zenilton);
}
