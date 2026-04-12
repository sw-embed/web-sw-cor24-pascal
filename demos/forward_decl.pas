program TestForward;

function double(n: integer): integer; forward;

function quadruple(n: integer): integer;
begin
  quadruple := double(double(n))
end;

function double(n: integer): integer;
begin
  double := n * 2
end;

function is_even(n: integer): boolean; forward;

function is_odd(n: integer): boolean;
begin
  if n = 0 then
    is_odd := false
  else
    is_odd := is_even(n - 1)
end;

function is_even(n: integer): boolean;
begin
  if n = 0 then
    is_even := true
  else
    is_even := is_odd(n - 1)
end;

begin
  writeln(quadruple(5));
  if is_even(4) then writeln(1) else writeln(0);
  if is_odd(3) then writeln(1) else writeln(0);
  if is_even(3) then writeln(1) else writeln(0)
end.
