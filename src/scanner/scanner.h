#ifndef JS2C_SCANNER_H_
#define JS2C_SCANNER_H_

#include <istream>
#if !defined(yyFlexLexerOnce)
#include <FlexLexer.h>
#endif

#include "src/parser/parser.h"

namespace js2c {

class Scanner : public yyFlexLexer {
 public:
  Scanner(std::istream* in) : yyFlexLexer(in) {}

  int lex(Parser::semantic_type* yylval, Parser::location_type* loc);
};

}  // namespace js2c

#endif