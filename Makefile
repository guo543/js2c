CXX = g++

OUTDIR = out
OBJDIR = $(OUTDIR)/objs

CXXDEBUG = -g
INCDIR = -I.
LIBDIR = -L$(OUTDIR)
LDLIBS = -lfl -ljs2c
CXXFLAGS = -Wall -Werror -std=c++11

AR = ar
ARFLAGS = rcs

FLEX = flex
BISON = bison

LIBJS2C = libjs2c
JS2C = js2c

TARGETS = $(LIBJS2C) $(JS2C)

OBJDIRS = $(OBJDIR)/scanner $(OBJDIR)/parser $(OBJDIR)/js2c

FLEX_SRCS = src/scanner/scanner.l
FLEX_SRCS_CC = src/scanner/scanner.cc

SCANNER_SRCS = $(wildcard src/scanner/*.cc) $(FLEX_SRCS_CC)
SCANNER_OBJS = $(patsubst src%, $(OBJDIR)%, $(patsubst %.cc, %.o, $(SCANNER_SRCS)))

BISON_SRCS = src/parser/parser.y
BISON_SRCS_H = src/parser/parser.h
BISON_SRCS_CC = src/parser/parser.cc

PARSER_SRCS = $(wildcard src/parser/*.cc) $(BISON_SRCS_CC)
PARSER_OBJS = $(patsubst src%, $(OBJDIR)%, $(patsubst %.cc, %.o, $(PARSER_SRCS)))

FLEX_BISON_GENERATED = $(FLEX_SRCS_CC) $(BISON_SRCS_H) $(BISON_SRCS_H_LOC) $(BISON_SRCS_CC)

LIBJS2C_OBJS = $(PARSER_OBJS) $(SCANNER_OBJS)

JS2C_SRCS = $(wildcard src/js2c/*.cc)
JS2C_OBJS = $(patsubst src%, $(OBJDIR)%, $(patsubst %.cc, %.o, $(JS2C_SRCS)))

all: mkdir $(TARGETS)

.PHONY: mkdir
mkdir:
	@mkdir -p $(OBJDIRS)

echo:
	echo $(OUTDIR)

$(LIBJS2C): $(FLEX_SRCS_CC) $(BISON_SRCS_CC) $(LIBJS2C_OBJS)
	$(AR) $(ARFLAGS) $(OUTDIR)/$@.a $^

$(JS2C): $(JS2C_OBJS)
	$(CXX) $(INCDIR) $(LIBDIR) $(CXXFLAGS) -o $(OUTDIR)/$@ $^ $(LDLIBS)

$(FLEX_SRCS_CC): $(FLEX_SRCS)
	$(FLEX) -o $@ $^

$(BISON_SRCS_CC): $(BISON_SRCS)
	$(BISON) --header="$(BISON_SRCS_H)" --output="$@" $^

$(OBJDIR)/%.o: src/%.cc
	$(CXX) $(INCDIR) $(CXXFLAGS) $(CXXDEBUG) -c -o $@ $<

.PHONY: clean
clean:
	rm -rf $(OBJDIR)
	rm -f $(OUTDIR)/${LIBJS2C}.a $(OUTDIR)/${JS2C}
	rm -rf $(FLEX_BISON_GENERATED)