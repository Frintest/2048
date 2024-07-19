unit fieldModule;

interface

uses squareModule, crt;

type
      Field = class
      private
            initialX, initialY: integer;
            squares: array [0..15] of integer;
            w, a, s, d, fIsRerender: boolean;
            
            function computeNextSquareIndex: integer;
            function computeValueSquare: integer;
            function getIsRerender: boolean;
            procedure setIsRerender(newValue: boolean);
            procedure addSquare(squareValue, index: integer);
            procedure onHandleTop;
      public
            constructor Create(_initialX, _initialY: integer);
            begin
                  self.initialX := _initialX;
                  self.initialY := _initialY;
                  
                  for var i := 0 to 15 do
                        self.squares[i] := -1;
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
      self.w := false;
      self.a := false;
      self.s := false;
      self.d := false;
      
      case readKey of
            #119, #87: 
                  begin
                        self.w := true;
                        self.onHandleTop();
                        self.fIsRerender := true;
                  end;
            #97, #65:
                  begin
                        self.a := true;
                        self.fIsRerender := true;
                  end;
            #115, #83:
                  begin
                        self.s := true;
                        self.fIsRerender := true;
                  end;
            #100, #68:
                  begin
                        self.d := true;
                        self.fIsRerender := true;
                  end;
      end;
end;

procedure Field.onHandleTop;
begin
      var newSquares: array [0..15] of integer;
      
      for var i := 0 to 15 do
            newSquares[i] := self.squares[i];
      
      for var i := 0 to 15 do
      begin
            //        0123
            //        4567
            //        89 10 11
            //        12 13 14 15
            if (self.squares[i] <> -1) and (i >= 4) then
            begin
                  case i of
                        4..7:
                              begin
                                    if self.squares[i - 4]  = -1 then
                                    begin
                                          newSquares[i - 4] := self.squares[i];
                                          newSquares[i] := -1;
                                    end
                                    
                                    else if self.squares[i - 4]  = self.squares[i] then
                                    begin
                                          newSquares[i - 4] := self.squares[i] * 2;
                                          newSquares[i] := -1;
                                    end;
                              end;
                        8..11:
                              begin
                                    if self.squares[i - 8]  = -1 then
                                    begin
                                          newSquares[i - 8] := self.squares[i];
                                          newSquares[i] := -1;
                                    end
                                    
                                    else if self.squares[i - 8] = self.squares[i] then
                                    begin
                                          newSquares[i - 8] := self.squares[i] * 2;
                                          newSquares[i] := -1;
                                    end
                                    
                                    else if self.squares[i - 4]  = -1 then
                                    begin
                                          newSquares[i - 4] := self.squares[i];
                                          newSquares[i] := -1;
                                    end
                                    
                                    else if self.squares[i - 4] = self.squares[i] then
                                    begin
                                          newSquares[i - 4] := self.squares[i] * 2;
                                          newSquares[i] := -1;
                                    end;
                              end;
                        12..15:
                              begin
                                    if self.squares[i - 12]  = -1 then
                                    begin
                                          newSquares[i - 12] := self.squares[i];
                                          newSquares[i] := -1;
                                    end
                                    
                                    else if self.squares[i - 8]  = -1 then
                                    begin
                                          newSquares[i - 8] := self.squares[i];
                                          newSquares[i] := -1;
                                    end
                                    
                                    else if self.squares[i - 4]  = -1 then
                                    begin
                                          newSquares[i - 4] := self.squares[i];
                                          newSquares[i] := -1;
                                    end;
                              end;
                  end;
            end;
      end;
      
      for var i := 0 to 15 do
            self.squares[i] := newSquares[i];
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