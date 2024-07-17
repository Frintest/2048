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
                  
                  for var i := 0 to 15 do
                        squares[i] := -1;
            end;
            
            procedure drawField;
            procedure handlersArrows;
      end;

implementation

function Field.computeNextSquareIndex: integer;
begin
      var index: integer;
      
      while true do
      begin
            index := random(0, 15);
            if index not in self.squares then
                  break;
      end;
      
      result := index;
end;

procedure Field.handlersArrows;
begin
      case readKey of
            #119, #87: self.w := true;
            #115, #83: self.s := true;
            #97, #65: self.a := true;
            #100, #68: self.d := true;
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