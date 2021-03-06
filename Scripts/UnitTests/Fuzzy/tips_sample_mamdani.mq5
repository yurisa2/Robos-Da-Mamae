﻿//+------------------------------------------------------------------+
//|                                                     fuzzynet.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//| Implementation of FuzzyNet library in MetaQuotes Language 5(MQL5)|
//|                                                                  |
//| The features of the FuzzyNet library include:                    |
//| - Create Mamdani fuzzy model                                     |
//| - Create Sugeno fuzzy model                                      |
//| - Normal membership function                                     |
//| - Triangular membership function                                 |
//| - Trapezoidal membership function                                |
//| - Constant membership function                                   |
//| - Defuzzification method of center of gravity (COG)              |
//| - Defuzzification method of bisector of area (BOA)               |
//| - Defuzzification method of mean of maxima (MeOM)                |
//|                                                                  |
//| If you find any functional differences between FuzzyNet for MQL5 |
//| and the original FuzzyNet project , please contact developers of |
//| MQL5 on the Forum at www.mql5.com.                               |
//|                                                                  |
//| You can report bugs found in the computational algorithms of the |
//| FuzzyNet library by notifying the FuzzyNet project coordinators  |
//+------------------------------------------------------------------+
//|                         SOURCE LICENSE                           |
//|                                                                  |
//| This program is free software; you can redistribute it and/or    |
//| modify it under the terms of the GNU General Public License as   |
//| published by the Free Software Foundation (www.fsf.org); either  |
//| version 2 of the License, or (at your option) any later version. |
//|                                                                  |
//| This program is distributed in the hope that it will be useful,  |
//| but WITHOUT ANY WARRANTY; without even the implied warranty of   |
//| MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the     |
//| GNU General Public License for more details.                     |
//|                                                                  |
//| A copy of the GNU General Public License is available at         |
//| http://www.fsf.org/licensing/licenses                            |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property script_show_inputs
//+------------------------------------------------------------------+
//| Connecting libraries                                             |
//+------------------------------------------------------------------+
#include <Math\Fuzzy\MamdaniFuzzySystem.mqh>
//--- input parameters

input double Banda = 0;
input double Rsi = 30;
input double Estocastico = 20;
input double MoneyFI = 20;
input double BandaL = 0;
input double RsiL = 30;
input double EstocasticoL = 20;
input double MoneyFIL = 20;


//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
{

  double retorno = 0;

  // Bloco para nao estourar o FUzzão

  // Bloco para nao estourar o FUzzão



  //--- Mamdani Fuzzy System
  CMamdaniFuzzySystem *fsIpsus=new CMamdaniFuzzySystem();

  //--- Create Output
  CFuzzyVariable *fvIpsus=new CFuzzyVariable("tendencia",-100,100);
  fvIpsus.Terms().Add(new CFuzzyTerm("re_compra", new CSigmoidalMembershipFunction(-0.1,-50)));
  fvIpsus.Terms().Add(new CFuzzyTerm("re_intermediario", new CGeneralizedBellShapedMembershipFunction(0,3,28)));
  fvIpsus.Terms().Add(new CFuzzyTerm("re_venda", new CSigmoidalMembershipFunction(0.1,50)));
  fsIpsus.Output().Add(fvIpsus);


  //--- Set input value
  CList *in=new CList;

  //--- Create first input variables for the system
  CFuzzyVariable *fvBanda=new CFuzzyVariable("banda_bollinger",-50.0,150.0);
  fvBanda.Terms().Add(new CFuzzyTerm("BB_Compra", new CSigmoidalMembershipFunction(-0.1,0)));
  fvBanda.Terms().Add(new CFuzzyTerm("BB_Meio", new CGeneralizedBellShapedMembershipFunction(50,3,28)));
  fvBanda.Terms().Add(new CFuzzyTerm("BB_Venda", new CSigmoidalMembershipFunction(0.1,100)));
  fsIpsus.Input().Add(fvBanda);
  CMamdaniFuzzyRule *R_Compra_BB = fsIpsus.ParseRule("if (banda_bollinger is BB_Compra) then tendencia is re_compra");
  CMamdaniFuzzyRule *R_Meio_BB = fsIpsus.ParseRule("if (banda_bollinger is BB_Meio) then tendencia is re_intermediario");
  CMamdaniFuzzyRule *R_Venda_BB = fsIpsus.ParseRule("if (banda_bollinger is BB_Venda) then tendencia is re_venda");
  fsIpsus.Rules().Add(R_Compra_BB);
  fsIpsus.Rules().Add(R_Meio_BB);
  fsIpsus.Rules().Add(R_Venda_BB);
  CDictionary_Obj_Double *p_od_Banda=new CDictionary_Obj_Double;
  p_od_Banda.SetAll(fvBanda, Banda);
  in.Add(p_od_Banda);


  //--- Create first input variables for the system
  CFuzzyVariable *fvBandaBBL=new CFuzzyVariable("banda_bollinger_large",-50.0,150.0);
  fvBandaBBL.Terms().Add(new CFuzzyTerm("BBL_Compra", new CSigmoidalMembershipFunction(-0.1,0)));
  fvBandaBBL.Terms().Add(new CFuzzyTerm("BBL_Meio", new CGeneralizedBellShapedMembershipFunction(50,3,28)));
  fvBandaBBL.Terms().Add(new CFuzzyTerm("BBL_Venda", new CSigmoidalMembershipFunction(0.1,100)));
  fsIpsus.Input().Add(fvBandaBBL);
  CMamdaniFuzzyRule *R_Compra_BBL = fsIpsus.ParseRule("if (banda_bollinger_large is BBL_Compra) then tendencia is re_compra");
  CMamdaniFuzzyRule *R_Meio_BBL = fsIpsus.ParseRule("if (banda_bollinger_large is BBL_Meio) then tendencia is re_intermediario");
  CMamdaniFuzzyRule *R_Venda_BBL = fsIpsus.ParseRule("if (banda_bollinger_large is BBL_Venda) then tendencia is re_venda");
  fsIpsus.Rules().Add(R_Compra_BBL);
  fsIpsus.Rules().Add(R_Meio_BBL);
  fsIpsus.Rules().Add(R_Venda_BBL);
  CDictionary_Obj_Double *p_od_BandaL=new CDictionary_Obj_Double;
  p_od_BandaL.SetAll(fvBandaBBL, BandaL);
  in.Add(p_od_BandaL);

  //--- Create second input variables for the system
  CFuzzyVariable *fvRsi=new CFuzzyVariable("rsi_forca",0,100);
  fvRsi.Terms().Add(new CFuzzyTerm("RSI_Compra", new CSigmoidalMembershipFunction(-0.2,30)));
  fvRsi.Terms().Add(new CFuzzyTerm("RSI_Meio", new CGeneralizedBellShapedMembershipFunction(50,3,15)));
  fvRsi.Terms().Add(new CFuzzyTerm("RSI_Venda", new CSigmoidalMembershipFunction(0.2,70)));
  fsIpsus.Input().Add(fvRsi);
  CMamdaniFuzzyRule *R_Compra_RSI = fsIpsus.ParseRule("if (rsi_forca is RSI_Compra) then tendencia is re_compra");
  CMamdaniFuzzyRule *R_Meio_RSI = fsIpsus.ParseRule("if (rsi_forca is RSI_Meio) then tendencia is re_intermediario");
  CMamdaniFuzzyRule *R_Venda_RSI = fsIpsus.ParseRule("if (rsi_forca is RSI_Venda) then tendencia is re_venda");
  fsIpsus.Rules().Add(R_Compra_RSI);
  fsIpsus.Rules().Add(R_Meio_RSI);
  fsIpsus.Rules().Add(R_Venda_RSI);
  CDictionary_Obj_Double *p_od_Rsi=new CDictionary_Obj_Double;
  p_od_Rsi.SetAll(fvRsi, Rsi);
  in.Add(p_od_Rsi);

  //--- Create second input variables for the system
  CFuzzyVariable *fvRsil=new CFuzzyVariable("rsil_forca",0,100);
  fvRsil.Terms().Add(new CFuzzyTerm("RSIL_Compra", new CSigmoidalMembershipFunction(-0.2,30)));
  fvRsil.Terms().Add(new CFuzzyTerm("RSIL_Meio", new CGeneralizedBellShapedMembershipFunction(50,3,15)));
  fvRsil.Terms().Add(new CFuzzyTerm("RSIL_Venda", new CSigmoidalMembershipFunction(0.2,70)));
  fsIpsus.Input().Add(fvRsil);
  CMamdaniFuzzyRule *R_Compra_RSIL = fsIpsus.ParseRule("if (rsil_forca is RSIL_Compra) then tendencia is re_compra");
  CMamdaniFuzzyRule *R_Meio_RSIL = fsIpsus.ParseRule("if (rsil_forca is RSIL_Meio) then tendencia is re_intermediario");
  CMamdaniFuzzyRule *R_Venda_RSIL = fsIpsus.ParseRule("if (rsil_forca is RSIL_Venda) then tendencia is re_venda");
  fsIpsus.Rules().Add(R_Compra_RSIL);
  fsIpsus.Rules().Add(R_Meio_RSIL);
  fsIpsus.Rules().Add(R_Venda_RSIL);
  CDictionary_Obj_Double *p_od_RsiL=new CDictionary_Obj_Double;
  p_od_RsiL.SetAll(fvRsil, RsiL);
  in.Add(p_od_RsiL);
  
  //--- Create first input variables for the system
  CFuzzyVariable *fvStoch=new CFuzzyVariable("stoch",0,100);
  fvStoch.Terms().Add(new CFuzzyTerm("S_Compra", new CSigmoidalMembershipFunction(-0.15,20)));
  fvStoch.Terms().Add(new CFuzzyTerm("S_Meio", new CGeneralizedBellShapedMembershipFunction(50,3,20)));
  fvStoch.Terms().Add(new CFuzzyTerm("S_Venda", new CSigmoidalMembershipFunction(0.15,80)));
  fsIpsus.Input().Add(fvStoch);
  CMamdaniFuzzyRule *R_S_Compra = fsIpsus.ParseRule("if (stoch is S_Compra) then tendencia is re_compra");
  CMamdaniFuzzyRule *R_S_Meio = fsIpsus.ParseRule("if (stoch is S_Meio) then tendencia is re_intermediario");
  CMamdaniFuzzyRule *R_S_Venda = fsIpsus.ParseRule("if (stoch is S_Venda) then tendencia is re_venda");
  fsIpsus.Rules().Add(R_S_Compra);
  fsIpsus.Rules().Add(R_S_Meio);
  fsIpsus.Rules().Add(R_S_Venda);
  CDictionary_Obj_Double *p_od_Stoch=new CDictionary_Obj_Double;
  p_od_Stoch.SetAll(fvStoch, Estocastico);
  in.Add(p_od_Stoch);


  //--- Create first input variables for the system
  CFuzzyVariable *fvStochl=new CFuzzyVariable("stochL",0,100);
  fvStochl.Terms().Add(new CFuzzyTerm("SL_Compra", new CSigmoidalMembershipFunction(-0.15,20)));
  fvStochl.Terms().Add(new CFuzzyTerm("SL_Meio", new CGeneralizedBellShapedMembershipFunction(50,3,20)));
  fvStochl.Terms().Add(new CFuzzyTerm("SL_Venda", new CSigmoidalMembershipFunction(0.15,80)));
  fsIpsus.Input().Add(fvStochl);
  CMamdaniFuzzyRule *R_SL_Compra = fsIpsus.ParseRule("if (stochL is SL_Compra) then tendencia is re_compra");
  CMamdaniFuzzyRule *R_SL_Meio = fsIpsus.ParseRule("if (stochL is SL_Meio) then tendencia is re_intermediario");
  CMamdaniFuzzyRule *R_SL_Venda = fsIpsus.ParseRule("if (stochL is SL_Venda) then tendencia is re_venda");
  fsIpsus.Rules().Add(R_SL_Compra);
  fsIpsus.Rules().Add(R_SL_Meio);
  fsIpsus.Rules().Add(R_SL_Venda);
  CDictionary_Obj_Double *p_od_StochL=new CDictionary_Obj_Double;
  p_od_StochL.SetAll(fvStochl, EstocasticoL);
  in.Add(p_od_StochL);


  //--- Create first input variables for the system
  CFuzzyVariable *fvMFI=new CFuzzyVariable("mfi",0,100);
  fvMFI.Terms().Add(new CFuzzyTerm("MFI_Compra", new CSigmoidalMembershipFunction(-0.15,20)));
  fvMFI.Terms().Add(new CFuzzyTerm("MFI_Meio", new CGeneralizedBellShapedMembershipFunction(50,3,20)));
  fvMFI.Terms().Add(new CFuzzyTerm("MFI_Venda", new CSigmoidalMembershipFunction(0.15,80)));
  fsIpsus.Input().Add(fvMFI);
  CMamdaniFuzzyRule *R_MFI_Compra = fsIpsus.ParseRule("if (mfi is MFI_Compra) then tendencia is re_compra");
  CMamdaniFuzzyRule *R_MFI_Meio = fsIpsus.ParseRule("if (mfi is MFI_Meio) then tendencia is re_intermediario");
  CMamdaniFuzzyRule *R_MFI_Venda = fsIpsus.ParseRule("if (mfi is MFI_Venda) then tendencia is re_venda");
  fsIpsus.Rules().Add(R_MFI_Compra);
  fsIpsus.Rules().Add(R_MFI_Meio);
  fsIpsus.Rules().Add(R_MFI_Venda);
  CDictionary_Obj_Double *p_od_MoneyFI=new CDictionary_Obj_Double;
  p_od_MoneyFI.SetAll(fvMFI, MoneyFI);
  in.Add(p_od_MoneyFI);


  //--- Create first input variables for the system
  CFuzzyVariable *fvMFIL=new CFuzzyVariable("mfiL",0,100);
  fvMFIL.Terms().Add(new CFuzzyTerm("MFIL_Compra", new CSigmoidalMembershipFunction(-0.15,20)));
  fvMFIL.Terms().Add(new CFuzzyTerm("MFIL_Meio", new CGeneralizedBellShapedMembershipFunction(50,3,20)));
  fvMFIL.Terms().Add(new CFuzzyTerm("MFIL_Venda", new CSigmoidalMembershipFunction(0.15,80)));
  fsIpsus.Input().Add(fvMFIL);
  CMamdaniFuzzyRule *R_MFIL_Compra = fsIpsus.ParseRule("if (mfiL is MFIL_Compra) then tendencia is re_compra");
  CMamdaniFuzzyRule *R_MFIL_Meio = fsIpsus.ParseRule("if (mfiL is MFIL_Meio) then tendencia is re_intermediario");
  CMamdaniFuzzyRule *R_MFIL_Venda = fsIpsus.ParseRule("if (mfiL is MFIL_Venda) then tendencia is re_venda");
  fsIpsus.Rules().Add(R_MFIL_Compra);
  fsIpsus.Rules().Add(R_MFIL_Meio);
  fsIpsus.Rules().Add(R_MFIL_Venda);
  CDictionary_Obj_Double *p_od_MoneyFIL=new CDictionary_Obj_Double;
  p_od_MoneyFIL.SetAll(fvMFIL, MoneyFIL);
  in.Add(p_od_MoneyFIL);



  //--- Get result
  CList *result;
  CDictionary_Obj_Double *p_od_Ipsus;
  result=fsIpsus.Calculate(in);
  p_od_Ipsus=result.GetNodeAtIndex(0);

  retorno = p_od_Ipsus.Value();
  double Wesley_Fuzzy_Valor = retorno;

  delete in;
  delete result;
  delete fsIpsus;

  Print("Retorno Fuzzy: " + retorno) ;



}
//+------------------------------------------------------------------+
