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
input ENUM_TIMEFRAMES TimeFrame = PERIOD_M10;                              //TimeFrame base

input int HoraDeInicio = 9;                                                //Hora de Início
input int MinutoDeInicio = 20;                                             //Minuto de Inicio
input int HoraDeFim = 17;                                                  //Hora de Fim
input int MinutoDeFim = 27;                                                //Minuto de Fim
input bool   ZerarFinalDoDia = true;                                       //Encerra operações no final do dia (execução extendida)
input string Descricao_Robo_Alpha = "";                                    //Descrição para logs e mensagens
//string Descricao_Robo = Descricao_Robo(); +"|"+Descricao_Robo_Alpha;

input string Parametros_Financeiros = "---------OU QUASE--------------------";
input double Lotes = 1;                                                    //Volume negociado
input int Limite_Operacoes = 9999;                                         //Limite de operações (entrada e Saida)
input double custo_operacao = 1.36;                                        //$ Por negocio
input double lucro_dia = 1000000;                                          //Lucro MAX dario ($ - liq)
input double preju_dia = 1000000;                                          //Preju MAX dario ($ - liq)
input bool   interrompe_durante = 0;                                       //(NAO FUNCIONAL AINDA) Interrompe a operacao nos limites IMEDIATAMENTE


string Desc_Se_Vazio ()
{
string TM = "";
/* VERIFICAR COMO FUNCIONAR ISSO
if(Descricao_Robo_Alpha =="")
  {
   TM = IntegerToString(TimeMagic);
  }*/
return TM;
}

string Descricao_Robo = Desc_Se_Vazio()+Descricao_Robo_Alpha;
input ENUM_ORDER_TYPE_FILLING TipoDeOrdem = ORDER_FILLING_RETURN;       //Tipo de ordem (teste)
input bool FX = false;                                                  // É Forex
input int Tipo_Comentario = 1;                                          //Tipo de Comentario (0 - simples, 1 - Avancado, 2 - DEBUG)
input bool Otimizacao = false;                                          //Parametro para otimização



input string Limites_Fixos = "----------USANDO TICK SIZE-----------";
input bool   Usa_Fixos = false;                                             //Usar Limites Fixos
input double StopLoss = 0;                                                 //Stop Loss (0 desliga)
input double RAW_MoverSL = 0;                                              //Mover o StopLoss DELTA (distância da entrada, 0 desliga)
input double PontoDeMudancaSL = 0;                                         //Distancia da entrada DELTA (Direção do Lucro, 0 = Preco da Operação)
input double TakeProfit = 0;                                               //Take Profit (0 desliga)
input double Trailing_stop =0;                                             //Trailing Stop (0 desliga)
input double Trailing_stop_start = 0;                                      //Inicio do Trailing Stop (0 desliga)

double MoverSL = 0;

input string Limites_Proporcionais  = "-------------------------------------";
enum Met_Prop
  {
  BB = 88,
  SMA  =534
  };
input bool     Usa_Prop = true;                                           //Usar Limites Proporcionais
input Met_Prop Prop_Metodo = 534;                                         //Método utilizado para o DELTA
input int      Prop_Periodos = 3;                                         //Períodos do prop SMA(3) BB(20)
input double   Prop_StopLoss = 0.7;                                       //StopLoss: Multiplicador do Delta (0 desliga)
input double   Prop_MoverSL = 0;                                          //Mover o StopLoss DELTA (distância da entrada, 0 desliga)
input double   Prop_PontoDeMudancaSL = 0;                                 //Distancia da entrada DELTA (Direção do Lucro, 0 = Preco da Operação)
input double   Prop_TakeProfit = 1;                                       //TakeProfit: Multiplicador do Delta (0 desliga)
input double   Prop_Trailing_stop =0;                                     //Trailing Stop: Multiplicador do Delta (0 desliga)
input double   Prop_Trailing_stop_start = 0;                              //Inicio do Trailing Stop (0 desliga)
input double   Prop_Limite_Minimo_Tick_Size = 0;                          //Limite Mínimo para operar (*Tick Size)

input string _Escalpelador_Maluco  =  "USANDO TICK SIZE E PROP - CUIDADO----";
input bool Usa_EM = false;                                                       //Usa Escalpelador Maluco
enum EM_Tipo_Picote
  {
  Fixo = 55,
  Proporcional  = 471
  };
input EM_Tipo_Picote EM_Picote_Tipo = 55;
input double Tamanho_Picote = 1;                                                 //Tamanho do Picote (Fixo & Prop)
input int EM_Vezes_Picote = 2;                                                   //Quantas vezes ele picota antes de esperar

int EM_Contador_Picote = 0;

double Tick_Size = 0;

double Valor_Escalpe ;


double Prop_Limite_Minimo = 0;

//VARS

int Contador_SLMOVEL = 0;

string HorarioInicio = IntegerToString(HoraDeInicio,2,'0') + ":" + IntegerToString(MinutoDeInicio,2,'0');
int MinutoDeFimMenos1;
string HorarioFim;
string HorarioFimMais1;

///////////////////////////////// Variaveis

datetime Agora;
string DiaHoje ;

double   Direcao = 0;
bool     Ordem = false;
int      Operacoes = 0;

bool     JaDeuFinal = false;
bool     JaZerou = false;

double StopLossValorCompra =-9999999999;
double TakeProfitValorCompra = 999999999;
double StopLossValorVenda =99999999999;
double TakeProfitValorVenda = -999999999;
double PrecoCompra = 0;
double PrecoVenda = 0;
bool   DeuTakeProfit = true;
bool   DeuStopLoss = true;
bool   PrimeiraOp = false;

int TimeMagic;
bool DaResultado;
double Acumulado = 0;
uint num_ordem_tiquete;
datetime Data_Hoje;

double TS_ValorCompra = 0;
double TS_ValorVenda = 999999999;

double TS_ValorVenda_atual = 9999999;
double TS_ValorCompra_atual = 0;

string Desc_Req = "";

int OperacoesFeitas = 0;
int OperacoesFeitasGlobais = 0;
double Liquidez_Teste = 0;

int HandleGHL;
int HandlePSar;
int HandleFrac;
int HandleOzy;
int HandleBSI;

int CondicaoBSI;

double liquidez_inicio = 0;
double Liquidez_Teste_fim = 0;
double Liquidez_Teste_inicio = 0;

double Prop_MoverSL_Valor = 0 ;
double Prop_Trailing_Stop_Valor = 0 ;
double Prop_Trailing_stop_start_Valor = 0;

///////////////////////////////////////////

 int Handle_Prop_Media_Alta = 0;
 int Handle_Prop_Media_Baixa = 0;
 int Handle_Prop_BB =0;
 int HandleHiLoMediaAlta =0;
 int HandleHiLoMediaBaixa = 0;
 double RetornaTendencia = 0;

 ///////////////////////////////////////////

 string Comentario_Simples = "";
 string Comentario_Avancado = "";
 string Comentario_Debug = "";

 string Comentario_Robo = "";

 int spread = 0;
