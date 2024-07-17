unit fieldModule;

interface

uses squareModule, crt;

type
      Field = class
      private
            initialX, initialY: integer;
            squares: array [0..15] of integer;
            squaresFillReady: array of integer;
            function computeNextSquareIndex(squaresFillReady: array of integer): integer;
      public
            constructor Create(_initialX, _initialY: integer);
            begin
                  initialX := _initialX;
                  initialY := _initialY;
            end;
            
            procedure drawField;
      end;

implementation

function Field.computeNextSquareIndex(squaresFillReady: array of integer): integer;
begin
      var index: integer;
      
      while true do
      begin
            index := random(0, 15);
            if index not in squaresFillReady then
                  break;
      end;
      
      result := index;
end;

procedure Field.drawField;
begin
      var x, y: integer;
      
      x := self.initialX;
      y := self.initialY;
      
      for var i := 0 to 3 do
      begin
            for var j := 0 to 3 do
            begin
                  var square := new Square(x, y, 8);
                  square.drawSquare();
                  x := x + 7;
            end;
            x := self.initialX;
            y := y + 7;
      end;
end;
end.