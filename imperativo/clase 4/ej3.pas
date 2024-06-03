program ej3;
const
	valorimp=30000;
type
	sucursales=1..4;
	
	ventas=record
		codigoprod:integer;
		codigosuc:integer;
		fecha:string;
		cantidadven:integer;
		end;
		
	lista=^nodo;
	
	nodo=record
		dato:ventas;
		sig:lista;
	end;
	
	librerias=array [sucursales] of lista;
	
	acumulador=record
		codigop:integer;
		totalven:integer;
	end;
	
	lista2=^nodo2;
	
	nodo2=record
		dato:acumulador;
		sig:lista2;
		end;
	
procedure generarveclis (var v:librerias);

	procedure inicializar (var v:librerias);
	var 
		i:integer;
	begin
		for i:= 1 to 4 do 
			v [i]:=nil;
	end;

	procedure ordenado (var L:lista; e:ventas);
	var
		nue, act, ant:lista;
	begin
		new (nue); nue^.dato:= e; nue^.sig:= nil;
		act:= L;
		while (act<> nil) and (act^.dato.codigoprod < e.codigoprod) do begin
			ant:= act;
			act:= act^.sig;
		end;
		if (L = act) then L:= nue
		else
			ant^.sig:= nue;
		nue^.sig:= act;
	end;
	
	procedure leerventa (var e:ventas);
	begin
		readln (e.codigosuc);
		if (e.codigosuc <> 0) then begin
			readln (e.codigoprod);
			readln (e.fecha);
			readln (e.cantidadven);
		end;
	end;

var
	e:ventas;
begin
	inicializar (v);
	leerventa (e);
	while (e.codigosuc <> 0) do begin 
		ordenado (v [e.codigosuc],e);
		leerventa (e);
	end;
end;

procedure minimo (v:librerias; var e:ventas);
var
	i,imin:integer;
begin
	e.codigoprod:=valorimp;
	for i:= 1 to 4 do begin
		if (v[i]^.dato.codigoprod<e.codigoprod) then begin
			imin:= i;
			e:=v[i]^.dato;
		end;
	end;
	if (e.codigoprod <> valorimp) then
		v[imin]:=v[imin]^.sig;
end;

procedure Mergeac (v:librerias; var l:lista2);

	procedure atras (var l:lista2; e:acumulador);
	var
		nue,act:lista2;
	begin
		new (nue); nue^.dato:=e; nue^.sig:=nil;
		if (l = nil) then l:= nue
		else begin
			act:=l;
			while (act^.sig <> nil) do 
				act:= act^.sig;
			act^.sig:=nue;
		end;
	end;

var
	e:acumulador;
	act:ventas;
begin
	l:=nil;
	minimo (v,act);
	while (act.codigoprod <> valorimp) do begin
		e.codigop:= act.codigoprod;
		while (e.codigop = act.codigoprod) do begin
			e.totalven:= act.cantidadven;
			minimo (v,act);
		end;
	atras (l,e);
	end;
end;

var
	l:lista2;
	v:librerias;
begin
	generarveclis (v);
	Mergeac (v,l);
end.
