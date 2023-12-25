grammar prog;

prog:
    (headerDeclaration | variableDeclaration | functionDeclaration | controlFlowStatement | expressionStatement | functionCall | returnStatement)+
;

headerDeclaration:
    '#include<' STRING '>'
;

variableDeclaration:
    dataType variableName (ASSIGN expression)? SEMICOLON
;

functionDeclaration:
    dataType functionName LPAREN parameters? RPAREN compoundStatement
;

controlFlowStatement:
    ifElseStatement
    | forLoop
    | whileLoop
;

expressionStatement:
    expression SEMICOLON
;

ifElseStatement:
    'if' LPAREN expression RPAREN compoundStatement ('else' compoundStatement)?
;

forLoop:
    'for' LPAREN (variableDeclaration | expression | ';') expression? ';' (expressionStatement | variableName INCREMENT | variableName DECREMENT) RPAREN compoundStatement
;

whileLoop:
    'while' LPAREN expression RPAREN compoundStatement
;

functionCall:
    functionName LPAREN functionParameters? RPAREN
;

returnStatement:
    'return' expression? SEMICOLON
;

compoundStatement:
    LBRACE (functionCall | returnStatement | variableDeclaration | controlFlowStatement | expressionStatement)* RBRACE
;

dataType:
    'int'
    | 'float'
    | 'double'
    | 'string'
;

parameters:
    dataType variableName (COMMA dataType variableName)*
;

functionParameters:
    expression (COMMA expression)*
;

expression:
    functionCall
    | expression logicalOperator expression
    | expression arithmeticOperator expression
    | expression relationalOperator expression
    | variableName
    | STRING
    | NUMBER
    | LPAREN expression RPAREN
    | variableName INCREMENT
    | variableName DECREMENT
;

variableName:
    IDENTIFIER
;

functionName:
    IDENTIFIER
;

logicalOperator:
    '&&'
    | '||'
;

arithmeticOperator:
    '+'
    | '-'
    | '*'
    | '/'
;

relationalOperator:
    '>'
    | '<'
    | '>='
    | '<='
    | '=='
    | '!='
;

ASSIGN: '=';
INCREMENT: '++';
DECREMENT: '--';
COMMA: ',';
SEMICOLON: ';';
LPAREN: '(';
RPAREN: ')';
LBRACE: '{';
RBRACE: '}';

STRING: '"' ~('"')* '"';
IDENTIFIER: [a-zA-Z_] [a-zA-Z0-9_]*;
NUMBER: [0-9]+ ('.' [0-9]+)?;

WS: [ \t\r\n]+ -> skip;
