grammar aula;

@header { import java.util.*; }
@members{
	Print interCode = new Print();
}

start: 	'inicio' {System.out.print(interCode.printInicio());}
		declare
		comando
		'fim' {System.out.print(interCode.printFim());};

comando: 	ID {System.out.print($ID.text+" ");}
			Op_atrib {System.out.print($Op_atrib.text+" ");} 
			(NUM {System.out.print($NUM.text);} | ID {System.out.print($ID.text);})
			PV {System.out.print($PV.text+" ");};
			
declare: 	'numero' {System.out.print("\nint ");}
			ID {System.out.print($ID.text+";\n");}
			PV;

ID: [a-z]([a-z]|[A-Z]|[0-9])*;
NUM: [0-9]+;
Op_atrib: '=';
PV: ';' ;
WS: [ \t\r\n]+ -> skip;