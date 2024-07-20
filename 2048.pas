uses fieldModule, crt;

begin
      var initialX, initialY, fieldSize, gameWidth, gameHeight, squareWidth, outerOffset, betweenOffer: integer;
      
      fieldSize := 4; // [1..12]
      outerOffset := 2;
      betweenOffer := 1;
      squareWidth := 6;
      gameWidth := outerOffset * 2 + squareWidth * fieldSize + betweenOffer * (fieldSize - 1);
      gameHeight := gameWidth;
      setWindowSize(gameWidth, gameHeight);
      hideCursor();
      
      initialX := 3;
      initialY := 3;
      
      var field := new Field(initialX, initialY, fieldSize);
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