/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                       Inputs.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robos feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

/////////////////////////////////////// Inputs

input string Parametros_Gerais = "-------------------------------------";  //Parametros Gerais
// input bool  multi_op = false;                                              //Multi Operacao (define o método de operacao)
input ENUM_TIMEFRAMES TimeFrame = PERIOD_CURRENT;                              //TimeFrame base

input int HoraDeInicio = 9;                                                //Hora de Inicio
input int MinutoDeInicio = 20;                                             //Minuto de Inicio
input int HoraDeFim = 17;                                                  //Hora de Fim
input int MinutoDeFim = 27;                                                //Minuto de Fim
input bool   ZerarFinalDoDia = true;                                       //Encerra operacoes no final do dia (execucao extendida)
input string Descricao_Robo_Alpha = "";                                    //Descricao para logs e mensagens
input bool Aleta_Operacao = false;                                          //Aparece um alerta quando entra
//string Descricao_Robo = Descricao_Robo(); +"|"+Descricao_Robo_Alpha;
input bool Custom_resultado_treino_nn = false;

input string Parametros_Financeiros = "---------OU QUASE--------------------";
input double Lotes = 1;                                                    //Volume negociado
input int Limite_Operacoes = 9999;                                         //Limite de operacoes diário (entrada e Saida)
input double custo_operacao = 1.36;                                        //$ Por negocio
input double lucro_dia = 1000000;                                          //Lucro MAX dario ($ - liq)
input double preju_dia = 1000000;                                          //Preju MAX dario ($ - liq)
input bool   interrompe_durante = 0;                                       // Interrompe a operacao nos limites (no candle)


string Descricao_Robo = Descricao_Robo_Alpha;
input int Tipo_Comentario = 2;                                          //Tipo de Comentario (0 - simples, 1 - Avancado, 2 - DEBUG)
input bool Otimizacao = false;                                          //Parametro para otimizacao

input string Limite = "----------USANDO TICK SIZE-----------";
enum Tipo_Limites
{
  Limite_Fixo = 55,
  Limite_Proporcional  = 471
};
input Tipo_Limites Tipo_Limite = 55;                                      //Tipo De limite
input double StopLoss = 0;                                                 //Stop Loss (0 desliga)
input double Limite_Maximo_SL_Tick_Size = 50;                        //Limite StopLoss Maximo (*TickSize)
//input double MoverSL = 0;                                              //Mover o StopLoss DELTA (distancia da entrada, 0 desliga)
//input double PontoDeMudancaSL = 0;                                         //Distancia da entrada DELTA (Direcao do Lucro, 0 = Preco da Operacao)
input double TakeProfit = 0;                                               //Take Profit (0 desliga)
input double TakeProfit_Volume = 0;                                               //Volume TakeProfit
input double TakeProfit2 = 0;                                               //Take Profit2 (0 desliga)
input double TakeProfit_Volume2 = 0;                                               //Volume TakeProfit2
input double TakeProfit3 = 0;                                               //Take Profit3 (0 desliga)
input double TakeProfit_Volume3 = 0;                                              //Volume TakeProfit3
input bool   Zerar_SL_TP = 1;                                                 //Zerar SL na realizacao parcial
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


long tipo_margem_conta = 0;
string minuto_passado = "0";

bool mocosa_indicadores = true; //esconde indicadores no teste, util para ver fluir.
