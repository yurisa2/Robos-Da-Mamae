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
bool comb_exist(string& array_ent[][10], string& combination[]) {
  bool retorno = 0;
  int size_comb = ArrayRange(combination,0);

  string array_temp[];
  ArrayResize(array_temp,size_comb);

  for (int i = 0; i < ArrayRange(array_ent,0); i++) { // Linhas
    for (int j = 0; j < size_comb; j++) {
      array_temp[j] = array_ent[i][j];
    }
    // Print("ArrayCompare(array_ent,combination) " + ArrayCompare(array_temp,combination));

    if(ArrayCompare(array_temp,combination) == 0) {
      retorno = 1;
      break;
    }
  }
  return retorno;
}

void generate_random_idx(string& options[],int num_vars,int& random_output[]) {
  MathSrand(TimeLocal());
  int size_t = num_vars;
  int options_size = ArrayRange(options,0);

  ArrayResize(random_output,size_t);

  for (int i = 0; i < size_t; i++) {
    int num = MathRand()%options_size;        // random number between 0 to 4 (even distribution)
    random_output[i] = num;
  }
}

int get_next_idx(string& final_ar[][10]) {

  for (int i = 0; i < ArrayRange(final_ar,0); i++) {
    if(final_ar[i][0] == NULL) return i;
  }

return ArrayRange(final_ar,0);
}


void OnStart()
{
  string final_ar[][10];

  string options[] = {"a1","a2","a3","a4"};

  int num_vars = 5;

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



  Print("Num Posicoes: " + MathPow(ArrayRange(options,0),num_vars));

  while (get_next_idx(final_ar) < (ArrayRange(final_ar,0))) {

    int next = get_next_idx(final_ar);

    string generated[];
    ArrayResize(generated, num_vars);
    int random_output[];
    generate_random_idx(options,num_vars,random_output);


    string combination[];
    ArrayResize(combination,num_vars);

    // ArrayPrint(random_output);

    for (int i = 0; i < num_vars; i++) {
      combination[i] = options[random_output[i]];
    }

    if(!comb_exist(final_ar,combination)) {
      for (int i = 0; i < num_vars; i++) {
        final_ar[next][i] = combination[i];
      }
    }

  }

  //
  ArrayPrint(final_ar);
  ArrayPrint(options);
}
