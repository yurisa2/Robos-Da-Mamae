//+------------------------------------------------------------------+
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
// double   Banda;
// double   Rsi;
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
double Fuzzy_Respo(double Banda, double Rsi)
  {
    if(Banda < -49) Banda = 0;
    if(Banda > 149) Banda = 149;
//--- Mamdani Fuzzy System
   CMamdaniFuzzySystem *fsIpsus=new CMamdaniFuzzySystem();
//--- Create first input variables for the system
   CFuzzyVariable *fvBanda=new CFuzzyVariable("banda_bollinger",-50.0,150.0);
   fvBanda.Terms().Add(new CFuzzyTerm("compra", new CTriangularMembershipFunction(-50.0, 0.0, 50.0)));
   fvBanda.Terms().Add(new CFuzzyTerm("neutro", new CTriangularMembershipFunction(20.0, 50.0, 80.0)));
   fvBanda.Terms().Add(new CFuzzyTerm("venda", new CTriangularMembershipFunction(50.0, 100.0, 150.0)));
   fsIpsus.Input().Add(fvBanda);
//--- Create second input variables for the system
   CFuzzyVariable *fvRsi=new CFuzzyVariable("rsi_forca",0.0,100.0);
   fvRsi.Terms().Add(new CFuzzyTerm("queda", new CTrapezoidMembershipFunction(60,70,99,99)));
   fvRsi.Terms().Add(new CFuzzyTerm("boia", new CTrapezoidMembershipFunction(30,45,55,70)));
   fvRsi.Terms().Add(new CFuzzyTerm("alta", new CTrapezoidMembershipFunction(0,0,30,40)));
   fsIpsus.Input().Add(fvRsi);
//--- Create Output
   CFuzzyVariable *fvIpsus=new CFuzzyVariable("tendencia",-100.0,100.0);
   fvIpsus.Terms().Add(new CFuzzyTerm("re_venda", new CNormalMembershipFunction(100.0,2)));
   fvIpsus.Terms().Add(new CFuzzyTerm("re_faz_nada", new CNormalMembershipFunction(0.0,2)));
   fvIpsus.Terms().Add(new CFuzzyTerm("re_compra", new CNormalMembershipFunction(-100.0,2)));
   fsIpsus.Output().Add(fvIpsus);
//--- Create three Mamdani fuzzy rule
   CMamdaniFuzzyRule *rule1 = fsIpsus.ParseRule("if (banda_bollinger is compra )  and (rsi_forca is alta) then tendencia is re_compra");
   CMamdaniFuzzyRule *rule2 = fsIpsus.ParseRule("if (banda_bollinger is venda )  and (rsi_forca is queda) then tendencia is re_venda");
   CMamdaniFuzzyRule *rule3 = fsIpsus.ParseRule("if (banda_bollinger is neutro) or (rsi_forca is boia) then tendencia is re_faz_nada");
//--- Add three Mamdani fuzzy rule in system
   fsIpsus.Rules().Add(rule1);
   fsIpsus.Rules().Add(rule2);
   fsIpsus.Rules().Add(rule3);
//--- Set input value
   CList *in=new CList;
   CDictionary_Obj_Double *p_od_Banda=new CDictionary_Obj_Double;
   CDictionary_Obj_Double *p_od_Rsi=new CDictionary_Obj_Double;
   p_od_Banda.SetAll(fvBanda, Banda);
   p_od_Rsi.SetAll(fvRsi, Rsi);
   in.Add(p_od_Banda);
   in.Add(p_od_Rsi);
//--- Get result
   CList *result;
   CDictionary_Obj_Double *p_od_Ipsus;
   result=fsIpsus.Calculate(in);
   p_od_Ipsus=result.GetNodeAtIndex(0);
//   Print("Ipsus, escala: ",p_od_Ipsus.Value());

double retorno = p_od_Ipsus.Value();

delete in;
delete result;
delete fsIpsus;

return retorno;

  }
//+------------------------------------------------------------------+
