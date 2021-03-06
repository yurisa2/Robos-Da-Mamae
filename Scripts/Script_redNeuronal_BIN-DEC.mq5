﻿//+------------------------------------------------------------------+
//|                                  Script descarga Indicadores.mq5 |
//|                             Copyright 2015, José Miguel Soriano. |
//+------------------------------------------------------------------+

#property copyright "José Miguel Soriano; Spain"
#property link      "josemiguel1812@hotmail.es"
#property version   "1.000"

#property script_show_confirm
#property script_show_inputs

#define FUNC_CAPA_OCULTA   1
#define FUNC_SALIDA        -5
            //1= func tangente hiperbólica; 2= e^(-x^2); 3= x>=0 raizC(1+x^2) x<0 e^x; 4= func sigmoide;
            //5= binomial x>0.5? 1: 0; -5= func lineal
#include <Math\Alglib\alglib.mqh>

enum mis_PROPIEDADES_RED {N_CAPAS, N_NEURONAS, N_ENTRADAS, N_SALIDAS, N_PESOS};
//---------------------------------  parametros entrada  ---------------------
sinput int nNeuronEntra= 10;                 //Num neuronas capa entrada
                                             //2^8= 256 2^9= 512; 2^10= 1024; 2^12= 4096; 2^14= 16384
sinput int nNeuronCapa1= 0;                  //Num neuronas capa oculta 1 (<1 no existe)
sinput int nNeuronCapa2= 0;                  //Num neuronas capa oculta 2 (<1 no existe)                                             //2^8= 256 2^9= 512; 2^10= 1024; 2^12= 4096; 2^14= 16384
sinput int nNeuronSal= 1;                    //Num neuronas capa salida

sinput int    historialEntrena= 800;         //Historial entrenamiento
sinput int    historialEvalua= 200;          //Historial predicción
sinput int    ciclosEntrena= 2;              //Ciclos de entrenamiento
sinput double tasaAprende= 0.001;            //Tasa de aprendizaje
sinput string intervEntrada= "";             //Normalización entrada: min y max deseados (vacío= NO normaliza)
sinput string intervSalida= "";              //Normalización salida: min y max deseados (vacío= NO normaliza)
sinput bool   imprEntrena= true;             //Imprimir datos entrena/evalua

// ------------------------------ VARIABLES GLOBALES -----------------------------
int puntFichTexto= 0;
ulong contFlush= 0;
CMultilayerPerceptronShell redNeuronal;
CMatrixDouble arDatosAprende(0, 0);
CMatrixDouble arDatosEval(0, 0);
double minAbsSalida= 0, maxAbsSalida= 0;
string nombreEA= "ScriptBinDec";

//+------------------------------------------------------------------+
void OnStart()              //Conversor binario a decimal
{
   string mensIni= "Script conversor BINARIO-DECIMAL",
          mens= "", cadNumBin= "", cadNumRed= "";
   int contAciertos= 0, arNumBin[],
       inicio= historialEntrena+1,
       fin= historialEntrena+historialEvalua;
   double arSalRed[], arNumEntra[], salida= 0, umbral= 0, peso= 0;
   double errorMedioEntren= 0;
   bool normEntrada= intervEntrada!="", normSalida= intervSalida!="", correcto= false,
        creada= creaRedNeuronal(redNeuronal);
   if(creada)
   {
      iniFichImprime(puntFichTexto, nombreEA+"-infRN", ".csv",mensIni);
      preparaDatosEntra(redNeuronal, arDatosAprende, intervEntrada!="", intervSalida!="");
      normalizaDatosRed(redNeuronal, arDatosAprende, normEntrada, normSalida);
      errorMedioEntren= entrenaEvalRed(redNeuronal, arDatosAprende);
      escrTexto("-------------------------", puntFichTexto);
      escrTexto("RESPUESTA RED------------", puntFichTexto);
      escrTexto("-------------------------", puntFichTexto);
      escrTexto("numBinEntra;numDecSalidaRed;correcto", puntFichTexto);
      for(int k= inicio; k<=fin; k++)
      {
         cadNumBin= dec_A_baseNumerica(k, arNumBin, 2, nNeuronEntra);
         ArrayCopy(arNumEntra, arNumBin);
         salida= respuestaRed(redNeuronal, arNumEntra, arSalRed);
         salida= MathRound(salida);
         correcto= k==(int)salida;
         escrTexto(cadNumBin+";"+IntegerToString((int)salida)+";"+correcto, puntFichTexto);
         cadNumRed= "";
      }
   }
   deIniFichImprime(puntFichTexto);
   return;
}

//-------------------------------- INICIALIZA FICHERO TEXTO   ---------------------------------
bool iniFichImprime(int &puntFich, string nombFich= "EA", string extension= ".csv", string mensIni= "")
{
   bool error= false;
   string fichImprime= nombFich + extension;
   ResetLastError();
   puntFich= FileOpen(fichImprime, FILE_WRITE|FILE_TXT|FILE_COMMON);
   error= (puntFich==INVALID_HANDLE);
   if(mensIni!="")
   {
      FileWrite(puntFich, fichImprime+ ";;;Path= ;"+ TerminalInfoString(TERMINAL_COMMONDATA_PATH)+"\\Files");
      FileWrite(puntFich, mensIni);
   }
   return(!error);
}

//---------------------------------- CIERRA Y VUELCA FICHERO TEXTO DEPURA
void deIniFichImprime(int puntFich)
{
   ResetLastError();
   if(puntFich!=INVALID_HANDLE)
   {
      FileFlush(puntFich);
      FileClose(puntFich);
      Print("Path= ", TerminalInfoString(TERMINAL_COMMONDATA_PATH));
   }
   return;
}

//--------------------------- ESCRIBE TEXTO  -------------------------------------------
void escrTexto(string mensaje, int puntFich, int nEscrit= 10)
{
   ResetLastError();
   if(puntFich!=INVALID_HANDLE)
   {
      FileWrite(puntFich, mensaje);
      contFlush++;
      if(contFlush%nEscrit==0) FileFlush(puntFich);
   }
}

//---------------------------------- CREA RED NEURONAL ------------------------------------------
bool creaRedNeuronal(CMultilayerPerceptronShell &objRed)
{
   bool creada= false;
   int nEntradas= 0, nSalidas= 0, nPesos= 0;
   if(nNeuronCapa1<1 && nNeuronCapa2<1) CAlglib::MLPCreate0(nNeuronEntra, nNeuronSal, objRed);   	//SALIDA LINEAL
   else if(nNeuronCapa2<1) CAlglib::MLPCreate1(nNeuronEntra, nNeuronCapa1, nNeuronSal, objRed);   	//SALIDA LINEAL
   else CAlglib::MLPCreate2(nNeuronEntra, nNeuronCapa1, nNeuronCapa2, nNeuronSal, objRed);   		//SALIDA LINEAL
   creada= existeRed(objRed);
   if(!creada) Print("Error creación RED NEURONAL ==> ", __FUNCTION__, " ", _LastError);
   else
   {
      CAlglib::MLPProperties(objRed, nEntradas, nSalidas, nPesos);
      Print("Creada Red nº capas ", propiedadRed(objRed, N_CAPAS));
      Print("Nº neuronas entrada ", nEntradas);
      Print("Nº neuronas capaOculta 1 ", nNeuronCapa1);
      Print("Nº neuronas capaOculta 2 ", nNeuronCapa2);
      Print("Nº neuronas salida ", nSalidas);
      Print("Nº pesos ", nPesos);
      Print("Historial entrena ", IntegerToString(historialEntrena));
   }
   return(creada);
}

//--------------------------------- EXISTE RED --------------------------------------------
bool existeRed(CMultilayerPerceptronShell &objRed)
{
   bool resp= false;
   int nEntradas= 0, nSalidas= 0, nPesos= 0;
   CAlglib::MLPProperties(objRed, nEntradas, nSalidas, nPesos);
   resp= nEntradas>0 && nSalidas>0;
   return(resp);
}

//---------------------------------- PREPARA DATOS ENTRADA / SALIDA --------------------------------------------------
void preparaDatosEntra(CMultilayerPerceptronShell &objRed, CMatrixDouble &arDatos, bool normEntrada= true , bool normSalida= true)
{
   int fila= 0, colum= 0, numDec= 0, arNumBin[],
       nEntras= propiedadRed(objRed, N_ENTRADAS),
       nSals= propiedadRed(objRed, N_SALIDAS);
   string linea= "", cadNum= "";
   arDatos.Resize(historialEntrena, nEntras+nSals);
   if(imprEntrena) escrTexto("numBin;numDec", puntFichTexto);
   for(fila= 0; fila<historialEntrena; fila++)
   {
      numDec= fila+1;
      cadNum= dec_A_baseNumerica(numDec, arNumBin, 2, nEntras);    //10000= 14 digitos en binario; 4000= 12 digitos en binario; 1000= 10 digitos
      for(colum= 0; colum<nEntras; colum++) arDatos[fila].Set(colum, arNumBin[colum]);
      for(colum= 0; colum<nSals; colum++) arDatos[fila].Set(colum+nEntras, numDec);
      if(imprEntrena)
      {
         for(colum= 0; colum<(nEntras); colum++) linea= DoubleToString(arDatos[fila][colum], 0)+linea;
         escrTexto(linea+";"+IntegerToString(numDec), puntFichTexto);
         linea= "";
      }
   }
   if(imprEntrena)
   {
      escrTexto(linea, puntFichTexto);
      Alert("Download file= ", nombreEA+"-infRN.csv");
      Alert("Path= ", TerminalInfoString(TERMINAL_COMMONDATA_PATH)+"\\Files");
   }
   return;
}

//---------------------------------- PROPIEDADES de la RED  -------------------------------------------
int propiedadRed(CMultilayerPerceptronShell &objRed, mis_PROPIEDADES_RED prop= N_CAPAS, int numCapa= 0)
{           //si se pide N_NEURONAS hay que especificar el numCapa
   int resp= 0, numEntras= 0, numSals= 0, numPesos= 0;
   if(prop>N_NEURONAS) CAlglib::MLPProperties(objRed, numEntras, numSals, numPesos);
   switch(prop)     //mis_PROPIEDADES_RED{N_CAPAS, N_NEURONAS, N_ENTRADAS, N_SALIDAS, N_PESOS};
   {
      case N_CAPAS:
         resp= CAlglib::MLPGetLayersCount(objRed);
         break;
      case N_NEURONAS:
         resp= CAlglib::MLPGetLayerSize(objRed, numCapa);
         break;
      case N_ENTRADAS:
         resp= numEntras;
         break;
      case N_SALIDAS:
         resp= numSals;
         break;
      case N_PESOS:
         resp= numPesos;
   }
   return(resp);
}

//------------------------------------ NORMALIZA ENTRADA/SALIDA RED -------------------------------------
void normalizaDatosRed(CMultilayerPerceptronShell &objRed, CMatrixDouble &arDatos, bool normEntrada= true, bool normSalida= true)
{
   int fila= 0, colum= 0, maxFila= arDatos.Size(),
       nEntradas= propiedadRed(objRed, N_ENTRADAS),
       nSalidas= propiedadRed(objRed, N_SALIDAS);
   double maxAbs= 0, minAbs= 0, maxRel= 0, minRel= 0;
   string arMaxMinRelEntra[], arMaxMinRelSals[];
   ushort valCaract= StringGetCharacter(";", 0);
   if(normEntrada) StringSplit(intervEntrada, valCaract, arMaxMinRelEntra);
   if(normSalida) StringSplit(intervSalida, valCaract, arMaxMinRelSals);
   for(colum= 0; normEntrada && colum<nEntradas; colum++)
   {
      maxAbs= arDatos[0][colum];
      minAbs= arDatos[0][colum];
      minRel= StringToDouble(arMaxMinRelEntra[0]);
      maxRel= StringToDouble(arMaxMinRelEntra[1]);
      for(fila= 0; fila<maxFila; fila++)		//identificamos maxAbs y minRel de cada columna de datos
      {
         if(maxAbs<arDatos[fila][colum]) maxAbs= arDatos[fila][colum];
         if(minAbs>arDatos[fila][colum]) minAbs= arDatos[fila][colum];
      }
      for(fila= 0; fila<maxFila; fila++)		//establecemos el nuevo valor normalizado
         arDatos[fila].Set(colum, normValor(arDatos[fila][colum], maxAbs, minAbs, maxRel, minRel));
   }
   for(colum= nEntradas; normSalida && colum<(nEntradas+nSalidas); colum++)
   {
      maxAbs= arDatos[0][colum];
      minAbs= arDatos[0][colum];
      minRel= StringToDouble(arMaxMinRelSals[0]);
      maxRel= StringToDouble(arMaxMinRelSals[1]);
      for(fila= 0; fila<maxFila; fila++)
      {
         if(maxAbs<arDatos[fila][colum]) maxAbs= arDatos[fila][colum];
         if(minAbs>arDatos[fila][colum]) minAbs= arDatos[fila][colum];
      }
      minAbsSalida= minAbs;
      maxAbsSalida= maxAbs;
      for(fila= 0; fila<maxFila; fila++)
         arDatos[fila].Set(colum, normValor(arDatos[fila][colum], maxAbs, minAbs, maxRel, minRel));
   }
   return;
}

//------------------------------------ FUNCION DE NORMALIZACIÓN ---------------------------------
double normValor(double valor, double maxAbs, double minAbs, double maxRel= 1, double minRel= -1)
{
   double valorNorm= 0;
   if(maxAbs>minAbs) valorNorm= (valor-minAbs)*(maxRel-minRel)/(maxAbs-minAbs) + minRel;
   return(valorNorm);
}

//------------------------------------- ENTRENAMIENTO de la RED ----------------------------------------
double entrenaEvalRed(CMultilayerPerceptronShell &objRed, CMatrixDouble &arDatosEntrena)
{
   bool salir= false;
   double errorM= 0;
   string mens= "Entrenamiento Red";
   int k= 0, i= 0, codResp= 0,
       historial= arDatosEntrena.Size();
   CMLPReportShell infoEntren;
   ResetLastError();
   datetime tmpIni= TimeLocal();
   Alert("Iniciando OPTIMIZACIÓN de RED NEURONAL...");
   Alert("Espere unos minutos... según cantidad de historial implicado.");
   Alert("...///...");
   if(propiedadRed(objRed, N_PESOS)<500)
      CAlglib::MLPTrainLM(objRed, arDatosEntrena, historial, tasaAprende, ciclosEntrena, codResp, infoEntren);
   else
      CAlglib::MLPTrainLBFGS(objRed, arDatosEntrena, historial, tasaAprende, ciclosEntrena, 0.01, 0, codResp, infoEntren);
   if(codResp==2 || codResp==6) errorM= CAlglib::MLPRMSError(objRed, arDatosEntrena, historial);
   datetime tmpFin= TimeLocal();
   Alert("NGrad ", infoEntren.GetNGrad(), " NHess ", infoEntren.GetNHess(), " NCholesky ", infoEntren.GetNCholesky());
   Alert("codResp ", codResp," Error medio Entren "+DoubleToString(errorM, 8), " ciclosEntrena ", ciclosEntrena);
   Alert("tmpEntren ", DoubleToString(((double)(tmpFin-tmpIni))/60.0, 2), " min", "---> tmpIni ", TimeToString(tmpIni, TIME_SECONDS), " tmpFin ", TimeToString(tmpFin, TIME_SECONDS));
   if(GetLastError()>0) Print("Error: ", GetLastError(), " ", __FUNCTION__);
   return(errorM);
}

//--------------------------------------- SOLICITA RESPUESTA A RED ---------------------------------
double respuestaRed(CMultilayerPerceptronShell &objRed, double &arEntradas[], double &arSalidas[])
{
   double resp= 0, nNeuron= 0;
   CAlglib::MLPProcess(objRed, arEntradas, arSalidas);
   resp= arSalidas[0];
   return(resp);
}

//------------------------------------- NUM DECIMAL a BINARIO ------------------------------------
string dec_A_baseNumerica(int numDec, int &arNumDestino[], int baseNum= 2, int nCifras= 6)
{
   string numCad= "";
   bool salir= false;
   int i= 0, k= 1, longCad= 0, numIni= numDec;
   while(!salir)
   {
      ArrayResize(arNumDestino, k);
      arNumDestino[k-1]= numIni%baseNum;
      numIni= numIni/baseNum;
      salir= numIni<baseNum;
      k++;
   }
   ArrayResize(arNumDestino, k);
   arNumDestino[k-1]= numIni;
   for(i= 0; i<k; i++) numCad= IntegerToString(arNumDestino[i])+numCad;
   longCad= k;
   if(longCad<nCifras)
   {
      ArrayResize(arNumDestino, nCifras);
      for(k= 0; k<(nCifras-longCad); k++)
      {
         numCad= "0"+numCad;
         arNumDestino[k+longCad]= 0;
      }
   }
   return(numCad);
}
