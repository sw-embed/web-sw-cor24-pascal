program StdLib;
var x: integer;
begin
  x := 0 - 5;
  writeln(Abs(x));
  writeln(Sqr(3));
  writeln(Succ(9));
  writeln(Pred(10));
  if Odd(7) then
    writeln('7 is odd');
  if not Odd(4) then
    writeln('4 is even')
end.
