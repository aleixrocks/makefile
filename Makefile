NAME=main

# Preprocessor variables 
DVAR+=-DCONFIG_MILK 
DVAR+=-DCONFIG_TOPING

# Groups of files
CORE=main.o cookies.o
MILK=milk.o
TOPING=toping.o

# objects and dependencies directories
DEPD=dep
OBJD=obj

# common compile options
LIB=#-lrt
CC=gcc
CFLAGS=$(DVAR) -g

# object list construction
OBJ_=$(CORE)
ifneq ($(findstring TOPING,$(DVAR)),)
	OBJ_+=$(TOPING)
endif
ifneq ($(findstring MILK,$(DVAR)),)
	OBJ_+=$(MILK)
endif
OBJ=$(patsubst %,$(OBJD)/%,$(OBJ_))

# main linking rule
$(NAME): $(OBJ)
	$(CC) -o $(@) $^ $(LIB)

# main building rule
$(OBJD)/%.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS)

# clean rule
.PHONY: clean
clean:
	rm -f iWalker $(OBJD)/*.o $(DEPD)/*.d

# dependency generation
$(DEPD)/%.d: %.c
	@set -e; rm -f $@; echo "rebuilding dependencies of $< ($@)";\
        $(CC) -MT "$(OBJD)/$*.o $(DEPD)/$*.d" -MM $(CFLAGS) $< -MF $@

include $(patsubst %.o,$(DEPD)/%.d,$(OBJ_))

