Program ej4;
const
	valorimp=30000;
type
	dias=1..7;
	
	entradas=record
		codigoO:integer;
		asiento:integer;
		monto:real;
		end;
	
	lista=^nodo;
	
	nodo=record
		dato:entradas;
		sig:lista;
	end;
	
	obras=array [dias] of lista;
	
	daton=record
		totven:integer;
		codigoO:integer;
		end;

	lista2=^nodo2;
	
	nodo2=record
		dato:daton;
		sig:lista2;
	end;
	
procedure generarlistas (var v:obras);

	procedure ini(var v:obras);
	var
		i:integer;
	begin
		for i:= 1 to 7 do
			v[i]:=nil;
	end;
	
	procedure leerdato (var e:entradas; var d:dias);
	begin
		readln (e.codigoO);
		if (e.codigoO<> 0) then begin
			readln (e.monto);
			readln (e.asiento);
			readln (d);
		end;
	end;
	
	procedure ordenado (var l:lista; e:entradas);
	var
		act,ant,nue:lista;
	begin
		new (nue); nue^.dato:=e; nue^.sig:=nil;
		act:=L;
		while (act<>nil) and (act^.dato.codigoO < e.codigoO) do begin
			ant:=act;
			act:=act^.sig;
		end;
		if (L=act) then L:=nue
		else
			ant^.sig:=nue;
		nue^.sig:=act;
	end;
	
var
	d:dias; e:entradas;
begin
	ini (v);
	leerdato (e,d);
	while (e.codigoO <> 0) do begin
		ordenado (v[d],e);
		leerdato (e,d);
	end;
end;

procedure minimo (var v:obras; var e:entradas);
var
	i,imin:integer;
begin
	e.codigoO:=valorimp;
	for i:= 1 to 7 do begin
		if (v[i]^.dato.codigoO < e.codigoO) then begin
			v[i]^.dato:= e;
			imin:=i;
		end;
	end;
	if (e.codigoO <> valorimp) then 
		v[imin]:= v[imin]^.sig;
end;

procedure mergeac (v:obras; var L:lista2);
	procedure atras (var L:lista2; e:daton);
	var
		nue,act:lista2;
	begin
		new (nue);
		nue^.dato:=e;
		nue^.sig:=nil;
		if (L=nil) then L:=nue
		else begin
			act:=L;
			while (act^.sig <> nil) do 
				act:=act^.sig;
			act^.sig:=nue;
		end;
	end;
	
var
	e:daton;
	act:entradas;
begin
	L:=nil;
	minimo (v,act);
	while (act.codigoO <> valorimp) do begin
		e.codigoO:=act.codigoO; e.totven:=0;
		while (e.codigoO = act.codigoO) do begin
			e.totven:= e.totven +1;
			minimo (v,act);
		end;
		atras (L,e);
	end;
end;

var
	v:obras;
	L:lista2;
begin
	generarlistas (v);
	mergeac (v,L);
end.
