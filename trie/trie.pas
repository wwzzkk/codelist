program trie;
type treenode=record
     cot:longint;
     son:array['a'..'z']of longint;
     end;
var s:ansistring;
    trie:array[1..1000000]of treenode;
    cot:longint;
procedure insert(x:ansistring);
var  i,t:longint;
begin
  t:=1;
  inc(trie[t].cot);
  for i:=1 to length(s) do
  begin
    if trie[t].son[s[i]]=0 then
    begin
      inc(cot);
      trie[t].son[s[i]]:=cot;
    end;
    t:=trie[t].son[s[i]];
    inc(trie[t].cot);
  end;
end;
function query(s:ansistring):longint;
var t:treenode;
    i:longint;
begin
  t:=trie[1];
  for i:=1 to length(s) do
  begin
    if t.son[s[i]]=0 then exit(0);
    t:=trie[t.son[s[i]]];
  end;
  exit(t.cot);
end;
begin
  s:='start';
  cot:=1;
  while s<>'' do
  begin
    readln(s);
    insert(s);
  end;
  while not eof do
  begin
    readln(s);
    writeln(query(s));
  end;
end.

