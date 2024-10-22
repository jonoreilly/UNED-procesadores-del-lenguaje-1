// subprogramas 

program prueba;



var
        z: integer;


procedure imprime_incrementa (x:integer);

  
        begin
            x:= x+1;     
	    write(x);       
        end;

begin

      write ("SUBPROGRAMAS PROCEDIMIENTOS");
 

      z:=1;
      write("z(2):");
      imprime_incrementa (z);

end.
