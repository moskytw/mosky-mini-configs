SHELL = /bin/bash

FG_YELLOW = \x1b[0;33m
ALL_RESET = \x1b[0m

# NOTE: use empty string as false, so `ifneq ($VAR,)` === if bool(VAR)
USER_IS_MOSKY = $(shell whoami | grep '^mosky$$' -o)
WITH_NVIM = $(shell command -v nvim)
WITH_TMUX_1_x = $(shell tmux -V | grep 'tmux 1.' -o)
ON_MAC = $(shell uname | grep 'Darwin' -o)

MKDIR = mkdir -p
CP = cp
CPB = cp -b
RM = rm -rf
RMI = rm -rf -i
PIPE_TRUE = | true
ifneq ($(USER_IS_MOSKY),)
CPB = cp
RMI = rm -rf
PIPE_TRUE =
endif

BASHRC_THE_SOURCING_LINE = for path in ~/.bashrc.d/*; do . $$path; done

.PHONY : all
all : build/ \
      build/bashrc.d/ \
      build/bash_profile \
      build/vimrc \
      build/gitconfig \
      build/tmux.conf \
      build/ssh_config \
      build/karabinder_bash_emacs.json

# $@: the target, i.e., 'build/'
build/ :
	$(MKDIR) $@

# $?: the newer prerequisites
build/bashrc.d/: src/bashrc.d/*
	$(MKDIR) $@
	$(CP) $? $@

# $<: the first prerequisite
build/bash_profile : src/bash_profile
ifneq ($(ON_MAC),)
	$(CP) $< $@
endif
	

build/vimrc : src/vimrc patches/vimrc_nvim.patch
	$(CP) $< $@
ifneq ($(WITH_NVIM),)
	patch $@ patches/vimrc_nvim.patch
endif

build/gitconfig : src/gitconfig \
                  patches/gitconfig_mosky.patch \
                  patches/gitconfig_nvim.patch
	$(CP) $< $@
ifneq ($(USER_IS_MOSKY),)
	patch $@ patches/gitconfig_mosky.patch
endif
ifneq ($(WITH_NVIM),)
	patch $@ patches/gitconfig_nvim.patch
endif
	
build/tmux.conf : src/tmux.conf patches/tmux.conf_1.x.patch
	$(CP) $< $@
ifneq ($(WITH_TMUX_1_x),)
	patch $@ patches/tmux.conf_1.x.patch
endif
	
build/ssh_config : src/ssh_config
ifneq ($(ON_MAC),)
	$(CP) $< $@
endif
	

build/% : src/%
	$(CP) $< $@

.PHONY : clean
clean :
	$(RM) -f build/

.PHONY : install
install :
	
	$(MKDIR) ~/.bashrc.d/
	$(CPB) build/bashrc.d/* ~/.bashrc.d/
	grep -F '$(BASHRC_THE_SOURCING_LINE)' ~/.bashrc \
|| echo $$'\n''$(BASHRC_THE_SOURCING_LINE)' >> ~/.bashrc
ifneq ($(ON_MAC),)
	$(CPB) build/bash_profile ~/.bash_profile
endif
	
ifneq ($(WITH_NVIM),)
	$(MKDIR) ~/.config/nvim/
	$(CPB) build/vimrc ~/.config/nvim/init.vim
else
	$(CPB) build/vimrc ~/.vimrc
endif
	
	$(CPB) build/gitconfig ~/.gitconfig
	$(CPB) build/tmux.conf ~/.tmux.conf
	
ifneq ($(ON_MAC),)
	$(CPB) build/ssh_config ~/.ssh/config
endif
	
ifneq ($(ON_MAC),)
	$(MKDIR) ~/.config/karabiner/assets/complex_modifications/
	$(CPB) build/karabinder_bash_emacs.json ~/.config/karabiner/assets/complex_modifications/bash_emacs.json
endif
	
	@echo -e "$(FG_YELLOW)Check scripts/* for more scripts.$(ALL_RESET)"

.PHONY : uninstall
uninstall :
	
	$(RM) ~/.bashrc.d/
	$(RMI) ~/.bashrc $(PIPE_TRUE)
ifneq ($(ON_MAC),)
	$(RM) ~/.bash_profile
endif
	
ifneq ($(WITH_NVIM),)
	$(RMI) ~/.config/nvim/init.vim
else
	$(RMI) ~/.vimrc
endif
	
	$(RM) ~/.gitconfig
	$(RM) ~/.tmux.conf
	
ifneq ($(ON_MAC),)
	$(RM) ~/.ssh/config
endif
	
ifneq ($(ON_MAC),)
	$(RM) ~/.config/karabiner/assets/complex_modifications/bash_emacs.json
endif

.PHONY : debug
debug :
	@echo $(CPB)
	@echo $(ON_MAC)
