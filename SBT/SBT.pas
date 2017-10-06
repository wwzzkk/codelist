program SBT;
type treenode=^node;
     node=record
     key,size:longint;
     l,r,p:treenode;
     end;
var root:treenode;
function max(a,b:longint):longint;
begin
  if a>b then exit(a) else exit(b);
end;
function search(x:treenode;k:longint):treenode;
begin
  if (x=nil)or(x^.key=k) then exit(x);
  if k<x^.key then
    exit(search(x^.l,k))
  else
    exit(search(x^.r,k));
end;
function minnode(x:treenode):treenode;
begin
  while x^.l<>nil do
    x:=x^.l;
  exit(x);
end;
function maxnode(x:treenode):treenode;
begin
  while x^.r<>nil do
    x:=x^.r;
  exit(x);
end;
function nodeprec(x:treenode):treenode;
var y:treenode;
begin
  if x^.l<>nil then exit(maxnode(x^.l));
  y:=x^.p;
  while (y<>nil)and(x=y^.l) do
  begin
    x:=y;
    y:=y^.p;
  end;
  exit(y);
end;
function nodesucc(x:treenode):treenode;
var y:treenode;
begin
  if x^.r<>nil then exit(minnode(x^.r));
  y:=x^.p;
  while (y<>nil)and(x=y^.r) do
  begin
    x:=y;
    y:=y^.p;
  end;
  exit(y);
end;
function numprec(x:treenode;k:longint):treenode;
begin
  if x=nil then exit(x);
  if x^.key>=k then
    exit(numprec(x^.l,k))
  else
    numprec:=numprec(x^.r,k);
  if numprec=nil then exit(x);
end;
function numsucc(x:treenode;k:longint):treenode;
begin
  if x=nil then exit(x);
  if x^.key<=k then
    exit(numsucc(x^.r,k))
  else
    numsucc:=numsucc(x^.l,k);
  if numsucc=nil then exit(x);
end;
procedure transplant(u,v:treenode);
  begin
    if u^.p=nil then
      root:=v
    else if u=u^.p^.l then
      u^.p^.l:=v
    else
      u^.p^.r:=v;
    if v<>nil then v^.p:=u^.p;
  end;
procedure maintain(x:treenode);
var sl,sr,sll,srr,slr,srl:longint;
  procedure calch(x:treenode);
  begin
    sl:=0;sr:=0;sll:=0;srr:=0;slr:=0;srl:=0;
    if x^.l=nil then sl:=0 else
    begin
      sl:=x^.l^.size;
      if x^.l^.l=nil then sll:=0 else sll:=x^.l^.l^.size;
      if x^.l^.r=nil then slr:=0 else slr:=x^.l^.r^.size;
    end;
    if x^.r=nil then sr:=0 else
    begin
      sr:=x^.r^.size;
      if x^.r^.r=nil then srr:=0 else srr:=x^.r^.r^.size;
      if x^.r^.l=nil then srl:=0 else srl:=x^.r^.l^.size;
    end;
    x^.size:=sl+sr+1;
  end;
  function LL(x:treenode):treenode;
  var y:treenode;
  begin
    y:=x^.l;
    transplant(y,y^.r);
    transplant(x,y);
    y^.r:=x;
    x^.p:=y;
    calch(x);
    calch(y);
    exit(y);
  end;
  function RR(x:treenode):treenode;
  var y:treenode;
  begin
    y:=x^.r;
    transplant(y,y^.l);
    transplant(x,y);
    y^.l:=x;
    x^.p:=y;
    calch(x);
    calch(y);
    exit(y);
  end;
  function LR(x:treenode):treenode;
  begin
    RR(x^.l);
    exit(LL(x));
  end;
  function RL(x:treenode):treenode;
  begin
    LL(x^.r);
    exit(RR(x));
  end;
begin
  calch(x);
  if sll>sr then
  begin
    x:=LL(x);
    maintain(x^.r);
    maintain(x);
  end
  else if srr>sl then
  begin
    x:=RR(x);
    maintain(x^.l);
    maintain(x);
  end
  else if slr>sr then
  begin
    x:=LR(x);
    maintain(x^.l);
    maintain(x);
  end
  else if srl>sl then
  begin
    x:=RL(x);
    maintain(x^.r);
    maintain(x);
  end;
  if (x^.p<>nil) then
    maintain(x^.p);
end;
procedure insert(k:longint);
var x,y,z:treenode;
begin
  y:=nil;
  x:=root;
  while x<>nil do
  begin
    y:=x;
    if k<x^.key then
      x:=x^.l
    else
      x:=x^.r;
  end;
  new(z);
  z^.key:=k;
  z^.l:=nil;
  z^.r:=nil;
  z^.size:=1;
  z^.p:=y;
  if y=nil then root:=z
  else if k<y^.key then
    y^.l:=z
  else
    y^.r:=z;
  maintain(z);
end;
procedure delete(x:treenode);
var y:treenode;
begin
  if x^.l=nil then
    transplant(x,x^.r)
  else if x^.r=nil then
    transplant(x,x^.l)
  else
  begin
    y:=minnode(x^.r);
    x^.key:=y^.key;
    delete(y);
    exit;
  end;
  y:=x^.p;
  while y<>nil do
  begin
    dec(y^.size);
    y:=y^.p;
  end;
  dispose(x);
end;
procedure dfs(x:treenode);
begin
  if x=nil then exit;
  dfs(x^.l);
  write(x^.key,' ');
  dfs(x^.r);
  if x=root then writeln;
end;
function select(x:treenode;k:longint):longint;
var sl:longint;
begin
  if x^.l<>nil then sl:=x^.l^.size else sl:=0;
  if k=sl+1 then exit(x^.key);
  if k<=sl then
    exit(select(x^.l,k))
  else
    exit(select(x^.r,k-sl-1));
end;
function rank(x:treenode;k:longint):longint;
var sl:longint;
    y:treenode;
begin
  if x=nil then exit(1);
  if x^.l<>nil then sl:=x^.l^.size else sl:=0;
  if k<=x^.key then
    exit(rank(x^.l,k))
  else
    exit(rank(x^.r,k)+sl+1);
end;
var n,i,opt,x,s,cnt:longint;
    g:treenode;
begin
  root:=nil;
  readln(n);
  for i:=1 to n do
  begin
    readln(opt,x);
    if root<>nil then s:=root^.size;
    if opt=1 then insert(x);
    if opt=2 then delete(search(root,x));
    if (opt=1)or(opt=2) then dfs(root);
    if opt=3 then writeln(rank(root,x));
    if opt=4 then writeln(select(root,x));
    if opt=5 then writeln(numprec(root,x)^.key);
    if opt=6 then writeln(numsucc(root,x)^.key);
  end;
end.

