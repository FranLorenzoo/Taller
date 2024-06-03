program ej2;
type
	venta=record
		codigop:integer;
		cant:integer;
		fecha:string [15];
		end;
		
	ventas=record
		total:integer;
		prod:integer;
		end;
	
	arbol=^hoja;
	
	hoja=record
		dato:venta;
		HI:arbol;
		HD:arbol;
		end;
		
	arbol2=^hoja2;
	
	hoja2=record
		dato:ventas;
		HI:arbol2;
		HD:arbol2;
		end;

procedure generarArbol (var a:arbol);
	
	procedure leerdato (var e:venta);
	begin
		readln (e.codigop);
		if (e.codigop<>0) then begin
			readln (e.cant);
			readln (e.fecha);
		end;
	end;
	
	procedure cargarH(var a:arbol; e:venta);
	begin
		if (a=nil) then begin
			new (a);
			a^.dato:=e;
			a^.HI:=nil;
			a^.HD:=nil;
		end
		else if (a^.dato.codigop < e.codigop) then
			cargarH (a^.HD,e)
		else
			cargarH (a^.HI,e);
	end;
var
	e:venta;
begin
	a:= nil;
	leerdato (e);
	while (e.codigop<>0) do begin
		cargarH (a,e);
		leerdato (e);
	end;
end;

procedure generarArbol2(var a2:arbol2; a:arbol);
	procedure cargarA (var a2:arbol2; e:ventas);
	begin
		if (a=nil) then begin
			new (a);
			a2^.dato:=e;
			a2^.HI:=nil;
			a2^.HD:=nil;
		end
		else if (a2^.dato.prod < e.prod) then
			cargarA (a2^.HD,e)
		else
			cargarA (a2^.HI,e);
	end;
	
var
	e2:ventas; 
begin
	if (a<>nil) then begin
		e2.prod:= a^.dato.codigop;
		if (a^.dato.codigop = e2.prod) then begin
			e2.total:= e2.total + a^.dato.cant;  
			generarArbol2 (a2, a^.HI);  
			generarArbol2 (a2, a^.HD);
			end
		else
			e2.total:= 0;
	end;
	cargarA (a2,e2);
	generarArbol2 (a2,a);
end;

function informar2 (prod:integer ; a2:arbol2): integer;
begin
	if (a2<>nil) then begin
		if (a2^.dato.prod < prod) then
			informar2:= informar2 (prod, a2^.HD)
		else if (a2^.dato.prod > prod) then
			informar2:= informar2 (prod, a2^.HI)
		else if (a2^.dato.prod = prod) then
			informar2:= a2^.dato.total;
		end
	else
		informar2:= 0;
end;

function informar (prod:integer; a:arbol): integer;
begin
	if (a<>nil) then begin
		if (a^.dato.codigop < prod) then
			informar:= informar (prod, a^.HD)
		else if (a^.dato.codigop > prod) then
			informar:= informar (prod, a^.HI)
		else if (a^.dato.codigop = prod) then
			informar:= a^.dato.cant + informar (prod, a^.HI) + informar (prod, a^.HD);
		end
	else
		informar:= 0;
end;

var
	a:arbol; a2:arbol2;
	codb,codb2:integer;
begin
	generarArbol (a);
	a2:= nil;
	generarArbol2 (a2,a);
	readln (codb);
	writeln  (informar (codb,a));
	readln (codb2);
	codb2:= informar2 (codb2,a2);
	if (codb2 = 0) then
		writeln ('codigo inexistente')
	else
		writeln (codb2);
end.
