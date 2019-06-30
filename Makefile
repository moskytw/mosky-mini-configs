SHELL = /bin/bash

MKDIR = mkdir -p
CP = cp -r
RM = rm -rf
INSTALL = install -m 644

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
	build/karabinder_complex_modifications/ \
	

build :
	$(MKDIR) $@

# $@: target, i.e., 'build/gitconfig'
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
ifneq ($(ON_MAC),)
	$(INSTALL) build/bash_profile ~/.bash_profile
	$(INSTALL) build/karabinder_complex_modifications/* ~/.config/karabiner/assets/complex_modifications/
endif

.PHONY : uninstall
uninstall :
	$(RM) ~/.bashrc.d/*
	$(RM) ~/.bash_profile
	$(RM) ~/.gitconfig
	$(RM) ~/.tmux.conf
	$(RM) -i ~/.config/karabiner/assets/complex_modifications/* | true
	$(RM) -i ~/.bashrc | true
