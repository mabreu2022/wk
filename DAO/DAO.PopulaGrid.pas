unit DAO.PopulaGrid;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.PG,
  FireDAC.Phys.PGDef,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  DAO.Conexao,
  Vcl.Dialogs,
  Classe.Pessoas;

type
  TPopularGrid = class
    private
      FConn: TFDConnection;
    public
      function PopulaGrid(aDs: TDatasource): TDataset;
      constructor Create;
     destructor Destroy; override;
  end;

implementation

uses
  View.Cadastros.Pessoas;

{ TPopularGrid }

constructor TPopularGrid.Create;
begin
  FConn:= TConnection.CreateConnection;
end;

destructor TPopularGrid.Destroy;
begin
  if Assigned(FConn) then
    Fconn.Free;
  inherited;
end;

function TPopularGrid.PopulaGrid(aDs: TDatasource): TDataset;
var
  Conexao: TConnection;
  QryPessoa: TFDQuery;

begin
  QryPessoa:= TFDQuery.Create(nil);
  try
    Result := Nil;
    Conexao:= TConnection.Create;
    QryPessoa.Connection:= Conexao.CreateConnection;
    QryPessoa.SQL.Add('Select idpessoa,nmprimeiro from public.pessoa');
    QryPessoa.Open;
    Result := QryPessoa;
  except on ex:exception do
    raise Exception.Create('Erro ao consultar tabela pessoa' + ex.Message);

  end;
end;

end.
