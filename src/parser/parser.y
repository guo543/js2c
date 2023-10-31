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

%token <int> BREAK
%token FOR

%%

program    : %empty
           | BREAK FOR    { printf("Got break and for!\n"); }

%%

void js2c::Parser::error(const location_type &loc, const std::string& msg) {
  std::cerr << "Error: " << msg << " at " << loc << "\n";
}