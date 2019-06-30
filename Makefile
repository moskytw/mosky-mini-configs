SHELL = /bin/bash

FG_YELLOW = \x1b[0;33m
ALL_RESET = \x1b[0m

MKDIR = mkdir -p
CP = cp
RM = rm -rf
ifeq ($(USER),mosky)
INSTALL = install -m 644
RMI = rm -rf
PIPE_TRUE =
else
INSTALL = install -b -m 644
RMI = rm -rf -i
PIPE_TRUE = | true
endif

# NOTE: use empty string as false, so `ifneq ($VAR,)` === if bool(VAR)
WITH_NVIM = $(shell command -v nvim)
WITH_TMUX_1_x = $(shell tmux -V | grep 'tmux 1.' -o)
ON_MAC = $(shell uname | grep 'Darwin' -o)

BASHRC_THE_SOURCING_LINE = for path in ~/.bashrc.d/*; do . $$path; done

.PHONY : all
all : build \
	build/bashrc.d/ \
	build/bash_profile \
	build/gitconfig \
	build/tmux.conf \
	build/ssh_config \
	build/karabinder_complex_modifications/ \
	

# $@: target, i.e., 'build'
build :
	$(MKDIR) $@

# $?: the newer prerequisite
build/bashrc.d/: src/bashrc.d/*
	$(MKDIR) $@
	$(CP) $? $@

# $<: the first prerequisite, i.e., 'src/gitconfig'
build/gitconfig : src/gitconfig
	$(CP) $< $@
ifneq ($(WITH_NVIM),)
	patch $@ patches/gitconfig_nvim.patch
endif

build/tmux.conf : src/tmux.conf
	$(CP) $< $@
ifneq ($(WITH_TMUX_1_x),)
	patch $@ patches/tmux.conf_1.x.patch
endif

build/karabinder_complex_modifications/: src/karabinder_complex_modifications/*
	$(MKDIR) $@
	$(CP) $? $@

build/% : src/%
	$(CP) $< $@

.PHONY : clean
clean :
	$(RM) -f build/*

.PHONY : install
install :
	$(MKDIR) ~/.bashrc.d/
	$(INSTALL) build/bashrc.d/* ~/.bashrc.d/
	grep -F '$(BASHRC_THE_SOURCING_LINE)' ~/.bashrc || echo '$(BASHRC_THE_SOURCING_LINE)' >> ~/.bashrc
	$(INSTALL) build/gitconfig ~/.gitconfig
	$(INSTALL) build/tmux.conf ~/.tmux.conf
	$(INSTALL) build/ssh_config ~/.ssh/config
ifneq ($(ON_MAC),)
	$(INSTALL) build/bash_profile ~/.bash_profile
	$(INSTALL) build/karabinder_complex_modifications/* ~/.config/karabiner/assets/complex_modifications/
	@echo -e "$(FG_YELLOW)Check bin/* for more scripts.$(ALL_RESET)"
endif

.PHONY : uninstall
uninstall :
	$(RM) ~/.bashrc.d/*
	$(RM) ~/.bash_profile
	$(RM) ~/.gitconfig
	$(RM) ~/.tmux.conf
	$(RM) ~/.ssh/config
	$(RMI) ~/.config/karabiner/assets/complex_modifications/* $(PIPE_TRUE)
	$(RMI) ~/.bashrc $(PIPE_TRUE)

.PHONY : debug
debug :
	@echo $(USER)
