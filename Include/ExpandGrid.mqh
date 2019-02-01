/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

#include <Arrays\ArrayDouble.mqh>
#include <Arrays\ArrayObj.mqh>
#include <Arrays\ArrayString.mqh>
#include <Arrays\ArrayInt.mqh>


#property copyright "PetroSa, Rob�s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class ExpandGrid
{
  public:
  // ~ExpandGrid();
  ExpandGrid(string& col_classes[], string& classes[]);
  void Get_Grid();
  void Get_Line(int line, string& line_output[]);
  string col_classes[];
  string classes[];
  int line_count;
  CArrayObj array;

  private:

};

void  ExpandGrid::ExpandGrid(string& col_classes_[], string& classes_[])
{
ArrayCopy(this.col_classes,col_classes_);
ArrayCopy(this.classes,classes_);
this.Get_Grid();
}

void  ExpandGrid::Get_Grid() {
  int positions;

  positions = ArrayRange(this.col_classes,0);

  int class_size = ArrayRange(this.classes,0);

  this.line_count = (int)pow(ArrayRange(this.classes,0),positions);

  CArrayString *originator=new CArrayString ;

  for (int i = 0; i < this.line_count; i++) {
    for(int j = 0; j < positions; j++ ) {
      for (int k = 0; k < class_size; k++) {
        originator.Add(this.classes[k]);
      }
    }
  }

int block = 0;
  for (int i = 0; i < positions; i++) {

    CArrayString *coluna=new CArrayString ;
    for (int j = 0; j < this.line_count; j++) {
      int idx = j + block;
      if(idx >= this.line_count) idx = idx - this.line_count;
        coluna.Add(originator.At(idx));
    }
    block++;
    // end Block
    this.array.Add(coluna);
  }

  for (int i = 0; i < originator.Total(); i++) {
    int idx = i + 1;
    if(idx >= originator.Total()) idx = idx - originator.Total();
    Print(originator.At(idx));
  }

  delete(originator);
}


void  ExpandGrid::Get_Line(int line, string& line_output[]) {
ArrayResize(line_output,this.array.Total());

  for (int i = 0; i < this.array.Total(); i++) {
    CArrayString *coluna_idx;
    coluna_idx = this.array.At(i);

      line_output[i] = coluna_idx.At(line);

  }


}
