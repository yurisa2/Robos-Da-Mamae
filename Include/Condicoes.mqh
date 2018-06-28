/* -*- C++ -*- */
//+------------------------------------------------------------------+
//|                                                              Sa2 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "PetroSa, Robs feitos na hora, quentinhos, tragam vasilhas."
#property link      "http://www.sa2.com.br"

class Condicoes_Basicas_OO
{
  public:
  bool Condicao();
  bool Horario();
  bool Operacao_Em_Curso();
  bool Condicoes_Basicas_OO::Lucro_Diario();
  bool Condicoes_Basicas_OO::Preju_Diario();
  bool Condicoes_Basicas_OO::Numero_Negocios();

  private:



};

bool Condicoes_Basicas_OO::Horario()
{
  string DiaHoraInicio;
  string DiaHoraFim;

  Agora = TimeCurrent();

  DiaHoje = TimeToString(TimeCurrent(),TIME_DATE);

  DiaHoraInicio = DiaHoje + " " + HorarioInicio;
  DiaHoraFim = DiaHoje + " " + HorarioFim;

  // Se Agora > String Dia + String Hora OK.
  //   Print("DiaHoje ",DiaHoje);
  if(Agora>=StringToTime(DiaHoraInicio) && Agora<=StringToTime(DiaHoraFim))
  {

      return true;
  }
  else return false;

}

bool Condicoes_Basicas_OO::Operacao_Em_Curso()
{
  if(O_Stops.Tipo_Posicao() == 0) return false;
  else return true;
}

bool Condicoes_Basicas_OO::Condicao()
{
  int Operacao_EC = 0;
  int Horario_Permite = 0;
  int NeuralNetwork_Permite = 0;
  int RandomDecisionForest_Permite = 0;


  if(!Operacao_Em_Curso()) Operacao_EC = 1;
  if(Horario()) Horario_Permite = 1;

  if(ml_on && rna_filtros_on)
  {
  machine_learning.Processa_RNA(resposta_y,machine_learning.rede_obj,dados_nn.x_entrada);
  double ml_p = resposta_y[1];
  if(ml_p >= rna_permite) NeuralNetwork_Permite = 1;
  Print("ml_p "+ DoubleToString(ml_p));

  }
  else NeuralNetwork_Permite = 1;

  if(ml_on && rdf_filtros_on)
  {
  machine_learning.Processa_RDF(resposta_y,machine_learning.tree_obj,dados_nn.x_entrada);
  double ml_t = resposta_y[1];
  if(ml_t >= rdf_permite) RandomDecisionForest_Permite = 1;
  Print("ml_t "+ DoubleToString(ml_t));

  }
  else RandomDecisionForest_Permite = 1;

  int Soma_Permite =  Operacao_EC +
                      Horario_Permite +
                      NeuralNetwork_Permite +
                      RandomDecisionForest_Permite +
                      Numero_Negocios() +
                      Lucro_Diario() +
                      Preju_Diario()


                      ;

  if(Soma_Permite == 7 ) return true;
  else return false;
}

bool Condicoes_Basicas_OO::Numero_Negocios()
{
  bool retorno = false;
  Totalizador *totalizator2 = new Totalizador(1);
  if(totalizator2.negocios < Limite_Operacoes) retorno = true;

  delete(totalizator2);
  return retorno;
}

bool Condicoes_Basicas_OO::Lucro_Diario()
{
  bool retorno = false;
  Totalizador *totalizator2 = new Totalizador(1);
  if(totalizator2.ganho_liquido() <= lucro_dia || lucro_dia == 0) retorno = true;

  delete(totalizator2);
  return retorno;
}

bool Condicoes_Basicas_OO::Preju_Diario()
{
  bool retorno = false;
  Totalizador *totalizator2 = new Totalizador(1);
  if((totalizator2.ganho_liquido() *-1) <= preju_dia  || lucro_dia == 0) retorno = true;

  delete(totalizator2);
  return retorno;
}

Condicoes_Basicas_OO Condicoes_Basicas;
