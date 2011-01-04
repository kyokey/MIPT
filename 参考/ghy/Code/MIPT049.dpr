
  program MIPT049;

    {$Q-,R-,S-}

    const
        finp  =  '';
        fout  =  '';
	maxn  =  1000 + 5;

    var
        f     :  array [0 .. maxn, 0 .. maxn] of longint;
	a     :  array [1 .. maxn] of longint;
	n     :  longint;

    procedure getinfo;
      var
         i    :  longint;
      begin
         assign(input,finp);reset(input);
	   read(n);
	   for i:=1 to n do read(a[i]);
	 close(input);
      end;

    procedure updata(a : longint; var b: longint);
      begin
          if a>b then b:=a;
      end;

    procedure work;
      var
          i,j  :  longint;
      begin
          fillchar(f,sizeof(f),$Ff);
	  f[0,0]:=0;
	  for i:=0 to n-1 do
	    for j:=0 to i do
	      if f[i,j]<>-1 then
	        begin
		  if (i+1<>n) then
                    if (f[i,j]>=100) then updata(f[i,j]-100,f[i+1,j+1]);
		  if f[i,j]+a[i+1]>=0 then updata(f[i,j]+a[i+1],f[i+1,j]);
		end;
      end;

    procedure getout;
      var
           i  :  longint;
      begin
           assign(output,fout);rewrite(output);
	     i:=n;
	     while (i>=0) and (f[n,i]=-1) do dec(i);
	     if i>=0 then i:=n-i;
	     writeln(i);
	   close(output);
      end;

    begin

        getinfo;
	work;
	getout;

    end.