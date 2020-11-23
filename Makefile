SHELL = /bin/bash

# FG_YELLOW = \x1b[0;33m
# ALL_RESET = \x1b[0m

# use empty string as false, so `ifneq ($VAR,)` === if bool(VAR)
# the `$$` will become `$`
USER_IS_MOSKY = $(shell whoami | grep '^mosky$$' -o)
WITH_TMUX_1_x = $(shell tmux -V 2> /dev/null | grep 'tmux 1.' -o)
WITH_TMUX_2_old = $(shell tmux -V 2> /dev/null | grep 'tmux 2.[1-8]' -o)
ON_MAC = $(shell uname | grep 'Darwin' -o)

MKDIR = mkdir -p
CP = cp
CPB = cp -b
RM = rm -rf
RMI = rm -rf -i
ifneq ($(USER_IS_MOSKY),)
CPB = cp
RMI = rm -rf
endif

BASHRC_THE_SOURCING_LINE = for path in ~/.bashrc.d/*; do . $$path; done

.PHONY: all
all: build/ \
      build/bashrc.d/ \
      build/bash_profile \
      build/vimrc \
      build/gitconfig \
      build/tmux.conf \
      build/ssh_config \
      build/karabiner_bash_emacs.json

# $@: the target, i.e., 'build/'
build/:
	$(MKDIR) $@

# $?: the newer prerequisites
build/bashrc.d/: configs/bashrc.d/*
	$(MKDIR) $@
	$(CP) $? $@

# $<: the first prerequisite
build/bash_profile: configs/bash_profile
ifneq ($(ON_MAC),)
	$(CP) $< $@
endif

build/vimrc: configs/vimrc
	$(CP) $< $@

build/gitconfig: configs/gitconfig \
                  patches/gitconfig_mosky.patch
	$(CP) $< $@
ifneq ($(USER_IS_MOSKY),)
	patch $@ patches/gitconfig_mosky.patch
endif

build/tmux.conf: configs/tmux.conf patches/tmux.conf_1.x.patch
	$(CP) $< $@
ifneq ($(WITH_TMUX_1_x),)
	patch $@ patches/tmux.conf_2_old.patch
	patch $@ patches/tmux.conf_1.x.patch
endif
ifneq ($(WITH_TMUX_2_old),)
	patch $@ patches/tmux.conf_2_old.patch
endif

build/ssh_config: configs/ssh_config
ifneq ($(ON_MAC),)
	$(CP) $< $@
endif

build/%: configs/%
	$(CP) $< $@

.PHONY: clean
clean:
	$(RM) build/

.PHONY: install
install:
	
	$(MKDIR) ~/.bashrc.d/
	$(CPB) build/bashrc.d/* ~/.bashrc.d/
	grep -F '$(BASHRC_THE_SOURCING_LINE)' ~/.bashrc \
|| echo $$'\n''$(BASHRC_THE_SOURCING_LINE)' >> ~/.bashrc
ifneq ($(ON_MAC),)
	$(CPB) build/bash_profile ~/.bash_profile
endif
	
	$(CPB) build/vimrc ~/.vimrc
	
	$(CPB) build/gitconfig ~/.gitconfig
	$(CPB) build/tmux.conf ~/.tmux.conf
	
ifneq ($(ON_MAC),)
	$(CPB) build/ssh_config ~/.ssh/config
endif
	
ifneq ($(ON_MAC),)
	$(MKDIR) ~/.config/karabiner/assets/complex_modifications/
	$(CPB) build/karabiner_bash_emacs.json ~/.config/karabiner/assets/complex_modifications/bash_emacs.json
endif

.PHONY: uninstall
uninstall:
	
	$(RM) ~/.bashrc.d/
	$(RMI) ~/.bashrc
ifneq ($(ON_MAC),)
	$(RM) ~/.bash_profile
endif
	
	$(RM) ~/.vimrc
	
	$(RM) ~/.gitconfig
	$(RM) ~/.tmux.conf
	
ifneq ($(ON_MAC),)
	$(RM) ~/.ssh/config
endif
	
ifneq ($(ON_MAC),)
	$(RM) ~/.config/karabiner/assets/complex_modifications/bash_emacs.json
endif

.PHONY: install-extra
install-extra:
ifneq ($(ON_MAC),)
	./scripts/install-homebrew || true
	./scripts/install-homebrew-formulas || true
	./scripts/install-pip-packages || true
endif
	./scripts/install-vim-plug || true
	./scripts/install-vim-plug-plugins || true

.PHONY: config
config:
	./scripts/config . '$(HOST)' '$(REMOTE_SHELL)'

.PHONY: debug
debug:
	@echo HOST: $(HOST)
	@echo REMOTE_SHELL: $(REMOTE_SHELL)
	@echo USER_IS_MOSKY: $(USER_IS_MOSKY)
	@echo WITH_TMUX_1_x: $(WITH_TMUX_1_x)
	@echo WITH_TMUX_2_old: $(WITH_TMUX_2_old)
	@echo ON_MAC: $(ON_MAC)
	@echo MKDIR: $(MKDIR)
	@echo CP: $(CP)
	@echo CPB: $(CPB)
	@echo RM: $(RM)
	@echo RMI: $(RMI)
