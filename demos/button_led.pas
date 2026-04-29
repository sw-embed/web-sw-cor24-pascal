program ButtonLed;
uses Hardware;
var on: boolean;
begin
  on := false;
  writeln('Press S2 switch...');
  while not on do
  begin
    if ReadSwitch = 1 then
    begin
      LedOn;
      on := true
    end
  end;
  writeln('LED on by switch')
end.
