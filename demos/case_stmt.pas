program CaseTest;
var
  day: integer;
begin
  for day := 1 to 7 do
  begin
    case day of
      1: writeln('Monday');
      2: writeln('Tuesday');
      3: writeln('Wednesday');
      4: writeln('Thursday');
      5: writeln('Friday');
      6: writeln('Saturday');
      7: writeln('Sunday')
    end;
  end;
  writeln('Done')
end.
