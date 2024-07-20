unit dataFromField;

interface

uses FieldClass;

function requestTotalCount(field: Field): integer;

implementation

function requestTotalCount(field: Field): integer;
begin
      result := field.computeTotalCount();
end;
end.