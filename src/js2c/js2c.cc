#include <FlexLexer.h>

#include "src/scanner/token.h"

using namespace js2c::scanner;

int main() {
  FlexLexer *flexer = new yyFlexLexer;
  flexer->yylex();
}