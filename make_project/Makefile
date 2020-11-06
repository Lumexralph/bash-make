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

clean :
		rm edit $(objects)

