unit onHandleDirectionModule;

interface

function onHandleDirection(squares: array [,] of integer; size: integer): array [,] of integer;
implementation

function onHandleDirection(squares: array [,] of integer; size: integer): array [,] of integer;
begin
      var newSquares := squares;
      
      for var i := 0 to size - 1 do
            for var j := 0 to size - 1 do
                  if (squares[i, j] <> -1) and (i >= 1) then
                        for var m := i downto 1 do
                        begin
                              if squares[i - m, j]  = -1 then
                              begin
                                    newSquares[i - m, j] := squares[i, j];
                                    newSquares[i, j] := -1;
                                    break;
                              end
                              
                              else if squares[i - m, j]  = squares[i, j] then
                              begin
                                    newSquares[i - m, j] := squares[i, j] * 2;
                                    newSquares[i, j] := -1;
                                    break;
                              end;
                        end;
      
      result := newSquares;
end;
end.