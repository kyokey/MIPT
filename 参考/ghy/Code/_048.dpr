const n                 = 8;

type  edgelink          = ^edgetype;
      edgetype          = record
        x               : integer;
        next            : edgelink;
      end;

var pq,pk               : integer;

    min,prev            : array[0..n*n*n*n*2-1] of integer;
    d                   : array[0..n*n*n*n*2-1] of integer;
    G                   : array[0..n*n*n*n*2-1] of edgelink;

procedure read_data;
var str                 : string[2];
begin
  readln(str);
  pq := (ord(str[1])-ord('a'))*8+(ord(str[2])-ord('0'));
  dec(pq);
  readln(str);
  pk := (ord(str[1])-ord('a'))*8+(ord(str[2])-ord('0'));
  dec(pk);
end;

procedure solve;
var q                           : array[1..n*n*n*n*2] of integer;
    b                           : array[0..64,0..64] of boolean;
    h,t                         : integer;

  procedure addedge(x,y         : integer);
  var temp                      : edgelink;
  begin
    new(temp);
    temp^.x := y;
    temp^.next := G[x];
    G[x] := temp;
    inc(d[y]);
  end;

  function king(x,y             : integer) : boolean;
  begin king := (abs(x mod 8-y mod 8)<=1) and (abs(x div 8-y div 8)<=1) end;

  procedure init;
  var xq,yq,x,y,dx,dy,temp      : integer;
      posq,posk,pos             : integer;
  begin
    fillchar(b,sizeof(b),false);
    fillchar(min,sizeof(min),255);
    for xq := 0 to 7 do
      for yq := 0 to 7 do
        for dx := -1 to 1 do
          for dy := -1 to 1 do
            if (dx<>0) or (dy<>0) then begin
               x := xq+dx; y := yq+dy;
               while (x<=7) and (x>=0) and (y<=7) and (y>=0) and ((x<>2) or (y<>2)) do begin
                 b[xq*8+yq,x*8+y] := true;
                 inc(x,dx); inc(y,dy);
               end;
            end;
    h := 1; t := 0;
    for posk := 0 to 63 do
      for posq := 0 to 63 do
        if (posk<>posq) and (posk<>18) and (posq<>18) then begin
          temp := 2*(posk*64+posq);
          if b[posq,posk] then begin
            inc(t);
            q[t] := temp;
            min[temp] := 0;
          end else if (abs(posk mod 8-2)<=1) and (abs(posk div 8-2)<=1) then begin
                     inc(t);
                     q[t] := temp;
                     min[temp] := 0;
                   end else for pos := 0 to 63 do
                              if (pos<>18) and b[posq,pos] then
                                if king(pos,18) or (not king(pos,posk)) then
                                  addedge(2*(posk*64+pos)+1,temp);
          if king(posq,18) or (not king(posk,posq)) then
            for pos := 0 to 63 do
              if (pos<>posq) and (pos<>18) and (pos<>posk) then
                if king(posk,pos) then
                  addedge(2*(pos*64+posq),temp+1);
        end;
  end;

  procedure main;
  var temp                      : edgelink;
  begin
    while h<=t do begin
      temp := G[q[h]];
      while temp<>nil do begin
        if q[h] mod 2=0 then begin
          dec(d[temp^.x]);
          if d[temp^.x]=0 then
            if (min[q[h]]<>0) or
               b[temp^.x div 128,(temp^.x mod 128) div 2] then begin
                inc(t);
                q[t] := temp^.x;
                min[temp^.x] := min[q[h]]+1;
              prev[temp^.x] := q[h];
            end;
        end;
        if q[h] mod 2=1 then begin
          dec(d[temp^.x]);
          if min[temp^.x]=-1 then begin
            min[temp^.x] := min[q[h]]+1;
            inc(t);
            q[t] := temp^.x;
            prev[temp^.x] := q[h];
          end;
        end;
        temp := temp^.next;
      end;
      inc(h);
    end;
  end;

begin
  fillchar(prev,sizeof(prev),255);
  init;
  main;
end;

procedure write_ans;
begin
  writeln(min[(pk*64+pq)*2] div 2);
end;

begin
  solve;
  read_data;
  write_ans;
end.
