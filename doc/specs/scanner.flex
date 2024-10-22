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
fin = "fin"{ESPACIO_BLANCO}

NUMERO=[1-9][0-9]*|0

CADENA=\".*\"

COMENTARIO_EN_LINEA=\/\/[^\r\n]*

IDENTIFICADOR=[a-zA-Z][a-zA-Z0-9]*

// TODO: comentario multi linea

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
	
	"{"                	{  	return createToken(sym.ABRE_CORCHETE);	}
	
	"}"                	{  	return createToken(sym.CIERRA_CORCHETE);	}
	
	
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

	{fin} 				{}
	
	{COMENTARIO_EN_LINEA}	{}
    
    // error en caso de no coincidir con ning�n patr�n
	[^]     
                        {                                               
                           LexicalError error = new LexicalError ();
                           error.setLine (yyline + 1);
                           error.setColumn (yycolumn + 1);
                           error.setLexema (yytext ());
                           lexicalErrorManager.lexicalError (error);
                        }
    
}


                         


