//+------------------------------------------------------------------+
//|                                                  xeon_script.mq5 |
//|                                                              Sa2 |
//|                                           https://www.sa2.com.br |
//+------------------------------------------------------------------+
#property copyright "Sa2"
#property link      "https://www.sa2.com.br"
#property version   "1.00"
#property script_show_inputs

void combinationUtil(int& arr[], int& data[], int start, int end,
  int index, int r, int& final_ar[][10])
  {
    if (index == r)    {
      for (int j=0; j<r; j++){
        if(j < r) final_ar[linhas][j] = data[j];
      }
      linhas++;
      return;
    }

    for (int i=start; i<=end; i++)     {
      data[index] = arr[i];
      combinationUtil(arr, data, 0, end, index+1, r,final_ar);
    }
  }

  int linhas = 0;
  void OnStart()
  {
    int arr[] = {1,2,3};
    int r = 2;
    int n = sizeof(arr)/sizeof(arr[0]);

    int final_ar[][10];
    int combinations = int(MathPow(ArrayRange(arr,0),r));
    ArrayResize(final_ar,combinations);

    int data[];
    ArrayResize(data,r);
    combinationUtil(arr, data, 0, n-1, 0, r,final_ar);

    ArrayPrint(final_ar);
  }
