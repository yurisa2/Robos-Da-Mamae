/* -*- C++ -*- */

class Xasmus
{

  public:
  void Avalia();

};


void Xasmus::Avalia()
{

  HiLo_OO *hilo = new HiLo_OO(4);
  int direcao = hilo.Direcao();
  MqlRates rates[];
  int copied=CopyRates(Symbol(),TimeFrame,0,100,rates);
    ArraySetAsSeries(rates,true);

  double lucro = rates[0].open - rates[1].open;

  // Print("Rates 0 " +  rates[0].open);
  // Print("Rates 1 " +  rates[1].open);
  Filtro_Fuzzy_Arquivo_Fisico = true;

  RSI *rsi_m1 = new RSI(14,PERIOD_M1);
  RSI *rsi_m5 = new RSI(14,PERIOD_M5);
  RSI *rsi_m10 = new RSI(14,PERIOD_M10);
  RSI *rsi_m15 = new RSI(14,PERIOD_M15);
  RSI *rsi_m30 = new RSI(14,PERIOD_M30);
  RSI *rsi_h1 = new RSI(14,PERIOD_H1);
  RSI *rsi_h4 = new RSI(14,PERIOD_H4);

  BB *bb_m1 = new BB(PERIOD_M1);
  BB *bb_m5 = new BB(PERIOD_M5);
  BB *bb_m10 = new BB(PERIOD_M10);
  BB *bb_m15 = new BB(PERIOD_M15);
  BB *bb_m30 = new BB(PERIOD_M30);
  BB *bb_h1 = new BB(PERIOD_H1);
  BB *bb_h4 = new BB(PERIOD_H4);

  string rsi_m1_var = DoubleToString(rsi_m1.Valor(0));
  string rsi_m5_var = DoubleToString(rsi_m5.Valor(0));
  string rsi_m10_var = DoubleToString(rsi_m10.Valor(0));
  string rsi_m15_var = DoubleToString(rsi_m15.Valor(0));
  string rsi_m30_var = DoubleToString(rsi_m30.Valor(0));
  string rsi_h1_var = DoubleToString(rsi_h1.Valor(0));
  string rsi_h4_var = DoubleToString(rsi_h4.Valor(0));

  string bbpp_m1_var = DoubleToString(bb_m1.BB_Posicao_Percent(0));
  string bbpp_m5_var = DoubleToString(bb_m5.BB_Posicao_Percent(0));
  string bbpp_m10_var = DoubleToString(bb_m10.BB_Posicao_Percent(0));
  string bbpp_m15_var = DoubleToString(bb_m15.BB_Posicao_Percent(0));
  string bbpp_m30_var = DoubleToString(bb_m30.BB_Posicao_Percent(0));
  string bbpp_h1_var = DoubleToString(bb_h1.BB_Posicao_Percent(0));
  string bbpp_h4_var = DoubleToString(bb_h4.BB_Posicao_Percent(0));


    delete(rsi_m1);
    delete(rsi_m5);
    delete(rsi_m10);
    delete(rsi_m15);
    delete(rsi_m30);
    delete(rsi_h1);
    delete(rsi_h4);

    delete(bb_m1);
    delete(bb_m5);
    delete(bb_m10);
    delete(bb_m15);
    delete(bb_m30);
    delete(bb_h1);
    delete(bb_h4);

  File_Gen *xasmus_file = new File_Gen("."+Symbol()+".csv","APPEND");

  string xasmus_line =
                    TimeToString(TimeCurrent(),TIME_DATE|TIME_SECONDS) + "," +
                    Symbol()  + "," +
                    DoubleToString(rates[0].open) + "," +
                    IntegerToString(direcao) + "," +
                    DoubleToString(lucro)  + "," +
                    rsi_m1_var + "," +
                    rsi_m5_var + "," +
                    rsi_m10_var + "," +
                    rsi_m15_var + "," +
                    rsi_m30_var + "," +
                    rsi_h1_var + "," +
                    rsi_h4_var + "," +
                    bbpp_m1_var + "," +
                    bbpp_m5_var + "," +
                    bbpp_m10_var + "," +
                    bbpp_m15_var + "," +
                    bbpp_m30_var + "," +
                    bbpp_h1_var + "," +
                    bbpp_h4_var
                    ;

  xasmus_file.Linha(xasmus_line);

  delete(xasmus_file);
  delete(hilo);
}
