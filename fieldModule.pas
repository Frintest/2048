unit fieldModule;

interface

uses squareModule, crt;

type
      Field = class
      private
            initialX, initialY: integer;
            squares: array [0..15] of integer;
            //            squaresFillReady: array of integer;
            function computeNextSquareIndex: integer;
      public
            constructor Create(_initialX, _initialY: integer);
            begin
                  initialX := _initialX;
                  initialY := _initialY;
            end;
            
            procedure drawField;
      end;

implementation

function Field.computeNextSquareIndex: integer;
begin
      var index: integer;
      index := random(0, 15);
      //      while true do
      //      begin
      //            index := random(0, 15);
      //                        if index not in self.squaresFillReady then
      //                              break;
      //      end;
      
      result := index;
end;

procedure Field.drawField;
begin
      var x, y: integer;
      var computeSquareIndex := self.computeNextSquareIndex();
      var currentSquareIndex:integer;
      
      self.squares[computeSquareIndex] := 2;
      
      //      var offsetPointX, offsetPointY: integer;
      
      //      case squareIndex of
      //            0..2: offsetPointX := 0;
      //            3..5: offsetPointX := 1;
      //            6..8: offsetPointX := 2;
      //      end;
      //      
      //      case squareIndex of
      //            0, 3, 6: offsetPointY := 0;
      //            1, 4, 7: offsetPointY := 1;
      //            2, 5, 8: offsetPointY := 2;
      //      end;
      
      x := self.initialX;
      y := self.initialY;
      
      for var i := 0 to 3 do
      begin
            for var j := 0 to 3 do
            begin
                  var square := new Square(x, y, self.squares[currentSquareIndex]);
                  square.drawSquare();
                  x := x + 7;
                  currentSquareIndex := currentSquareIndex + 1;
            end;
            x := self.initialX;
            y := y + 7;
      end;
end;
end.