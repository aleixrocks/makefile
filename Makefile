NAME=main

# Preprocessor variables 
DVAR+=-DCONFIG_MILK 
DVAR+=-DCONFIG_TOPING

# Groups of files
CORE=main.o cookies.o
MILK=milk.o
TOPING=toping.o

# common compile options
LIB=#-lrt #libraries
CC=gcc #compiler
CFLAGS=$(DVAR) -g #compiler options

# objects and dependencies directories
DEPD=dep
OBJD=obj

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
	rm -f $(NAME) $(OBJD)/*.o $(DEPD)/*.d

# dependency generation
$(DEPD)/%.d: %.c
	@set -e; rm -f $@; echo "rebuilding dependencies of $< ($@)";\
        $(CC) -MT "$(OBJD)/$*.o $(DEPD)/$*.d" -MM $(CFLAGS) $< -MF $@

DEPF=$(patsubst %.o,$(DEPD)/%.d,$(OBJ_))
include $(DEPF)

