grammar opa;


start: 'hello' ID NUMERO';';


ID: ([a-z]|[A-Z])+;
NUMERO: ([0-9])+;
WS: [ \t\r\n]+ -> skip;