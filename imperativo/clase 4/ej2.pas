program ej2;
const
	Valorimposible=9999;
type
	generos= 1..8;

	peliculas=record
		codigop:integer;
		codigog:generos;
		puntajeprom:real;
	end;
		
	lista=^nodo;
	
	nodo=record
		dato:peliculas;
		sig:lista;
		end;
	
	peliculas2=record
		codigop:integer;
		puntajeprom:real;
	end;
	
	lista2=^nodo2;
	
	nodo2=record
		dato:peliculas2;
		sig:lista2;
	end;
	
	vector=array [generos] of lista2;
	
	
procedure generarlista (var L:lista);
	procedure leerelem (var e:peliculas);
	begin	
		readln (e.codigop);
		if (e.codigop <> -1) then begin
			readln (e.codigog);
			readln (e.puntajeprom);
		end;
	end;
	
	procedure ordenado (var L:lista; e:peliculas);
	var
		nue,act,ant:lista;
	begin
		new (nue);nue^.dato:=e;nue^.sig:=nil;
		act:= L;
		while (act <>nil) and (act^.dato.codigop < e.codigop) do begin
			ant:= act;
			act:= act^.sig;
		end;
		if (L=act) then L:= nue
		else 
			ant^.sig:= nue;
		nue^.sig:= act;
	end;
var
	e:peliculas;
begin
	L:= nil;
	leerelem (e);
	while (e.codigop <> -1) do begin
		ordenado (L,e);
		leerelem (e);
	end;
end;

procedure generarvector (var v:vector; L:lista);

	procedure inicializar (var v:vector);
	var
		i:integer;
	begin
		for i:= 1 to 8 do 
			v[i]:=nil;
	end;
	
	procedure atras (var L:lista2; e:peliculas2);
	var
		nue,act:lista2;
	begin
		new (nue);nue^.dato:= e; nue^.sig:=nil;
		if (L = nil) then L:= nue
		else begin
			act := L;
			while (act^.sig<>nil) do 
				act:=act^.sig;
			act^.sig:= nue;
		end;
	end;
	
	procedure hacerdato (var e:peliculas2; aux:peliculas);
	begin
		e.codigop:=aux.codigop;
		e.puntajeprom:=aux.puntajeprom;
	end;
	
var
	e:peliculas2;
begin
	inicializar (v);
	hacerdato (e,L^.dato);
	while (L<>nil) do begin
		atras (v[L^.dato.codigog],e);
		L:=L^.sig;
		hacerdato (e,L^.dato);
	end;
end;

procedure minimo (var v:vector; var dato:peliculas);
var
	imin, i:integer;
begin
	dato.codigop:=Valorimposible;
	for i:= 1 to 8 do begin
		if (v[i]^.dato.codigop < dato.codigop) then begin
			imin:= i;
			dato.codigop:= v[i]^.dato.codigop;
			dato.puntajeprom:= v[i]^.dato.puntajeprom;
			dato.codigog:= i;
		end;
	end;
	if (dato.codigop <> Valorimposible) then
		v[imin]:= v[imin]^.sig;
end;

procedure merge (var Lnueva:lista; v:vector);
	procedure atras (var L:lista; dato:peliculas);
	var
		nue, act:lista;
	begin
		new (nue); nue^.dato:= dato; nue^.sig:= nil;
		if (L=nil) then L:= nue
		else begin
			act:= L;
			while (act^.sig <> nil) do 
				act:= act^.sig;
			act^.sig:=nue;
		end;
	end;
var
	dato:peliculas;
begin
	Lnueva:= nil;
	minimo (v,dato);
	while (dato.codigop <> Valorimposible) do begin
		atras (Lnueva, dato);
		minimo (v,dato);
	end;
end;

var
	L:lista;
	M:lista;
	v:vector;
begin
	generarlista (L);
	generarvector (v,L);
	merge (M, v);
end.
