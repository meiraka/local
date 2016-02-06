.PHONY: all devel desktop
all: devel desktop

ALL = $(filter-out Makefile $(wildcard *.rules) $(wildcard *.defs), $(wildcard *))
DEVEL = clang neovim neovim-python-client tmux
DESKTOP = $(filter-out $(DEVEL), $(ALL))

echo:
	echo $(ALL)

.PHONY: clean
clean:
	@LIST="$(ALL)";\
		for x in $$LIST; do\
		cd "$$x"; make clean;cd ..;\
		done

devel:
	@LIST="$(DEVEL)";\
		for x in $$LIST; do\
		cd "$$x"; make; make install;cd ..;\
		done

desktop:
	@LIST="$(DESKTOP)";\
		for x in $$LIST; do\
		cd "$$x"; make; make install;cd ..;\
		done
