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
LFLAGS = -+

BISON = bison

LIBJS2C = libjs2c
JS2C = js2c

TARGETS = $(LIBJS2C) $(JS2C)

OBJDIRS = $(OBJDIR)/scanner $(OBJDIR)/js2c

SCANNER_SRCS_L = src/scanner/scanner.l
SCANNER_SRCS_L_GEN = src/scanner/flex_lexer.cc

SCANNER_SRCS = $(wildcard src/scanner/*.cc) $(SCANNER_SRCS_L_GEN)
SCANNER_OBJS = $(patsubst src%, $(OBJDIR)%, $(patsubst %.cc, %.o, $(SCANNER_SRCS)))

LIBJS2C_OBJS = $(SCANNER_OBJS)

JS2C_SRCS = $(wildcard src/js2c/*.cc)
JS2C_OBJS = $(patsubst src%, $(OBJDIR)%, $(patsubst %.cc, %.o, $(JS2C_SRCS)))

FLEX = flex

all: $(TARGETS)

echo:
	echo $(OUTDIR)

$(LIBJS2C): $(LIBJS2C_OBJS)
	@mkdir -p $(OBJDIRS)
	@mkdir -p $(OBJDIRS)
	$(AR) $(ARFLAGS) $(OUTDIR)/$@.a $^

$(JS2C): $(JS2C_OBJS)
	@mkdir -p $(OBJDIRS)
	$(CXX) $(INCDIR) $(LIBDIR) $(CXXFLAGS) -o $(OUTDIR)/$@ $^ $(LDLIBS)

$(SCANNER_SRCS_L_GEN): $(SCANNER_SRCS_L)
	$(FLEX) -o $@ $(LFLAGS) $^

$(OBJDIR)/%.o: src/%.cc
	$(CXX) $(INCDIR) $(CXXFLAGS) $(CXXDEBUG) -c -o $@ $<

.PHONY: clean
clean:
	rm -f $(LIBJS2C_OBJS) $(JS2C_OBJS) $(SCANNER_SRCS_L_GEN) $(OUTDIR)/${LIBJS2C}.a $(OUTDIR)/${JS2C}