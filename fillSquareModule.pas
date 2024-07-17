unit fillSquareModule;

interface

uses squareModule;

type
      fillSquare = class(Square)
      private
            function computeBgColor(number: integer): integer;
      end;

implementation

function Square.computeBgColor(number: integer): integer;
begin
      var color: integer;
      
      case number of
            2: color := LightBlue;
            4: color := LightCyan;
            8: color := LightRed;
            16: color := LightGreen;
      end;
      
      result := color;
end;
end.