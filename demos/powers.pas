program Power;
var base, exp, result, i: integer;
begin
  base := 2;
  exp := 1;
  while exp <= 12 do
  begin
    result := 1;
    i := 0;
    while i < exp do
    begin
      result := result * base;
      i := i + 1
    end;
    writeln(result);
    exp := exp + 1
  end
end.
