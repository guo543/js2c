%{
#include <iostream>
#include <FlexLexer.h>
%}

%require "3.2"
%language "C++"

%define api.parser.class {Parser}
%define api.namespace {js2c}

%code requires
{
  namespace js2c {
    class Scanner;
  }  // namespace js2c
}

%parse-param {Scanner* scanner}

%code {
  #include "src/scanner/scanner.h"
  #define yylex scanner->lex
}

%define api.value.type variant
%define parse.assert

%locations
%define api.location.file none

%token BREAK
%token FOR
%token NEW
%token VAR
%token CONTINUE
%token FUNCTION
%token RETURN
%token VOID
%token DELETE
%token IF
%token THIS
%token WHILE
%token ELSE
%token IN
%token TYPEOF
%token WITH
%token ASSIGN
%token GT
%token LT
%token EQUAL
%token LE
%token GE
%token NE
%token COMMA
%token NOT
%token BITNOT
%token QUES
%token COLON
%token DOT
%token AND
%token OR
%token INC
%token DEC
%token ADD
%token SUB
%token MUL
%token DIV
%token BITAND
%token BITOR
%token BITXOR
%token MOD
%token LSHIFT
%token RSHIFT
%token URSHIFT
%token ADDEQ
%token SUBEQ
%token MULEQ
%token DIVEQ
%token BITANDEQ
%token BITOREQ
%token BITXOREQ
%token MODEQ
%token LSHIFTEQ
%token RSHIFTEQ
%token URSHIFTEQ
%token LPAREN
%token RPAREN
%token LCBRACKET
%token RCBRACKET
%token LBRACKET
%token RBRACKET
%token SEMICOLON
%token NULLLIT
%token UNDEFLIT
%token <bool> BOOLLIT
%token <double> NUMLIT
%token <std::string> IDENTIFIER
%token <std::string> STRINGLIT

%nterm <double> equation

%%

program     : %empty
            | equation { printf("Result: %.2lf\n", $1); }

equation    : NUMLIT ADD NUMLIT { printf("got equation"); $$ = 1.2; }

%%

void js2c::Parser::error(const location_type &loc, const std::string& msg) {
  std::cerr << "Error: " << msg << " at " << loc << "\n";
}