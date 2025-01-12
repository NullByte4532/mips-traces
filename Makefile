# 
# Building the elf_parser for MIPS ElF binaries
# @author Alexander Titov <alexander.igorevich.titov@gmail.com>
# Copyright 2012 uArchSim iLab Project
#

# create a list of all assembly files in the current folder
ASM_FILES = $(wildcard *.s)

# using names of the assembly files create a list of output 
# execution files 
OUT_FILES= $(patsubst %.s,%.out,$(ASM_FILES))

MIPS_AS?=mips-as
MIPS_LD?=mips-ld

# assemble all the object files 
build_all: $(OUT_FILES)

%.out: %.o
	@$(MIPS_LD) $< -o $@
	@chmod -x $@
	@echo $@ is built

%.o: %.s
	@$(MIPS_AS) $< -o $@ -O0 -mips2

# it is needed to preven make from 
# deleting .o files automatically
.PRECIOUS: %.o

.PHONY: clean
clean:
	-rm *.o *.out -rf

.PHONY: help
help:
	@echo "  This makefile build all MIPS assembly files in the directory."
	@echo "  To do that just type 'make' or 'make build_all'."
	@echo "  Note that assembly files should have '.s' extension."
