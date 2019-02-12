//+------------------------------------------------------------------+
//|                                                         HiLo.mq5 |
//|                                  Copyright 2010, Charly King Her |
//|                                   www.bussinessclubworldwide.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2010, Charly King Her"
#property link      "www.bussinessclubworldwide.com"
#property version   "1.00"
#property indicator_separate_window

#property indicator_buffers 2
#property indicator_plots   2
//+------------------------------------------------------------------+
#property indicator_label1  "Wesley"
#property indicator_type1   DRAW_LINE
#property indicator_color1  Yellow
#property indicator_style1  STYLE_SOLID
#property indicator_width1  2
#property indicator_label2   "data"
#property indicator_type1   DRAW_LINE
#property indicator_color2   Yellow
#property indicator_style2 STYLE_SOLID
#property indicator_width2   2

#property indicator_minimum -100
#property indicator_maximum 100

//+------------------------------------------------------------------+
bool Wesley_Permite_Large = false;         //Permite o uso de 2 timeframes (large)
ENUM_TIMEFRAMES Wesley_Large = PERIOD_CURRENT;                                         //Periodo Large

bool Wesley_BBG_Enable = false;
bool Wesley_RSIG_Enable = false;
bool Wesley_StochG_Enable = false;
bool Wesley_MFIG_Enable = false;

bool Wesley_BBL_Enable = false; //BBL Enable
bool Wesley_RSIL_Enable = false; //RSIL Enable
bool Wesley_StochL_Enable = false; //StochL Enable
bool Wesley_MFIL_Enable = false;  //MFIL Enable

double Tick_Size = SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_SIZE);
double daotick_geral;

//
input string Indicadores_Especificos = "-------------------------------------";
input bool Wesley_BB_Enable = true; //BB Enable
input bool Wesley_RSI_Enable = true; //RSI Enable
input bool Wesley_Stoch_Enable = true; //Stoch Enable
input bool Wesley_MFI_Enable = true; //MFI Enable
//+------------------------------------------------------------------+
double         RatesTotal[];
double         indice[];


ENUM_TIMEFRAMES TimeFrame = PERIOD_CURRENT;

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
  double Wesley::Fuzzy_Respo(double Banda = 0, double Rsi = 50, double Estocastico = 50, double MoneyFI = 50,
    double BandaL = 0, double RsiL = 50, double EstocasticoL = 50, double MoneyFIL = 50, double Wesley_ADX = 50);
    void Get_Dados(int barra = 0);
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
    Get_Dados(barra);
  }

  void Wesley::Get_Dados(int barra = 0)
  {

    BB *Banda_BB = new BB(TimeFrame);
    RSI *RSI_OO = new RSI(14,TimeFrame);
    Stoch *Stoch_OO = new Stoch(10,3,3,TimeFrame);
    MFI *MFI_OO = new MFI(TimeFrame);
    Volumes *Volumes_OO = new Volumes(NULL,TimeFrame);
    ADX *ADX_OO = new ADX(14,TimeFrame);

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


  #include <Wesley\Wesley_Fuzzy.mqh>
  #include <Math\Fuzzy\MamdaniFuzzySystem.mqh>


  #include <Indicadores\RSI_OO.mqh>
  #include <Indicadores\BB.mqh>
  #include <Indicadores\MACD.mqh>
  #include <Indicadores\Stoch.mqh>
  #include <Indicadores\MFI.mqh>
  #include <Indicadores\Volumes.mqh>
  #include <Indicadores\ADX.mqh>

  //+------------------------------------------------------------------+
  //| Custom indicator initialization function                         |
  //+------------------------------------------------------------------+
  int OnInit()
  {
    SetIndexBuffer(0,RatesTotal,INDICATOR_DATA);
    SetIndexBuffer(1,indice,INDICATOR_DATA);

    return(0);
  }
  //+------------------------------------------------------------------+
  //| Custom indicator iteration function                              |
  //+------------------------------------------------------------------+
  int OnCalculate(const int rates_total,
    const int prev_calculated,
    const datetime &time[],
    const double &open[],
    const double &high[],
    const double &low[],
    const double &close[],
    const long &tick_volume[],
    const long &volume[],
    const int &spread[])
    {

      for(int idx=1; idx < rates_total; idx++)
      {
        daotick_geral = close[idx];

        if((rates_total - idx) < 1000 )
        {
          Wesley *Wesley_OO = new Wesley(rates_total - idx);
          // RatesTotal[idx] =    rates_total - idx;
          RatesTotal[idx] = Wesley_OO.Wesley_Fuzzy_Valor;
          // indice[idx] = rates_total - idx;
          indice[idx] = close[0];
          delete(Wesley_OO);
        }
        else RatesTotal[idx] = 0;
      }
      return(rates_total);
    }
