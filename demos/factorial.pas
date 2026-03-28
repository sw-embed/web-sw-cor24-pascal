program Factorial;
var n, s, i: integer;
begin
  n := 10;
  i := 1;
  s := 1;
  while i <= n do
  begin
    s := s * i;
    i := i + 1
  end;
  writeln('10! = ');
  writeln(s)
end.
