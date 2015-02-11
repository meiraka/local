.PHONY: clean fetch extract build-dep build install
all: build-dep build

INSTALL_PREFIX?=$(HOME)/local
CONFIGURE_ARGS= --prefix $(INSTALL_PREFIX) --enable-optimized --enable-assertions=no --enable-targets=host-only
MAKE_ARGS= -j2

RELEASE?=3.3
ARCHIVE_FORMAT?=gz

LLVM=llvm-$(RELEASE).src
CLANG=cfe-$(RELEASE).src
COMPILER_RT=compiler-rt-$(RELEASE).src
LLVM_ARCHIVE=$(LLVM).tar.$(ARCHIVE_FORMAT)
CLANG_ARCHIVE=$(CLANG).tar.$(ARCHIVE_FORMAT)
COMPILER_RT_ARCHIVE=$(COMPILER_RT).tar.$(ARCHIVE_FORMAT)

DIRS= $(LLVM) $(CLANG) $(COMPILER_RT)
ARCHIVES= $(LLVM_ARCHIVE) $(CLANG_ARCHIVE) $(COMPILER_RT_ARCHIVE)

$(ARCHIVES):
	for archive in $(ARCHIVES) ; do \
	(curl -L http://www.llvm.org/releases/$(RELEASE)/$$archive -o $$archive) ;\
	done

$(DIRS):| $(ARCHIVES)
	for archive in $(ARCHIVES) ; do \
	(tar -xf $$archive) ;\
	done

$(LLVM)/tools/clang:| $(CLANG) $(LLVM)
	cp -r $(CLANG) $(LLVM)/tools/clang

$(LLVM)/projects/compiler-rt:| $(COMPILER_RT) $($LLVM)
	cp -r $(COMPILER_RT) $(LLVM)/projects/compiler-rt

$(LLVM)/config.log:| $(LLVM)/tools/clang $(LLVM)/projects/compiler-rt
	cd $(LLVM); ./configure $(CONFIGURE_ARGS)

fetch: $(ARCHIVES)

extract: $(DIRS)

clean:
	-rm -rf $(DIRS)
	-rm $(ARCHIVES)

build-dep:
	-sudo apt-get install build-essential

build:| $(LLVM)/config.log
	cd $(LLVM); make $(MAKE_ARGS)

install:
	cd $(LLVM); make install
