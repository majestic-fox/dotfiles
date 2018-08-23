DOTFILES := $(shell pwd)
all: sync tmux
.PHONY: sync tmux

sync:
	@ln -fs ${DOTFILES}/zsh/zshrc ${HOME}/.zshrc
	@[ -f ${DOTFILES}/zsh/zshlocal ] && ln -fs ${DOTFILES}/zsh/zshlocal ${HOME}/.zshlocal

tmux:
	ln -fs $(DOTFILES)/tmux/tmux.conf ${HOME}/.tmux.conf
	ln -fs $(DOTFILES)/tmux/tmux.conf.local ${HOME}/.tmux.conf.local
	ln -fs $(DOTFILES)/tmux/scripts/tmux-spotify-info ${HOME}/bin/tmux-spotify-info
