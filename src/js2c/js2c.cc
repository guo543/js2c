#include <FlexLexer.h>

int main() {
  FlexLexer *flexer = new yyFlexLexer;
  flexer->yylex();
}