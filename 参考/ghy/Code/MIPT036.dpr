
  program MIPT036;

     {$Q-,R-,S-}
     
     const
        finp    =  'P036.in';
	fout    =  'output.txt';
	n       =  6;
	maxr    =  1000;
	maxh    =  46656; {6^6}
	rotate  :  array [1 .. 6, 1 .. 6] of longint=
	           ((6,2,1,4,3,5),(3,2,5,4,6,1),(1,3,4,6,5,2),(1,6,2,3,5,4),(2,5,3,1,4,6),(4,1,3,5,2,6));
	
     type
        Tindex  =  array [1 .. n] of longint;
	
     var
        a,b    :   Tindex;
        ans    :   longint;
	count  :   array [0 .. 1, 1 .. maxr] of longint;
	hash   :   array [0 .. maxh-1] of boolean;
	
     procedure getinfo;
       var
          i   :   longint;
       begin
          assign(input,finp);reset(input);
	    for i:=1 to n do read(a[i]);
	    for i:=1 to n do read(b[i]);
	  close(input);
       end;
       
     function  get(a : Tindex): longint;
       var
          i,x    :  longint;
       begin
          x:=0;
          for i:=1 to n do 
	    x:=x*6+a[i]-1;
	  get:=x;
       end;
       
     procedure dfs(a : Tindex);
       var
          x,i,j :  longint;
	  b     :  Tindex;
       begin
          x:=get(a);
	  if hash[x] then exit;
	  hash[x]:=true;
	  for i:=1 to 6 do 
	    begin
	      for j:=1 to 6 do 
	        b[j]:=a[rotate[i,j]];
	      dfs(b);
	    end;
       end;

     procedure swap(var a,b : longint);
       var
          change  :  longint;
       begin
          change:=a; a:=b; b:=change;
       end;

     procedure work;
       var
          i,cnt  :  longint;
       begin
          fillchar(count,sizeof(count),0);
	  for i:=1 to n do 
	    begin
	      inc(count[0,a[i]]); 
	      inc(count[1,b[i]]);
	    end;
	  for i:=1 to maxr do
	    if count[0,i]<>count[1,i] then
	      begin
	        ans:=0; exit;
	      end;
	  cnt:=0;
	  for i:=1 to maxr do
	    if count[0,i]>0 then
	      begin
	        inc(cnt); count[0,i]:=cnt;
              end;
	  for i:=1 to n do
	    begin
	      a[i]:=count[0,a[i]];
	      b[i]:=count[0,b[i]];
	    end;
	  fillchar(hash,sizeof(hash),false);
	  dfs(a);
	  if hash[get(b)] then begin ans:=1; exit; end;
	  swap(a[1],a[5]); dfs(a);
          if hash[get(b)] then begin ans:=2; exit; end; swap(a[1],a[5]);
	  swap(a[2],a[4]); dfs(a);
          if hash[get(b)] then begin ans:=2; exit; end; swap(a[2],a[4]);
	  swap(a[3],a[6]); dfs(a);
          if hash[get(b)] then begin ans:=2; exit; end; swap(a[3],a[6]);
	  ans:=0;
       end;
       
     procedure getout;
       begin
          assign(output,fout);rewrite(output);
	    writeln(ans);
	  close(output);
       end;
       
     begin
     
          getinfo;
	  work;
	  getout;
     end.
     