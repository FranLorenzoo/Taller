program ej1;
const
	DF=300;
type 
	rango=1..300;
	
	oficinas=record
		codigoiden:integer;
		DNI:integer;
		valorex:real;
		end;
		
	vector=array [rango] of oficinas;
	
procedure generarArreglo (var v:vector; var DL:integer);
	procedure leerdato (var e:oficinas);
	begin
		readln (e.codigoiden);
		if (e.codigoiden<>-1) then begin
			readln (e.DNI);
			readln (e.valorex);
		end;
	end;
var
	e:oficinas;
begin
	DL:=0;
	leerdato (e);
	while (e.codigoiden <> -1) and (DL<=DF) do begin
		DL:=DL +1;
		v[DL]:=e;
		leerdato (e);
	end;
end;

procedure insercion (var v:vector);
var
	i,j:integer; act:oficinas;
begin
	for i:= 2 to DF do begin
		j:=i-1;
		act:=v[i];
		while (j>0) and (act.codigoiden < v[j].codigoiden) do begin
			v[j+1]:= v[j];
			j:=j-1;
		end;
	v [j+1]:=act;
	end;
end;

procedure dicotomica (cod:integer;v:vector; ini,fin,DL:integer;var pos:integer);
begin
	while (pos<>ini) and (pos<>fin) do begin
		if (v[pos].codigoiden <= cod) then begin
			ini:= pos;
			pos:=pos + (ini div 2);
		end
		else begin
			fin:=pos;
			pos:=fin div 2;
		end;
	end;
	if (v[pos].codigoiden = cod) then
		writeln (v[pos].dni)
	else
		writeln ('no existe');
end;

function exptot (v:vector; dl:integer):real;
begin
	if (dl <> 0) then 
		exptot:= v[dl].valorex + exptot (v,dl-1);
	exptot:=0;
end;

var
	expensas:real;
	v:vector;
	cod,DL,ini,fin,pos:integer;
begin
	generarArreglo (v,DL);
	insercion(v);
	ini:=1; fin:= DL; pos:= DL div 2; readln (cod);
	dicotomica (cod,v,ini,fin,DL,pos);
	expensas:=exptot(v,DL);
	writeln (expensas);
end.
