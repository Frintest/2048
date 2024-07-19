unit onHandleBottomModule;

interface

function onHandleBottom(squares: array of integer): array of integer;
implementation

function onHandleBottom(squares: array of integer): array of integer;
begin
      var newSquares := squares;
      
      for var i := 0 to 15 do
            if (squares[i] <> -1) and (i >= 4) then
                  for var j := trunc(i / 4) downto 1 do
                  begin
                        var diff: integer;
                        
                        diff := j * 4;
                        
                        if squares[i - diff]  = -1 then
                        begin
                              newSquares[i - diff] := squares[i];
                              newSquares[i] := -1;
                              break;
                        end
                        
                        else if squares[i - diff]  = squares[i] then
                        begin
                              newSquares[i - diff] := squares[i] * 2;
                              newSquares[i] := -1;
                              break;
                        end;
                  end;
      
      result := newSquares;
end;
end.