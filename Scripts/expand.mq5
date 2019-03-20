//+------------------------------------------------------------------+
//|                                                  xeon_script.mq5 |
//|                                                              Sa2 |
//|                                           https://www.sa2.com.br |
//+------------------------------------------------------------------+
#property copyright "Sa2"
#property link      "https://www.sa2.com.br"
#property version   "1.00"
#property script_show_inputs

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
    string final_ar[][10];

    string options[] = {"a1","a2"};

    int num_vars = 2;


    string results[];

    ArrayResize(results,int(MathPow(ArrayRange(options,0),num_vars)));

    ArrayResize(final_ar,int(MathPow(ArrayRange(options,0),num_vars)));

    int w_i = 0;

    while (w_i < ArrayRange(results,0)) {
      for (int i = 0; i < ArrayRange(options,0); i++) {
        results[w_i] = options[i];
        w_i++;
      }
    }


string




//Preencher na vertical parece bom

for (int col_j = 0; col_j < num_vars; col_j++) {

for (int lin_i = 0; lin_i < MathPow(ArrayRange(options,0),num_vars); lin_i++) {
  int pseudo_i = lin_i;
  if(pseudo_i == ArrayRange(options,0)) pseudo_i = lin_i - (lin_i -  ArrayRange(options,0));

  final_ar[lin_i][col_j] = options[pseudo_i];

  pseudo_i++;

}
}


Print("Num Posicoes: " + MathPow(ArrayRange(options,0),num_vars));



    ArrayPrint(options);
    ArrayPrint(final_ar);
  }
