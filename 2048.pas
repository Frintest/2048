uses fieldModule, crt;

begin
      var initialX, initialY: integer;
      
      setWindowSize(31, 32);
      hideCursor();
      
      initialX := 3;
      initialY := 3;
      var field := new Field(initialX, initialY);
      field.drawField();
      
      textColor(black);
      textBackground(black);
end.