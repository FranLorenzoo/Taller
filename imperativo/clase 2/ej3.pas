{.- Escribir un programa que:
a. Implemente un módulo recursivo que genere una lista de números enteros “random” mayores a 0 y menores a 100. Finalizar con el número 0.
b. Implemente un módulo recursivo que devuelva el mínimo valor de la lista. 
c. Implemente un módulo recursivo que devuelva el máximo valor de la lista. 
d. Implemente un módulo recursivo que devuelva verdadero si un valor determinado se encuentra en la lista o falso en caso contrario
}
type
lista=^nodo;
nodo=record
dato:integer;
sig:lista;
end;
procedure agregarAdelante(var l:lista;d:integer);
var
nue:lista;
begin
new(nue);
nue^.dato:=d;
nue^.sig:=l;
l:=nue;
end;
procedure CargarListRecursivo (var l:lista);
var
numero:integer;
begin
numero:=random(100);
if(numero<>0)then begin
agregarAdelante(l,numero);
CargarListRecursivo(l);
end;
end;
procedure mostrarLista(l:lista);
var
num:integer;
begin
num:=0;
while (l<>nil)do begin
	writeln(l^.dato);
	num:=num+1;
	l:=l^.sig;
end;
writeln('cantidad de numeros :',num);
end;

function minimo (min:integer;l:lista):integer;
begin
	if (l<>nil) then begin
		if (min > l^.dato) then 
			min:= l^.dato;
		min:= minimo (min,l^.sig);
	end;
	minimo:= min;
end;

function estaOno (l:lista;numero:integer):boolean;
begin
if(l<>nil)and(l^.dato<>numero)
then begin
	if(l^.dato=numero)then estaOno:=true
  else if(l<>nil) then  estaOno:=estaOno(l^.sig,numero);
end;
if (l = nil) then estaOno:= false;
end;
var
l:lista;
min:integer;
nume:integer;
begin
min:=101;
randomize;
l:=nil;
CargarListRecursivo(l);
mostrarLista(l);
writeln ('capo el minimo es: ',minimo (min,l));
readln (nume);
writeln (estaOno (l,nume));
end.
