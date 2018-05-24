/* -*- C++ -*- */

class Halley
{

  public:
  void Halley_Comentario();
  void Avalia();
  void Timer();
  int  Formato(int barra = 0);
  int Direcao(int barra = 0);
  int Forma_Direcao(int barra = 0);
  MqlRates Halley::Preco(int barra = 0);

};



void Halley::Halley_Comentario()
{
  // MA *MediaMovel20 = new MA(20);
  // Comentario_Robo = "MediaMovel20: " + MediaMovel20.Valor();
  // delete(MediaMovel20);

}

int  Halley::Formato(int barra = 0)
{
  int  retorno = false;
  double sombra = NULL;
  double sombra2 = NULL;
  double corpo = NULL;

  MqlRates rates[];
  ArraySetAsSeries(rates,true);
  int copied=CopyRates(Symbol(),TimeFrame,0,200,rates);

  //  Print("Hora: " +  rates[barra+1].time +" | OHLC:" + rates[barra+1].open + " | " + rates[barra+1].high +" | " + rates[barra+1].low +" | " + rates[barra+1].close);

  //ShootingStar

  if(rates[barra+1].close >= rates[barra+1].open) //Candle de alta
  {
    corpo = MathAbs(rates[barra+1].close - rates[barra+1].open);
    sombra =  MathAbs(rates[barra+1].high - rates[barra+1].close);
    sombra2 = MathAbs(rates[barra+1].open - rates[barra+1].low);
    if(sombra2 == 0) sombra2 = 0.01;

    if(sombra > (n_vezes * corpo) && ((sombra/sombra2) > prop_sombra || sombra2 == 0.01))
    {
      retorno = -1;
    }
  }

  if(rates[barra+1].close <= rates[barra+1].open)  //Candle de baixa
  {
    corpo = MathAbs(rates[barra+1].open - rates[barra+1].close);
    sombra =  MathAbs(rates[barra+1].high - rates[barra+1].open);
    sombra2 = MathAbs(rates[barra+1].close - rates[barra+1].low);
    if(sombra2 == 0) sombra2 = 0.01;

    if(sombra > (n_vezes * corpo) && ((sombra/sombra2) > prop_sombra || sombra2 == 0.01))
    {
      retorno = -1;
    }
  }


  if(rates[barra+1].close >= rates[barra+1].open) //Candle de alta
  {
    corpo = MathAbs(rates[barra+1].close - rates[barra+1].open);
    sombra =  MathAbs(rates[barra+1].open - rates[barra+1].low);
    sombra2 = MathAbs(rates[barra+1].high - rates[barra+1].close);
    if(sombra2 == 0) sombra2 = 0.01;

    if(sombra > (n_vezes * corpo) && ((sombra/sombra2) > prop_sombra || sombra2 == 0.01))
    {
      retorno = 1;
    }
  }

  if(rates[barra+1].close <= rates[barra+1].open)  //Candle de baixa
  {
    corpo = MathAbs(rates[barra+1].open - rates[barra+1].close);
    sombra =  MathAbs(rates[barra+1].close - rates[barra+1].low);
    sombra2 = MathAbs(rates[barra+1].high - rates[barra+1].open);
    if(sombra2 == 0) sombra2 = 0.01;

    if(sombra > (n_vezes * corpo) && ((sombra/sombra2) > prop_sombra || sombra2 == 0.01))
    {
      retorno = 1;
    }
  }

  //Print("Corpo: " + corpo + " | Sombra: " + sombra); //DEBUG

  return retorno;
}

int Halley::Direcao(int barra = 0)
{
  int retorno = 0;
  double valor_ma = 0;
  double preco = 0;
  int direcao_ma = 0;
  int barra_somar_1 = 0;
  int barra_somar_2 = 0;

  barra_somar_1 = barra + 1;
  barra_somar_2 = barra + 2;

  MqlRates rates[];
  ArraySetAsSeries(rates,true);
  int copied=CopyRates(Symbol(),TimeFrame,0,200,rates);

  preco =  rates[barra_somar_1].close;

  MA *MediaMovel20 = new MA(20,NULL,TimeFrame);

  valor_ma = MediaMovel20.Valor(barra_somar_1);
  if(MediaMovel20.Valor(barra_somar_2) < MediaMovel20.Valor(barra_somar_1)) direcao_ma = 1;
  if(MediaMovel20.Valor(barra_somar_2) > MediaMovel20.Valor(barra_somar_1)) direcao_ma = -1;
  //DUP
  valor_ma = MediaMovel20.Valor(barra_somar_1);
  if(MediaMovel20.Valor(barra_somar_2) < MediaMovel20.Valor(barra_somar_1)) direcao_ma = 1;
  if(MediaMovel20.Valor(barra_somar_2) > MediaMovel20.Valor(barra_somar_1)) direcao_ma = -1;
  //DUP


  // Print("direcao_ma: "+direcao_ma); //DEBUG
  // Print("MediaMovel20.Valor(barra_somar_2): "+MediaMovel20.Valor(barra_somar_2)); //DEBUG
  // Print("MediaMovel20.Valor(barra_somar_1): "+MediaMovel20.Valor(barra_somar_1)); //DEBUG
  // Print("preco: "+ preco); //DEBUG
  // Print("valor_ma: "+ valor_ma); //DEBUG
  //
  // Print("barra_somar_1: " +barra_somar_1); //DEBUG
  // Print("barra_somar_2: " +barra_somar_2); //DEBUG
  //  Print("MediaMovel20.Valor(barra_somar_2): " + MediaMovel20.Valor(barra_somar_2)); //DEBUG


  delete(MediaMovel20);

  if(direcao_ma == 1 && preco > valor_ma ) retorno = 1;
  if(direcao_ma == -1 && preco < valor_ma ) retorno = -1;

  //  Print("Direcao(int barra = 0): " + retorno); //DEBUG
  return retorno;
}

MqlRates Halley::Preco(int barra = 0)
{

  barra = barra + 1;


  MqlRates rates[];
  ArraySetAsSeries(rates,true);
  int copied=CopyRates(Symbol(),TimeFrame,0,200,rates);



  return rates[barra];


}

void Halley::Avalia()
{
  int mudanca = 0;
  Condicoes_Basicas_OO *Condicoes = new Condicoes_Basicas_OO;
  datetime DiaHojeStart =  StringToTime(TimeToString(TimeCurrent(),TIME_DATE) + " 00:01");


  if(Condicoes.Horario())
  {
    if(O_Stops.Tipo_Posicao() == 0)
    {
      for(int i=0;i<n_ultimos;i++)
      {
        if(Formato(i) < 0 && (Direcao(i) > 0 || Opera_Somente_Formato) && daotick_geral <  Preco(i).low && Preco(i).time != UltimoFormato && Preco(i).time > DiaHojeStart && Halley_Tipo_op <=0 )
        {
          Opera_Mercado *opera = new Opera_Mercado;
          //      Print("Formato("+i+"): " + Formato(i) + " | Direcao: " + Direcao(i) + " | Preco("+i+"): " + Preco(i).low + " | Hora: " + Preco(i).time) ;
          opera.AbrePosicao(-1,"Formato("+IntegerToString(i)+"): " + DoubleToString(Formato(i)) + " | Direcao: " + DoubleToString(Direcao(i)) + " | Preco("+IntegerToString(i)+"): " + DoubleToString(Preco(i).low) + " | Hora: " + DoubleToString(Preco(i).time));
          UltimoFormato = Preco(i).time;
          double sl = Preco(i).high;
          if(Utiliza_SL_Setup) opera.SetaSL(sl);
          delete(opera);
        }

        if(Formato(i) > 0 && (Direcao(i) < 0 || Opera_Somente_Formato) && daotick_geral >  Preco(i).high && Preco(i).time != UltimoFormato && Preco(i).time > DiaHojeStart && Halley_Tipo_op >=0 )
        //if(Formato(i) > 0 && (Direcao(i) < 0 || Opera_Somente_Formato) < 0 && daotick_geral >  Preco(i).high && Preco(i).time != UltimoFormato && Preco(i).time > DiaHojeStart && Halley_Tipo_op >=0 )
        //Eu fiz cagada aqui, mas fez muito dinheiro,  (Direcao(i) < 0 || Opera_Somente_Formato) < 0 ,
        {
          Opera_Mercado *opera = new Opera_Mercado;
          //    Print("Formato("+i+"): " + Formato(i) + " | Direcao: " + Direcao(i) + " | Preco("+i+"): " + Preco(i).high  + " | Hora: " + Preco(i).time) ;
          opera.AbrePosicao(1,"Formato("+IntegerToString(i)+"): " + DoubleToString(Formato(i)) + " | Direcao: " + DoubleToString(Direcao(i)) + " | Preco("+IntegerToString(i)+"): " + DoubleToString(Preco(i).low) + " | Hora: " + DoubleToString(Preco(i).time));
          UltimoFormato = Preco(i).time;
          double sl = Preco(i).low;
          if(Utiliza_SL_Setup) opera.SetaSL(sl);
          delete(opera);
        }
      }
    }



    //if(Formato(0) != 0) Print("Formato(0): " + Formato(0) + " | Direcao: " + Direcao(0)) ; //DEBUG
    // Print("Formato(0): " + Formato(0) + " | Direcao: " + Direcao(0)) ; //DEBUG

    // Print("Formato(0): " + Formato(0) + " | Formato(1): " + Formato(1) + " | Formato(2): " + Formato(2)) ;
    // Print("Direcao(0): " + Direcao(0) + " | Direcao(1): " + Direcao(1) + " | Direcao(2): " + Direcao(2)) ;

    // if( Formato(0) == true && Direcao(0) == 1 ) Print("Identificado 0");
    // if( Formato(1) == true && Direcao(1) == 1 ) Print("Identificado 1");
    // if( Formato(2) == true && Direcao(2) == 1 ) Print("Identificado 2");



    Opera_Mercado *opera = new Opera_Mercado;
    //  if(O_Stops.Tipo_Posicao() == 0 )   opera.AbrePosicao(-1,"Halley: ");
    delete(opera);

    //  Print("Halley: " + DoubleToString(Valor_Halley_atual)); //DEBUG
  }

  delete(Condicoes);
}

void Halley::Timer()
{
  //AQUI FICAVA O CODEGO DE ZERAR PENDENTES
}
