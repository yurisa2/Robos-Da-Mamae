//+------------------------------------------------------------------+
//|                                                     fuzzynet.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
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
double Fuzzy_Respo(double Banda = 0, double Rsi = 50, double Estocastico = 50, double MoneyFI = 50)
{
  double retorno = 0;

  if(Banda < -49) Banda = 0;
  if(Banda > 149) Banda = 149;

  //--- Mamdani Fuzzy System
  CMamdaniFuzzySystem *fsIpsus=new CMamdaniFuzzySystem();

  //--- Create Output
  CFuzzyVariable *fvIpsus=new CFuzzyVariable("tendencia",-100,100.0);
  fvIpsus.Terms().Add(new CFuzzyTerm("re_venda", new CSigmoidalMembershipFunction(0.1,50)));
  fvIpsus.Terms().Add(new CFuzzyTerm("re_compra", new CSigmoidalMembershipFunction(-0.1,-50)));
  fsIpsus.Output().Add(fvIpsus);
  //--- Create three Mamdani fuzzy rule
  // //--- Create first input variables for the system
  // CFuzzyVariable *fvBanda=new CFuzzyVariable("banda_bollinger",-50.0,150.0);
  // fvBanda.Terms().Add(new CFuzzyTerm("venda", new CTrapezoidMembershipFunction(50,100,120, 150)));
  // fvBanda.Terms().Add(new CFuzzyTerm("compra", new CTrapezoidMembershipFunction(-50,-20,0,50)));
  // fsIpsus.Input().Add(fvBanda);

  //--- Create first input variables for the system
  CFuzzyVariable *fvBanda=new CFuzzyVariable("banda_bollinger",-50.0,150.0);
  fvBanda.Terms().Add(new CFuzzyTerm("venda", new CTrapezoidMembershipFunction(50,100,120, 150)));
  fvBanda.Terms().Add(new CFuzzyTerm("compra", new CTrapezoidMembershipFunction(-50,-20,0,50)));
  fsIpsus.Input().Add(fvBanda);
  CMamdaniFuzzyRule *rule1 = fsIpsus.ParseRule("if (banda_bollinger is compra)  then tendencia is re_compra");
  CMamdaniFuzzyRule *rule2 = fsIpsus.ParseRule("if (banda_bollinger is venda)  then tendencia is re_venda");
  fsIpsus.Rules().Add(rule1);
  fsIpsus.Rules().Add(rule2);

  //--- Create second input variables for the system
  CFuzzyVariable *fvRsi=new CFuzzyVariable("rsi_forca",0.0,100.0);
  fvRsi.Terms().Add(new CFuzzyTerm("venda", new CSigmoidalMembershipFunction(0.3,70)));
  fvRsi.Terms().Add(new CFuzzyTerm("compra", new CSigmoidalMembershipFunction(-0.3,30)));
  fsIpsus.Input().Add(fvRsi);
  CMamdaniFuzzyRule *rule7 = fsIpsus.ParseRule("if (rsi_forca is compra) then tendencia is re_compra");
  CMamdaniFuzzyRule *rule8 = fsIpsus.ParseRule("if (rsi_forca is venda) then tendencia is re_venda");
  fsIpsus.Rules().Add(rule7);
  fsIpsus.Rules().Add(rule8);

  //--- Create first input variables for the system
  CFuzzyVariable *fvStoch=new CFuzzyVariable("stoch",0,100.0);
  fvStoch.Terms().Add(new CFuzzyTerm("venda", new CSigmoidalMembershipFunction(0.2,80)));
  fvStoch.Terms().Add(new CFuzzyTerm("compra", new CSigmoidalMembershipFunction(-0.2,20)));
  fsIpsus.Input().Add(fvStoch);
  CMamdaniFuzzyRule *rule10 = fsIpsus.ParseRule("if (stoch is compra) then tendencia is re_compra");
  CMamdaniFuzzyRule *rule11 = fsIpsus.ParseRule("if (stoch is venda) then tendencia is re_venda");
  fsIpsus.Rules().Add(rule10);
  fsIpsus.Rules().Add(rule11);

  //--- Create first input variables for the system
  CFuzzyVariable *fvMFI=new CFuzzyVariable("mfi",0,100.0);
  fvMFI.Terms().Add(new CFuzzyTerm("venda", new CSigmoidalMembershipFunction(0.2,80)));
  fvMFI.Terms().Add(new CFuzzyTerm("compra", new CSigmoidalMembershipFunction(-0.2,20)));
  fsIpsus.Input().Add(fvMFI);
  CMamdaniFuzzyRule *rule12 = fsIpsus.ParseRule("if (mfi is compra) then tendencia is re_compra");
  CMamdaniFuzzyRule *rule13 = fsIpsus.ParseRule("if (mfi is venda) then tendencia is re_venda");
  fsIpsus.Rules().Add(rule12);
  fsIpsus.Rules().Add(rule13);







  //--- Set input value
  CList *in=new CList;
  CDictionary_Obj_Double *p_od_Banda=new CDictionary_Obj_Double;
  CDictionary_Obj_Double *p_od_Rsi=new CDictionary_Obj_Double;
  CDictionary_Obj_Double *p_od_Stoch=new CDictionary_Obj_Double;
  CDictionary_Obj_Double *p_od_MoneyFI=new CDictionary_Obj_Double;

  p_od_Banda.SetAll(fvBanda, Banda);
  p_od_Rsi.SetAll(fvRsi, Rsi);
  p_od_Stoch.SetAll(fvStoch, Estocastico);
  p_od_MoneyFI.SetAll(fvMFI, MoneyFI);

  in.Add(p_od_Banda);
  in.Add(p_od_Rsi);
  in.Add(p_od_Stoch);
  in.Add(p_od_MoneyFI);

  //--- Get result
  CList *result;
  CDictionary_Obj_Double *p_od_Ipsus;
  result=fsIpsus.Calculate(in);
  p_od_Ipsus=result.GetNodeAtIndex(0);
  //   Print("Ipsus, escala: ",p_od_Ipsus.Value());

  retorno = p_od_Ipsus.Value();

  delete in;
  delete result;
  delete fsIpsus;

  return retorno;

}
//+------------------------------------------------------------------+
