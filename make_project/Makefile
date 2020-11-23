# get environment variable in FOO and store it in variable FOO
$(info $(FOO))

# discover where FOO got that value
$(info $(FOO) $(origin FOO))

# prevent a definition in a makefile from overriding the environment by specifying the -e
# (or --environment-overrides) option on the command line of GNU make. i.e 

# to guarantee that the variable FOO gets its value inside the makefile, not from the environment
override FOO=Lumexd
$(info $(FOO) $(origin FOO))

###################################################################################################
##	RULES
# 1. The override directive beats the command line,
# 2. which beats environment over­ rides (the -e option),
# 3. which beats variables defined in a makefile,
# 4. which beats the original environment. Alternatively, you can always use $(origin) to find out what’s going on.
###################################################################################################

objects = main.o kbd.o command.o display.o \
       	  insert.o search.o files.o utils.o

edit : $(objects)
		cc -o edit $(objects)

main : main.c defs.h

		cc -c main.c

kbd.o : kbd.c defs.h command.h

		cc -c kbd.c

command.o : command.c defs.h command.h

		cc -c command.c

display.o : display.c defs.h buffer.h

		cc -c display.c

insert.o : insert.c defs.h buffer.h

		cc -c insert.c

search.o : search.c defs.h buffer.h

		cc -c search.c

files.o : files.c defs.h buffer.h command.h

		cc -c files.c

utils.o : utils.c defs.h

		cc -c utils.c

# order-only prerequisites
OBJDIR := objdir
OBJ := $(addprefix $(OBJDIR)/,foo.o bar.o baz.o)

$(OBJDIR)/%.o : %.c
		$(COMPILE.c) $(OUTPUT_OPTION) $<

all : $(OBJS)

$(OBJS) : | $(OBJDIR)

$(OBJDIR) :
		mkdir $(OBJDIR)

# It is a good practice to have a cleanup target action in our makefile,
# any action we don’t want to run by default should not be placed at the top of the targets.
# We use .PHONY : target action,
# it causes Make to not get confused by an actual file called or named as the target.

.PHONY : clean
clean :
		rm edit $(objects)

		# using wildcards, delete all the object files in current working directory
		rm -f *.o

# print all the ‘.c’ files that have changed since the last time you printed them
# It uses an empty target file "print", empty target files used to record events
# The automatic variable ‘$?’ is used to print only those files that have changed
.PHONY : print
print : *.c
		lpr -p $?
		touch print

#################################################################################
#### Wildcard, VPATH vairable, vpath directive and automatic vairables
#################################################################################

# - match every files in the working directory that has the .o file extension
# Objects = *.o, it will be taken as the string “*.o”, to make the expansion happen instead use
Objects := $(wildcard *.o)


# Search Directories for Prerequisites - VPATH variable
# It is a variable used by make to automatically search directories for prerequisites
# You specify a list of directories that make should search.
# If a file that is listed as a target or prerequisites does not exist in the current directory,
# make searches the directories listed in VPATH for a file with that name.
#  make searches the 2 directories in the order they are declared
VPATH = src:../headers

# Also, there is the vpath directive - it allows you to specify a search path for a particular class of file names
# Below tells make to look for any prerequisite whose name ends in .h in the directory ../headers
# if the file is not found in the current directory.
vpath %.h ../headers

# look for a file ending in ‘.c’ in foo, then blish, then bar, while
vpath %.c foo
vpath % blish
vpath %.c bar

# look for a file ending in ‘.c’ in foo, then bar, then blish.
vpath %.c foo:bar
vpath % blish


# Writing Recipes with Directory Search and automatic variables
# $^ - automatic variables, the value is a list of all the prerequisites of the rule, including the name of the directories in which they are found
# $@ - automatic variable that has the value as the target of the rule.
# $< - is just the first prerequisite

# The below rule means, compile using the CFLAGS environment variable the prerequisites (foo.c)-$^ and output as foo.o - $@(object file target)
foo.o : foo.c
		cc -c $(CFLAGS) $^ -o $@

# Below rule uses a VPATH variable to indicate where to search the prerequisites id can't be found in current directory.
# uses the environment vairable CFLAGS to compile the first prerequisite foo.c($<) and output as the target foo.o($@)
VPATH = src:../headers
foo.o : foo.c defs.h hack.h
		cc -c $(CFLAGS) $< -o $@