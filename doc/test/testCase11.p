program test;

var
	a, b: integer;

begin

	// No se produce un error porque se ignoran los caracteres especiales y las secuencias de escape
	// se procesa como la cadena (cadena sin cerrar \)
	
	write("cadena sin cerrar \");

end.