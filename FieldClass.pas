unit FieldClass;

interface

uses SquareClass, crt, onHandleDirectionModule;

type
      Field = class
      private
            initialX, initialY, size, squareSize, errorCode: integer;
            squares: array [,] of integer;
            fIsRerender: boolean;
            
            procedure fillSquaresErrorCodes;
            function computeNextSquareIndex: System.Tuple<integer, integer>;
            function computeValueSquare: integer;
            function getIsRerender: boolean;
            procedure setIsRerender(newValue: boolean);
            procedure addSquare(squareIndexes: System.Tuple<integer, integer>; squareValue: integer);
            function rotateSquaresToLeft(squares: array [,] of integer): array [,] of integer;
            function rotateSquaresToRight(squares: array [,] of integer): array [,] of integer;
            function rotateSquaresToOpposite(squares: array [,] of integer): array [,] of integer;
            function onHandleTop(squares: array [,] of integer): array [,] of integer;
            function onHandleLeft(squares: array  [,] of integer): array [,] of integer;
            function onHandleBottom(squares: array [,] of integer): array [,] of integer;
            function onHandleRight(squares: array [,] of integer): array [,] of integer;
      public
            constructor Create(_initialX, _initialY, _size, _squareSize, _errorCode: integer);
            begin
                  self.initialX := _initialX;
                  self.initialY := _initialY;
                  self.size := _size;
                  self.squareSize := _squareSize;
                  self.errorCode := _errorCode;
                  squares := new integer[self.size, self.size];
                  self.fillSquaresErrorCodes();
            end;
            
            procedure drawField;
            procedure handlersArrows;
            function computeTotalCount: integer;
            
            property isRerender: boolean read getIsRerender write setIsRerender;
      end;

implementation

function Field.computeTotalCount: integer;
begin
      var totalCount: integer;
      
      for var i := 0 to self.size - 1 do
            for var j := 0 to self.size - 1 do
                  if self.squares[i, j] <> -1 then
                        totalCount := totalCount + self.squares[i, j];

      result := totalCount;
end;

procedure Field.fillSquaresErrorCodes;
begin
      for var i := 0 to self.size - 1 do
            for var j := 0 to self.size - 1 do
                  self.squares[i, j] := self.errorCode;
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
            indexY := random(0, self.size - 1);
            indexX := random(0, self.size - 1);
            
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
                        self.setIsRerender(true);
                  end;
            #97, #65:
                  begin
                        self.squares := self.onHandleLeft(self.squares);
                        self.setIsRerender(true);
                  end;
            #115, #83:
                  begin
                        self.squares := self.onHandleBottom(self.squares);
                        self.setIsRerender(true);
                  end;
            #100, #68:
                  begin
                        self.squares := self.onHandleRight(self.squares);
                        self.setIsRerender(true);
                  end;
      end;
end;

function Field.rotateSquaresToLeft(squares: array [,] of integer): array [,] of integer;
begin
      var rotateSquares:  array [,] of integer := new integer[self.size, self.size];
      
      for var i := 0 to self.size - 1 do
            for var j := 0 to self.size - 1 do
                  rotateSquares[i, j] := squares[self.size - j - 1, i];
      
      result := rotateSquares;
end;

function Field.rotateSquaresToRight(squares: array [,] of integer): array [,] of integer;
begin
      var rotateSquares:  array [,] of integer := new integer[self.size, self.size];
      
      for var i := 0 to self.size - 1 do
            for var j := 0 to self.size - 1 do
                  rotateSquares[i, j] := squares[j, self.size - i - 1];
      
      result := rotateSquares;
end;

function Field.rotateSquaresToOpposite(squares: array [,] of integer): array [,] of integer;
begin
      var rotateSquares := self.rotateSquaresToLeft(self.rotateSquaresToLeft(squares));
      result := rotateSquares;
end;

function Field.onHandleTop(squares: array [,] of integer): array [,] of integer;
begin
      result := onHandleDirection(squares, self.size);
end;

function Field.onHandleLeft(squares: array [,] of integer): array [,] of integer;
begin
      var rotateLeftSquares := self.rotateSquaresToLeft(squares);
      var newSquares := onHandleDirection(rotateLeftSquares, self.size);
      var rotateRightSquares := self.rotateSquaresToRight(newSquares); 
      
      result := rotateRightSquares;
end;

function Field.onHandleRight(squares: array [,] of integer): array [,] of integer;
begin
      var rotateRightSquares := self.rotateSquaresToRight(squares);
      var newSquares := onHandleDirection(rotateRightSquares, self.size);
      var rotateLeftSquares := self.rotateSquaresToLeft(newSquares);
      
      result := rotateLeftSquares;
end;

function Field.onHandleBottom(squares: array [,] of integer): array [,] of integer;
begin
      var rotateBottomSquares := self.rotateSquaresToOpposite(squares);
      var newSquares := onHandleDirection(rotateBottomSquares, self.size);
      var rotateTopSquares := self.rotateSquaresToOpposite(newSquares);
      
      result := rotateTopSquares;
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
      
      for var i := 0 to self.size - 1 do
      begin
            for var j := 0 to self.size - 1 do
            begin
                  var square := new Square(x, y, self.squareSize, self.squares[i, j], self.errorCode);
                  square.drawSquare();
                  x := x + self.squareSize + 1;
            end;
            x := self.initialX;
            y := y + self.squareSize + 1;
      end;
      
      self.setIsRerender(false);
end;
end.