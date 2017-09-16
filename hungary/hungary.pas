program hungary;
var go:array[1..1000,0..1000]of longint;
    from:array[1..1000]of longint;
    f:array[1..1000]of boolean;
    n,m,cnt,ans,c,i:longint;
procedure swap(var x,y:longint);
var t:longint;
begin
  t:=x;
  x:=y;
  y:=t;
end;

procedure add;
var x,y:longint;
begin
  readln(x,y);
  if (x>n)or(y>m) then exit;
  //if f[y] then swap(x,y);
  //f[x]:=true;
  inc(go[x,0]);
  go[x,go[x,0]]:=y;
end;

function match(x:longint):boolean;
var i:longint;
begin
  if f[x] then exit(false);
  f[x]:=true;
  for i:=1 to go[x,0] do
  begin
    if (from[go[x,i]]=0)or(match(from[go[x,i]])) then
    begin
      from[go[x,i]]:=x;
      exit(true);
    end;
  end;
  exit(false);
end;
begin
  readln(n,m,c);
  for i:=1 to c do add;
  for i:=1 to n do
  begin
    fillchar(f,sizeof(f),false);
    if match(i) then inc(ans);
  end;
  writeln(ans);
end.
