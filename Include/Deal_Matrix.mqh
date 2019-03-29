/* -*- C++ -*- */

class DealMatrix
{
  public:
  DealMatrix() {};
  void Add_Line(double& line[]);
  double matrix[][100];
  bool print_matrix_each_deal;

};

void DealMatrix::Add_Line(double& line[]) {
  ArrayResize(this.matrix, ArrayRange(this.matrix,0)+1); //Aumenta o Array em uma unidade

  for(int i = 0; i <   ArrayRange(line,0); i++) {
    this.matrix[(ArrayRange(this.matrix,0)-1)][i] = line[i];
  }
  if(this.print_matrix_each_deal) ArrayPrint(this.matrix); //DEBUG
}

DealMatrix deal_matrix;
