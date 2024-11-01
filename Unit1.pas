unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Label4: TLabel;
    Label5: TLabel;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);

var
  usuario: string;
  senha: string;
  query: string;
  encontrado: Boolean;

begin
  usuario := Edit1.Text;
  senha := Edit2.Text;

  if (usuario = '') or (senha = '') then
  begin
    ShowMessage('Por favor, preencha usu�rio e senha.');
  end;

  //query := 'SELECT COUNT(*) FROM users WHERE users.user = ''' + usuario + ''' AND users.password = ''' + senha + '''';
  query := 'SELECT COUNT(*) FROM users WHERE users.user = :usuario AND users.password = :senha';

  try
    FDConnection1.Connected := True; // Conecta ao banco de dados

    FDQuery1.SQL.Text := query;
    FDQuery1.ParamByName('usuario').AsString := usuario;
    FDQuery1.ParamByName('senha').AsString := senha;

    FDQuery1.Open;

    encontrado := FDQuery1.Fields[0].AsInteger > 0;

    if encontrado then
      ShowMessage('Usu�rio e senha v�lidos!')
    else
      ShowMessage('Usu�rio ou senha inv�lidos.');

  except
    on E: Exception do
      ShowMessage('Erro ao acessar o banco de dados: ' + E.Message);
  end;

  FDConnection1.Connected := False;
end;

end.

