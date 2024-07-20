unit SquareClass;

interface

uses crt;

type
      Square = class
      private
            x, y, size, number, errorCode: integer;
            function computeBgColor: integer;
      public
            constructor Create(_x, _y, _size, _number, _errorCode: integer);
            begin
                  self.x := _x;
                  self.y := _y;
                  self.size := _size;
                  self.number := _number;
                  self.errorCode := _errorCode;
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
            32: color := LightMagenta;
      //            64: color:= ;
      //            128: color := ;
      //            256: color := ;
      //            512 : color := ;
      //            1024 :color := ;
      //            2048: color := ;
      end;
      
      result := color;
end;

procedure Square.drawSquare;
begin
      var color := computeBgColor();
      var strNumber: string;
      
      strNumber := intToStr(self.number);
      gotoXY(self.x, self.y);
      for var i := 0 to self.size - 1 do
      begin
            for var j := 0 to self.size - 1 do
            begin
                  if (j >= 1) and (j <= length(strNumber)) and (i = 1) and (self.number <> self.errorCode) then
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