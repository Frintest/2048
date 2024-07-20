unit GameClass;

interface

uses FieldClass, crt;

type
      Game = class
      private
            initialX, initialY, width, height, squaresCount, squareSize, totalCountHeight,
            gameOffset, fieldTopOffset, betweenOffset, totalCount, errorCode: integer;
            isWinner: boolean;
            field: FieldClass.Field;
            
            function computeFieldInitialCoords: System.Tuple<integer, integer>;
            function computeGameSize: System.Tuple<integer, integer>;
            procedure render;
            procedure drawTotalCount;
      public
            constructor Create(_squaresCount,  _squareSize, _totalCountHeight,
            _gameOffset, _fieldTopOffset, _betweenOffset: integer);
            begin
                  self.squaresCount := _squaresCount;
                  self.squareSize := _squareSize;
                  self.totalCountHeight := _totalCountHeight;
                  self.gameOffset := _gameOffset;
                  self.fieldTopOffset := _fieldTopOffset;
                  self.betweenOffset := _betweenOffset;
                  self.errorCode := -1;
                  
                  var coords := self.computeFieldInitialCoords();
                  var computedX, computedY: integer;
                  (computedX, computedY) := coords;
                  self.initialX := computedX;
                  self.initialY := computedY;
                  self.field := new FieldClass.Field(self.initialX, self.initialY, self.squaresCount, self.squareSize, self.errorCode);
                  
                  self.drawTotalCount();
            end;
            
            procedure init;
      end;

implementation

procedure Game.drawTotalCount;
begin
      gotoXY(self.gameOffset + 1, self.gameOffset + 1);
      write('Счёт: ');
      textColor(white);
      write(self.totalCount);
end;

function Game.computeFieldInitialCoords: System.Tuple<integer, integer>;
begin
      var coords: (integer, integer);
      var initialX, initialY: integer;
      
      initialX := self.gameOffset + 1;
      initialY := self.gameOffset + self.totalCountHeight + self.fieldTopOffset + 1;
      coords := (initialX, initialY);
      
      result := coords;
end;

function Game.computeGameSize: System.Tuple<integer, integer>;
begin
      var size: (integer, integer);
      var width, height: integer;
      
      width := self.gameOffset * 2 + self.squareSize *  self.squaresCount + self.betweenOffset * (self.squaresCount - 1);
      height := width + self.totalCountHeight + self.fieldTopOffset;
      size := (width, height);
      
      result := size;
end;

procedure Game.init;
begin
      var size := self.computeGameSize();
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