/* -*- C++ -*- */

class DealMatrix
{
  public:
  DealMatrix() {};
  void addLine(double& line[]);
  void addDeal(CDealInfo& deal);
  double matrix[][100];
  bool print_matrix_each_deal;
  datetime deals_time[];
  ENUM_DEAL_TYPE deals_type[];

};

void DealMatrix::addLine(double& line[]) {
  ArrayResize(this.matrix, ArrayRange(this.matrix,0)+1); //Aumenta o Array em uma unidade

  for(int i = 0; i <   ArrayRange(line,0); i++) {
    this.matrix[(ArrayRange(this.matrix,0)-1)][i] = line[i];
  }
  if(this.print_matrix_each_deal) ArrayPrint(this.matrix); //DEBUG
}

void DealMatrix::addDeal(CDealInfo& deal) {
  int current_size = ArrayRange(deals_time,0);

  ArrayResize(deals_time,(current_size+1));
  ArrayResize(deals_type,(current_size+1));

  this.deals_type[current_size] = deal.DealType();
  this.deals_time[current_size] = deal.Time();


  for (int i = 0; i < ArrayRange(this.deals_type,0); i++) {


    Print("DIRECAO: " + EnumToString(this.deals_type[i]));
    Print("i: " + i + "time: " + this.deals_time[i]);
    // Print("ArrayRange(deals,0): " + ArrayRange(deals,0));
  }
}

DealMatrix deal_matrix;
