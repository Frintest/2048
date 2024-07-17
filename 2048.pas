uses crt;
uses field;

begin
      var numbers: array [0..15] of integer;
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