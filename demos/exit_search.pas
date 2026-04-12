program ExitDemo;
{ Demo: exit for early return — a simple linear search }
type
  PNode = ^Node;
  Node = record
    value: integer;
    next: PNode
  end;
var
  head, p: PNode;
  i: integer;

function Find(list: PNode; target: integer): integer;
var cur: PNode;
begin
  cur := list;
  Find := 0;
  while cur <> nil do begin
    if cur^.value = target then begin
      Find := 1;
      exit
    end;
    cur := cur^.next
  end
end;

begin
  { Build list: 10 20 30 40 50 }
  head := nil;
  i := 5;
  while i >= 1 do begin
    new(p);
    p^.value := i * 10;
    p^.next := head;
    head := p;
    i := i - 1
  end;

  { Search tests }
  writeln(Find(head, 30));
  writeln(Find(head, 99));
  writeln(Find(head, 10));
  writeln(Find(head, 50))
end.
