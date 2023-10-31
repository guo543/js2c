%{
#include <cstdio>
#include <cstdlib>
#include "src/scanner/scanner.h"

#undef YY_DECL
#define YY_DECL int js2c::Scanner::lex(js2c::Parser::semantic_type* yylval, js2c::Parser::location_type* loc)

using token = js2c::Parser::token;

#define YY_USER_ACTION loc->step(); loc->columns(yyleng);
%}

%option c++ noyywrap
%option yyclass="js2c::Scanner"

white_space                  [\x09\x0B\x0C\x20]

line_terminator              [\x0A\x0D]

comment                      ({multi_line_comment})|({single_line_comment})

multi_line_comment           "/*"[^*]*("*"([^*/][^*]*)?)*"*/"
single_line_comment          "//"[^\x0A\x0D]*

identifier                   [a-zA-Z$_][a-zA-Z0-9$_]*

decimal_literal              ("0"|([1-9][0-9]*))?("."[0-9]*)?(("e"|"E")("+"|"-")?[0-9]*)?

hex_integer_literal          ("0x"|"0X")[0-9a-fA-F]+
octal_integer_literal        "0"[0-7]+

string_literal               (\"{double_string_literal}\")|('{single_string_literal}')

double_string_literal        (([^\"\\\x0A\x0D])|({escape_sequence}))*
single_string_literal        (([^'\\\x0A\x0D])|({escape_sequence}))*

escape_sequence              ({character_escape_sequence})|({octal_escape_sequence})|({hex_escape_sequence})|({unicode_escape_sequence})

character_escape_sequence    \\(['\"\\bfnrt]|[^'\"\\bfnrt0-7xu\x0A\x0D])
octal_escape_sequence        (\\[0-7])|(\\[0-7][0-7])|(\\[2-3][0-7][0-7])
hex_escape_sequence          \\x[0-9a-fA-F][0-9a-fA-F]
unicode_escape_sequence      \\u[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]



%%

{white_space} {
  printf("<space>");
}

{line_terminator} {
  printf("<newline>\n");
}

{comment} {
  printf("<comment>");
}

"break" {
  printf("<break>");
  // return token::BREAK;
}

"for" {
  printf("<for>");
  // return token::FOR;
}

"new" {
  printf("<new>");
}

"var" {
  printf("<var>");
}

"continue" {
  printf("<continue>");
}

"function" {
  printf("<function>");
}

"return" {
  printf("<return>");
}

"void" {
  printf("<void>");
}

"delete" {
  printf("<delete>");
}

"if" {
  printf("<if>");
}

"this" {
  printf("<this>");
}

"while" {
  printf("<while>");
}

"else" {
  printf("<else>");
}

"in" {
  printf("<in>");
}

"typeof" {
  printf("<typeof>");
}

"with" {
  printf("<with>");
}

"=" {
  printf("<assign>");
}

">" {
  printf("<gt>");
}

"<" {
  printf("<lt>");
}

"==" {
  printf("<eq>");
}

"<=" {
  printf("<le>");
}

">=" {
  printf("<ge>");
}

"!=" {
  printf("<ne>");
}

"," {
  printf("<comma>");
}

"!" {
  printf("<not>");
}

"~" {
  printf("<bitnot>");
}

"?" {
  printf("<ques>");
}

":" {
  printf("<colon>");
}

"." {
  printf("<dot>");
}

"&&" {
  printf("<and>");
}

"||" {
  printf("<or>");
}

"++" {
  printf("<inc>");
}

"--" {
  printf("<dec>");
}

"+" {
  printf("<add>");
  // return token::ADD;
}

"-" {
  printf("<sub>");
}

"*" {
  printf("<mul>");
}

"/" {
  printf("<div>");
}

"&" {
  printf("<bitand>");
}

"|" {
  printf("<bitor>");
}

"^" {
  printf("<bitxor>");
}

"%" {
  printf("<mod>");
}

"<<" {
  printf("<bitleftshift>");
}

">>" {
  printf("<bitrightshift>");
}

">>>" {
  printf("<biturightshift>");
}

"+=" {
  printf("<addeq>");
}

"-=" {
  printf("<subeq>");
}

"*=" {
  printf("<muleq>");
}

"/=" {
  printf("<diveq>");
}

"&=" {
  printf("<bitandeq>");
}

"|=" {
  printf("<bitoreq>");
}

"^=" {
  printf("<bitxoreq>");
}

"%=" {
  printf("<modeq>");
}

"<<=" {
  printf("<bitleftshifteq>");
}

">>=" {
  printf("<bitrightshifteq>");
}

">>>=" {
  printf("<biturightshifteq>");
}

"(" {
  printf("<leftparen>");
}

")" {
  printf("<rightparen>");
}

"{" {
  printf("<leftcbrac>");
}

"}" {
  printf("<rightcbrac>");
}

"[" {
  printf("<leftbrac>");
}

"]" {
  printf("<rightbrac>");
}

";" {
  printf("<semicolon>");
}

"null" {
  printf("<null>");
}

"undefined" {
  printf("<undefined>");
}

"true" {
  printf("<true>");
}

"false" {
  printf("<false>");
}

{decimal_literal} {
  printf("<decimal: %s>", YYText());
  // char *endptr;
  // yylval->emplace<double>(strtod(YYText(), &endptr));
  // return token::NUMLIT;
}

{hex_integer_literal} {
  printf("<hex: %s>", YYText());
}

{octal_integer_literal} {
  printf("<octal: %s>", YYText());
}

{identifier} {
  printf("<id: %s>", YYText());
}

{string_literal} {
  printf("<str: %s>", YYText());
}

%%
