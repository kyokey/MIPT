(*
	Problem: MIPT 012 Correct dictionary
	Author: Amber
	Method: Hash + Topological Sort
	Date: 2005-12-4
*)
program MIPT_012(Input,Output);
const
	MaxN=1000;
	MaxHashSize=2011;
	MaxDefinition=20;
type
	TIndex=Longint;
	TWord=String[20];
	TDictionary=array[1..MaxN]of record
		Word:TWord;
		Num:TIndex;
		Define:array[1..MaxDefinition]of TIndex;
		DefineWord:array[1..MaxDefinition]of TWord;
	end;
	THash=array[0..MaxHashSize-1]of TIndex;
	TDeleted=array[1..MaxN]of Boolean;
var
	N:TIndex;
	D:TDictionary;
	Hash:THash;
	Del:TDeleted;
	
procedure ReadWord(var St:TWord);
var
	Ch:Char;
begin
	St:='';
	while not Eoln do
	begin
		Read(Ch);
		if Ch<>' ' then
			St:=St+Ch
		else if St<>'' then
			Break;
	end;
end;
function Hash_Value(const St:TWord):TIndex;
var
	i:TIndex;
begin
	Result:=0;
	for i:=1 to Length(St) do
		Result:=(Result shl 8+Ord(St[i])) mod MaxHashSize;
end;
function Hash_Find(const St:TWord):TIndex;
var
	i:TIndex;
begin
	i:=Hash_Value(St);
	while Hash[i]>0 do
	begin
		if D[Hash[i]].Word=St then Break;
		Inc(i);
		if i=MaxHashSize then i:=0;
	end;
	Result:=i;
end;
procedure Hash_Insert(const Pos:TIndex;const Ind:TIndex);
begin
	Hash[Pos]:=Ind;
end;
procedure Main;
label
	Error;
var
	i,j:TIndex;
	Num,Ret:TIndex;
	Count:TIndex;
	Found,Valid:Boolean;
begin
	FillChar(Hash,SizeOf(Hash),0);
	Readln(N);
	for i:=1 to N do
	begin
		ReadWord(D[i].Word);
		Ret:=Hash_Find(D[i].Word);
		if Hash[Ret]>0 then goto Error;
		Hash_Insert(Ret,i);
		Read(D[i].Num);
		for j:=1 to D[i].Num do
			ReadWord(D[i].DefineWord[j]);
		Readln;
	end;
	for i:=1 to N do
	begin
		Num:=D[i].Num;
		D[i].Num:=0;
		while Num>0 do
		begin
			Ret:=Hash_Find(D[i].DefineWord[Num]);
			Dec(Num);
			if Hash[Ret]>0 then
			begin
				Inc(D[i].Num);
				D[i].Define[D[i].Num]:=Hash[Ret];
			end;
		end;
	end;
	//Topological sort
	FillChar(Del,SizeOf(Del),0);
	Count:=N;
	while Count>0 do
	begin
		Found:=false;
		for i:=1 to N do
			if not Del[i] then
			begin
				Valid:=true;
				for j:=1 to D[i].Num do
					if not Del[D[i].Define[j]] then
					begin
						Valid:=false;
						Break;
					end;
				if Valid then
				begin
					Del[i]:=true;
					Found:=true;
					Dec(Count);
				end;
			end;
		if not Found then goto Error;
	end;
	Writeln('CORRECT');
	Exit;
	Error:
	Writeln('NOT CORRECT');
end;
begin
	Main;
end.