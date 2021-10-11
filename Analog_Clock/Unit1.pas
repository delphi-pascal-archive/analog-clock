unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Types, StdCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const BackColor = $00F5D3C0;
      ForeColor = clSkyBlue;
      ident     = 20;
var
  Form1: TForm1;
  angle : real = 0;
  sx1, sy1, mx1, my1, hx1, hy1 : integer;
  hour, min, sec, oth : word;

implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var i, x, y, rad : integer;
    a       : real;
begin
  // angle := (pi/180)*360;
  Image1.Canvas.Font.Name:='Arial';
  Image1.Canvas.Brush.Color := BackColor;
  Image1.Canvas.FillRect(Rect(0, 0, Image1.Width, Image1.Height));

  hx1 := Image1.Width div 2;
  hy1 := hx1;
  mx1 := hy1;
  my1 := mx1;
  sx1 := my1;
  sy1 := sx1;
  // Разметка циферблата
  for i := 1 to 12 do begin
    rad := Image1.Width div 2;
    a := pi/180 - (((pi/180)*30)*i);
    x := Round((rad-ident)  * sin(a)) + rad;
    y := Round((rad-ident)  * cos(a)) + rad;
    x := (rad*2) - x;
    y := (rad*2) - y;
    case i of
      12 : begin y := y - 15 end;
      2  : begin x := x + 10 end;
      1  : begin x := x + 15; y := y - 5 end;
      3  : begin x := x + 3 end;
      6  : begin y := y + 3; x := x - 3; end;
      7  : begin y := y + 5 end;
      8  : begin x := x - 7 end;
      9  : begin x := x - 10; y := y - 10 end;
      10 : begin y := y - 10; x := x - 15 end;
      11 : begin y := y - 10; x := x - 15 end;
    end;
    Image1.Canvas.TextOut(x, y, IntToStr(i));
  end;
    Image1.Canvas.Brush.Color := ForeColor;
  Image1.Canvas.Ellipse(ident, ident, Image1.Width - ident, Image1.Height - ident);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var rad, x1, y1: Integer;
    ah, am, asec : real;
begin
  rad := (Image1.Width div 2);
  //Смотрим дату и время
  DecodeTime(Now, hour, min, sec, oth);
  //Определяем углы
  ah := pi/180 - (((pi/180)*30)*hour);
  am := pi/180 - (((pi/180)*6)*min);
  asec := pi/180 - (((pi/180)*6)*sec);
  Label1.Caption := TimeToStr(Now);
  Label2.Caption := IntToStr(60-sec);
    //Часы
    Image1.Canvas.MoveTo(rad, rad);
    Image1.Canvas.Pen.Color := ForeColor;
    Image1.Canvas.Pen.Width := 5;
    Image1.Canvas.LineTo(hx1, hy1);
    Image1.Canvas.Pen.Color := clBlack;
    Image1.Canvas.MoveTo(rad, rad);
    // Радиус умножить на sin(x), округлить и прибавить к координате
    x1 := Round((rad-40-ident)  * sin(ah)) + rad;
    y1 := Round((rad-40-ident)  * cos(ah)) + rad;

    x1 := (rad*2) - x1;
    y1 := (rad*2) - y1;
    Image1.Canvas.LineTo(x1, y1);
    hx1 := x1;
    hy1 := y1;

    //Минуты
    Image1.Canvas.MoveTo(rad, rad);
    Image1.Canvas.Pen.Color := ForeColor;
    Image1.Canvas.Pen.Width := 2;
    Image1.Canvas.LineTo(mx1, my1);
    Image1.Canvas.Pen.Color := clBlack;
    Image1.Canvas.MoveTo(rad, rad);
    // Радиус умножить на sin(x), округлить и прибавить к координате
    x1 := Round((rad-10-ident)  * sin(am)) + rad;
    y1 := Round((rad-10-ident)  * cos(am)) + rad;

    x1 := (rad*2) - x1;
    y1 := (rad*2) - y1;

    mx1 := x1;
    my1 := y1;
        Image1.Canvas.LineTo(x1, y1);
    //Секунды
    Image1.Canvas.MoveTo(rad, rad);
    Image1.Canvas.Pen.Color := ForeColor;
    Image1.Canvas.Pen.Width := 1;
    Image1.Canvas.LineTo(sx1, sy1);
    Image1.Canvas.Pen.Color := clRed;
    Image1.Canvas.MoveTo(rad, rad);
    // Радиус умножить на sin(x), округлить и прибавить к координате
    x1 := Round((rad-2-ident)  * sin(asec)) + rad;
    y1:= Round((rad-2-ident)  * cos(asec)) + rad;

    x1 := (rad*2) - x1;
    y1 := (rad*2) - y1;
    Image1.Canvas.LineTo(x1, y1);
    sx1 := x1;
    sy1 := y1;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  Form2.Show;
end;

end.
