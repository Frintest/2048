unit squareModule;

interface

uses crt;

type
      Square = class
      private
            x: integer;
            y: integer;
            number: integer;
            function computeBgColor(number: integer): integer;
      public
            constructor Create(_x: integer; _y: integer; _number: integer);
            begin
                  x := _x;
                  y := _y;
                  number := _number;
            end;
            
            procedure drawSquare;
      end;

implementation

function Square.computeBgColor(number: integer): integer;
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

procedure Square.drawSquare;
begin
      var color := computeBgColor(self.number);
      var strNumber: string;
      
      strNumber := intToStr(self.number);
      gotoXY(self.x, self.y);
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
            gotoXY(self.x, whereY + 1);
      end;
end;
end.