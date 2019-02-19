//+------------------------------------------------------------------+
//|                                                     fileread.mq5 |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Sa2"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <File_Reader.mqh>

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---


  File_Read *file_read = new File_Read("teste.txt");

   ArrayPrint(file_read.linha_str_array);
   
  }
//+------------------------------------------------------------------+
