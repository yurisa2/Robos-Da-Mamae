//+------------------------------------------------------------------+
//|                                                       Inputs.mqh |
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robôs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

/////////////////////////////////////// Inputs

input string Parametros_Gerais = "-------------------------------------"; //Parametros Gerais
input int Lotes = 1;                                                      //Volume negociado
input int HoraDeInicio = 9;                                                //Hora de Início
input int MinutoDeInicio = 20;                                              //Minuto de Inicio
input int HoraDeFim = 17;                                                  //Hora de Fim
input int MinutoDeFim = 27;                                                //Minuto de Fim
input int Limite_Operacoes = 9999;                                         //Limite de operações
input double lucro_dia = 1000000;                                          //Lucro da Conta desde inicio da execução

input bool   ZerarFinalDoDia = true;                                       //Encerra operações no final do dia (execução extendida)
input string Descricao_Robo = "";                                          //Descrição para logs e mensagens
input ENUM_ORDER_TYPE_FILLING TipoDeOrdem = ORDER_FILLING_RETURN;          //Tipo de ordem (teste)
input bool OperacaoLogoDeCara = false;                                     //Opera assim que o horário liberar, sem virada de tendencia


input string Indicadores = "-------------------------------------";
input ENUM_TIMEFRAMES TimeFrame = PERIOD_M10;
input bool SaiPeloIndicador = true;                                        //Saida pelo indicador
input bool IndicadorTempoReal = false;                                     //Indicador em tempo real

input string Configs_HiLo = "-------------------------------------";
input bool Usa_Hilo = 1;                                                   //Usar HiLo
input int Periodos =  4;                                              //Periodos do HiLo


input string Configs_Ozy = "-------------------------------------";
input bool Usa_Ozy = 0;                                                   //Usar Ozymandias
input ENUM_MA_METHOD Ozy_MM =  MODE_SMA;                                              //Tipo de MM Ozymandias
input int Ozy_Shift = 0;                                                  //Shift Ozymandias
input int Ozy_length = 2;                                                  //Length Ozymandias


input string Configs_PSAR = "-------------------------------------";
input bool Usa_PSar = 0;                                                   //Usar Parabolic SAR
input double PSAR_Step = 0;                                             //Parabolic SAR Step (0.02)
input double PSAR_Max_Step = 0;                                          //Parabolic SAR Max Step (0.2)

input string Configs_Fractals = "-------------------------------------";
input bool Usa_Fractal = 0;                                                   //Usar Fractals (Bill Williams)
input int   Frac_Candles_Espera = 3;                                           //Quantos candles esperar o sinal (3)

input string Limites_Fixos = "-------------------------------------";
input bool   Usa_Fixos = true;                                             //Usar Limites Fixos
input double StopLoss = 0;                                                 //Stop Loss (0 desliga)
input double MoverSL = 0;                                                  //Mover o StopLoss DELTA (distância da entrada, 0 desliga)
input double PontoDeMudancaSL = 0;                                         //Distancia da entrada DELTA (Direção do Lucro, 0 = Preco da Operação)
input double TakeProfit = 0;                                               //Take Profit (0 desliga)
input double Trailing_stop =0;                                             //Trailing Stop (0 desliga)
input double Trailing_stop_start = 0;                                      //Inicio do Trailing Stop (0 desliga)


input string Limites_Proporcionais  = "-------------------------------------";
enum Met_Prop

  {

  BB = 88,

  SMA  =534

  };
input bool     Usa_Prop = true;                                                //Usar Limites Proporcionais
input Met_Prop Prop_Metodo = 534;                                             //Método utilizado para o DELTA                                              
input int      Prop_Periodos = 3;                                           //Períodos do prop SMA(3) BB(20)
input double   Prop_StopLoss = 0.7;                                        //StopLoss: Multiplicador do Delta (0 desliga)
input double   Prop_MoverSL = 0;                                                  //Mover o StopLoss DELTA (distância da entrada, 0 desliga)
input double   Prop_PontoDeMudancaSL = 0;                                         //Distancia da entrada DELTA (Direção do Lucro, 0 = Preco da Operação)
input double   Prop_TakeProfit = 1;                                       //TakeProfit: Multiplicador do Delta (0 desliga)
input double   Prop_Trailing_stop =0;                                    //Trailing Stop: Multiplicador do Delta (0 desliga)
input double   Prop_Trailing_stop_start = 0;                                      //Inicio do Trailing Stop (0 desliga)
input double   Prop_Limite_Minimo_Tick_Size = 0;                                  //Limite Mínimo para operar (*Tick Size)


double Tick_Size = 0;
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

double   Mudanca = 0;
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

int Mudou = 0;

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

int HandleGHL;
int HandlePSar;
int HandleFrac;
int HandleOzy;
int CondicaoPsar;


double liquidez_inicio=0;

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