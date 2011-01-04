(*
	Problem: MIPT 014 War-cry
	Author: Amber
	Method: Trie + DP
	Date: 2006-9-30
*)
program MIPT_014(Input, Output);
const
	MaxN = 100;
	MaxM = 25;
	MaxP = 100;
	MaxNum = MaxP * MaxN + 1;
type
	TIndex = Longint;
	TNode = record
		Child: array ['a'..'z'] of TIndex;
		Suffix: TIndex;
		Value: TIndex;
	end;
	TTrie = array [1..MaxNum] of TNode;
	TValid = array ['a'..'z'] of Boolean;
	TDP = array [0..MaxN, 1..MaxNum] of record
		Value, Prev: TIndex;
	end;
	TQueue = array [1..MaxNum] of TIndex;
var
	N, M, P: TIndex;
	Alphabet: String;
	Valid: TValid;
	Num: TIndex;
	Trie: TTrie;
	Queue: TQueue;
	F: TDP;
	Max: TIndex;
	Answer: String;

procedure Main;
var
	i, j, k: TIndex;
	Ch: Char;
	Ptr, Cur: TIndex;
	Pop, Push: TIndex;
	CurValue: TIndex;
begin
	FillChar(Trie, SizeOf(Trie), 0);
	Readln(N, M, P);
	Readln(Alphabet);
	for Ch := 'a' to 'z' do
		Valid[Ch] := (Pos(Ch, Alphabet) > 0);
	Num := 1;
	for i := 1 to P do
	begin
		Ptr := 1;
		while true do
		begin
			Read(Ch);
			if Ch = ' ' then Break;
			if Trie[Ptr].Child[Ch] = 0 then
			begin
				Inc(Num);
				Trie[Ptr].Child[Ch] := Num;
			end;
			Ptr := Trie[Ptr].Child[Ch];
		end;
		Readln(CurValue);
		Inc(Trie[Ptr].Value, CurValue);
	end;

	Pop := 1;
	Push := 1;
	for Ch := 'a' to 'z' do
		if Valid[Ch] then
		begin
			if Trie[1].Child[Ch] = 0 then
			begin
				Inc(Num);
				Trie[1].Child[Ch] := Num;
			end;
			Cur := Trie[1].Child[Ch];
			Trie[Cur].Suffix := 1;
			Queue[Push] := Cur;
			Inc(Push);
		end;
	while Pop < Push do
	begin
		Cur := Queue[Pop];
		Inc(Pop);
		for Ch := 'a' to 'z' do
			if Valid[Ch] then
				if Trie[Cur].Child[Ch] = 0 then
					Trie[Cur].Child[Ch] := Trie[Trie[Cur].Suffix].Child[Ch]
				else
				begin
					Ptr := Cur;
					repeat
						Ptr := Trie[Ptr].Suffix;
					until Trie[Ptr].Child[Ch] > 0;
					Ptr := Trie[Ptr].Child[Ch];
					Trie[Trie[Cur].Child[Ch]].Suffix := Ptr;
					Inc(Trie[Trie[Cur].Child[Ch]].Value, Trie[Ptr].Value);
					Queue[Push] := Trie[Cur].Child[Ch];
					Inc(Push);
				end;
	end;

	FillChar(F, SizeOf(F), 255);
	F[0, 1].Value := 0;
	F[0, 1].Prev := 0;
	for i := 0 to N - 1 do
		for j := 1 to Num do
			if F[i, j].Prev > -1 then
				for Ch := 'a' to 'z' do
					if Valid[Ch] then
					begin
						k := Trie[j].Child[Ch];
						if F[i + 1, k].Value < F[i, j].Value + Trie[k].Value then
						begin
							F[i + 1, k].Value := F[i, j].Value + Trie[k].Value;
							F[i + 1, k].Prev := j;
						end;
					end;
	Max := -1;
	j := 0;
	for i := 1 to Num do
		if F[N, i].Value > Max then
		begin
			Max := F[N, i].Value;
			j := i;
		end;
	Answer := '';
	for i := N downto 1 do
	begin
		k := F[i, j].Prev;
		for Ch := 'a' to 'z' do
			if Valid[Ch] then
				if Trie[k].Child[Ch] = j then
				begin
					Answer := Ch + Answer;
					Break;
				end;
		j := k;
	end;
	Writeln(Max);
	Writeln(Answer);
end;
begin
	Main;
end.