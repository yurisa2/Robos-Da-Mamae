/* -*- C++ -*- */

class DealMatrix
{
  public:
  DealMatrix() {};
  void addLine(double& line[]);
  void addDeal(CDealInfo& deal);
  double matrix[][100];
  double matrix_0[][100];
  double matrix_1[][100];
  double matrix_buy[][100];
  double matrix_buy_0[][100];
  double matrix_buy_1[][100];
  double matrix_sell[][100];
  double matrix_sell_0[][100];
  double matrix_sell_1[][100];
  bool print_matrix_each_deal;
  datetime deals_time[];
  ENUM_DEAL_TYPE deals_type[];

};

void DealMatrix::addLine(double& line[]) {

  //GLOBAL
  ArrayResize(this.matrix, ArrayRange(this.matrix,0)+1); //Aumenta o Array em uma unidade

  for(int i = 0; i <   ArrayRange(line,0); i++) {
    this.matrix[(ArrayRange(this.matrix,0)-1)][i] = line[i];
  }

  //MATRIX 0
  if(line[0] < 0) {
  ArrayResize(this.matrix_0, ArrayRange(this.matrix_0,0)+1); //Aumenta o Array em uma unidade

  for(int i = 0; i <   ArrayRange(line,0); i++) {
    this.matrix_0[(ArrayRange(this.matrix_0,0)-1)][i] = line[i];
  }
}

  //MATRIX 1
  if(line[0] > 0) {
  ArrayResize(this.matrix_1, ArrayRange(this.matrix_1,0)+1); //Aumenta o Array em uma unidade

  for(int i = 0; i <   ArrayRange(line,0); i++) {
    this.matrix_1[(ArrayRange(this.matrix_1,0)-1)][i] = line[i];
  }
}


  //matrix_buy
  if(this.deals_type[ArrayRange(this.deals_type,0)-1] == DEAL_TYPE_BUY) {
  ArrayResize(this.matrix_buy, ArrayRange(this.matrix_buy,0)+1); //Aumenta o Array em uma unidade

  for(int i = 0; i <   ArrayRange(line,0); i++) {
    this.matrix_buy[(ArrayRange(this.matrix_buy,0)-1)][i] = line[i];
  }
}

  //matrix_buy_0
  if(this.deals_type[ArrayRange(this.deals_type,0)-1] == DEAL_TYPE_BUY &&
    line[0] < 0) {
  ArrayResize(this.matrix_buy_0, ArrayRange(this.matrix_buy_0,0)+1); //Aumenta o Array em uma unidade

  for(int i = 0; i <   ArrayRange(line,0); i++) {
    this.matrix_buy_0[(ArrayRange(this.matrix_buy_0,0)-1)][i] = line[i];
  }
}

  //matrix_buy_1
  if(this.deals_type[ArrayRange(this.deals_type,0)-1] == DEAL_TYPE_BUY &&
    line[0] > 0) {
  ArrayResize(this.matrix_buy_1, ArrayRange(this.matrix_buy_1,0)+1); //Aumenta o Array em uma unidade

  for(int i = 0; i <   ArrayRange(line,0); i++) {
    this.matrix_buy_1[(ArrayRange(this.matrix_buy_1,0)-1)][i] = line[i];
  }
}

  //matrix_sell_0
  if(this.deals_type[ArrayRange(this.deals_type,0)-1] == DEAL_TYPE_SELL &&
    line[0] < 0) {
  ArrayResize(this.matrix_sell_0, ArrayRange(this.matrix_sell_0,0)+1); //Aumenta o Array em uma unidade

  for(int i = 0; i <   ArrayRange(line,0); i++) {
    this.matrix_sell_0[(ArrayRange(this.matrix_sell_0,0)-1)][i] = line[i];
  }
}

  //matrix_sell_1
  if(this.deals_type[ArrayRange(this.deals_type,0)-1] == DEAL_TYPE_SELL &&
    line[0] > 0) {
  ArrayResize(this.matrix_sell_1, ArrayRange(this.matrix_sell_1,0)+1); //Aumenta o Array em uma unidade

  for(int i = 0; i <   ArrayRange(line,0); i++) {
    this.matrix_sell_1[(ArrayRange(this.matrix_sell_1,0)-1)][i] = line[i];
  }
}


Print("this.matrix");
ArrayPrint(this.matrix);
Print("this.matrix_0");
ArrayPrint(this.matrix_0);
Print("this.matrix_1");
ArrayPrint(this.matrix_1);
Print("this.matrix_buy");
ArrayPrint(this.matrix_buy);
Print("this.matrix_buy_0");
ArrayPrint(this.matrix_buy_0);
Print("this.matrix_buy_1");
ArrayPrint(this.matrix_buy_1);
Print("this.matrix_sell");
ArrayPrint(this.matrix_sell);
Print("this.matrix_sell_0");
ArrayPrint(this.matrix_sell_0);
Print("this.matrix_sell_1");
ArrayPrint(this.matrix_sell_1);


  if(this.print_matrix_each_deal) ArrayPrint(this.matrix); //DEBUG
}

void DealMatrix::addDeal(CDealInfo& deal) {
  int current_size = ArrayRange(deals_time,0);

  ArrayResize(deals_time,(current_size+1));
  ArrayResize(deals_type,(current_size+1));

  this.deals_type[current_size] = deal.DealType();
  this.deals_time[current_size] = deal.Time();


  for (int i = 0; i < ArrayRange(this.deals_type,0); i++) {


    // Print("DIRECAO: " + EnumToString(this.deals_type[i]));
    // Print("i: " + i + "time: " + this.deals_time[i]);
    // Print("ArrayRange(deals,0): " + ArrayRange(deals,0));
  }

  Print(ArrayRange((this.deals_type),0));
}





DealMatrix deal_matrix;
