program prim;
type data=record
     key,go:longint;
     end;
var heap:array[0..404000]of data;
    size:longint;
procedure push(x:data);
var son,fa:longint;
begin
  inc(size);
  son:=size;
  heap[size]:=x;
  fa:=size>>1;
  while (son>1)and(heap[fa].key>heap[son].key) do
  begin
    heap[0]:=heap[fa];
    heap[fa]:=heap[son];
    heap[son]:=heap[0];
    son:=fa;
    fa:=son>>1;
  end;
end;
function pop:data;
var fa,son:longint;
begin
  pop:=heap[1];
  heap[1]:=heap[size];
  dec(size);
  fa:=1;
  son:=2;
  while (son<=size) do
  begin
    if (son+1<=size)and(heap[son].key>heap[son+1].key) then inc(son);
    if heap[fa].key>heap[son].key then
    begin
      heap[0]:=heap[fa];
      heap[fa]:=heap[son];
      heap[son]:=heap[0];
      fa:=son;
      son:=fa<<1;
    end
    else
    break;
  end;
end;

type edge=record
     w,go,next:longint;
     end;
var e:array[1..404000]of edge;
    head:array[1..5050]of longint;
    cnt:longint;
procedure add;
var x,y:longint;
begin
  inc(cnt);
  readln(x,y,e[cnt].w);
  e[cnt].next:=head[x];
  e[cnt].go:=y;
  head[x]:=cnt;
  inc(cnt);
  e[cnt].w:=e[cnt-1].w;
  e[cnt].next:=head[y];
  e[cnt].go:=x;
  head[y]:=cnt;
end;

var f:array[1..5050]of boolean;
    i,n,m,temp,ecnt,ans:longint;
    t:data;
begin
  readln(n,m);
  fillchar(head,sizeof(head),-1);
  for i:=1 to m do add;
  fillchar(f,sizeof(f),true);
  f[1]:=false;
  temp:=head[1];
  while temp<>-1 do
  begin
    t.key:=e[temp].w;
    t.go:=e[temp].go;
    push(t);
    temp:=e[temp].next;
  end;
  ecnt:=1;
  while ecnt<n do
  begin
    repeat
      t:=pop;
    until f[t.go];
    f[t.go]:=false;
    inc(ans,t.key);
    inc(ecnt);
    temp:=head[t.go];
    while temp<>-1 do
    begin
      t.key:=e[temp].w;
      t.go:=e[temp].go;
      if f[e[temp].go] then push(t);
      temp:=e[temp].next;
    end;
  end;
 writeln(ans);
end.
