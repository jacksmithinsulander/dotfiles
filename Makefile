BASE = $(PWD)
SCRIPTS = $(HOME)/.scripts
MKDIR = mkdir -p
LN = ln -vsf
LNDIR = ln -vs

#installguix:
	
installpkgsrc:

installnix:

init:
	$(LNDIR) $(PWD)/vis $(HOME)/.config/vis
	$(LN) $(PWD).xinitrc $(HOME)/.xinitrc
