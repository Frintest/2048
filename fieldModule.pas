unit fieldModule;

interface

uses squareModule, crt, onHandleDirectionModule;

type
      Field = class
      private
            initialX, initialY: integer;
            errorCode: integer := -1;
            size: integer := 4;
            squares: array [,] of integer := new integer[size, size];
            fIsRerender: boolean;
            
            procedure fillSquaresErrorCodes;
            function computeNextSquareIndex: System.Tuple<integer, integer>;
            function computeValueSquare: integer;
            function getIsRerender: boolean;
            procedure setIsRerender(newValue: boolean);
            procedure addSquare(squareIndexes: System.Tuple<integer, integer>; squareValue: integer);
            function rotateSquaresToLeft(squares: array [,] of integer): array [,] of integer;
            function rotateSquaresToRight(squares: array [,] of integer): array [,] of integer;
            function onHandleTop(squares: array [,] of integer): array [,] of integer;
            function onHandleLeft(squares: array  [,] of integer): array [,] of integer;
            function onHandleBottom(squares: array [,] of integer): array [,] of integer;
            function onHandleRight(squares: array [,] of integer): array [,] of integer;
      public
            constructor Create(_initialX, _initialY: integer);
            begin
                  self.initialY := _initialY;
                  self.initialX := _initialX;
                  self.fillSquaresErrorCodes();
            end;
            
            procedure drawField;
            procedure handlersArrows;
            
            property isRerender: boolean read getIsRerender write setIsRerender;
      end;

implementation

procedure Field.fillSquaresErrorCodes;
begin
      for var i := 0 to 3 do
      begin
            for var j := 0 to 3 do
            begin
                  self.squares[i, j] := self.errorCode;
            end;
      end;
end;

function Field.getIsRerender: boolean;
begin
      result := self.fIsRerender;
end;

procedure Field.setIsRerender(newValue: boolean);
begin
      self.fIsRerender := newValue;
end;

function Field.computeValueSquare: integer;
begin
      var luckKprobability: integer;
      var squareValue: integer;
      
      luckKprobability := random(0, 4);
      if luckKprobability <> 3 then
            squareValue := 2
      else
            squareValue := 4;
      
      result := squareValue;
end;

function Field.computeNextSquareIndex: System.Tuple<integer, integer>;
begin
      var indexY, indexX: integer;
      
      while true do
      begin
            indexY := random(0, 3);
            indexX := random(0, 3);
            
            if self.squares[indexY, indexX] = -1 then
                  break;
      end;
      
      var resultIndexes: (integer, integer);
      resultIndexes := (indexY, indexX);
      
      result := resultIndexes;
end;

procedure Field.handlersArrows;
begin
      case readKey of
            #119, #87: 
                  begin
                        self.squares := self.onHandleTop(self.squares);
                        self.fIsRerender := true;
                  end;
            #97, #65:
                  begin
                        self.squares := self.onHandleLeft(self.squares);
                        self.fIsRerender := true;
                  end;
            #115, #83:
                  begin
                        self.squares := self.onHandleBottom(self.squares);
                        self.fIsRerender := true;
                  end;
            #100, #68:
                  begin
                        self.squares := self.onHandleRight(self.squares);
                        self.fIsRerender := true;
                  end;
      end;
end;

function Field.onHandleTop(squares: array [,] of integer): array [,] of integer;
begin
      result := onHandleDirection(squares);
end;

function Field.rotateSquaresToLeft(squares: array [,] of integer): array [,] of integer;
begin
      var rotateSquares:  array [,] of integer := new integer[4, 4];
      
      for var i := 0 to 3 do
            for var j := 0 to 3 do
                  rotateSquares[i, j] := squares[4 - j - 1, i];
            
      result := rotateSquares;
end;

function Field.rotateSquaresToRight(squares: array [,] of integer): array [,] of integer;
begin
      var rotateSquares:  array [,] of integer := new integer[4, 4];
      
      for var i := 0 to 3 do
            for var j := 0 to 3 do
                  rotateSquares[i, j] := squares[j, 4 - i - 1];
            
      result := rotateSquares;
end;

function Field.onHandleLeft(squares: array [,] of integer): array [,] of integer;
begin
      var rotateLeftSquares := self.rotateSquaresToLeft(squares);
      var newSquares := onHandleDirection(rotateLeftSquares);
      var rotateRightSquares := self.rotateSquaresToRight(newSquares);
            
      result := rotateRightSquares;
end;

function Field.onHandleBottom(squares: array [,] of integer): array [,] of integer;
begin
      result := onHandleDirection(squares);
end;

function Field.onHandleRight(squares: array [,] of integer): array [,] of integer;
begin
      result := onHandleDirection(squares);
end;

procedure Field.addSquare(squareIndexes: System.Tuple<integer, integer>; squareValue: integer);
begin
      var indexY, indexX: integer;
      (indexY, indexX) := squareIndexes;
      self.squares[indexY, indexX] := squareValue;
end;

procedure Field.drawField;
begin
      var y, x: integer;
      var squareIndexes := self.computeNextSquareIndex();
      var squareValue := self.computeValueSquare();
      
      y := self.initialY;
      x := self.initialX;
      self.addSquare(squareIndexes, squareValue);
      
      for var i := 0 to 3 do
      begin
            for var j := 0 to 3 do
            begin
                  var square := new Square(x, y, self.squares[i, j]);
                  square.drawSquare();
                  x := x + 7;
            end;
            x := self.initialX;
            y := y + 7;
      end;
      
      self.fIsRerender := false;
end;
end.