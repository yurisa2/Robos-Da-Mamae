/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                              Sa2 |
//|                                           https://www.sa2.com.br |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class Afis
{
  public:
  Afis(int linesize_) {this.linesize = linesize_;};

  void divide_datasets(double& dataset_inteiro[][100]);

  void Calc_BX(const double& historico[]);
  double bx_min;
  double bx_q1;
  double bx_median;
  double bx_q3;
  double bx_max;


  void Add_Line(double& line[]);
  int linesize;
  double dataset_0[][100];
  double dataset_1[][100];

  double dataset[][100]; // Hope doesn't get shit


  private:

};

void Afis::Calc_BX(const double& historico[]) {

  MathTukeySummary(historico,
                    true,
                    this.bx_min,
                    this.bx_q1,
                    this.bx_median,
                    this.bx_q3,
                    this.bx_max);
}

void Afis::Add_Line(double& line[]) {
  ArrayResize(this.dataset, ArrayRange(this.dataset,0)+1); //Aumenta o Array em uma unidade

  for(int i = 0; i <  this.linesize; i++) {
    this.dataset[(ArrayRange(this.dataset,0)-1)][i] = line[i];
  }
}

void Afis::divide_datasets(double& dataset_inteiro[][100]) {

  for (int i = 0; i <  ArrayRange(dataset_inteiro,0); i++) {
    
    if(dataset_inteiro[i][0] == 0) {
      ArrayResize(this.dataset_0, ArrayRange(this.dataset_0,0)+1);
      for(int j = 0; j <  this.linesize; j++) {
        this.dataset_0[(ArrayRange(this.dataset_0,0)-1)][j] = dataset_inteiro[i][j];
      }
    }
    if(dataset_inteiro[i][0] == 1) {
      ArrayResize(this.dataset_1, ArrayRange(this.dataset_1,0)+1);
      for(int j = 0; j <  this.linesize; j++) {
        this.dataset_1[(ArrayRange(this.dataset_1,0)-1)][j] = dataset_inteiro[i][j];
      }
    }

  }

}
