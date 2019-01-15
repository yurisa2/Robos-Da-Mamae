/* -*- C++ -*- */

class Xeon
{

  public:
  void Comentario();
  void SendData(string url, string headers);
  void Avalia();
  Xeon();

  private:

};

void Xeon::Xeon()
{


}

void Xeon::Avalia()
{
  Aquisicao *ind = new Aquisicao;

  string base_url = "http://localhost:8000/writecsv";

  for(int i = 0; i < 1; i++) {
    ind.Dados(i);
    string payloapost_request;

    payloapost_request += "barra=";
    payloapost_request += IntegerToString(i);

    payloapost_request += "&AC_Var=";
    payloapost_request += DoubleToString(ind.AC_Var);

    payloapost_request += "&AC_cx=";
    payloapost_request += DoubleToString(ind.AC_cx);

    payloapost_request += "&AC_norm=";
    payloapost_request += DoubleToString(ind.AC_norm);

    payloapost_request += "&AD_Var=";
    payloapost_request += DoubleToString(ind.AD_Var);

    payloapost_request += "&AD_cx=";
    payloapost_request += DoubleToString(ind.AD_cx);

    payloapost_request += "&AD_norm=";
    payloapost_request += DoubleToString(ind.AD_norm);

    payloapost_request += "&ADX_FW=";
    payloapost_request += DoubleToString(ind.ADX_FW);

    payloapost_request += "&adx_cx=";
    payloapost_request += DoubleToString(ind.adx_cx);

    payloapost_request += "&adx_norm=";
    payloapost_request += DoubleToString(ind.adx_norm);

    payloapost_request += "&ATR_Var=";
    payloapost_request += DoubleToString(ind.ATR_Var);

    payloapost_request += "&ATR_cx=";
    payloapost_request += DoubleToString(ind.ATR_cx);

    payloapost_request += "&ATR_norm=";
    payloapost_request += DoubleToString(ind.ATR_norm);

    payloapost_request += "&BB_Delta_Bruto=";
    payloapost_request += DoubleToString(ind.BB_Delta_Bruto);

    payloapost_request += "&BB_Delta_Bruto_Cx=";
    payloapost_request += DoubleToString(ind.BB_Delta_Bruto_Cx);

    payloapost_request += "&BB_Delta_Bruto_norm=";
    payloapost_request += DoubleToString(ind.BB_Delta_Bruto_norm);

    payloapost_request += "&Banda_Delta_Valor=";
    payloapost_request += DoubleToString(ind.Banda_Delta_Valor);

    payloapost_request += "&BB_Posicao_Percent=";
    payloapost_request += DoubleToString(ind.BB_Posicao_Percent);

    payloapost_request += "&BB_Posicao_Percent_Cx=";
    payloapost_request += DoubleToString(ind.BB_Posicao_Percent_Cx);

    payloapost_request += "&BB_Posicao_Percent_norm=";
    payloapost_request += DoubleToString(ind.BB_Posicao_Percent_norm);

    payloapost_request += "&BullsP_Var=";
    payloapost_request += DoubleToString(ind.BullsP_Var);

    payloapost_request += "&BullsP_Var_Cx=";
    payloapost_request += DoubleToString(ind.BullsP_Var_Cx);

    payloapost_request += "&BullsP_norm=";
    payloapost_request += DoubleToString(ind.BullsP_norm);

    payloapost_request += "&BearsP_Var=";
    payloapost_request += DoubleToString(ind.BearsP_Var);

    payloapost_request += "&BearsP_Var_Cx=";
    payloapost_request += DoubleToString(ind.BearsP_Var_Cx);

    payloapost_request += "&BearsP_norm=";
    payloapost_request += DoubleToString(ind.BearsP_norm);

    payloapost_request += "&BWMFI_Var=";
    payloapost_request += DoubleToString(ind.BWMFI_Var);

    payloapost_request += "&BWMFI_Var_Cx=";
    payloapost_request += DoubleToString(ind.BWMFI_Var_Cx);

    payloapost_request += "&BWMFI_norm=";
    payloapost_request += DoubleToString(ind.BWMFI_norm);

    payloapost_request += "&CCI_Var=";
    payloapost_request += DoubleToString(ind.CCI_Var);

    payloapost_request += "&CCI_Var_Cx=";
    payloapost_request += DoubleToString(ind.CCI_Var_Cx);

    payloapost_request += "&CCI_norm=";
    payloapost_request += DoubleToString(ind.CCI_norm);

    payloapost_request += "&DeMarker_Var=";
    payloapost_request += DoubleToString(ind.DeMarker_Var);

    payloapost_request += "&DeMarker_Var_Cx=";
    payloapost_request += DoubleToString(ind.DeMarker_Var_Cx);

    payloapost_request += "&DeMarker_norm=";
    payloapost_request += DoubleToString(ind.DeMarker_norm);

    payloapost_request += "&DP_DMM20=";
    payloapost_request += DoubleToString(ind.DP_DMM20);

    payloapost_request += "&DP_PAAMM20=";
    payloapost_request += DoubleToString(ind.DP_PAAMM20);

    payloapost_request += "&DP_MM20MM50=";
    payloapost_request += DoubleToString(ind.DP_MM20MM50);

    payloapost_request += "&DP_D=";
    payloapost_request += DoubleToString(ind.DP_D);

    payloapost_request += "&MFI_FW=";
    payloapost_request += DoubleToString(ind.MFI_FW);

    payloapost_request += "&MFI_Cx=";
    payloapost_request += DoubleToString(ind.MFI_Cx);

    payloapost_request += "&MFI_norm=";
    payloapost_request += DoubleToString(ind.MFI_norm);

    payloapost_request += "&Momentum_Var=";
    payloapost_request += DoubleToString(ind.Momentum_Var);

    payloapost_request += "&Momentum_Var_Cx=";
    payloapost_request += DoubleToString(ind.Momentum_Var_Cx);

    payloapost_request += "&Momentum_norm=";
    payloapost_request += DoubleToString(ind.Momentum_norm);

    payloapost_request += "&RSI_Var=";
    payloapost_request += DoubleToString(ind.RSI_Var);

    payloapost_request += "&RSI_Var_Cx=";
    payloapost_request += DoubleToString(ind.RSI_Var_Cx);

    payloapost_request += "&RSI_norm=";
    payloapost_request += DoubleToString(ind.RSI_norm);

    payloapost_request += "&Stoch_FW=";
    payloapost_request += DoubleToString(ind.Stoch_FW);

    payloapost_request += "&Stoch_Cx_0=";
    payloapost_request += DoubleToString(ind.Stoch_Cx_0);

    payloapost_request += "&Stoch_Cx_1=";
    payloapost_request += DoubleToString(ind.Stoch_Cx_1);

    payloapost_request += "&Stoch_norm_1=";
    payloapost_request += DoubleToString(ind.Stoch_norm_1);

    payloapost_request += "&Stoch_norm_2=";
    payloapost_request += DoubleToString(ind.Stoch_norm_2);

    payloapost_request += "&Volume_FW=";
    payloapost_request += DoubleToString(ind.Volume_FW);

    payloapost_request += "&Volume_Cx=";
    payloapost_request += DoubleToString(ind.Volume_Cx);

    payloapost_request += "&Volume_norm=";
    payloapost_request += DoubleToString(ind.Volume_norm);

    payloapost_request += "&WPR_Var=";
    payloapost_request += DoubleToString(ind.WPR_Var);

    payloapost_request += "&WPR_Var_Cx=";
    payloapost_request += DoubleToString(ind.WPR_Var_Cx);

    payloapost_request += "&WPR_norm=";
    payloapost_request += DoubleToString(ind.WPR_norm);

    this.SendData(base_url,payloapost_request);
  }
  delete(ind);
}

void Xeon::Comentario()
{
  if(Tipo_Comentario > 0)
  {
    Comentario_Robo = "Xeon: ";
    // Comentario_Robo += "\n Spread: ";
//
  }
}

void Xeon::SendData(string url, string content){

  Print("SendingData");

  string cookie=NULL,result_headers;
     char   data[];
     char result[];
  //--- para trabalhar com o servidor é necessário adicionar a URL "https://finance.yahoo.com"
  //--- na lista de URLs permitidas (menu Principal->Ferramentas->Opções, guia "Experts"):
  //--- redefinimos o código do último erro
     ResetLastError();
  //--- download da página html do Yahoo Finance
  // string headers2 = "Content-Type: application/x-www-form-urlencoded";
  string headers2 = "";
  // string headers2 = headers;
//
// first_name=John&last_name=Doe&action=Submit";

  ArrayResize(data, StringToCharArray(content, data, 0, WHOLE_ARRAY)-1);

     int res=WebRequest("POST",url,headers2,500,data,result,result_headers);
     if(res==-1)
       {
        Print("Erro no WebRequest. Código de erro =",GetLastError());
        //--- é possível que a URL não esteja na lista, exibimos uma mensagem sobre a necessidade de adicioná-la
        MessageBox("É necessário adicionar um endereço '"+url+"' à lista de URL permitidas na guia 'Experts'","Erro",MB_ICONINFORMATION);
       }
     else
       {
        if(res==200)
          {
           //--- download bem-sucedido
           PrintFormat("O arquivo foi baixado com sucesso, tamanho %d bytes.",ArraySize(result));
           //PrintFormat("Cabeçalhos do servidor: %s",headers);
           //--- salvamos os dados em um arquivo
           int filehandle=FileOpen("url.htm",FILE_WRITE|FILE_BIN);
           if(filehandle!=INVALID_HANDLE)
             {
              //--- armazenamos o conteúdo do array result[] no arquivo
              FileWriteArray(filehandle,result,0,ArraySize(result));
              //--- fechamos o arquivo
              FileClose(filehandle);
             }
           else
              Print("Erro em FileOpen. Código de erro =",GetLastError());
          }
        else
           PrintFormat("Erro de download '%s', código %d",url,res);
       }
}
