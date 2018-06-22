/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                       Inputs.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robos feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

/////////////////////////////////////// Inputs
enum TFs
{
   _M1= PERIOD_M1,
   _M5= PERIOD_M5,
   _M10= PERIOD_M10,
   _M15=PERIOD_M15,
//   _M20=PERIOD_M20,
   _M30=PERIOD_M30,
   _H1= PERIOD_H1,
   // _H2= PERIOD_H2,
   _H4= PERIOD_H4,
//   _H8= PERIOD_H8,
   _D1= PERIOD_D1
   // _W1= PERIOD_W1,
   // _MN1=PERIOD_MN1
};



input string Parametros_Gerais = "-------------------------------------";  //Parametros Gerais
// input bool  multi_op = false;                                              //Multi Operacao (define o método de operacao)
input TFs TimeFrame_ = _M1;                              //TimeFrame base

ENUM_TIMEFRAMES defMarcoTiempo(TFs marco)
{
   ENUM_TIMEFRAMES resp= _Period;
   switch(marco)
   {
      case _M1: resp= PERIOD_M1; break;
      case _M5: resp= PERIOD_M5; break;
      case _M10: resp= PERIOD_M10; break;
      case _M15: resp= PERIOD_M15; break;
      //case _M20: resp= PERIOD_M20; break;
      case _M30: resp= PERIOD_M30; break;
      case _H1: resp= PERIOD_H1; break;
      // case _H2: resp= PERIOD_H2; break;
      // case _H4: resp= PERIOD_H4; break;
      //case _H8: resp= PERIOD_H8; break;
      case _D1: resp= PERIOD_D1; break;
      // case _W1: resp= PERIOD_W1; break;
      // case _MN1: resp= PERIOD_MN1;
   }
return(resp);
}

ENUM_TIMEFRAMES TimeFrame = defMarcoTiempo(TimeFrame_);

input int HoraDeInicio = 9;                                                //Hora de Inicio
input int MinutoDeInicio = 20;                                             //Minuto de Inicio
input int HoraDeFim = 17;                                                  //Hora de Fim
input int MinutoDeFim = 27;                                                //Minuto de Fim
input bool   ZerarFinalDoDia = true;                                       //Encerra operacoes no final do dia (execucao extendida)
input string Descricao_Robo_Alpha = "";                                    //Descricao para logs e mensagens
sinput bool Aleta_Operacao = false;                                          //Aparece um alerta quando entra
//string Descricao_Robo = Descricao_Robo(); +"|"+Descricao_Robo_Alpha;
sinput bool Custom_resultado_treino_nn = false;

input string Parametros_Financeiros = "---------OU QUASE--------------------";
input double Lotes = 1;                                                    //Volume negociado
input int Limite_Operacoes = 9999;                                         //Limite de operacoes diário (entrada e Saida)
input double custo_operacao = 1.36;                                        //$ Por negocio
input double lucro_dia = 1000000;                                          //Lucro MAX dario ($ - liq)
input double preju_dia = 1000000;                                          //Preju MAX dario ($ - liq)
input bool   interrompe_durante = 0;                                       // Interrompe a operacao nos limites (no candle)


string Descricao_Robo = Descricao_Robo_Alpha;
sinput int Tipo_Comentario = 2;                                          //Tipo de Comentario (0 - simples, 1 - Avancado, 2 - DEBUG)
input bool Otimizacao = false;                                          //Parametro para otimizacao

input string Limite = "----------USANDO TICK SIZE-----------";
enum Tipo_Limites
{
  Limite_Fixo = 55,
  Limite_Proporcional_StopsLevel  = 471
};
input Tipo_Limites Tipo_Limite = 55;                                      //Tipo De limite
input double StopLoss = 0;                                                 //Stop Loss (0 desliga)
double Limite_Maximo_SL_Tick_Size = 50000;                        //Limite StopLoss Maximo (*TickSize)
//input double MoverSL = 0;                                              //Mover o StopLoss DELTA (distancia da entrada, 0 desliga)
//input double PontoDeMudancaSL = 0;                                         //Distancia da entrada DELTA (Direcao do Lucro, 0 = Preco da Operacao)
input double TakeProfit = 0;                                               //Take Profit (0 desliga)
input double TakeProfit_Volume = 0;                                               //Volume TakeProfit
input double TakeProfit2 = 0;                                               //Take Profit2 (0 desliga)
input double TakeProfit_Volume2 = 0;                                               //Volume TakeProfit2
input double TakeProfit3 = 0;                                               //Take Profit3 (0 desliga)
input double TakeProfit_Volume3 = 0;                                              //Volume TakeProfit3
input int   Zerar_SL_TP = 1;                                                 //Zerar SL 0 - desliga | 1 - na primeira | 2 - na segunda
input double Trailing_stop = 0;                                             //Trailing Stop (0 desliga)
input double Trailing_stop_start = 0;                                      //Inicio do Trailing Stop (0 desliga)

//
// input string _Escalpelador_Maluco  =  "USANDO TICK SIZE E PROP - CUIDADO----";
// input bool Usa_EM = false;                                                       //Usa Escalpelador Maluco
// enum EM_Tipo_Picote
// {
//   Fixo = 55,
//   Proporcional  = 471
// };
// input EM_Tipo_Picote EM_Picote_Tipo = 55;
// input double Tamanho_Picote = 1;                                                 //Tamanho do Picote (Fixo & Prop)
// input int EM_Vezes_Picote = 2;                                                   //Quantas vezes ele picota antes de esperar
//
// int EM_Contador_Picote = 0;

double Tick_Size = 0;
double Volume_Step = 0;

//VARS

int Contador_SLMOVEL = 0;

string HorarioInicio = IntegerToString(HoraDeInicio,2,'0') + ":" + IntegerToString(MinutoDeInicio,2,'0');
int MinutoDeFimMenos1;
string HorarioFim;
string HorarioFimMais1;
datetime data_inicio_execucao = TimeCurrent();


///////////////////////////////// Variaveis

datetime Agora;
string DiaHoje ;

double   Direcao = 0;
bool     Ordem = false;
int      Operacoes = 0;

bool     JaDeuFinal = false;
bool     JaZerou = false;

bool   DeuTakeProfit = true;
bool   DeuStopLoss = true;
bool   PrimeiraOp = false;

int TimeMagic;
bool DaResultado;
double Acumulado = 0;
uint num_ordem_tiquete;
datetime Data_Hoje;

string Desc_Req = "";

int OperacoesFeitas = 0;
int OperacoesFeitasGlobais = 0;
double Liquidez_Teste = 0;

double liquidez_inicio = 0;
double Liquidez_Teste_fim = 0;
double Liquidez_inicio = 0;

///////////////////////////////////////////

///////////////////////////////////////////

string Comentario_Simples = "";
string Comentario_Avancado = "";
string Comentario_Debug = "";

string Comentario_Robo = "";

string PrecoNegocio = "0";

//Variaveis Definidas Globalmente
double daotick_geral = 0;
double daotick_venda = 0;
double daotick_compra = 0;
double Saldo_Do_Dia_RT = 0;
double Calcula_Spread_RT = 0;
//bool Saldo_Dia_Permite_RT = 0;
bool TaDentroDoHorario_RT = 0;

//FIM DAS VDG
/////////////////////////////////////////// TEMP OFF
// input string Label_Filtro_Fuzzy = "---------- FILTRO FUZZY ----------";
// input bool Filtro_Fuzzy_Ligado = false;
// input bool Filtro_Fuzzy_Arquivo_Fisico = false;
// input bool Filtro_Fuzzy_Escreve_Estatistica = false;
// input bool Filtro_Fuzzy_Escreve_Fuz = false;
// input double Filtro_Fuzzy_Limite = 51;
// input int Filtro_Fuzzy_Num_Linhas = 20;
// input int Filtro_Fuzzy_Ultimas_Linhas = 100;
// input double Filtro_Fuzzy_Histerese = 0.3;
string Label_Filtro_Fuzzy = "---------- FILTRO FUZZY ----------";
bool Filtro_Fuzzy_Ligado = false;
bool Filtro_Fuzzy_Arquivo_Fisico = false;
bool Filtro_Fuzzy_Escreve_Estatistica = false;
bool Filtro_Fuzzy_Escreve_Fuz = false;
double Filtro_Fuzzy_Limite = 51;
int Filtro_Fuzzy_Num_Linhas = 20;
int Filtro_Fuzzy_Ultimas_Linhas = 100;
double Filtro_Fuzzy_Histerese = 0.3;

double filtro_fuzzy_arquivo = 0;
/////////////////////////////////////////// TEMP OFF
#include <Inputs_ML.mqh>
input string Label_Filtro_Filtros = "//////////////////////////////////// FILTROS ////////////////////////////////////"; //FILTROS
input string Label_Filtro_RNA_Filtro = "---------- RNA Filtros ----------"; //FILTROS RNA
input bool rna_filtros_on = false;
input double rna_permite = 0;
sinput bool rna_levanta_arquivo_rede = false;
input string rna_arquivo_trn = "Arquivo_Ja_Salvo_Em_COMMON.trn";

input string Label_Filtro_RDF_Filtro = "---------- RDF Filtros ----------"; //FILTROS RNA
input bool rdf_filtros_on = false;
input double rdf_permite = 0;
sinput bool rdf_levanta_arquivo_arvores = false;
input string rdf_arquivo_trn = "Arquivo_Ja_Salvo_Em_COMMON.rdf.trn";


long tipo_margem_conta = 0;
string minuto_passado = "0";

bool mocosa_indicadores = true; //esconde indicadores no teste, util para ver fluir.


bool ja_zerou_sl_temp = false; //PQ NAO TO AGUENTANDO MAIS
