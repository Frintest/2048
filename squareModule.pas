unit squareModule;

interface

uses crt;

type
      Square = class
      private
            x, y, number: integer;
            function computeBgColor: integer;
      public
            constructor Create(_x, _y: integer; _number: integer := -1);
            begin
                  x := _x;
                  y := _y;
                  number := _number;
            end;
            
            procedure drawSquare;
      end;

implementation

function Square.computeBgColor: integer;
begin
      var color: integer;
      
      case self.number of
            -1: color := LightGray;
            2: color := LightBlue;
            4: color := LightCyan;
            8: color := LightRed;
            16: color := LightGreen;
      end;
      
      result := color;
end;

procedure Square.drawSquare;
begin
      var color := computeBgColor();
      var strNumber: string;
      
      strNumber := intToStr(self.number);
      gotoXY(self.x, self.y);
      for var i := 0 to 5 do
      begin
            for var j := 0 to 5 do
            begin
                  if (j >= 1) and (j <= length(strNumber)) and (i = 1) and (self.number <> -1) then
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
            gotoXY(self.x, whereY + 1);
      end;
end;
end.