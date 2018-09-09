/* -*- C++ -*- */
#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"



class MACD
{
  public:
  void MACD(int fast_ema_period = 12,int slow_ema_period = 26,int signal_period = 9,string symbol = NULL, ENUM_TIMEFRAMES period = PERIOD_CURRENT, ENUM_APPLIED_PRICE applied_price = PRICE_CLOSE);
  double Valor(int buffer = 0, int barra = 0);
  double Cx(int buffer = 0);
  double MACD::Normalizacao_Valores_MACD(int buffer = 0, int ponteiro = 0, int universo = -1,int periods = 7); //Universo 0 = Linha MACD, 1 = Sinal, -1 = INCLUI O ZERO
  double MACD::Distancia_Linha_Zero(int ponteiro = 0);
  double MACD::Distancia_Linha_Sinal(int ponteiro = 0);
  double MACD::Diferenca_Angulo_Linha_Sinal();


  private:
  int HandleMACD;

};

void MACD::MACD(int fast_ema_period = 12,int slow_ema_period = 26,int signal_period = 9,string symbol = NULL, ENUM_TIMEFRAMES period = PERIOD_CURRENT, ENUM_APPLIED_PRICE applied_price = PRICE_CLOSE)
{
  HandleMACD = 0;
  HandleMACD = iMACD(symbol,period,fast_ema_period,slow_ema_period,signal_period,applied_price);
  // ChartIndicatorAdd(0,1,HandleMACD);

  // Print("Handle MACD: " + IntegerToString(HandleMACD)); //DEBUG

  if(HandleMACD == 0)
  {
    ExpertRemove();
  }
}

double MACD::Valor(int buffer = 0, int barra = 0)
{
  double _MACD[];
  double retorno = NULL;

  ArraySetAsSeries(_MACD, true);
  int MACD_copied = CopyBuffer(HandleMACD,buffer,0,barra+5,_MACD);

  retorno = _MACD[barra];

  return(retorno);
}

double MACD::Normalizacao_Valores_MACD(int buffer = 0, int ponteiro = 0, int universo = -1,int periods = 7)
{
  double retorno = NULL; //Pag 128

  double Linha1 = Valor(0,6);
  double Sinal1 = Valor(1,6);
  double Linha2 = Valor(0,5);
  double Sinal2 = Valor(1,5);
  double Linha3 = Valor(0,4);
  double Sinal3 = Valor(1,4);
  double Linha4 = Valor(0,3);
  double Sinal4 = Valor(1,3);
  double Linha5 = Valor(0,2);
  double Sinal5 = Valor(1,2);
  double Linha6 = Valor(0,1);
  double Sinal6 = Valor(1,1);
  double Linha7 = Valor(0,0);
  double Sinal7 = Valor(1,0);

  double Valores[14];
  Valores[0] = Linha1;
  Valores[1] = Sinal1;
  Valores[2] = Linha2;
  Valores[3] = Sinal2;
  Valores[4] = Linha3;
  Valores[5] = Sinal3;
  Valores[6] = Linha4;
  Valores[7] = Sinal4;
  Valores[8] = Linha5;
  Valores[9] = Sinal5;
  Valores[10] = Linha6;
  Valores[11] = Sinal6;
  Valores[12] = Linha7;
  Valores[13] = Sinal7;

  double Linha[7];
  Linha[0] = Linha1;
  Linha[1] = Linha2;
  Linha[2] = Linha3;
  Linha[3] = Linha4;
  Linha[4] = Linha5;
  Linha[5] = Linha6;
  Linha[6] = Linha7;

  double Sinal[7];
  Sinal[0] = Sinal1;
  Sinal[1] = Sinal2;
  Sinal[2] = Sinal3;
  Sinal[3] = Sinal4;
  Sinal[4] = Sinal5;
  Sinal[5] = Sinal6;
  Sinal[6] = Sinal7;

  double Z_min_calculado = NULL;
  double Z_max_calculado = NULL;

  if(universo == -1)
  {
      Z_min_calculado = Valores[ArrayMinimum(Valores)];
      Z_max_calculado = Valores[ArrayMaximum(Valores)];

      if(ponteiro == -1)
      {
        Z_min_calculado = MathMin(Valores[ArrayMinimum(Valores)],0);
        Z_max_calculado = MathMax(Valores[ArrayMaximum(Valores)],0);
      }
    }

  if(universo == 0)
  {
      Z_min_calculado = Linha[ArrayMinimum(Linha)];
      Z_max_calculado = Linha[ArrayMaximum(Linha)];

      if(ponteiro == -1)
      {
        Z_min_calculado = MathMin(Linha[ArrayMinimum(Linha)],0);
        Z_max_calculado = MathMax(Linha[ArrayMaximum(Linha)],0);
      }
    }

  if(universo == 1)
  {
      Z_min_calculado = Sinal[ArrayMinimum(Sinal)];
      Z_max_calculado = Sinal[ArrayMaximum(Sinal)];

      if(ponteiro == -1)
      {
        Z_min_calculado = MathMin(Sinal[ArrayMinimum(Sinal)],0);
        Z_max_calculado = MathMax(Sinal[ArrayMaximum(Sinal)],0);
      }
    }

  double Z_Minimo = Z_min_calculado;
  double Z_Maximo = Z_max_calculado;

  double zi = NULL;

  if(ponteiro == -1) zi = 0;
  else zi = Valor(buffer,ponteiro);


  double Z_max_menos_Z_min = Z_Maximo - Z_Minimo;
  if(Z_max_menos_Z_min == 0) Z_max_menos_Z_min = 0.00000000000000000000000001;


  retorno = (zi - Z_Minimo) / (Z_max_menos_Z_min);

  return(retorno);
}



double MACD::Cx(int buffer = 0)
{
  double retorno = NULL;


  double ya = Normalizacao_Valores_MACD(buffer,2);
  double yb = Normalizacao_Valores_MACD(buffer,1);
  double yc = Normalizacao_Valores_MACD(buffer,0);

  double y_media = (ya + yb + yc ) /3;

  double aF1 = -1;
  double bF1 = 0;
  double cF1 = 1;

  double aF2 = ya - y_media;
  double bF2 = yb - y_media;
  double cF2 = yc - y_media;

  double aF3 = aF1 * aF2;
  double bF3 = bF1 * bF2;
  double cF3 = cF1 * cF2;

  double aF4 = 1;
  double bF4 = 0;
  double cF4 = 1;

  double beta = (aF3 + bF3 + cF3) / (aF4 + bF4 + cF4);

  // retorno = beta;
  retorno = MathArctan(beta);

  return(retorno);
}

double MACD::Distancia_Linha_Zero(int ponteiro = 0)
{
  double retorno = NULL;

  retorno = Normalizacao_Valores_MACD(0,ponteiro,-1) -  Normalizacao_Valores_MACD(0,-1,-1);

return retorno;
}

double MACD::Distancia_Linha_Sinal(int ponteiro = 0)
{
  double retorno = NULL;

  retorno = Normalizacao_Valores_MACD(0,ponteiro,-1) -  Normalizacao_Valores_MACD(1,ponteiro,-1);

return retorno;
}


double MACD::Diferenca_Angulo_Linha_Sinal()
{
  double retorno = NULL;

  retorno = Cx(0) -  Cx(1);

return retorno;
}
