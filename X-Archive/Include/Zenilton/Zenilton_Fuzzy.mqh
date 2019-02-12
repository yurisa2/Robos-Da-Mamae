//+------------------------------------------------------------------+
//|                                                     fuzzynet.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
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
    double retorno = 0;

    if(Banda < -49) Banda = 0;
    if(Banda > 149) Banda = 149;

  if(Condicoes_Basicas_Gerais())
  {

//--- Mamdani Fuzzy System
   CMamdaniFuzzySystem *fsIpsus=new CMamdaniFuzzySystem();
//--- Create first input variables for the system
   CFuzzyVariable *fvBanda=new CFuzzyVariable("banda_bollinger",-50.0,150.0);
   fvBanda.Terms().Add(new CFuzzyTerm("venda", new CTrapezoidMembershipFunction(50,100,120, 150)));
   fvBanda.Terms().Add(new CFuzzyTerm("neutro", new CTrapezoidMembershipFunction(20,40, 60, 80)));
   fvBanda.Terms().Add(new CFuzzyTerm("compra", new CTrapezoidMembershipFunction(-50,-30,0,50)));
   fsIpsus.Input().Add(fvBanda);
//--- Create second input variables for the system
   CFuzzyVariable *fvRsi=new CFuzzyVariable("rsi_forca",0.0,100.0);
   fvRsi.Terms().Add(new CFuzzyTerm("queda", new CTrapezoidMembershipFunction(60,70,99,99)));
   fvRsi.Terms().Add(new CFuzzyTerm("boia", new CTrapezoidMembershipFunction(30,45,55,70)));
   fvRsi.Terms().Add(new CFuzzyTerm("alta", new CTrapezoidMembershipFunction(0,0,30,40)));
   fsIpsus.Input().Add(fvRsi);
//--- Create Output
CFuzzyVariable *fvIpsus=new CFuzzyVariable("tendencia",-100.0,100.0);
fvIpsus.Terms().Add(new CFuzzyTerm("re_venda", new CTriangularMembershipFunction(70,100,100)));
fvIpsus.Terms().Add(new CFuzzyTerm("re_faz_nada", new CTriangularMembershipFunction(-80,0,80)));
fvIpsus.Terms().Add(new CFuzzyTerm("re_compra", new CTriangularMembershipFunction(-100,-100,-70)));
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

retorno = p_od_Ipsus.Value();

delete in;
delete result;
delete fsIpsus;
} // fim do Basico Permite
return retorno;

  }
//+------------------------------------------------------------------+
