unit drawFieldModule;

uses drawSquareModule;

procedure drawField(initialX: integer; initialY: integer);
begin
      var x: integer;
      var y: integer;
      
      x := initialX;
      y := initialY;
      
      for var i := 0 to 3 do
      begin
            for var j := 0 to 3 do
            begin
                  drawSquare(x, y);
                  x := x + 7;
            end;
            x := initialX;
            y := y + 7;
      end;
end;
end.