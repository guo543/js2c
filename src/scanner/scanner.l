%{
#include <iostream>
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

{white_space} {}

{line_terminator} {}

{comment} {}

"break" { return token::BREAK; }

"for" { return token::FOR; }

"new" { return token::NEW; }

"var" { return token::VAR; }

"continue" { return token::CONTINUE; }

"function" { return token::FUNCTION; }

"return" { return token::RETURN; }

"void" { return token::VOID; }

"delete" { return token::DELETE; }

"if" { return token::IF; }

"this" { return token::THIS; }

"while" { return token::WHILE; }

"else" { return token::ELSE; }

"in" { return token::IN; }

"typeof" { return token::TYPEOF; }

"with" { return token::WITH; }

"=" { return token::ASSIGN; }

">" { return token::GT; }

"<" { return token::LT; }

"==" { return token::EQUAL; }

"<=" { return token::LE; }

">=" { return token::GE; }

"!=" { return token::NE; }

"," { return token::COMMA; }

"!" { return token::NOT; }

"~" { return token::BITNOT; }

"?" { return token::QUES; }

":" { return token::COLON; }

"." { return token::DOT; }

"&&" { return token::AND; }

"||" { return token::OR; }

"++" { return token::INC; }

"--" { return token::DEC; }

"+" { return token::ADD; }

"-" { return token::SUB; }

"*" { return token::MUL; }

"/" { return token::DIV; }

"&" { return token::BITAND; }

"|" { return token::BITOR; }

"^" { return token::BITXOR; }

"%" { return token::MOD; }

"<<" { return token::LSHIFT; }

">>" { return token::RSHIFT; }

">>>" { return token::URSHIFT; }

"+=" { return token::ADDEQ; }

"-=" { return token::SUBEQ; }

"*=" { return token::MULEQ; }

"/=" { return token::DIVEQ; }

"&=" { return token::BITANDEQ; }

"|=" { return token::BITOREQ; }

"^=" { return token::BITXOREQ; }

"%=" { return token::MODEQ; }

"<<=" { return token::LSHIFTEQ; }

">>=" { return token::RSHIFTEQ; }

">>>=" { return token::URSHIFTEQ; }

"(" { return token::LPAREN; }

")" { return token::RPAREN; }

"{" { return token::LCBRACKET; }

"}" { return token::RCBRACKET; }

"[" { return token::LBRACKET; }

"]" { return token::RBRACKET; }

";" { return token::SEMICOLON; }

"null" { return token::NULLLIT; }

"undefined" { return token::UNDEFLIT; }

"true" { yylval->emplace<bool>(true); return token::BOOLLIT; }

"false" { yylval->emplace<bool>(false); return token::BOOLLIT; }

{decimal_literal} {
  char *endptr;
  yylval->emplace<double>(strtod(YYText(), &endptr));
  std::cout << strtod(YYText(), &endptr) << "\n";
  return token::NUMLIT;
}

{hex_integer_literal} {
  char *endptr;
  yylval->emplace<double>(strtod(YYText(), &endptr));
  std::cout << strtod(YYText(), &endptr) << "\n";
  return token::NUMLIT;
}

{octal_integer_literal} {
  char *endptr;
  yylval->emplace<double>(strtod(YYText(), &endptr));
  std::cout << strtod(YYText(), &endptr) << "\n";
  return token::NUMLIT;
}

{identifier} {
  yylval->emplace<std::string>(yytext);
  return token::IDENTIFIER;
}

{string_literal} {
  char* str = strdup(YYText() + 1);
  str[strlen(str) - 1] = '\0';
  yylval->emplace<std::string>(str);
  return token::STRINGLIT;
}

%%
