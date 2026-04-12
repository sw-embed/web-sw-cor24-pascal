program BinarySearchTree;
{ Demo: binary search tree with in-order traversal }
type
  PNode = ^Node;
  Node = record
    value: integer;
    left: PNode;
    right: PNode
  end;
var
  root, p, parent: PNode;
  val, i: integer;

procedure PrintTree(t: PNode);
begin
  if t <> nil then begin
    PrintTree(t^.left);
    writeln(t^.value);
    PrintTree(t^.right)
  end
end;

begin
  root := nil;

  { Insert values: 4 2 6 1 3 5 7 }
  i := 0;
  while i < 7 do begin
    { Pick value from sequence }
    if i = 0 then val := 4
    else if i = 1 then val := 2
    else if i = 2 then val := 6
    else if i = 3 then val := 1
    else if i = 4 then val := 3
    else if i = 5 then val := 5
    else val := 7;

    { Create new node }
    new(p);
    p^.value := val;
    p^.left := nil;
    p^.right := nil;

    { Insert into tree }
    if root = nil then
      root := p
    else begin
      parent := root;
      while parent <> nil do begin
        if val < parent^.value then begin
          if parent^.left = nil then begin
            parent^.left := p;
            parent := nil
          end else
            parent := parent^.left
        end else begin
          if parent^.right = nil then begin
            parent^.right := p;
            parent := nil
          end else
            parent := parent^.right
        end
      end
    end;

    i := i + 1
  end;

  { In-order traversal should print 1 2 3 4 5 6 7 }
  PrintTree(root)
end.
