program ej2;
type
	anios=2010..2018;

	auto=record
		patente:integer;
		anio:anios;
		marca:string;
		modelo:string;
		end;
		
	arbol=^nodo;

	nodo=record
		dato:auto;
		HI:arbol;
		HD:arbol;
	end;
	
	nuevoa=record
		patente:integer;
		marca:string;
		modelo:string;
	end;
	
	lista=^nodo2;
	
	nodo2=record
		dato:nuevoa;
		sig:lista;
	end;
	
	vec=array [anios] of lista;
	
procedure garbol (var a:arbol);

	procedure leerdato (var e:auto);
	begin
		writeln ('ingrese la patente ');
		readln (e.patente);
		if (e.patente <> 0) then begin
			writeln ('ingrese el año de fabricacion ');
			readln (e.anio);
			writeln ('ingrese la marca');
			readln (e.marca);
			writeln ('ingrese el modelo de auto ');
			readln (e.modelo);
		end;
	end;

	procedure cargarnodo (var a:arbol; e:auto); 
	begin
		if (a=nil) then begin
			new (a);
			a^.dato:=e;
			a^.HI:=nil;
			a^.HD:= nil;
		end
		else begin
			if (a^.dato.patente < e.patente) then
				cargarnodo (a^.HD,e)
			else
				cargarnodo (a^.HI,e);
		end;
	end;

var
	e:auto;
begin
	leerdato (e);
	a:=nil;
	while (e.patente <> 0) do begin
		cargarnodo (a,e);
		leerdato (e);
	end;
end;

function cantidadMar (a:arbol ;  marca:string;canti:integer) : integer;
begin
	if (a<>nil) then begin
		if (a^.dato.marca = marca) then
			cantidadMar:= cantidadMar(a^.HI ,marca,canti) + cantidadMar (a^.HD ,marca,canti) + 1 
		else
			cantidadMar:= cantidadMar(a^.HI ,marca,canti) + cantidadMar (a^.HD ,marca,canti);
	end;
end;

procedure inicializar (var v:vec);
var
	i:integer;
begin;
	for i:= 2010 to 2018 do
		v[i]:=nil;
end;

procedure generarnuevaE (a:arbol; var v:vec);
	
	procedure insertar (L:lista; e:nuevoa);
	var
		nue,act:lista;
	begin
		new (nue); nue^.dato:=e; nue^.sig:=nil;
		if (L=nil) then
			L:=nue
		else begin
			act:=L;
			while (act^.sig<>nil) do
				act:=act^.sig;
			act^.sig:=nue;
		end;
	end;

var
	e:nuevoa;
begin
	if (a<>nil) then begin
		e.patente:=a^.dato.patente;e.marca:=a^.dato.marca;e.modelo:=a^.dato.modelo;
		insertar (v[a^.dato.anio],e);
		generarnuevaE (a^.HI,v);
		generarnuevaE (a^.HD,v);
	end;
end;

function devuelvoA (a:arbol; paten:integer):integer;
begin
	if (a <>nil) and (a^.dato.patente <> paten) then begin
		devuelvoA (a^.HI,paten);
		devuelvoA (a^.HD,paten);
	end
	else begin
		if (a^.dato.patente = paten) then devuelvoA:=a^.dato.anio
		else
			devuelvoA:=0;
	end;
end;

var
	a:arbol;
	paten,canti:integer;
	marca:string;
	v:vec;
begin
	garbol (a);
	writeln ('ingrsar marca a buscar ');
	readln (marca);
	canti:=0;
	writeln ('la cantidad de autos de esta marca son: ', cantidadMar (a,marca,canti));
	inicializar (v);
	generarnuevaE(a,v);
	writeln ('inserte la patente que buscaba: ');
	readln (paten);
	writeln ('el año de fabricacion del auto de patente ', paten,' es: ', devuelvoA (a,paten)); 
end.
