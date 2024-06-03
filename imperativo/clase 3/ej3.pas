program ej3;
type
	unlp=record
		legajo:integer;
		dni:integer;
		anhoingreso:integer;
		end;
	
	arbol=^nodo;
	
	nodo=record
		dato:unlp;
		HI:arbol;
		HD:arbol;
		end;

procedure generararbol (var a:arbol);
	
	procedure leeralumno (var e:unlp);
	begin
		readln (e.legajo);
		if (e.legajo <> 0) then begin
			readln (e.dni);
			readln (e.anhoingreso);
		end;
	end;
	
	procedure insertar (var a:arbol; e:unlp);
	begin
		if (a= nil) then begin
			new (a);
			a^.dato:= e;
			a^.HI:=nil;
			a^.HD:= nil;
		end
		else if (a^.dato.legajo < e.legajo) then
			insertar (a^.HD, e)
			else
				insertar (a^.HI,e);
	end;
var
	e:unlp;
begin
	a:=nil;
	leeralumno (e);
	while (e.legajo<>0) do begin
		insertar (a,e);
		leeralumno (e);
	end;
end;

procedure informarmenos (a:arbol; le:integer);
begin
	if (a<>nil) then begin
		if (a^.dato.legajo < le) then begin
			writeln (a^.dato.anhoingreso, a^.dato.dni);
			informarmenos (a^.HI, le);
			informarmenos (a^.HD, le);
		end
		else
			informarmenos (a^.HI,le);
	end;
end;

procedure informarentre (a:arbol; piso,techo:integer);
begin
	if (a<>nil) then begin
		if (a^.dato.legajo < piso) then
			informarentre (a^.HD, piso, techo)
		else if (a^.dato.legajo > techo) then
			informarentre (a^.HI, piso, techo)
			else begin
				writeln (a^.dato.anhoingreso, a^.dato.dni);
				informarentre (a^.HI,piso,techo);
				informarentre (a^.HD,piso,techo);
			end;
	end;
end;

function maximo (a:arbol; max:integer):integer;
begin
	if (a<>nil) then begin
		if (a^.dato.dni > max) then 
			max:=a^.dato.dni;
		max:= maximo (a^.HI, max);
		max:= maximo (a^.HD, max);
	end;
	maximo:= max;
end;

function cant (a:arbol): integer;
begin
	if (a<>nil) then begin
		if ((a^.dato.dni MOD 2)<> 0) then
			cant:= cant (a^.HI) +  cant (a^.HD) + 1
		else
			cant:= cant (a^.HI) +  cant (a^.HD);
	end
	else
		cant:= 0;
end;

var
	a:arbol; cantidad,max,piso,techo,le:integer;
begin
	generararbol (a);
	readln (le);
	informarmenos (a,le);
	readln (piso);
	readln (techo);
	informarentre (a,piso,techo);
	max:=0;
	max:= maximo (a,max);
	cantidad:= cant (a);
	writeln (cantidad);
end.
