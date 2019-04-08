/* -*- C++ -*- */

class Xolodeck
{

  public:
  Xolodeck();
  void Comentario();
  void Avalia();
  void Timer();


  private:
  bool Toque_Mediana();
  int Rompimento_Bandas(int barra = 1);
  int Direcao();

};

void Xolodeck::Xolodeck()
{


}

bool Xolodeck::Toque_Mediana()
{
  bool retorno = false;
  if(O_BB.BB_Base() >= (daotick_geral - Tick_Size) && O_BB.BB_Base() <=  (daotick_geral + Tick_Size)) retorno = true;

  //if(retorno) Print("TOCOU HEIN PUTO"); //DEBUG

  return retorno;
}

int Xolodeck::Rompimento_Bandas(int barra)
{
  int retorno = 0;

  MqlRates rates[];
  CopyRates(Symbol(),TimeFrame,0,barra+1,rates);
  ArraySetAsSeries(rates,true);
  double preco_min = rates[barra].low;
  double preco_max = rates[barra].high;

  if(O_BB.BB_Low(barra) > preco_min) retorno = 1;
  if(O_BB.BB_High(barra) < preco_max) retorno = -1;

  // if(retorno !=0) Print("Rompimento_Bandas" + IntegerToString(retorno));
  //if(retorno !=0)  Print("Rompimento_Bandas: " + IntegerToString(retorno) + "  |   barra: " + IntegerToString(barra) + "  |  Hora: " + TimeToString(rates[barra].time));

  if(retorno != 0) ultimo_rompimento = Preco(barra).time;

  return retorno;
}

void Xolodeck::Comentario()
{


}

int Xolodeck::Direcao()
{
  int retorno = 0;
  int barra_i = 0;
  for(int i=1; i <= n_ultimos; i++)
  {
    retorno = Rompimento_Bandas(i);
    barra_i = i;
    if(retorno != 0) break;
  }

  // if(retorno != 0) Print("Direcao! " + IntegerToString(retorno) + "  |   barra_i: " + IntegerToString(barra_i)); //DEBUG

  return retorno;
}

void Xolodeck::Avalia()
{
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;

  if(Toque_Mediana() &&
  Direcao() != 0 &&
  Condicoes.Horario() &&
  O_Stops.Tipo_Posicao() == 0 &&
  ultimo_rompimento_operado != ultimo_rompimento
  )
  {
    if(Direcao() > 0 && xolo_compra
    && daotick_geral > (O_BB.BB_Base() + (rompimento_mediana * Tick_Size)) )
    {

              Filtro_Afis *filtrofuzzy = new Filtro_Afis;
              filtrofuzzy.min_feats = 1;
              filtrofuzzy.max_feats = ff_max_feats;
              filtrofuzzy.direction = 1;
              filtrofuzzy.num_lines = ff_dataset_size;
              filtrofuzzy.calc();

              Print("filtrofuzzy.res_0: " + filtrofuzzy.res_0);
              Print("filtrofuzzy.res_1: " + filtrofuzzy.res_1);

              bool filtro_fuzzy_ok = false;

              if(filtrofuzzy.res_1 == 0 || (filtrofuzzy.res_1 >= filtrofuzzy.res_0)) filtro_fuzzy_ok = true;

              delete(filtrofuzzy);

      Opera_Mercado *opera = new Opera_Mercado;
      if(filtro_fuzzy_ok) opera.AbrePosicao(1,"Valor: " + DoubleToString(daotick_geral));
      delete(opera);
      ultimo_rompimento_operado = ultimo_rompimento;
    }

    if(Direcao() < 0 && xolo_venda
    && daotick_geral < (O_BB.BB_Base() - (rompimento_mediana * Tick_Size)) )
    {

      Filtro_Afis *filtrofuzzy = new Filtro_Afis;
      filtrofuzzy.min_feats = 1;
      filtrofuzzy.max_feats = ff_max_feats;
      filtrofuzzy.direction = -1;
      filtrofuzzy.num_lines = ff_dataset_size;
      filtrofuzzy.calc();

      Print("filtrofuzzy.res_0: " + filtrofuzzy.res_0);
      Print("filtrofuzzy.res_1: " + filtrofuzzy.res_1);

      bool filtro_fuzzy_ok = false;

      if(filtrofuzzy.res_1 == 0 || (filtrofuzzy.res_1 >= filtrofuzzy.res_0)) filtro_fuzzy_ok = true;

      delete(filtrofuzzy);

      Opera_Mercado *opera = new Opera_Mercado;
      if(filtro_fuzzy_ok) opera.AbrePosicao(-1,"Valor: " + DoubleToString(daotick_geral));
      delete(opera);
      ultimo_rompimento_operado = ultimo_rompimento;
    }

    // Print("ultimo_rompimento_operado: " + TimeToString(ultimo_rompimento_operado)); //DEBUG
    // Print("ultimo_rompimento: " + TimeToString(ultimo_rompimento)); //DEBUG
  }

  delete(Condicoes);
}

void Xolodeck::Timer()
{


}

BB O_BB(TimeFrame,NULL,p_bb);
