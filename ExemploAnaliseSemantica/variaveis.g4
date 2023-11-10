grammar variaveis;

@header {
    import java.util.*;
}

@members {
	Variavel novaVariavel = new Variavel();
	ControleVariavel cv = new ControleVariavel();
	int escopo;
	int tipo;
	String nome;
}

vai:    { escopo = 0;}
		declvar
		'inicio' { escopo = 1;}
		declvar
		cmd
	    'fim'
   ;

declvar:    (
                tipo
                ID { novaVariavel = new Variavel($ID.text, tipo, escopo);
                     boolean declarado = cv.adiciona(novaVariavel);
					 if(!declarado){
					    System.err.println("Variavel "+$ID.text+" ja foi declarada!!!");
					    System.exit(0);
					 }
				   }
		        PV
		    )*
       ;

tipo:   (
            'natural'   {tipo = 0;} |
            'texto'     {tipo = 1;} |
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

atrib:  ID PV
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