program RepeatTest;
var n: integer;
begin
  n := 5;
  repeat
    writeln(n);
    n := n - 1
  until n = 0;
  writeln('done')
end.
