(*
	Problem: MIPT 300 Algorithm Complexity
	Author: Amber
	Method: Expression Processing
	Date: 2005-11-28
*)
program MIPT_300(Input,Output);
const
	MaxDegree=10+1;
	MaxStackSize=MaxDegree;
type
	TIndex=Longint;
	TPolynomial=record
		Degree:TIndex;
		Coeff:array[0..MaxDegree]of TIndex;
	end;
	TStack=array[0..MaxStackSize]of record
		T:TIndex;
		P:TPolynomial;
	end;
var
	Top:TIndex;
	Stack:TStack;

procedure ReadWord(var St:String);
var
	Ch:Char;
begin
	St:='';
	while St='' do
	begin
		while not Eoln do
		begin
			Read(Ch);
			if (Ch=' ') and (St<>'') then Break;
			St:=St+Ch;
		end;
		if Eoln then Readln;
	end;
end;
procedure Add(var A:TPolynomial;const B:TPolynomial;Multiplier:TIndex);
var
	i:TIndex;
begin
	if B.Degree>A.Degree then A.Degree:=B.Degree;
	for i:=0 to A.Degree do
		Inc(A.Coeff[i],B.Coeff[i]*Multiplier);
end;
function SetConstant(X:TIndex):TPolynomial;
begin
	FillChar(Result,SizeOf(Result),0);
	Result.Coeff[0]:=X;
end;
function SetDegreeUp(X:TPolynomial):TPolynomial;
begin
	if X.Coeff[X.Degree]>0 then Inc(X.Degree);
	Move(X.Coeff[0],X.Coeff[1],(X.Degree+1)*SizeOf(TIndex));
	X.Coeff[0]:=0;
	Result:=X;
end;
procedure Main;
var
	i:TIndex;
	X:TIndex;
	St:String;
	Code:Integer;
	Ans:TPolynomial;
begin
	Top:=-1;
	while not Eof do
	begin
		ReadWord(St);
		if St='BEGIN' then
		begin
			Top:=0;
			Stack[Top].P:=SetConstant(0);
			Stack[Top].T:=1;
		end;
		if Top=-1 then Continue;//if not BEGIN
		if St='OP' then
		begin
			ReadWord(St);
			Val(St,X,Code);
			Add(Stack[Top].P,SetConstant(X),1);
		end
		else if St='LOOP' then
		begin
			Inc(Top);
			ReadWord(St);
			if St='n' then
				Stack[Top].T:=-1 //n
			else 
				Val(St,Stack[Top].T,Code);
			Stack[Top].P:=SetConstant(0);
		end
		else if St='END' then
		begin
			if Top=0 then Break;
			if Stack[Top].T=-1 then //n
				Add(Stack[Top-1].P,SetDegreeUp(Stack[Top].P),1)
			else
				Add(Stack[Top-1].P,Stack[Top].P,Stack[Top].T);
			Dec(Top);
		end;
	end;
	Write('Runtime = ');
	Ans:=Stack[0].P;
	if (Ans.Degree=0)and(Ans.Coeff[0]=0) then
	begin
		Writeln(0);
		Exit;
	end;
	for i:=Ans.Degree downto 0 do
		if Ans.Coeff[i]>0 then
		begin
			if i<Ans.Degree then Write('+');
			if i=0 then
				Write(Ans.Coeff[0])
			else
			begin
				if Ans.Coeff[i]>1 then Write(Ans.Coeff[i],'*');
				Write('n');
				if i>1 then Write('^',i);
			end;
		end;
	Writeln;
end;
begin
	Main;
end.