program uset;
var u,rank:array[1..10100]of longint;
    i,n,m,t,x,y:longint;

function find(x:longint):longint;
begin
  if x=u[x] then exit(x)
  else u[x]:=find(u[x]);
  exit(u[x]);
end;

procedure union(x,y:longint);
begin
  x:=find(x);y:=find(y);
  if  x=y then exit;
  if rank[x]>rank[y] then u[y]:=x
  else u[x]:=y;
  if rank[x]=rank[y] then inc(rank[y]);
end;

begin
  readln(n,m);
  for i:=1 to n do u[i]:=i;
  for i:=1 to m do
  begin
    readln(t,x,y);
    if t=1 then union(x,y);
    if t=2 then
      if find(x)=find(y) then writeln('Y')
      else writeln('N');
  end;
end.

