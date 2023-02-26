unit View.Cadastros.Pessoas;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Dao.Conexao,
  DAO.Delete,
  Dao.Inserir,
  DAO.Lote,
  DAO.Update,
  REST.Types,
  REST.Client,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  REST.Response.Adapter,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Firedac.Dapt,
  Vcl.Grids,
  Vcl.DBGrids,
  Model.Pessoas,
  Datasnap.DBClient,
  Vcl.DBCtrls,
  FireDAC.Phys.PGDef,
  FireDAC.Phys,
  FireDAC.Phys.PG,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI,
  Classe.Pessoas, FireDAC.Stan.Async;

type
  TForm2 = class(TForm)
    Panel1                      : TPanel;
    BtnIncluir                  : TButton;
    BtnAlterar                  : TButton;
    BtnExcluir                  : TButton;
    BtnInserirLotes             : TButton;
    EdtIdPessoa                 : TEdit;
    Label2                      : TLabel;
    Label3                      : TLabel;
    EdtCEP                      : TEdit;
    EdtIdEndereco               : TEdit;
    EdtUF                       : TEdit;
    EdtCidade                   : TEdit;
    EdtBairro                   : TEdit;
    EdtLogradouro               : TEdit;
    EdtComplemento              : TEdit;
    Label4                      : TLabel;
    Label5                      : TLabel;
    Label6                      : TLabel;
    Label7                      : TLabel;
    Label8                      : TLabel;
    Label9                      : TLabel;
    RESTClient1                 : TRESTClient;
    RESTRequest1                : TRESTRequest;
    RESTResponse1               : TRESTResponse;
    RESTResponseDataSetAdapter1 : TRESTResponseDataSetAdapter;
    MemTable                    : TFDMemTable;
    DBGridPessoas               : TDBGrid;
    Label10                     : TLabel;
    EdtFlNatureza               : TEdit;
    Label11                     : TLabel;
    EdtDsDocumento              : TEdit;
    Label12                     : TLabel;
    EdtNMPRIMEIRO               : TEdit;
    Label13                     : TLabel;
    EdtDTREGISTRO               : TEdit;
    BtnSalvar                   : TButton;
    BtnDBNav                    : TDBNavigator;
    EdtNMSEGUNDO                : TEdit;
    Label1                      : TLabel;
    DataSource1                 : TDataSource;
    EdtPesquisa                 : TEdit;
    procedure EdtCEPExit                  (Sender: TObject);
    procedure BtnIncluirClick             (Sender: TObject);
    procedure FormShow                    (Sender: TObject);
    procedure BtnAlterarClick             (Sender: TObject);
    procedure BtnExcluirClick             (Sender: TObject);
    procedure EdtComplementoExit          (Sender: TObject);
    procedure BtnSalvarClick              (Sender: TObject);
    procedure BtnInserirLotesClick        (Sender: TObject);
    procedure DBGridPessoasDrawColumnCell (Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure EdtPesquisaKeyPress         (Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FPessoa: TPessoa;
//    FDAO: TModelDAOPessoa; {Mudar todos os DAO para um arquivo unico TesteWK.DAO.Pessoa }
    FUpdate: TUpdate;
    FDelete: TDAODelete;
    procedure LigaBotoes;
    procedure DesligaBotoes;
    procedure LimpaCampos;
    procedure DesligaCampos;
    Procedure LigaCampos;
    procedure PopularPessoa(var Pessoa: TPessoa);
    procedure QryPessoaAfterScroll(DataSet: TDataSet);
    procedure CarregaClassePessoa;
    procedure Alterar;

  public
    { Public declarations }
    QryPessoa: TFDQuery;
    FTipoAcao: String;
    procedure ZebrarDbGrid(dSouce: TDataSource;
                           grid  : TDBGrid;
                           State : TGridDrawState;
                           Rect  : TRect;
                           Column: TColumn);


  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses DAO.PopulaGrid;


procedure TForm2.BtnAlterarClick(Sender: TObject);
begin
  FTipoAcao := 'A';
  Desligabotoes;
  LigaCampos;
  EdtFlNatureza.SetFocus;

end;

procedure TForm2.BtnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Tem certeza que deseja excluir este Registro ?' + FPessoa.nmprimeiro,
     mtConfirmation,[mbYes, mbNo], 0) = mrYes then
  begin
    try
       FDelete            := TDAODelete.Create;
       FPessoa            := TPessoa.Create;
       FPessoa.idpessoa   := QryPessoa.FieldValues['idpessoa'];
       FPessoa.idEndereco := QryPessoa.FieldValues['idendereco'];
       FDelete.Excluir(FPessoa);
       QryPessoa.First;
       QryPessoa.Refresh;

    finally
      FDelete.Free;
      //FPessoa.Free;
    end;
  end;
end;

procedure TForm2.BtnIncluirClick(Sender: TObject);
var
  Incluir: TIncluir;
begin

  Desligabotoes;
  LigaCampos;
  LimpaCampos;
  EdtIdPessoa.text:= IntToStr(Incluir.PesquisaId('pessoa','idpessoa'));
  EdtFlNatureza.SetFocus;
end;

procedure TForm2.BtnInserirLotesClick(Sender: TObject);
var
  Lote: TLote;
begin
  Lote.InserirEmLote;
  QryPessoa.Refresh;
end;

procedure TForm2.BtnSalvarClick(Sender: TObject);
var
   Txt              : String;
   Incluir          : TIncluir;
   Conexao          : TConnection;
   Pessoa           : TPessoa;
   Regras           : TRegrasDeNegocio;
begin
   if FTipoAcao = 'A' then
   begin
     PopularPessoa(FPessoa);
     Alterar;
     LigaBotoes;
     QryPessoa.Refresh;
     exit;
   end;

   LigaBotoes;
   Txt:= EdtIdPessoa.Text;

   EdtIdPessoa.text:= IntToStr(Incluir.PesquisaId('pessoa','idpessoa'));

   {Persistencia de dados obrigatoria}
   try
      Regras:= TRegrasDeNegocio.Create;
      Regras.TestaseTemEndereco(EdtCEP.Text,
                                EdtIdEndereco.Text,
                                EdtUF.Text,
                                EdtCidade.Text,
                                EdtBairro.Text,
                                EdtLogradouro.Text);
   finally
     Regras.Free;
   end;

   try
     Pessoa:= TPessoa.Create;
     PopularPessoa(Pessoa);
     Incluir.Inserir(Pessoa);
     QryPessoa.Refresh;
     QryPessoa.Last;
   finally
     Pessoa.Free;
   end;

   if Txt <> EdtIdPessoa.text then
     ShowMessage('O Numero ' + Txt + 'foi recalculado para: ' + EdtIdPessoa.text);


end;

procedure TForm2.DBGridPessoasDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   ZebrarDbGrid(DataSource1, DBGridPessoas, State, Rect, Column);
end;

procedure TForm2.DesligaBotoes;
begin
  BtnIncluir.Enabled      := False;
  BtnAlterar.Enabled      := False;
  BtnExcluir.Enabled      := False;
  BtnSalvar.Enabled       := True;
  BtnInserirLotes.Enabled := False;
  BtnDBNav.Enabled        := True;
end;

procedure TForm2.DesligaCampos;
var
  i  : Integer;
begin
   For i := 0 to ComponentCount -1 do
   begin
     if Components[i] is TEdit then
      begin
       TEdit(Components[i]).ReadOnly:=True;
      end;
     if Components[i] is TComboBox then
      begin
       TComboBox(Components[i]).Enabled:= True;
      end;
     if Components[i] is TMemo then
      begin
       TMemo(Components[i]).ReadOnly:= True;
      end;
   end;
   EdtIdPessoa.ReadOnly:=True;

end;

procedure TForm2.EdtCEPExit(Sender: TObject);
var
  Incluir: TIncluir;
begin

  TThread.CreateAnonymousThread(procedure
  begin
    TThread.Queue(nil, procedure
    begin
      if Length(EdtCEP.Text)<5 then
      Exit;

      if EdtCEP.MaxLength > 8 then
      begin
        ShowMessage('O CEP deve conter somente 8 numeros');
        EdtCEP.SetFocus;
      end;

      RestRequest1.Resource := EdtCep.Text + '/json';
      RestRequest1.Execute;

      if RestRequest1.Response.StatusCode = 200 then
      begin
          if RestRequest1.Response.Content.IndexOf('erro')  > 0 then
            Showmessage('O CEP n�o foi encontrado')
          else
          begin
            with MemTable do
            begin

              EdtLogradouro.Text  := FieldByName('logradouro').AsString;
              EdtComplemento.Text := FieldByName('complemento').AsString;
              EdtBairro.Text      := FieldByName('bairro').AsString;
              EdtCidade.Text      := FieldByName('localidade').AsString;
              EdtUF.Text          := FieldByName('uf').AsString;
            end;
          end;
      end
      else
        ShowMessage('Erro ao consultar o CEP');

      try
        Incluir:= TIncluir.Create;
        EdtIdEndereco.text:= IntToStr(Incluir.PesquisaIdEndereco('endereco','idendereco'));
      finally
        Incluir.Free;
      end;

    end);

  end).Start

end;

procedure TForm2.EdtComplementoExit(Sender: TObject);
begin
  BtnSalvar.Enabled:= True;
  BtnSalvar.SetFocus;
end;

procedure TForm2.EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  QryPessoa.Locate('nmprimeiro', EdtPesquisa.Text, [loCaseInsensitive,loPartialKey]);
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FPessoa.Free;
end;

procedure TForm2.FormShow(Sender: TObject);
var
  Pessoa : TPopularGrid;
  Conexao: TConnection;

begin

  FPessoa:= TPessoa.Create;
  Ligabotoes;
  EdtFlNatureza.SetFocus;

  try
    Conexao:= TConnection.Create;
    QryPessoa:= TFDQuery.Create(Self);
    QryPessoa.Connection:= Conexao.CreateConnection;
    QryPessoa.SQL.Clear;
    QryPessoa.SQL.Add('Select p.*, e.*, i.* from public.pessoa p');
    QryPessoa.SQL.Add('Left Join endereco e on p.idpessoa = e.idpessoa');
    QryPessoa.SQL.Add('Left Join endereco_integracao i on e.idendereco = i.idendereco');
    QryPessoa.SQL.Add(' Order By p.idPessoa');
    QryPessoa.Open;

    BtnDBNav.DataSource:= DataSource1;
    QryPessoa.First;
    QryPessoa.AfterScroll:= QryPessoaAfterScroll;
    DataSource1.DataSet:= QryPessoa;
    DbGridPessoas.DataSource:= DataSource1;


  finally

  end;


end;

procedure TForm2.LigaBotoes;
begin
  BtnIncluir.Enabled:= True;
  BtnAlterar.Enabled:= True;
  BtnExcluir.Enabled:= True;
  BtnSalvar.Enabled := False;
  BtnInserirLotes.Enabled:= True;
  BtnDBNav.Enabled:= True;
end;

procedure TForm2.LigaCampos;
var
  i  : Integer;
begin
   For i := 0 to ComponentCount -1 do
   begin
     if Components[i] is TEdit then
      begin
       TEdit(Components[i]).ReadOnly:=false;
      end;
     if Components[i] is TComboBox then
      begin
       TComboBox(Components[i]).Enabled:= false;
      end;
     if Components[i] is TMemo then
      begin
       TMemo(Components[i]).ReadOnly:= false;
      end;
   end;

   EdtIdPessoa.ReadOnly:=True;

end;

procedure TForm2.PopularPessoa(var Pessoa: TPessoa);
begin

  Pessoa.idpessoa    := StrToInt64(EdtIdPessoa.Text);
  Pessoa.flnatureza  := StrToInt(EdtFlNatureza.Text);
  Pessoa.dsdocumento := EdtDsDocumento.Text;
  Pessoa.nmprimeiro  := EdtNMPRIMEIRO.Text;
  Pessoa.nmsegundo   := EdtNMSEGUNDO.Text;
  Pessoa.UF          := EdtUF.Text;
  Pessoa.Cidade      := EdtCidade.Text;
  Pessoa.Bairro      := EdtBairro.Text;
  Pessoa.Logradouro  := EdtLogradouro.Text;
  Pessoa.Complemento := EdtComplemento.Text;
  Pessoa.dtregistro  := StrToDateTime(EdtDTREGISTRO.Text);
  Pessoa.idEndereco  := StrToInt64(EdtIdEndereco.Text);
  Pessoa.CEP         := EdtCEP.Text;
end;


procedure TForm2.QryPessoaAfterScroll(DataSet: TDataSet);
begin

  EdtIdPessoa.Text   := QryPessoa.FieldByName('idpessoa').Value;
  EdtFlNatureza.Text := QryPessoa.FieldByName('flNatureza').Value;
  EdtDsDocumento.Text:= QryPessoa.FieldByName('dsDocumento').Value;
  EdtNMPRIMEIRO.Text := QryPessoa.FieldByName('nmprimeiro').Value;
  EdtNMSEGUNDO.Text  := QryPessoa.FieldByName('nmsegundo').Value;
  EdtDTREGISTRO.Text := QryPessoa.FieldByName('dtregistro').Value;
  EdtCEP.Text        := QryPessoa.FieldByName('dsCEP').Value;
  EdtIdEndereco.Text := QryPessoa.FieldByName('idEndereco').Value;
  EdtUF.Text         := QryPessoa.FieldByName('dsUF').Value;
  EdtCidade.Text     := QryPessoa.FieldByName('nmCidade').Value;
  EdtBairro.Text     := QryPessoa.FieldByName('nmBairro').Value;
  EdtLogradouro.Text := QryPessoa.FieldByName('nmLogradouro').Value;
  EdtComplemento.Text:= QryPessoa.FieldByName('dsComplemento').Value;

  CarregaClassePessoa;

end;

procedure TForm2.ZebrarDbGrid(dSouce: TDataSource; grid: TDBGrid;
  State: TGridDrawState; Rect: TRect; Column: TColumn);
begin
  if not odd(dSouce.DataSet.RecNo) then
    if not(gdselected in State) then
    begin
      grid.canvas.Brush.Color := $00FFEFDF;
      grid.canvas.FillRect(Rect);
    end;
  if (gdselected in State) then
  begin
    grid.canvas.Font.Color := clred;
    grid.canvas.Brush.Color := clYellow; // $00FFEFDF;
  end;
  grid.DefaultDrawDataCell(Rect, Column.Field, State);
  grid.Color := clWindow;
end;

procedure TForm2.Alterar;
begin
  Desligabotoes;
  LigaCampos;
  try
    FUpdate := TUpdate.Create;
    FPessoa.idpessoa := QryPessoa.FieldValues['idpessoa'];
    FPessoa.idEndereco := QryPessoa.FieldValues['idendereco'];
    FUpdate.Alterar(FPessoa);
    QryPessoa.Refresh;
  finally
    FUpdate.Free;

  end;
end;

procedure TForm2.CarregaClassePessoa;
begin

  FPessoa.idpessoa    := StrToInt64(QryPessoa.FieldByName('idpessoa').Value);
  FPessoa.flnatureza  := StrToInt(QryPessoa.FieldByName('flNatureza').Value);
  FPessoa.dsdocumento := QryPessoa.FieldByName('dsDocumento').Value;
  FPessoa.nmprimeiro  := QryPessoa.FieldByName('nmprimeiro').Value;
  FPessoa.nmsegundo   := QryPessoa.FieldByName('nmsegundo').Value;
  FPessoa.UF          := QryPessoa.FieldByName('dsuf').Value;
  FPessoa.Cidade      := QryPessoa.FieldByName('nmCidade').Value;
  FPessoa.Bairro      := QryPessoa.FieldByName('nmBairro').Value;
  FPessoa.Logradouro  := QryPessoa.FieldByName('nmLogradouro').Value;
  FPessoa.Complemento := QryPessoa.FieldByName('dsComplemento').Value;
  FPessoa.dtregistro  := StrToDate(QryPessoa.FieldByName('dtregistro').Value);
  FPessoa.idEndereco  := QryPessoa.FieldByName('idendereco').Value;
  FPessoa.CEP         := QryPessoa.FieldByName('dsCEP').Value;
end;

procedure TForm2.LimpaCampos;
var
  i: integer;
begin
   For i := 0 to ComponentCount -1 do
   begin
     if Components[i] is TEdit then
      begin
       TEdit(Components[i]).Clear;
      end;
   end;
end;

end.
