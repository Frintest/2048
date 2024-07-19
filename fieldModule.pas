unit fieldModule;

interface

uses squareModule, crt, onHandleDirectionModule;

type
      Field = class
      private
            initialX, initialY: integer;
            errorCode: integer := -1;
            squares: array of integer := arrFill(16, errorCode);
            fIsRerender: boolean;
            
            function computeNextSquareIndex: integer;
            function computeValueSquare: integer;
            function getIsRerender: boolean;
            procedure setIsRerender(newValue: boolean);
            procedure addSquare(squareValue, index: integer);
            function onHandleTop(squares: array of integer): array of integer;
      //            function onHandleLeft(squares: array of integer): array of integer;
                  function onHandleBottom(squares: array of integer): array of integer;
      //            function onHandleRight(squares: array of integer): array of integer;
      public
            constructor Create(_initialX, _initialY: integer);
            begin
                  self.initialX := _initialX;
                  self.initialY := _initialY;
            end;
            
            procedure drawField;
            procedure handlersArrows;
            
            property isRerender: boolean read getIsRerender write setIsRerender;
      end;

implementation

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

function Field.computeNextSquareIndex: integer;
begin
      var index: integer;
      
      while true do
      begin
            index := random(0, 15);
            
            if self.squares[index] = -1 then
                  break;
      end;
      
      result := index;
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
                        //                        self.onHandleLeft();
                        self.fIsRerender := true;
                  end;
            #115, #83:
                  begin
                        self.squares := self.onHandleBottom(self.squares);
                        self.fIsRerender := true;
                  end;
            #100, #68:
                  begin
                        //                        self.onHandleRight();
                        self.fIsRerender := true;
                  end;
      end;
end;

            //        0123
            //        4567
            //        89 10 11
            //        12 13 14 15

            //     4 / 4 = 1
            //     8 / 4 = 2
            //     12 / 4 = 3

function Field.onHandleTop(squares: array of integer): array of integer;
begin
      result := onHandleDirection(squares);
end;

function Field.onHandleBottom(squares: array of integer): array of integer;
begin
      result := onHandleDirection(squares);
end;

procedure Field.addSquare(squareValue, index: integer);
begin
      self.squares[index] := squareValue;
end;

procedure Field.drawField;
begin
      var x, y: integer;
      var computeSquareIndex := self.computeNextSquareIndex();
      var currentSquareIndex: integer;
      var squareValue := self.computeValueSquare();
      
      x := self.initialX;
      y := self.initialY;
      self.addSquare(squareValue, computeSquareIndex);
      
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
      
      self.fIsRerender := false;
end;
end.