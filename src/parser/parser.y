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

%start expression

%%

primary_expression            :    THIS
                              |    IDENTIFIER
                              |    NULLLIT
                              |    UNDEFLIT
                              |    BOOLLIT
                              |    NUMLIT
                              |    STRINGLIT
                              |    LPAREN expression RPAREN
                              ;

member_expression             :    primary_expression
                              |    member_expression LBRACKET expression RBRACKET
                              |    member_expression DOT IDENTIFIER
                              |    NEW member_expression arguments
                              ;

new_expression                :    member_expression
                              |    NEW new_expression
                              ;

call_expression               :    member_expression arguments
                              |    call_expression arguments
                              |    call_expression LBRACKET expression RBRACKET
                              |    call_expression DOT IDENTIFIER
                              ;                  

arguments                     :    LPAREN RPAREN
                              |    LPAREN argument_list RPAREN
                              ;

argument_list                 :    assignment_expression
                              |    argument_list COMMA assignment_expression
                              ;

left_hand_side_expression     :    new_expression
                              |    call_expression
                              ;

postfix_expression            :    left_hand_side_expression
                              |    left_hand_side_expression INC
                              |    left_hand_side_expression DEC
                              ;

unary_expression              :    postfix_expression
                              |    DELETE unary_expression
                              |    VOID unary_expression
                              |    TYPEOF unary_expression
                              |    INC unary_expression
                              |    DEC unary_expression
                              |    ADD unary_expression
                              |    SUB unary_expression
                              |    BITNOT unary_expression
                              |    NOT unary_expression

multiplicative_expression     :    unary_expression
                              |    multiplicative_expression MUL unary_expression
                              |    multiplicative_expression DIV unary_expression
                              |    multiplicative_expression MOD unary_expression
                              ;

additive_expression           :    multiplicative_expression
                              |    additive_expression ADD multiplicative_expression
                              |    additive_expression SUB multiplicative_expression
                              ;

shift_expression              :    additive_expression
                              |    shift_expression LSHIFT additive_expression
                              |    shift_expression RSHIFT additive_expression
                              |    shift_expression URSHIFT additive_expression
                              ;

relational_expression         :    shift_expression
                              |    relational_expression LT shift_expression
                              |    relational_expression GT shift_expression
                              |    relational_expression LE shift_expression
                              |    relational_expression GE shift_expression
                              ;

equality_expression           :    relational_expression
                              |    equality_expression EQUAL relational_expression
                              |    equality_expression NE relational_expression
                              ;

bitwise_and_expression        :    equality_expression
                              |    bitwise_and_expression BITAND equality_expression
                              ;

bitwise_xor_expression        :    bitwise_and_expression
                              |    bitwise_xor_expression BITXOR bitwise_and_expression
                              ;

bitwise_or_expression         :    bitwise_xor_expression
                              |    bitwise_or_expression BITOR bitwise_xor_expression
                              ;

logical_and_expression        :    bitwise_or_expression
                              |    logical_and_expression AND bitwise_or_expression
                              ;

logical_or_expression         :    logical_and_expression
                              |    logical_or_expression OR logical_and_expression

conditional_expression        :    logical_or_expression
                              |    logical_or_expression QUES assignment_expression COLON assignment_expression
                              ;

assignment_expression         :    conditional_expression
                              |    left_hand_side_expression assignment_operator assignment_expression

assignment_operator           :    ASSIGN
                              |    MULEQ
                              |    DIVEQ
                              |    MODEQ
                              |    ADDEQ
                              |    SUBEQ
                              |    LSHIFTEQ
                              |    RSHIFTEQ
                              |    URSHIFTEQ
                              |    BITANDEQ
                              |    BITXOREQ
                              |    BITOREQ
                              ;

expression                    :    assignment_expression                 { printf("Got Expression!\n"); }
                              |    expression COMMA assignment_expression
                              ;

%%

void js2c::Parser::error(const location_type &loc, const std::string& msg) {
  std::cerr << "Error: " << msg << " at " << loc << "\n";
}