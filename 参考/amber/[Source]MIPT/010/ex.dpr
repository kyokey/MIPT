(*
	Problem: MIPT 010 New Year congratulations
	Author: Amber
	Method:
		Method: Forward Star(Quick sort)
		+Hungary-DFS
		+Unmatch First optimization
	Date: 2005-12-13
*)
program MIPT_010(Input,Output);
const
	MaxN=32000;
	MaxM=32000;
	MaxE=32000;
type
	TIndex=Longint;
	TEdge=record
		u,v:TIndex;
	end;
	TLink=array[1..MaxM]of TIndex;
	TCover=array[1..MaxM]of Boolean;
	TEdgeSet=array[1..MaxE]of TEdge;
	TEdgeFlag=array[0..MaxN]of TIndex;
var
	N,M,E:TIndex;
	Link:TLink;
	Cover:TCover;
	Edge:TEdgeSet;
	H:TEdgeFlag;
procedure QuickSort(l,r:TIndex);
var
	i,j:TIndex;
	Mid,Tmp:TEdge;
begin
	i:=l;
	j:=r;
	Mid:=Edge[(i+j) div 2];
	repeat
		while Edge[i].u<Mid.u do Inc(i);
		while Mid.u<Edge[j].u do Dec(j);
		if i<=j then
		begin
			Tmp:=Edge[i];
			Edge[i]:=Edge[j];
			Edge[j]:=Tmp;
			Inc(i);
			Dec(j);
		end;
	until i>j;
	if l<j then QuickSort(l,j);
	if i<r then QuickSort(i,r);
end;

function FindPath(u:TIndex):Boolean;
var
	i,p:TIndex;
	v,w:TIndex;
begin
	FindPath:=true;
	for p:=0 to 1 do
		for i:=H[u-1]+1 to H[u] do
		begin
			v:=Edge[i].v;
			if ((Link[v]+p=0) xor (Link[v]*p>0)) and not Cover[v] then 
			//Unmatch First optimization
			begin
				w:=Link[v];
				Link[v]:=u;
				Cover[v]:=true;
				if (w=0) or FindPath(w) then Exit;
				Link[v]:=w;
			end;
		end;
	FindPath:=false;
end;

procedure Main;
var
	i,j:TIndex;
	Total:TIndex;
begin
	Readln(N,M,E);
	for i:=1 to E do
		Readln(Edge[i].u,Edge[i].v);
	QuickSort(1,E);
	j:=0;
	H[0]:=0;
	for i:=1 to N do
	begin
		while (j+1<=E) and (Edge[j+1].u=i) do Inc(j);
		H[i]:=j;
	end;
	FillChar(Link,SizeOf(Link),0);
	Total:=0;
	for i:=1 to N do
	begin
		FillChar(Cover,SizeOf(Cover),0);
		if FindPath(i) then Inc(Total);
	end;
	Writeln(Total);
	for i:=1 to M do
		if Link[i]>0 then
			Writeln(Link[i],' ',i);
end;
begin
	Main;
end.