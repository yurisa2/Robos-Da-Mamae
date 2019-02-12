﻿/* -*- C++ -*- */
#property copyright "PetroSa, Robï¿½s feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class MFI
{
  public:
  void MFI(
            ENUM_TIMEFRAMES      period = PERIOD_CURRENT,             // period
            int                  ma_period = 14,                    // averaging period
            ENUM_APPLIED_VOLUME  applied_volume = VOLUME_REAL,      // volume type for calculation );
            string               symbol = NULL             // symbol name
          );
  double Valor(int barra = 0);
  double Cx(int barra = 0,int periods = 7);
  double Normalizado(int barra = 0,int periods = 7);


  private:
  int HandleMFI;

};

void MFI::MFI(ENUM_TIMEFRAMES period = PERIOD_CURRENT,int ma_period = 14, ENUM_APPLIED_VOLUME  applied_volume = VOLUME_REAL,string symbol = NULL)
{
  HandleMFI = 0;
  HandleMFI = iMFI(symbol,period,ma_period,applied_volume);
  // ChartIndicatorAdd(0,1,HandleMFI);

  // Print("Handle MFI: " + IntegerToString(HandleMFI));

  if(HandleMFI == 0)
  {
    ExpertRemove();
  }
}

double MFI::Valor(int barra = 0)
{
     double _MFI[];
     double retorno = NULL;

     ArraySetAsSeries(_MFI, true);
     int MFI_copied = CopyBuffer(HandleMFI,0,0,barra+5,_MFI);

     retorno = _MFI[barra];

     return(retorno);
}

double MFI::Cx(int barra = 0,int periods = 7)
{
  double retorno = NULL;

  double vetor_norm[];
  ArrayResize(vetor_norm,periods);

  for(int i = 0; i < periods; i++) {
    vetor_norm[i] = Valor(barra+i);
  }

  Normalizacao *mat = new Normalizacao(vetor_norm);
  retorno = mat.Coeficiente_Angular;
  delete(mat);

  return(retorno);
}

double MFI::Normalizado(int barra = 0,int periods = 7)
{
  double retorno = NULL;

  double vetor_norm[];
  ArrayResize(vetor_norm,periods);

  for(int i = 0; i < periods; i++) {
    vetor_norm[i] = Valor(barra+i);
  }

  Normalizacao *mat = new Normalizacao(vetor_norm);
  retorno = mat.Valor_Normalizado;
  delete(mat);


  return(retorno);
}
