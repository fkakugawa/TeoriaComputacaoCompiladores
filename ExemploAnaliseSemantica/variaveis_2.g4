grammar variaveis_2;

@header {
    import java.util.*;
}

@members {
	Variavel novaVariavel = new Variavel();
	ControleVariavel cv = new ControleVariavel();
	String codigoJava = "";
	int escopo;
	int tipo;
	String nome;
}

vai:    { escopo = 0;
		  codigoJava += "public class Codigo{\n\t";
		}
		declvar
		'inicio' { 	escopo = 1;
					codigoJava += "public static void main(String args[]){\n\t\t"; 
				 }
		declvar
		cmd
	    'fim' {codigoJava += "\t}\n}";
			   System.out.println(codigoJava);
			  }
   ;

declvar:    (
                tipo
                ID { novaVariavel = new Variavel($ID.text, tipo, escopo);
                     boolean declarado = cv.adiciona(novaVariavel);
					 if(!declarado){
					    System.err.println("Variavel "+$ID.text+" ja foi declarada!!!");
					    System.exit(0);
					 }
					 codigoJava += $ID.text;
				   }
		        PV {codigoJava += ";\n";}
		    )*
       ;

tipo:   (
            'natural'   {	tipo = 0;
							codigoJava += "int ";
						} |
            'texto'     {	tipo = 1;
							codigoJava += "String ";
						} |
            'decimal'   {tipo = 2;}
        )
   ;

cmd:    (cond |atrib)*
   ;

cond:   'se' AP comp FP AC cmd FC
		('senao' AC cmd FC )?
	;

comp:   (ID | NUM) OPREL (ID | NUM)
    ;

atrib:  ID {	boolean resultado = cv.jaExiste($ID.text);
				if(!resultado){
					System.err.println("A variavel "+$ID.text+" nao foi declarada");
					System.exit(0);
				}
			}
		PV
     ;

ID: [A-Za-z]+;
NUM: [0-9]+;
OPREL: '>' | '<' | '>=' | '<=' | '==' | '!=' ;
PV: ';' ;
AC: '{' ;
FC: '}' ;
AP: '(' ;
FP: ')' ;
Op_atrib: '=';
WS: [ \t\r\n]+ -> skip;