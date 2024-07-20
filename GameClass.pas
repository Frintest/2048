unit GameClass;

interface

uses FieldClass, crt;

type
      Game = class
      private
            initialX, initialY, width, height, squaresCount, fieldOffset, squareSize, betweenOffset, errorCode, isWinner: integer;
            field: FieldClass.Field;
            
            function computeFieldSize: System.Tuple<integer, integer>;
            procedure render;
      public
            constructor Create(_initialX, _initialY, _squaresCount, _fieldOffset, _squareSize, _betweenOffser: integer);
            begin
                  self.initialX := _initialX;
                  self.initialY := _initialY;
                  self.squaresCount := _squaresCount;
                  self.fieldOffset := _fieldOffset;
                  self.squareSize := _squareSize;
                  self.betweenOffset := _betweenOffser;
                  self.errorCode := -1;
                  self.field := new FieldClass.Field(_initialX, _initialY, _squaresCount);
            end;
            
            procedure init;
      end;

implementation

function Game.computeFieldSize: System.Tuple<integer, integer>;
begin
      var size: (integer, integer);
      var width, height: integer;
      
      width := self.fieldOffset * 2 + self.squareSize *  self.squaresCount + self.betweenOffset * (self.squaresCount - 1);
      height := width;
      size := (width, height);
      
      result := size;
end;

procedure Game.init;
begin
      var size := self.computeFieldSize();
      var width, height: integer;
      
      (width, height) := size;
      self.width := width;
      self.height := height;
      
      setWindowSize(self.width, self.height);
      hideCursor();
      
      self.field.drawField();
      
      while true do
            self.render();
      
      textColor(black);
      textBackground(black);
      readln;
end;

procedure Game.render;
begin
      self.field.handlersArrows();
      
      if self.field.IsRerender then
            self.field.drawField();
end;
end.