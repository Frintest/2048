uses GameClass;

begin
      var squaresCount, squareSize, totalCountHeight, gameOffset, fieldTopOffset, betweenOffset: integer;
      
      squaresCount := 4;
      squareSize := 6;
      totalCountHeight := 1;
      gameOffset := 2;
      fieldTopOffset := 2;
      betweenOffset := 1;
      
      var game := new Game(squaresCount, squareSize, totalCountHeight, gameOffset, fieldTopOffset, betweenOffset);
      game.init();
end.