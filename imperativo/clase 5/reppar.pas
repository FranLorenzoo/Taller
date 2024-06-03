program parrep;
type
	julio=1..31;
	
	compra=record
		dia:julio;
		cantprod:integer;
		monto:real;
	end;
	
	lista=^nodo2;
	
	nodo2=record
		dato:compra;
		sig:lista;
		end;
	
	compra2=record
		codigocliente:integer;
		compras:lista;
	end;
	
	arbol=^nodo;
	
	nodo=record
		dato:compra2;
		HI:arbol;
		HD:arbol;
		end;
		
		
procedure generarArbol (var a:arbol);


	procedure leerdato (var c:compra; var clien:integer);
	begin
		writeln ('inserte la cantidad de productos: ');
		readln (c.cantprod);
		if (c.cantprod <>0) then begin
			writeln ('inserte el dia de la compra: ');
			readln (c.dia);
			writeln ('inserte el monto de la compra: ');
			readln (c.monto);
			writeln ('inserte el codigo del cliente: ');
			readln (clien);
		end;
	end;
	
	procedure insertarelem (var a:arbol; e:compra2; c:compra);
	var
		nue:lista;
	begin
		if (a=nil) then begin
			new (a);
			a^.dato:=e;
			a^.dato.compras:=nil;
			new (nue);
			nue^.dato:=c;
			nue^.sig:=a^.dato.compras;
			a^.dato.compras:=nue;
		end
		else begin
			if (a^.dato.codigocliente = e.codigocliente) then begin
				new (nue);
				nue^.dato:=c;
				nue^.sig:=a^.dato.compras;
				a^.dato.compras:=nue;
			end
			else begin
				if (a^.dato.codigocliente < e.codigocliente)then
					insertarelem (a^.HD, e, c)
				else
					insertarelem (a^.HI,e,c);
			end;
		end;
	end;

var
	e:compra2;
	c:compra;
begin
	a:=nil;
	leerdato (c,e.codigocliente);
	while (c.cantprod <> 0) do begin
		insertarelem (a,e,c);
		leerdato (c,e.codigocliente);
	end;
end;

function retornarconcodigo (a:arbol; codi:integer): lista;
begin
	if (a <> nil) then begin
		if (a^.dato.codigocliente = codi) then
			retornarconcodigo:= a^.dato.compras
		else begin
			if (a^.dato.codigocliente < codi) then
				retornarconcodigo (a^.HD,codi) 
			else
				retornarconcodigo (a^.HI,codi);
		end;
	end
	else
		retornarconcodigo:=nil;
end;

function retornarmonto (L:lista; max:integer; maxmon:real):real;
begin
	if (L<>nil) then begin
		if (L^.dato.cantprod > max) then begin
			max:=L^.dato.cantprod;
			maxmon:=L^.dato.monto;
		end;
		retornarmonto (L^.sig, max, maxmon);
	end;
	retornarmonto:= maxmon;
end;

procedure informarLis (L:lista);
begin
	while (L<>nil) do begin
		writeln ('cantidad de productos: ', L^.dato.cantprod, ' dia de la compra: ', L^.dato.dia, ' monto de la compra: ', L^.dato.monto);
		L:=L^.sig;
	end;
end;

var
	a:arbol;
	L:lista;
	codi:integer;
	max:integer;
	maxmon:real;
begin
	generarArbol (a);
	writeln ('inserte el codigo a buscar: ');
	readln (codi);
	L:= retornarconcodigo (a,codi);
	informarLis (L);
	max:=0; maxmon:=0;
	maxmon:= retornarmonto (L,max,maxmon);
	writeln ('el monto de la compra con mas cantidad fue: ', maxmon);
end.
