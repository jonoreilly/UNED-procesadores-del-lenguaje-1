package compiler.lexical;

import compiler.syntax.sym;
import compiler.lexical.Token;
import es.uned.lsi.compiler.lexical.ScannerIF;
import es.uned.lsi.compiler.lexical.LexicalError;
import es.uned.lsi.compiler.lexical.LexicalErrorManager;

// incluir aqui, si es necesario otras importaciones

%%
 
%public
%class Scanner
%char
%line
%column
%cup
%unicode

// Este lenguaje NO es sensible a las mayusculas
%caseless


%implements ScannerIF
%scanerror LexicalError

// incluir aqui, si es necesario otras directivas

%{

  LexicalErrorManager lexicalErrorManager = new LexicalErrorManager ();
  
  private int commentCount = 0;
  
  public Token createToken(int tokenId) {
  
		Token token = new Token(tokenId);
		
        token.setLine(yyline + 1);
        
        token.setColumn(yycolumn + 1);
        
        token.setLexema(yytext());
		
		return token;
  
  }
  
%}  
  

ESPACIO_BLANCO=[ \t\r\n\f]

NUMERO=[1-9][0-9]*|0

CADENA=\".*\"

COMENTARIO_EN_LINEA=\/\/[^\r\n]*

IDENTIFICADOR=[^0-9 \t\r\n\f\"\+\-\*\/\.\,\;\:\=\>\<\(\)\[\]\{\}][^ \t\r\n\f\"\+\-\*\/\.\,\;\:\=\>\<\(\)\[\]\{\}]*

ABRE_COMENTARIO_MULTI_LINEA="{"

CIERRA_COMENTARIO_MULTI_LINEA="}"

%state COMENTARIO_MULTI_LINEA

%%

<YYINITIAL> 
{
           			       
	"+"                	{	return createToken(sym.MAS);	}
                    	
	"-"                	{ 	return createToken(sym.MENOS);	}
	
	"*"                	{ 	return createToken(sym.POR);	}
	
	"/"                	{ 	return createToken(sym.ENTRE);	}
	
	"."                	{ 	return createToken(sym.PUNTO);	}
	
	","                	{ 	return createToken(sym.COMA);	}
	
	";"                	{ 	return createToken(sym.PUNTO_Y_COMA);	}
	
	":"                	{  	return createToken(sym.DOS_PUNTOS);	}
	
	"="                	{  	return createToken(sym.IGUAL);	}
	
	":="                {  	return createToken(sym.ASIGNACION);	}
	
	".."                {  	return createToken(sym.RANGO);	}
	
	">"                	{  	return createToken(sym.MAYOR);	}
	
	"<>"                {  	return createToken(sym.DISTINTO);	}
	
	"("                	{  	return createToken(sym.ABRE_PARENTESIS);	}
	
	")"                	{  	return createToken(sym.CIERRA_PARENTESIS);	}
	
	"["                	{  	return createToken(sym.ABRE_VECTOR);	}
	
	"]"                	{  	return createToken(sym.CIERRA_VECTOR);	}
	
	
	"begin"             {  	return createToken(sym.BEGIN);	}
	
	"end"               {  	return createToken(sym.END);	}
	
	"function"          {  	return createToken(sym.FUNCTION);	}
	
	"procedure"         {  	return createToken(sym.PROCEDURE);	}
	
	"program"           {  	return createToken(sym.PROGRAM);	}
	
	"if"                {	return createToken(sym.IF);	}
	
	"then"              {  	return createToken(sym.THEN);	}
	
	"else"              {  	return createToken(sym.ELSE);	}
	
	"repeat"            {  	return createToken(sym.REPEAT);	}
	
	"until"             {  	return createToken(sym.UNTIL);	}
		
	"type"              {  	return createToken(sym.TYPE);	}
	
	"set"               {  	return createToken(sym.SET);	}
	
	"const"             {  	return createToken(sym.CONST);	}
	
	"var"               {  	return createToken(sym.VAR);	}
	
	"boolean"           {  	return createToken(sym.BOOLEAN);	}
	
	"integer"           {  	return createToken(sym.INTEGER);	}
	
	"true"              {  	return createToken(sym.TRUE);	}
	
	"false"             {  	return createToken(sym.FALSE);	}
	
	"in"                {  	return createToken(sym.IN);	}
	
	"of"                {  	return createToken(sym.OF);	}
	
	"or"                {  	return createToken(sym.OR);	}
	
	"write"             {  	return createToken(sym.WRITE);	}
	
	
	{NUMERO}			{	return createToken(sym.NUMERO);	}
	
	{CADENA}			{	return createToken(sym.CADENA);	}
	
	{IDENTIFICADOR}		{	return createToken(sym.IDENTIFICADOR);	}
	

   	{ESPACIO_BLANCO}	{}
	
	{COMENTARIO_EN_LINEA}	{}
	
	
	{ABRE_COMENTARIO_MULTI_LINEA} {
	
							commentCount = 1;
	
							yybegin(COMENTARIO_MULTI_LINEA);
	
						}
	
    
    // error en caso de no coincidir con ning�n patr�n
	[^]     
                        {                                               
                           LexicalError error = new LexicalError ("Token no identificado");
                           error.setLine (yyline + 1);
                           error.setColumn (yycolumn + 1);
                           error.setLexema (yytext ());
                           lexicalErrorManager.lexicalError (error);
                        }
    
}


<COMENTARIO_MULTI_LINEA>
{

	{ABRE_COMENTARIO_MULTI_LINEA} { commentCount++; }
	
	{CIERRA_COMENTARIO_MULTI_LINEA} {
								
								commentCount--;
								
								if (commentCount <= 0) {
									
									yybegin(YYINITIAL);
									
								}
								
							}
							
							
	// TODO: explicar porq usamos EOF y no \r\f
	<<EOF>>	  			{ 
                           LexicalError error = new LexicalError ("Comentario no cerrado");
                           error.setLine (yyline + 1);
                           error.setColumn (yycolumn + 1);
                           error.setLexema (yytext ());
                           lexicalErrorManager.lexicalError (error);
                           
                           return null;
                       	}
							
	[^] 				{}

}

                         


