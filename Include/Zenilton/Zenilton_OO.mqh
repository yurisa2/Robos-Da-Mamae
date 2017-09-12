/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                             SA2 - Investment soft|
//+------------------------------------------------------------------+

class Zenilton
{
  public:
  void Zenilton();
  void Avalia();
  void Zeni_Compra();
  void Zeni_Venda();
};

void Zenilton::Zenilton()
{
Direcao = 1;
}

void Zenilton::Avalia()
{
  if(Operacoes == 0 && TaDentroDoHorario_RT && JaZerou)
  {
    Stoch *estocastico_curto = new Stoch(10,3,3,Zeni_Periodo_Curto);
    MA *ema5_curto = new MA(5,MODE_EMA,Zeni_Periodo_Curto);
    MA *ema10_curto = new MA(10,MODE_EMA,Zeni_Periodo_Curto);
    RSI *rsi_curto = new RSI(9,Zeni_Periodo_Curto);

    Stoch *estocastico_longo = new Stoch(10,3,3,Zeni_Periodo_Longo);
    MA *ema5_longo = new MA(5,MODE_EMA,Zeni_Periodo_Longo);
    MA *ema10_longo = new MA(10,MODE_EMA,Zeni_Periodo_Longo);
    RSI *rsi_longo = new RSI(9,Zeni_Periodo_Longo);

    MACD *macd_curto = new MACD(12,26,9);

    int emas_longas = 0;
    int rsi_longo_tendencia = 0;
    int estocastico_longo_tendencia = 0;

    int emas_curtas = 0;
    int rsi_curto_tendencia = 0;
    int estocastico_curto_tendencia = 0;
    int macd_curto_tendencia = 0;
    int tendencia_longa = 0;
    int tendencia_curta = 0;

    if(ema5_longo.Valor() > ema10_longo.Valor())  emas_longas = 1;
    if(ema5_longo.Valor() < ema10_longo.Valor())  emas_longas = -1;

    if(rsi_longo.Valor() > 50) rsi_longo_tendencia = 1;
    if(rsi_longo.Valor() < 50) rsi_longo_tendencia = -1;

    if(estocastico_longo.Valor(0) > estocastico_longo.Valor(0,1) && estocastico_longo.Valor(0) < 80) estocastico_longo_tendencia = -1;
    if(estocastico_longo.Valor(0) < estocastico_longo.Valor(0,1) && estocastico_longo.Valor(0) > 20) estocastico_longo_tendencia = 1;


    if(ema5_curto.Valor() > ema10_curto.Valor())  emas_curtas = 1;
    if(ema5_curto.Valor() < ema10_curto.Valor())  emas_curtas = -1;

    if(rsi_curto.Valor() > 50) rsi_curto_tendencia = 1;
    if(rsi_curto.Valor() < 50) rsi_curto_tendencia = -1;

    if(estocastico_curto.Valor(0) > estocastico_curto.Valor(0,1) && estocastico_curto.Valor(0) < 80) estocastico_curto_tendencia = -1;
    if(estocastico_curto.Valor(0) < estocastico_curto.Valor(0,1) && estocastico_curto.Valor(0) > 20) estocastico_curto_tendencia = 1;

    if(macd_curto.Valor(0) < 0 && (macd_curto.Valor(0) > macd_curto.Valor(1))) macd_curto_tendencia = 1;
    if(macd_curto.Valor(0) > 0 && (macd_curto.Valor(0) < macd_curto.Valor(1))) macd_curto_tendencia = -1;

    tendencia_longa = rsi_longo_tendencia + estocastico_longo_tendencia + emas_longas;
    tendencia_curta = macd_curto_tendencia + emas_curtas + rsi_curto_tendencia + estocastico_curto_tendencia;

    if(tendencia_longa == 3 && tendencia_curta == 4) Zeni_Compra();
    if(tendencia_longa == -3 && tendencia_curta == -4) Zeni_Venda();

    delete(estocastico_longo);
    delete(ema5_longo);
    delete(ema10_longo);
    delete(rsi_longo);
    delete(estocastico_curto);
    delete(ema5_curto);
    delete(ema10_curto);
    delete(rsi_curto);
    delete(macd_curto);
  }
}

void Zenilton::Zeni_Compra()
{
  if(TaDentroDoHorario_RT==true && JaZerou)
  {

    if(Operacoes==0 && OperacoesFeitas < (Limite_Operacoes*2) && Saldo_Dia_Permite() == true &&  (  (Usa_Prop == true && Prop_Delta() > Prop_Limite_Minimo) || Usa_Fixos == true ) )
    {
      DeuStopLoss = false;
      DeuTakeProfit = false;
      Ordem = false;
      Direcao = 0;
      MontarRequisicao(ORDER_TYPE_BUY,"Entrada Zenilton");
    }
  }
}

void Zenilton::Zeni_Venda()
{
  if(TaDentroDoHorario_RT==true && JaZerou)
  {

    if(Operacoes==0 && OperacoesFeitas < (Limite_Operacoes*2) && Saldo_Dia_Permite() == true &&  (  (Usa_Prop == true && Prop_Delta() > Prop_Limite_Minimo) || Usa_Fixos == true ) )
    {
      DeuStopLoss = false;
      DeuTakeProfit = false;
      Ordem = false;
      Direcao = 0;
      MontarRequisicao(ORDER_TYPE_SELL,"Entrada Zenilton");
    }
  }
}
