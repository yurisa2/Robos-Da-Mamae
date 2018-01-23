/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                       Inputs.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

/////////////////////////////////////// Inputs

input string Parametros_Gerais = "-------------------------------------";  //Parametros Gerais
// input bool  multi_op = false;                                              //Multi Operacao (define o método de operacao)
input ENUM_TIMEFRAMES TimeFrame = PERIOD_CURRENT;                              //TimeFrame base

input int HoraDeInicio = 9;                                                //Hora de Inicio
input int MinutoDeInicio = 20;                                             //Minuto de Inicio
input int HoraDeFim = 17;                                                  //Hora de Fim
input int MinutoDeFim = 27;                                                //Minuto de Fim
input bool   ZerarFinalDoDia = true;                                       //Encerra operações no final do dia (execução extendida)
input string Descricao_Robo_Alpha = "";                                    //Descriçõo para logs e mensagens
//string Descricao_Robo = Descricao_Robo(); +"|"+Descricao_Robo_Alpha;

input string Parametros_Financeiros = "---------OU QUASE--------------------";
input double Lotes = 1;                                                    //Volume negociado
//input int Limite_Operacoes = 9999;                                         //Limite de operações (entrada e Saida)
input double custo_operacao = 1.36;                                        //$ Por negocio
//input double lucro_dia = 1000000;                                          //Lucro MAX dario ($ - liq)
//input double preju_dia = 1000000;                                          //Preju MAX dario ($ - liq)
//input bool   interrompe_durante = 0;                                       //(NAO FUNCIONAL AINDA) Interrompe a operacao nos limites IMEDIATAMENTE


string Descricao_Robo = Descricao_Robo_Alpha;
input int Tipo_Comentario = 1;                                          //Tipo de Comentario (0 - simples, 1 - Avancado, 2 - DEBUG)
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
//input double MoverSL = 0;                                              //Mover o StopLoss DELTA (distância da entrada, 0 desliga)
//input double PontoDeMudancaSL = 0;                                         //Distancia da entrada DELTA (Direção do Lucro, 0 = Preco da Operacão)
input double TakeProfit = 0;                                               //Take Profit (0 desliga)
input double TakeProfit_Volume = 0;                                               //Volume TakeProfit
input double TakeProfit2 = 0;                                               //Take Profit2 (0 desliga)
input double TakeProfit_Volume2 = 0;                                               //Volume TakeProfit2
input double TakeProfit3 = 0;                                               //Take Profit3 (0 desliga)
input double TakeProfit_Volume3 = 0;                                              //Volume TakeProfit3
input bool   Zerar_SL_TP = 1;                                                 //Zerar SL na realização parcial
input double Trailing_stop = 0;                                             //Trailing Stop (0 desliga)
input double Trailing_stop_start = 0;                                      //Inicio do Trailing Stop (0 desliga)

input string Limites_Label  =  "Limites e Condicões de entrada";   // Limites e condições de entrada
input double Limite_Volume_Min = 0;                                //Limite Minimo Volume (Absoluto)
input double Limite_Volume_Max = 999999;                                //Limite Maximo Volume (Absoluto)
input double Limite_BB_Bruta_Min = 0;                                //Limite BB_Bruta  (*Tick Size)
input double Limite_BB_Bruta_Max = 999999;                                //Limite BB_Bruta (*Tick Size)
input double Limite_Minimo_Tick_Size = 0;                          //Limite Minimo (BB Delta) para operar (*Tick Size)
input double Limite_Maximo_Tick_Size = 9999;                          //Limite Maximo (BB Delta) para operar (*Tick Size)
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
double Liquidez_Teste_inicio = 0;

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
