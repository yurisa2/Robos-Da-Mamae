//+------------------------------------------------------------------+
//|                                   S_ShapedMembershipFunction.mq5 |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include <Math\Fuzzy\membershipfunction.mqh>
#include <Graphics\Graphic.mqh>
//--- Create membership functions
CSigmoidalMembershipFunction func1(0.1,100);
CGeneralizedBellShapedMembershipFunction func2(50,3,28);
CSigmoidalMembershipFunction func3(-0.1,0);

//--- Create wrappers for membership functions
double S_ShapedMembershipFunction1(double x) { return(func1.GetValue(x)); }
double GeneralizedBellShapedMembershipFuncion2(double x) { return(func2.GetValue(x)); }
double SigmoidalMembershipFunction3(double x) { return(func3.GetValue(x)); }
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
    ObjectsDeleteAll(0);
//--- create graphic
   CGraphic graphic;
   if(!graphic.Create(0,"S_ShapedMembershipFunction",0,30,30,780,380))
     {
      graphic.Attach(0,"S_ShapedMembershipFunction");
     }
   graphic.HistoryNameWidth(70);
   graphic.BackgroundMain("S_ShapedMembershipFunction");
   graphic.BackgroundMainSize(16);
//--- create curve
  graphic.CurveAdd(S_ShapedMembershipFunction1,-50,150,0.1,CURVE_LINES,"Func1");
  graphic.CurveAdd(GeneralizedBellShapedMembershipFuncion2,-50,150,0.1,CURVE_LINES,"Func2");
  graphic.CurveAdd(SigmoidalMembershipFunction3,-50,150.0,0.1,CURVE_LINES,"Func3");
//--- sets the X-axis properties
   graphic.XAxis().AutoScale(false);
   graphic.XAxis().Min(-50);
   graphic.XAxis().Max(150);
   graphic.XAxis().DefaultStep(10.0);
//--- sets the Y-axis properties
  // graphic.YAxis().AutoScale(true);
  /// graphic.YAxis().Min(0.0);
  // graphic.YAxis().Max(1.1);
  // graphic.YAxis().DefaultStep(0.2);
//--- plot
   graphic.CurvePlotAll();
   graphic.Update();
  }
