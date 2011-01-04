{$I+,S+,Q+,R+}
{$APPTYPE CONSOLE}
const
	maxn = 8010;
    maxk = 300000;

type
	TStrips	= object
    	size, n, m	: longint;
        head, tail	: array[1 .. maxk] of longint;

        procedure add(u, v, p : longint);
        procedure rebuild;
        function find(k : longint) : boolean;
    end;

procedure TStrips.add(u, v, p : longint);
begin
	inc(size);
    head[size] := u * m + v;
    if v + p - 1 > m then p := m - (v - 1);
    tail[size] := head[size] + p - 1;
end;

procedure TStrips.rebuild;

	procedure sort(l, r : longint);
    var
    	i, j, midx, midy, temp	: longint;
    begin
    	i := l; midx := head[(l * 2 + r) div 3];
        j := r; midy := tail[(l * 2 + r) div 3];
    	while i <= j do begin
        	while (head[i] < midx) or (head[i] = midx) and (tail[i] < midy) do i := i + 1;
        	while (head[j] > midx) or (head[j] = midx) and (tail[j] > midy) do j := j - 1;
            if i <= j then begin
            	temp := head[i]; head[i] := head[j]; head[j] := temp;
            	temp := tail[i]; tail[i] := tail[j]; tail[j] := temp;
                i := i + 1; j := j - 1;
            end;
        end;
        if i < r then sort(i, r);
        if l < j then sort(l, j);
    end;

var
	i, k	: longint;

begin
	if size = 0 then exit;
	sort(1, size);
	k := 1;
    for i := 2 to size do begin
    	if (head[i] <= tail[k]) and (tail[i] > tail[k]) then tail[k] := tail[i];
        if head[i] > tail[k] then begin
        	k := k + 1;
            head[k] := head[i];
            tail[k] := tail[i];
        end;
    end; size := k;
end;

function TStrips.find(k : longint) : boolean;
var
	l, r, mid	: longint;
begin
	l := 1; r := size;
    while l < r do begin
    	mid := (l + r + 1) shr 1;
        if k < head[mid] then r := mid - 1 else l := mid;
    end;
    find := (l = r) and (head[l] <= k) and (tail[l] >= k);
end;

var
	stripA, stripB		: TStrips;
    n, m, problem		: longint;
    d, i, j, k, u, v, p	: longint;
    nd, t, cnt			: longint;
    a, b, c				: array[0 .. maxn] of longint;
    fath, rank			: array[0 .. maxn] of longint;

function find(u : longint) : longint;
var
	v, k	: longint;
begin
	v := u;
    while fath[u] <> u do u := fath[u];
    find := u;
    while fath[v] <> u do begin
    	k := fath[v];
        fath[v] := u;
        v := k;
    end;
end;

procedure merge(u, v : longint);
begin
	if u = v then exit;
    if rank[u] < rank[v] then begin
    	inc(rank[v]);
        fath[u] := v;
    end else begin
    	inc(rank[u]);
        fath[v] := u;
    end;
end;

begin
	stripA.size := 0; stripB.size := 0;

	readln(problem);
    readln(n, m);
    stripA.n := n; stripA.m := m;
    stripB.n := m; stripB.m := n;

    readln(k);
    for i := 1 to k do begin
    	readln(d, u, v, p);
        if d = 0
        	then stripA.add(u, v, p)
            else stripB.add(v, u, p);
    end;

    stripA.rebuild;
    stripB.rebuild;

    t := 0; cnt := 0;
    for i := 1 to m do a[i] := 0; d := 0;
    fillchar(fath, sizeof(fath), 0);
    fillchar(rank, sizeof(rank), 0);
    for i := 1 to n do begin
    	fillchar(b, sizeof(b), 0);
    	for j := 1 to m do
			if not stripA.find(i * m + j) and not stripB.find(j * n + i) then begin
            	if b[j - 1] = 0 then inc(d);
                b[j] := d; inc(cnt);
                fath[d] := d; rank[d] := 0;
            end;
		for j := 1 to m do if (a[j] > 0) and (b[j] > 0) then merge(find(a[j]), find(b[j]));

        fillchar(c, sizeof(c), 0); nd := 0;
        for j := 1 to m do if b[j] > 0 then begin
        	k := find(b[j]);
            if c[k] = 0 then begin inc(nd); c[k] := nd; end;
            b[j] := c[k]; 
        end;
        for j := 1 to m do if (a[j] > 0) and (c[find(a[j])] = 0) then begin inc(t); c[find(a[j])] := 1; end;
        for j := 1 to m do a[j] := b[j];
    	d := nd;
        for j := 1 to d do begin fath[j] := j; rank[j] := 0; end;
    end;
    inc(t, d);
    if problem = 1 then writeln(cnt) else writeln(t);
end.

