program ej2;

procedure leernum (var num:integer);
begin
	readln (num);
end;

procedure imprimir (var num:integer);
var
	dig:integer;
begin
	while (num <> 0) do begin
		dig:= num MOD 10;
		num:= num DIV 10;
		imprimir (num);
		write (dig);
	end;
end;

var
	num:integer;
begin
	leernum (num);
	imprimir (num);
end.
