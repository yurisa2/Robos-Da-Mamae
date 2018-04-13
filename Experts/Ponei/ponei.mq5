//+------------------------------------------------------------------+
//|                                                     TestMLPs.mq5 |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
#include "class_NetMLP.mqh"
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
input int camadas = 2;
input int primeira_camada = 6;
input int segunda_camada = 6;
input int terceira_camada = 1;


input int epocas = 1000;
input int amostras = 1000;

double vector[5];   // Input vector
int snn[];    // Network structure: the first layer  - 3 neurons, the second (output) one - 1 neuron
double out[1];      // The network responses array

double mse = 0;


double EntradaTeach[]; // Input teaching data array
double SaidaTeach[];            // Output teaching data array
//---
int n_patterns = 0;



//+-----------------------------------------------------------------+
void OnInit()
{


  if(camadas==1)
  {
    ArrayResize(snn,2);
    snn[0] = primeira_camada;
    snn[1] = 1;
  }

  if(camadas==2)
  {
    ArrayResize(snn,3);
    snn[0] = primeira_camada;
    snn[1] = segunda_camada;
    snn[2] = 1;
  }

  if(camadas==3)
  {
    ArrayResize(snn,4);
    snn[0] = primeira_camada;
    snn[1] = segunda_camada;
    snn[2] = terceira_camada;
    snn[3] = 1;
}

  double b_m_1 = 0;
  double b_m_2 = 0;
  double b_m_3 = 0;
  double b_m_4 = 0;
  double b_m_5 = 0;
  double resp = 0;


  for(int i=0; i<amostras;i++) {
    int tamanho_entrada = (i+1)*5;
    ArrayResize(EntradaTeach,tamanho_entrada);
    ArrayResize(SaidaTeach,i+1);

    // double m_1 = MathRand() * 3.05/100000;
    // double m_2 = MathRand() * 3.05/100000;

    //Proposta Inicial é

    double m_1 = MathRand() * 3.05/100000;  //Preco Normalizado 1
    double m_2 = MathRand() * 3.05/100000;  //Preco Normalizado 2
    double m_3 = MathRand() * 3.05/100000;  //Preco Normalizado 3
    double m_4 = MathRand() * 3.05/100000;  //CX Preco
    double m_5 = MathRand() * 3.05/100000;  //BBPP



    EntradaTeach[ArraySize(EntradaTeach)-5] = NormalizeDouble(m_1,2);
    EntradaTeach[ArraySize(EntradaTeach)-4] = NormalizeDouble(m_2,2);
    EntradaTeach[ArraySize(EntradaTeach)-3] = NormalizeDouble(m_3,2);
    EntradaTeach[ArraySize(EntradaTeach)-2] = NormalizeDouble(m_4,2);
    EntradaTeach[ArraySize(EntradaTeach)-1] = NormalizeDouble(m_5,2);

    b_m_1 = EntradaTeach[ArraySize(EntradaTeach)-5];
    b_m_2 = EntradaTeach[ArraySize(EntradaTeach)-4];
    b_m_3 = EntradaTeach[ArraySize(EntradaTeach)-3];
    b_m_4 = EntradaTeach[ArraySize(EntradaTeach)-2];
    b_m_5 = EntradaTeach[ArraySize(EntradaTeach)-1];


    SaidaTeach[i] = (m_1 + m_2 + m_3 + m_4 + m_5)/5;
    resp = SaidaTeach[i];
  }
  n_patterns = ArraySize(SaidaTeach);

  // PrintFormat("n_patterns: %i ",n_patterns);
  // PrintFormat("ArraySize(EntradaTeach): %1",ArraySize(EntradaTeach));


  //captação
  //AC, ATR, BBDB, BBDV, BbP, BULLS_P

  CNetMLP *net;
  int epoch=epocas;
  //---
  // Print("Agora é media denovo com 5 caboco, CAZZO!");
  //--- for the input data range -1..1 the active function hyperbolic tangent is used
  int AFT=0;
  //--- network creation
  net=new CNetMLP(ArraySize(snn),snn,2,AFT);
  //--- network teaching
  //--- number of patterns, input data array, output data array, permissible error
  net.Learn(n_patterns,EntradaTeach,SaidaTeach,epoch,1.0e-8);
  // Print("MSE=",net.mse,"  Epoch=",net.epoch);
mse = net.mse;
  vector[0] = b_m_1;
  vector[1] = b_m_2;
  vector[2] = b_m_3;
  vector[3] = b_m_4;
  vector[4] = b_m_5;

  net.Calculate(vector,out);
//   Print("Input=",
//   (string)vector[0],", ",
//   (string)vector[1],", ",
//   (string)vector[2],", ",
//   (string)vector[3],", ",
//   (string)vector[4],", ",
//   " Output=",DoubleToString(out[0])
//
// );

// Print("b_m_1 " + b_m_1);
// Print("b_m_2 " + b_m_2);
// Print("b_m_3 " + b_m_3);
// Print("b_m_4 " + b_m_4);
// Print("b_m_5 " + b_m_5);
Print("Resposta="+resp+", Net="+out[0]+
", MSE="+mse+", Amostras="+amostras+", Epoch="+epocas+
", RNA="+primeira_camada+","+segunda_camada+","+terceira_camada);


delete net;
//---
}
//+------------------------------------------------------------------+

double OnTester()
{
  return mse;
}
