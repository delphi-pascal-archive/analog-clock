unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, Mask;

type
  TForm2 = class(TForm)
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    MaskEdit1: TMaskEdit;
    Label3: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  exec, onned : Boolean;
  TmrName : String;
  Time   : TDateTime;

implementation

{$R *.dfm}

procedure TForm2.Button2Click(Sender: TObject);
begin
  Close;
  exec := false;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  exec := true;
  onned := SpeedButton1.Down;
end;

end.
