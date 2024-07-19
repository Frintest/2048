uses fieldModule, crt;

begin
      var initialX, initialY: integer;
      
      setWindowSize(31, 32);
      hideCursor();
      
      initialX := 3;
      initialY := 3;
      var field := new Field(initialX, initialY);
      field.drawField();
      
      while true do
      begin
            field.handlersArrows();
            
            if field.IsRerender then
            begin
                  field.drawField();
            end;
      end;
      
      textColor(black);
      textBackground(black);
      readln;
end.