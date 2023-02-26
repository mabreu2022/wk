program TesteWK;

uses
  Vcl.Forms,
  UMainForm in 'UMainForm.pas' {Form1},
  Dao.Conexao in 'DAO\Dao.Conexao.pas',
  Dao.Inserir in 'DAO\Dao.Inserir.pas',
  DAO.Update in 'DAO\DAO.Update.pas',
  DAO.Delete in 'DAO\DAO.Delete.pas',
  DAO.Lote in 'DAO\DAO.Lote.pas',
  View.Cadastros.Pessoas in 'View\View.Cadastros.Pessoas.pas' {Form2},
  Model.Pessoas in 'Model\Model.Pessoas.pas',
  Classe.Pessoas in 'Pessoa\Classe.Pessoas.pas',
  Vcl.Themes,
  Vcl.Styles,
  DAO.PopulaGrid in 'DAO\DAO.PopulaGrid.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Silver');
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
