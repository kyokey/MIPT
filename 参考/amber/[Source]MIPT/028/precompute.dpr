(*
	Problem: MIPT 028 Circle Game
	Author: Amber
	Method: Enumerate and Simulate
	Date: 2006-11-28
*)
program MIPT_028(Input,Output);
const
	MaxK=14;
type
	TIndex=Longint;
	THash=array[0..MaxK*2-1]of Boolean;
procedure Main;
label 
	Error;
var
	F:THash;
	i,j,p:TIndex;
	K,M:TIndex;
begin
	Readln(K);
	M:=K;
	repeat
		Inc(M);
		FillChar(F,SizeOf(F),0);
		p:=0;
		for i:=1 to K do
		begin
			for j:=1 to (M-1) mod (2*K-i+1) do
				repeat
					p:=(p+1) mod (2*K);
				until not F[p];
			if p<K then goto Error;
			F[p]:=true;
			repeat
				p:=(p+1) mod (2*K);
			until not F[p];
		end;
		Break;
		Error: Continue;
	until false;
	Writeln(M);
end;
begin
	Main;
end.