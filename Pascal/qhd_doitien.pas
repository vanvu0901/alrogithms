Program DoiTien;

var n,m: integer;
	l: array[0..32000] of integer;
	a: array[1..20] of integer;

{thu tuc doc file}
procedure readfile;
var	i: integer;
begin
	assign(input, 'doitien.inp');
	reset(input);
	readln(n, m);
	for i:=1 to n do
		read(a[i]);
	close(input);
end;

{thu tuc quy hoach dong doi tien}
procedure quyhoachdong;
var	i,t: integer;
begin
	l[0] := 0;	{voi t = 0}
	for t := 1 to m do
		l[t] := m + 1;	{khoi tao L[t] = maxint hay m+1 voi moi t  0}

	for i := 1 to n do
		for t := a[i] to m do 	{bat dau tu a[i], voi t < a[i] thi L[t] khong thay doi}
			if l[t] > (1 + l[t - a[i]]) then
				l[t] := 1 + l[t - a[i]];
end;

{thu tuc ghi file theo yeu cau}
procedure writefile;
var	i,t: integer;
	g: array[1..20] of integer;
begin
	assign(output, 'doitien.out');
	rewrite(output);
	if l[m] > m then
		writeln('inf')
	else 
	begin
		t := m;	{t bat dau tu m dong}
		i := n;		{i bat dau tu menh gia cao nhat}
		while i > 0 do	{trong khi i van lon hon 0}
		begin
			if t >= a[i] then	{neu so tien can doi lon hon menh gia loai tien thu i}
			begin
				g[i] := t div a[i];	{so to can lay ung voi loai tien thu i}
				t := t - g[i]*a[i];	{so tien con lai can doi t = t – so to * menh gia}
				dec(i);				{xet loai tien menh gia thap hon voi so tien con lai}
			end
			else
			begin
				g[i] := 0;			{neu so tien can doi nho hon menh gia thi khong lay}
				dec(i);				{xet menh gia thap hon}
			end;
		end;

		writeln(l[m]);
		for i := 1 to n do
			write(g[i], ' ');
	end;
	close(output);
end;

BEGIN
	readfile;
	quyhoachdong;
	writefile;
END.