program TestNested;
var result: integer;

procedure outer;
var x: integer;

  procedure inner;
  begin
    x := 42
  end;

  procedure set_x(n: integer);
  begin
    x := n
  end;

  function get_x: integer;
  begin
    get_x := x
  end;

begin
  x := 0;
  inner;
  writeln(get_x);
  set_x(99);
  writeln(get_x);
  result := x
end;

procedure deep;
var a: integer;

  procedure mid;
  var b: integer;

    procedure bot;
    begin
      b := a + 10
    end;

  begin
    b := 0;
    bot;
    a := b
  end;

begin
  a := 5;
  mid;
  result := a
end;

begin
  outer;
  writeln(result);
  deep;
  writeln(result)
end.
