program treearray;
var ta:array[1..500500]of longint;
    i,n,m,t,x,k:longint;
function lowbit(x:longint):longint;
begin
  exit(x and -x);
end;
procedure add(x,k:longint);
begin
  while x<=n do
  begin
    inc(ta[x],k);
    inc(x,lowbit(x));
  end;
end;
function query(x:longint):longint;
begin
  query:=0;
  while x>=1 do
  begin
    inc(query,ta[x]);
    dec(x,lowbit(x));
  end;
end;
begin
  readln(n,m);
  for i:=1 to n do
  begin
    read(t);
    add(i,t);
  end;
  for i:=1 to m do
  begin
    readln(t,x,k);
    if t=1 then add(x,k);
    if t=2 then writeln(query(k)-query(x-1));
  end;
end.

