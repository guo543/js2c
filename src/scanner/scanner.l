%{
  #include <cstdio>
%}

%option noyywrap

white_space [\x09\x0B\x0C\x20]

line_terminator [\x0A\x0D]

comment ({multi_line_comment}|{single_line_comment})

multi_line_comment "/*"[^*]*("*"([^*/][^*]*)?)*"*/"
single_line_comment "//"[^\x0A\x0D]*

identifier [a-zA-Z$_][a-zA-Z0-9$_]*

decimal_literal ("0"|([1-9][0-9]*))?("."[0-9]*)?(("e"|"E")("+"|"-")?[0-9]*)?

hex_integer_literal ("0x"|"0X")[0-9a-fA-F]+
octal_integer_literal "0"[0-7]+

string_literal a

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
}

"for" {
  printf("<for>");
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

"true" {
  printf("<true>");
}

"false" {
  printf("<false>");
}

{decimal_literal} {
  printf("<decimal: %s>", yytext);
}

{hex_integer_literal} {
  printf("<hex: %s>", yytext);
}

{octal_integer_literal} {
  printf("<octal: %s>", yytext);
}

{identifier} {
  printf("<id: %s>", yytext);
}

%%