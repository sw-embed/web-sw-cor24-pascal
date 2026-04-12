program PointerTest;
{ Test: pointer types, new, dispose, nil, dereference }
type
  PNode = ^Node;
  Node = record
    value: integer;
    next: PNode
  end;
var
  head, p, tmp: PNode;
  i: integer;
begin
  head := nil;

  { Build list: insert 1, 2, 3, 4, 5 at head }
  i := 1;
  while i <= 5 do begin
    new(p);
    p^.value := i;
    p^.next := head;
    head := p;
    i := i + 1
  end;

  { Walk list and print values (should be 5 4 3 2 1) }
  p := head;
  while p <> nil do begin
    writeln(p^.value);
    p := p^.next
  end;

  { Dispose all nodes }
  p := head;
  while p <> nil do begin
    tmp := p^.next;
    dispose(p);
    p := tmp
  end;

  writeln(0)
end.
