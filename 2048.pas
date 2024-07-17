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

begin
      var a: array [0..15] of integer;
      var initialX: integer;
      var initialY: integer;
      
      setWindowSize(31, 32);
      hideCursor();
      
      initialX := 3;
      initialY := 3;
      drawField(initialX, initialY);
      
      textColor(black);
      textBackground(black);
end.