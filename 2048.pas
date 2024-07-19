uses fieldModule, crt;

begin
      var initialX, initialY, size, gameWidth, gameHeight, squareWidth, outerOffset, betweenOffer: integer;
      
      size := 4; // >3 bug
      outerOffset := 2;
      betweenOffer := 1;
      squareWidth := 6;
      gameWidth := outerOffset * 2 + squareWidth * size + betweenOffer * (size - 1);
      gameHeight := gameWidth;
      setWindowSize(gameWidth, gameHeight);
      hideCursor();
      
      initialX := 3;
      initialY := 3;
      
      var field := new Field(initialX, initialY, size);
      field.drawField();
      
      while true do
      begin
            field.handlersArrows();
            
            if field.IsRerender then
                  field.drawField();
      end;
      
      textColor(black);
      textBackground(black);
      readln;
end.