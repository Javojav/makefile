CC	:= gcc
CCFLAGS	:= -Wall -pedantic

IFLAGS=-I./
LDFLAGS=-L./
LDLIBS=-lname #Excluding lib

EXE	:= #EXEname

VFLAGS	:= -s --leak-check=full --track-origins=yes

#####################################################
# .EXE
#####################################################

$(EXE) : *.o *.a
	$(CC) -o $@ $(CCFLAGS) $^ $(LDFLAGS) $(LDLIBS) $(LIBS)

#####################################################
# .o
#####################################################

deps:= $(patsubst %.o, %.d, $(objs))
-include $(deps)
DEPFLAGS = -MMD -MF $(@:.o=.d)

%.o: %.c
	$(CC) -c $(CCFLAGS) $< $(DEPFLAGS)

#####################################################
# function
#####################################################
.PHONY: all clear run valgrind

all: $(EXE)

clear:
	rm -f *.o *.d $(EXE)

run: $(EXE)
	./$<

valgrind: $(EXE)
	valgrind $(VFLAGS) ./$< --log-file=valgrind.log
