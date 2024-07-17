unit square;

interface

uses crt;

function computeBgColor(number: integer): integer;
procedure drawSquare(x: integer; y: integer; number: integer);
implementation

function computeBgColor(number: integer): integer;
begin
      var color: integer;
      
  case number of
            2: color := LightBlue;
            4: color := LightCyan;
            8: color := LightRed;
            16: color := LightGreen;
      end;
      
      result := color;
end;

procedure drawSquare(x: integer; y: integer; number: integer);
begin
      var color := computeBgColor(number);
      var strNumber: string;
      
      strNumber := intToStr(number);
      gotoXY(x, y);
      for var i := 0 to 5 do
      begin
            for var j := 0 to 5 do
            begin
                  if (j >= 1) and (j <= length(strNumber)) and (i = 1) then
                  begin
                        textColor(white);
                        textBackground(color);
                        write(strNumber[j]);
                  end else begin
                        textColor(color);
                        textBackground(color);
                        write('@');
                  end;
            end;
            gotoXY(x, whereY + 1);
      end;
end;
end.