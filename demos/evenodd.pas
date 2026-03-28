program EvenOdd;
var i: integer;
begin
  i := 1;
  while i <= 10 do
  begin
    if i mod 2 = 0 then
      writeln(i)
    else
      writeln(0 - i);
    i := i + 1
  end
end.
