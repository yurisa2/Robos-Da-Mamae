/* -*- C++ -*- */

class DealMatrix
{
  public:
  DealMatrix() {};
  void Add_Line(double& line[]);
  double matrix[][100];

};

void DealMatrix::Add_Line(double& line[]) {
  ArrayResize(this.matrix, ArrayRange(this.matrix,0)+1); //Aumenta o Array em uma unidade

  for(int i = 0; i <   ArrayRange(line,0); i++) {
    this.matrix[(ArrayRange(this.matrix,0)-1)][i] = line[i];
  }
  ArrayPrint(this.matrix);
}

DealMatrix deal_matrix;
