program conErrorSintactico;

var
	a, b: integer;

begin

	// Error sintactico porque tiene una expresion ambigua (dos expresiones asociativas del mismo nivel)
	
	if (a > b <> 10) then
		write("true");
	else
		write("false");
end.