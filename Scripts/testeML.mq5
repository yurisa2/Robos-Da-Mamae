//+------------------------------------------------------------------+
//|                                  Script descarga Indicadores.mq5 |
//|                             Copyright 2015, José Miguel Soriano. |
//+------------------------------------------------------------------+

#include <ML.mqh>




//+------------------------------------------------------------------+
void OnStart()              //Conversor binario a decimal
{

  ML *machine_learning = new ML;

  for(int i = 0; i < 215; i++)
  {
    double numero1 = 0.7787;
    // Print("Numer1 na entrada " + numero1);
    string linha = i + "," + numero1  ;
    machine_learning.Append(linha);
  }

  Print("Matriz[0][0]" + machine_learning.Matriz[0][0]);
  Print("Matriz[0][1]" + machine_learning.Matriz[0][1]);
  Print("Matriz[0][2]" + machine_learning.Matriz[0][2]);
  Print("Matriz[0][3]" + machine_learning.Matriz[0][3]);
  Print("Matriz[0][4]" + machine_learning.Matriz[0][4]);
  Print("Matriz[0][5]" + machine_learning.Matriz[0][5]);
  Print("Matriz[0][6]" + machine_learning.Matriz[0][6]);
  Print("Matriz[0][7]" + machine_learning.Matriz[0][7]);

  machine_learning.ML_Save("teste_ML.txt");
  delete machine_learning;
}
