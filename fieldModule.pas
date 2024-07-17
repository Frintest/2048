unit fieldModule;

interface

uses squareModule, crt;

type
      Field = class
      private
            initialX, initialY: integer;
            squares: array [0..15] of integer;
            w, a, s, d: boolean;
            function computeNextSquareIndex: integer;
      public
            constructor Create(_initialX, _initialY: integer);
            begin
                  initialX := _initialX;
                  initialY := _initialY;
            end;
            
            procedure drawField;
            procedure handlersArrows;
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

procedure Field.handlersArrows;
begin
      case readKey of
            #119, #87: write('1w');
            #115, #83: write('1s');
            #97, #65: write('1a');
            #100, #68: write('1d');
      end;
end;

procedure Field.drawField;
begin
      var x, y: integer;
      var computeSquareIndex := self.computeNextSquareIndex();
      var currentSquareIndex: integer;
      
      self.squares[computeSquareIndex] := 2;
      
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