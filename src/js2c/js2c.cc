#include "src/parser/parser.h"
#include "src/scanner/scanner.h"

int main(int argc, char* argv[]) {
  js2c::Scanner scanner(&std::cin);
  js2c::Parser parser(&scanner);
  parser.parse();
}