uses GameClass;

begin
      var initialX, initialY, squaresCount, fieldOffset, squareSize, betweenOffset: integer;
      
      initialX := 3;
      initialY := 3;
      squaresCount := 4;
      fieldOffset := 2;
      squareSize := 6;
      betweenOffset := 1;
      
      var game := new Game(initialX, initialY, squaresCount, fieldOffset, squareSize, betweenOffset);
      game.init();
end.