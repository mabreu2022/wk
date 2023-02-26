unit DAO.Lote;

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
  Vcl.Dialogs,
  FireDAC.Comp.Client,
  DAO.Conexao;

type
  TLote = class
    private

    public
       Procedure InserirEmLote;
  end;


implementation


{ TLote }

procedure TLote.InserirEmLote;
var
  lStringListFile, lStringListFile2, lStringListFile3: TStringList;
  lStringListLine, lStringListLine2, lStringListLine3: TStringList;
  lCounter,lCounter2,lCounter3: integer;
  lStart, lEnd: TDateTime;
  FDMTPessoa: TFDQuery;
  FDIntermediaria: TFDQuery;
  FDEndereco: TFDQuery;
  Conexao: TConnection;


  idpessoa: Integer;
  idEndereco: Int64;
begin
  {$REGION 'Mockeados'}

  lStart := Now;

  FDMTPessoa                 := TFDQuery.Create(nil);
  FDIntermediaria            := TFDQuery.Create(nil);
  FDEndereco                 := TFDQuery.Create(nil);
  Conexao                    := TConnection.Create;
  FDMTPessoa.Connection      :=  Conexao.CreateConnection;

  FDIntermediaria.Connection :=  Conexao.CreateConnection;
  FDEndereco.Connection      :=  Conexao.CreateConnection;

  FDMTPessoa.SQL.Clear;
  FDMTPessoa.SQL.Add('INSERT INTO PESSOA(IDPESSOA, FLNATUREZA, DSDOCUMENTO, NMPRIMEIRO, NMSEGUNDO, DTREGISTRO)');
  FDMTPessoa.SQL.Add('VALUES (:IDPESSOA, :FLNATUREZA, :DSDOCUMENTO, :NMPRIMEIRO, :NMSEGUNDO, :DTREGISTRO )');


  FDIntermediaria.SQL.Clear;
  FDIntermediaria.SQL.Add('INSERT INTO ENDERECO(IDENDERECO, IDPESSOA, DSCEP)');
  FDIntermediaria.SQL.Add('VALUES (:IDENDERECO, :IDPESSOA, :DSCEP)');


  FDEndereco.SQL.Clear;
  FDEndereco.SQL.Add('INSERT INTO ENDERECO_INTEGRACAO(IDENDERECO, DSUF, NMCIDADE, NMBAIRRO, NMLOGRADOURO, DSCOMPLEMENTO)');
  FDEndereco.SQL.Add('VALUES (:IDENDERECO, :DSUF, :NMCIDADE, :NMBAIRRO, :NMLOGRADOURO, :DSCOMPLEMENTO)');

  lStringListFile  := TStringList.Create;
  lStringListLine  := TStringList.Create;
  lStringListFile2 := TStringList.Create;
  lStringListLine2 := TStringList.Create;
  lStringListFile3 := TStringList.Create;
  lStringListLine3 := TStringList.Create;

  try

    lStringListFile.LoadFromFile('MOCK.csv');
    lStringListFile2.LoadFromFile('MOCK2.csv');
    lStringListFile3.LoadFromFile('MOCK3.csv');

    FDMTPessoa.Params.ArraySize      := lStringListFile.Count;
    FDIntermediaria.Params.ArraySize := lStringListFile2.Count;
    FDEndereco.Params.ArraySize      := lStringListFile3.Count;

    for lCounter := 0 to Pred(lStringListFile.Count) do
    begin
      lStringListLine.StrictDelimiter := True;

      lStringListLine.CommaText  := lStringListFile[lCounter];

      FDMTPessoa.ParamByName('IDPESSOA').AsLargeInts[lCounter]   := StrToInt64(lStringListLine[0]);
      FDMTPessoa.ParamByName('FLNATUREZA').AsSmallInts[lCounter] := StrToInt(lStringListLine[1]);
      FDMTPessoa.ParamByName('DSDOCUMENTO').AsStrings[lCounter]  := lStringListLine[2];
      FDMTPessoa.ParamByName('NMPRIMEIRO').AsStrings[lCounter]   := lStringListLine[3];
      FDMTPessoa.ParamByName('NMSEGUNDO').AsStrings[lCounter]    := lStringListLine[4];
      FDMTPessoa.ParamByName('DTREGISTRO').AsDates[lCounter]     := StrToDate(lStringListLine[5]);

    end;
    FDMTPessoa.Execute(lStringListFile.Count, 0);

    for lCounter2 := 0 to Pred(lStringListFile2.Count) do
    begin

      lStringListLine2.StrictDelimiter := True;

      lStringListLine2.CommaText := lStringListFile2[lCounter2];

      FDIntermediaria.ParamByName('IDENDERECO').AsLargeInts[lCounter2] := StrToInt64(lStringListLine2[0]);
      FDIntermediaria.ParamByName('IDPESSOA').AsSmallInts[lCounter2]   := StrToInt(lStringListLine2[1]);
      FDIntermediaria.ParamByName('DSCEP').AsStrings[lCounter2]        := lStringListLine2[2];

    end;
    FDIntermediaria.Execute(lStringListFile2.Count, 0);

    for lCounter3 := 0 to Pred(lStringListFile3.Count) do
    begin
      lStringListLine3.StrictDelimiter := True;

      lStringListLine3.CommaText := lStringListFile3[lCounter3];

      FDEndereco.ParamByName('IDENDERECO').AsLargeInts[lCounter3]   := StrToInt64(lStringListLine3[0]);
      FDEndereco.ParamByName('DSUF').AsStrings[lCounter3]           := lStringListLine3[1];
      FDEndereco.ParamByName('NMCIDADE').AsStrings[lCounter3]       := lStringListLine3[2];
      FDEndereco.ParamByName('NMBAIRRO').AsStrings[lCounter3]       := lStringListLine3[3];
      FDEndereco.ParamByName('NMLOGRADOURO').AsStrings[lCounter3]   := lStringListLine3[4];
      FDEndereco.ParamByName('DSCOMPLEMENTO').AsStrings[lCounter3]  := lStringListLine3[5];

    end;
    FDEndereco.Execute(lStringListFile3.Count, 0);


  finally
    lStringListLine.Free;
    lStringListFile.Free;
    lStringListLine2.Free;
    lStringListFile2.Free;
    lStringListLine3.Free;
    lStringListFile3.Free;

  end;

  lEnd := Now;

  ShowMessage('Time elapsed: ' + FormatDateTime('hh:nn:ss:zzz', lEnd - lStart));

end;

 {$ENDREGION}

end.
