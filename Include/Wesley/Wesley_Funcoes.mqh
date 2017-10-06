/* -*- C++ -*- */
//+------------------------------------------------------------------+

#include <Math\Fuzzy\MamdaniFuzzySystem.mqh>

class Wesley
{
  public:
  void Wesley::Wesley(int barra = 0);
  double Wesley_Fuzzy_Valor;
  double Wesley_BB_Valor;
  double Wesley_RSI_Valor;
  double Wesley_MF_Valor;
  double Wesley_Stoch_Valor;
  double Wesley_ADX_Valor;

  private:
  void Get_Dados(int barra = 0);
  void Wesley::Comentario();
  void Wesley::Abre();
  void Wesley::Fecha();
    double Wesley::Fuzzy_Respo(double Banda = 0, double Rsi = 50, double Estocastico = 50, double MoneyFI = 50,
      double BandaL = 0, double RsiL = 50, double EstocasticoL = 50, double MoneyFIL = 50, double Wesley_ADX = 50);
  double Wesley_BB_Delta_Valor;
  double Wesley_Volumes;
  double Wesley_BB_ValorL;
  double Wesley_BB_Delta_ValorL;
  double Wesley_RSI_ValorL;
  double Wesley_Stoch_ValorL;
  double Wesley_MF_ValorL;
  double Wesley_VolumesL;
};

void Wesley::Wesley(int barra = 0)
{
  if(TaDentroDoHorario_RT)
  {
    Get_Dados(barra);
    Abre();
  }
  if(!Otimizacao) Comentario();

  if(Wesley_Sai_Em_Zero && O_Stops.Tipo_Posicao() != 0 ) Fecha();
}

void Wesley::Get_Dados(int barra = 0)
{
  if(TaDentroDoHorario_RT)
  {
    BB *Banda_BB = new BB(TimeFrame);
    RSI *RSI_OO = new RSI(14,TimeFrame);
    Stoch *Stoch_OO = new Stoch(10,3,3,TimeFrame);
    MFI *MFI_OO = new MFI(TimeFrame);
    Volumes *Volumes_OO = new Volumes(NULL,TimeFrame);
    ADX *ADX_OO = new ADX(4,TimeFrame);

    BB *Banda_BBL = new BB(Wesley_Large);
    RSI *RSI_OOL = new RSI(14,Wesley_Large);
    Stoch *Stoch_OOL = new Stoch(10,3,3,Wesley_Large);
    MFI *MFI_OOL = new MFI(Wesley_Large);
    Volumes *Volumes_OOL = new Volumes(NULL,Wesley_Large);

    Wesley_BB_Valor = Banda_BB.BB_Posicao_Percent(barra);
    Wesley_BB_Delta_Valor = Banda_BB.Banda_Delta_Valor();
    Wesley_RSI_Valor = RSI_OO.Valor(barra);
    Wesley_Stoch_Valor = Stoch_OO.Valor(barra);
    Wesley_MF_Valor = MFI_OO.Valor(barra);
    Wesley_Volumes = Volumes_OO.Valor(barra);

    Wesley_ADX_Valor = ADX_OO.Valor(0,barra);

    Wesley_BB_ValorL = Banda_BBL.BB_Posicao_Percent(barra);
    Wesley_BB_Delta_ValorL = Banda_BBL.Banda_Delta_Valor();
    Wesley_RSI_ValorL = RSI_OOL.Valor(barra);
    Wesley_Stoch_ValorL = Stoch_OOL.Valor(barra);
    Wesley_MF_ValorL = MFI_OOL.Valor(barra);
    Wesley_VolumesL = Volumes_OOL.Valor(barra);

    Wesley_Fuzzy_Valor = Fuzzy_Respo(
      Wesley_BB_Valor,Wesley_RSI_Valor,Wesley_Stoch_Valor,Wesley_MF_Valor,
      Wesley_BB_ValorL,Wesley_RSI_ValorL,Wesley_Stoch_ValorL,Wesley_MF_ValorL,Wesley_ADX_Valor
    );

    delete(RSI_OO);
    delete(Banda_BB);
    delete(Stoch_OO);
    delete(MFI_OO);
    delete(Volumes_OO);
    delete(ADX_OO);


    delete(RSI_OOL);
    delete(Banda_BBL);
    delete(Volumes_OOL);
    delete(Stoch_OOL);
    delete(MFI_OOL);
  }
  else
  {
    Wesley_BB_Valor = 0;
    Wesley_RSI_Valor = 0;
    Wesley_Stoch_Valor = 0;
    Wesley_MF_Valor = 0;
    Wesley_BB_ValorL = 0;
    Wesley_RSI_ValorL = 0;
    Wesley_Stoch_ValorL = 0;
    Wesley_MF_ValorL = 0;
    Wesley_ADX_Valor = 0;
  }
}

void Wesley::Abre()
{
  double Wesley_Valor_Compra_Mod = 0;

  if(Wesley_Igual_Lados) Wesley_Valor_Compra_Mod = Wesley_Valor_Venda * -1;   //ME DA O TACAPEEEEEEEEEEEEEEEE
  else Wesley_Valor_Compra_Mod = Wesley_Valor_Compra;

  if(Wesley_Fuzzy_Valor > Wesley_Valor_Venda)
  {
    Opera_Mercado *opera = new Opera_Mercado;
    if(!Wesley_Inverte) opera.AbrePosicao(ORDER_TYPE_SELL,"Fuzzy: " + DoubleToString(Wesley_Fuzzy_Valor));
    if(Wesley_Inverte) opera.AbrePosicao(ORDER_TYPE_BUY,"Fuzzy: " + DoubleToString(Wesley_Fuzzy_Valor));
    // if(!Wesley_Inverte) opera.AbrePosicao(ORDER_TYPE_SELL,DoubleToString(Wesley_BB_Valor,0) + ";" + DoubleToString(Wesley_BB_Delta_Valor,0) + ";" + DoubleToString(Wesley_RSI_Valor,0) + ";" + DoubleToString(Wesley_Stoch_Valor,0) + ";" + DoubleToString(Wesley_MF_Valor,0) + ";" + DoubleToString(Wesley_Volumes,0));
    // if(Wesley_Inverte) opera.AbrePosicao(ORDER_TYPE_BUY,DoubleToString(Wesley_BB_Valor,0) + ";" + DoubleToString(Wesley_BB_Delta_Valor,0) + ";" + DoubleToString(Wesley_RSI_Valor,0) + ";" + DoubleToString(Wesley_Stoch_Valor,0) + ";" + DoubleToString(Wesley_MF_Valor,0) + ";" + DoubleToString(Wesley_Volumes,0));
    delete(opera);
  }

  if(Wesley_Fuzzy_Valor < Wesley_Valor_Compra_Mod)
  {
    Opera_Mercado *opera = new Opera_Mercado;
    if(!Wesley_Inverte) opera.AbrePosicao(ORDER_TYPE_BUY,"Fuzzy: " + DoubleToString(Wesley_Fuzzy_Valor));
    if(Wesley_Inverte) opera.AbrePosicao(ORDER_TYPE_SELL,"Fuzzy: " + DoubleToString(Wesley_Fuzzy_Valor));
    // if(!Wesley_Inverte) opera.AbrePosicao(ORDER_TYPE_BUY,DoubleToString(Wesley_BB_Valor,0) + ";" + DoubleToString(Wesley_BB_Delta_Valor,0) + ";" + DoubleToString(Wesley_RSI_Valor,0) + ";" + DoubleToString(Wesley_Stoch_Valor,0) + ";" + DoubleToString(Wesley_MF_Valor,0) + ";" + DoubleToString(Wesley_Volumes,0));
    // if(Wesley_Inverte) opera.AbrePosicao(ORDER_TYPE_SELL,DoubleToString(Wesley_BB_Valor,0) + ";" + DoubleToString(Wesley_BB_Delta_Valor,0) + ";" + DoubleToString(Wesley_RSI_Valor,0) + ";" + DoubleToString(Wesley_Stoch_Valor,0) + ";" + DoubleToString(Wesley_MF_Valor,0) + ";" + DoubleToString(Wesley_Volumes,0));
    delete(opera);
  }
}

void Wesley::Fecha()
{
  if(O_Stops.Tipo_Posicao() < 0 && Wesley_Fuzzy_Valor <= 0)
  {
    Opera_Mercado *opera = new Opera_Mercado;
    opera.FechaPosicao() ;
    delete(opera);
  }

  if(O_Stops.Tipo_Posicao() > 0 && Wesley_Fuzzy_Valor >= 0)
  {
    Opera_Mercado *opera = new Opera_Mercado;
    opera.FechaPosicao() ;
    delete(opera);
  }
}

void Wesley::Comentario()
{
  Comentario_Robo = "\n Wesley_BB_Tamanho_Porcent BB: " + DoubleToString(Wesley_BB_Valor,2);
  Comentario_Robo = Comentario_Robo + "\n CalculaRSI: " + DoubleToString(Wesley_RSI_Valor,2);
  Comentario_Robo = Comentario_Robo + "\n Stoch: " + DoubleToString(Wesley_Stoch_Valor,2);
  Comentario_Robo = Comentario_Robo + "\n MFI: " + DoubleToString(Wesley_MF_Valor,2);
  Comentario_Robo = Comentario_Robo + "\n ADX: " + DoubleToString(Wesley_ADX_Valor,2);
  Comentario_Robo = Comentario_Robo + "\n\n";

//  Comentario_Robo = Comentario_Robo + "\n Wesley_BB_Delta_Valor: " + DoubleToString(Wesley_BB_Delta_Valor,2);
//  Comentario_Robo = Comentario_Robo + "\n Wesley_Volumes: " + DoubleToString(Wesley_Volumes,2);
  // Comentario_Robo = Comentario_Robo + "\n Wesley_BB_Tamanho_Porcent BB L: " + DoubleToString(Wesley_BB_ValorL,2);
  // Comentario_Robo = Comentario_Robo + "\n CalculaRSI (L): " + DoubleToString(Wesley_RSI_ValorL,2);
  // Comentario_Robo = Comentario_Robo + "\n Stoch (L): " + DoubleToString(Wesley_Stoch_ValorL,2);
  // Comentario_Robo = Comentario_Robo + "\n MFI (L): " + DoubleToString(Wesley_MF_ValorL,2);
//  Comentario_Robo = Comentario_Robo + "\n Wesley_BB_Delta_Valor (L): " + DoubleToString(Wesley_BB_Delta_Valor,2);
//  Comentario_Robo = Comentario_Robo + "\n Wesley_Volumes (L): " + DoubleToString(Wesley_Volumes,2);
  Comentario_Robo = Comentario_Robo + "\n\n";

  Comentario_Robo = Comentario_Robo + "\n Fuzzy_Respo(): " + DoubleToString(Wesley_Fuzzy_Valor,2);

}

//+------------------------------------------------------------------+
