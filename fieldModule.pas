unit fieldModule;

interface

uses squareModule;
uses crt;

var
      squaresFillReady: array of integer;

procedure drawField(initialX: integer; initialY: integer);
function computeNextSquareIndex(squaresFillReady: array of integer): integer;
implementation

function computeNextSquareIndex(squaresFillReady: array of integer): integer;
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

procedure drawField(initialX: integer; initialY: integer);
begin
      var x: integer;
      var y: integer;
      
      x := initialX;
      y := initialY;
      
      for var i := 0 to 3 do
      begin
            for var j := 0 to 3 do
            begin
                  var square := new Square(x, y, 8);
                  square.drawSquare();
                  x := x + 7;
            end;
            x := initialX;
            y := y + 7;
      end;
end;
end.