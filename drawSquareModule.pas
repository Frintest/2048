unit drawSquareModule;

uses crt;

procedure drawSquare(x: integer; y: integer);
begin
      var color := darkGray;
      
      gotoXY(x, y);
      for var i := 0 to 5 do
      begin
            for var j := 0 to 5 do
            begin
                  textColor(color);
                  textBackground(color);
                  write('@');
            end;
            gotoXY(x, whereY + 1);
      end;
end;
end.