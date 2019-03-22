//+------------------------------------------------------------------+
//|                                                  xeon_script.mq5 |
//|                                                              Sa2 |
//|                                           https://www.sa2.com.br |
//+------------------------------------------------------------------+
#property copyright "Sa2"
#property link      "https://www.sa2.com.br"
#property version   "1.00"
#property script_show_inputs

int return_rev(int size_, int index) {
  int retorno = 0;

  if(index > (size_-1)) {
    int tam_multiplos = int(MathFloor(index/size_));

    // Print(tam_multiplos); //DEBUG

    retorno = index - (tam_multiplos * size_);

  } else {
    retorno = index;
  }

  return retorno;
}

void OnStart()
{
  string final_ar[][10];
  string options[] = {"a1","a2", "a3"};
  int num_vars = 3;
  string results[];
  int combinations = int(MathPow(ArrayRange(options,0),num_vars));
  int total_numbers = combinations;

  Print("Num Posicoes: " + combinations);



  // ArrayResize(results,total_numbers);
  ArrayResize(results,ArrayRange(options,0));
  ArrayResize(final_ar,combinations);

  int w_i = 0;

  while (w_i < ArrayRange(results,0)) {
    for (int i = 0; i < ArrayRange(options,0); i++) {
      results[w_i] = options[i];
      w_i++;
    }
  }


  // for (int i = 0; i < 30; i++) {
  //   int new_i = return_rev(ArrayRange(results,0),i);
  //
  //   Print("index " + i + " Value " + results[new_i]);
  // }

  for (int i = 0; i < combinations; i++) {
    for (int j = 0; j < num_vars; j++) {
      int temp_i = i + j;

      int new_i = return_rev(ArrayRange(results,0),temp_i);

      final_ar[i][j] = results[new_i];

    }
  }

  ArrayPrint(results);

  ArrayPrint(final_ar);
}
