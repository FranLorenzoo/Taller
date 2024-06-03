program ej4;
const
	valorim=30000;
type
	rango=1..7;
	
	funciones=record
		codigoO:integer;
		asiento:integer;
		monto:real;
	end;
	
	lista=^nodo;
	
	nodo=record
		dato:funciones;
		sig:lista;
	end;
	
	listas=array [rango] of lista;

	fun=record
		total:integer;
		codigoO:integer;
	end;
	
	lista2=^nodo2;
	
	nodo2=record
		dato:fun;
		sig:lista2;
	end;

procedure generarlista (var v:listas);

	procedure inici (var v:listas);
	var
		i:integer;
	begin
		for i:= 1 to 7 do
			v[i]:=nil;
	end;
	
	procedure ordenado (var L:lista; e:funciones);
	var
		nue,act,ant:lista;
	begin
		new (nue); nue^.dato:= e; nue^.sig:=nil;
		act:=L;
		while (act<>nil) and (act^.dato.codigoO < e.codigoO) do begin
			ant:=act;
			act:=act^.sig;
		end;
		if (act=L) then L:=nue
		else
			ant^.sig:=nue;
		nue^.sig:=act;
	end;
	
	procedure leerdato (var e:funciones; var x:rango);
	begin
		readln (e.codigoO);
		if (e.codigoO <> 0) then begin
			readln (e.asiento);
			readln (e.monto);
			readln (x);
		end;
	end;
var
	e:funciones;x:rango;
begin
	inici (v);
	leerdato (e,x);
	while (e.codigoO<> 0) do begin
		ordenado (v[x],e);
		leerdato (e,x);
	end;
end;

procedure minimo (var v:listas; var e:funciones);
var
	i,imin:integer;
begin
	e.codigoO:=valorim;
	for i:= 1 to 7 do begin
		if (e.codigoO > v[i]^.dato.codigoO) then begin
			e:=v[i]^.dato;
			imin:=i;
		end;
	end;
	if (e.codigoO <> valorim) then
		v[imin]:=v[imin]^.sig;
end;

procedure Mergeac (var L:lista2; v:listas);

	procedure atras (var L:lista2; e:fun);
	var
		nue,act:lista2;
	begin
		new (nue); nue^.dato:=e; nue^.sig:=nil;
		if (L=nil) then L:=nue
		else begin
			act:=L;
			while (act^.sig <> nil) do
				act:=act^.sig;
			act^.sig:= nue;
		end;
	end;
	
var
	act:funciones;
	e:fun;
begin
	L:=nil;
	minimo (v,act);
	while (act.codigoO <> valorim) do begin
		e.codigoO:= act.codigoO; e.total:=0;
		while (e.codigoO = act.codigoO) do begin
			e.total:= e.total + 1;
			minimo (v,act);
		end;
		atras (L,e);
	end;
end;

procedure informarRec (L:lista2);
begin
	while (L<> nil ) do begin
		writeln (L^.dato.codigoO, L^.dato.total);
		informarRec (L^.sig);
	end;
end;

var
	v:listas; L:lista2;
begin
	generarlista(v);
	Mergeac (L,v);
	informarRec (L);
end.
