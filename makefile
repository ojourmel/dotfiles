# Oliver Jourmel
# Initialization and configuration make file
#
# Targets can be used to install, update, and diff dotfiles

help:
	@echo ""
	@echo "WARNING: This will clober your current dotfiles!"
	@echo "Use setup-all to get things going"
	@echo "Use install-all to check dependencies"
	@echo "Use configure-all to set up the dotfiles!"
	@echo "Use configure-shell to set up server defaults"
	@echo "Use configure-desktop to set up X windows stuff"
	@echo "Use diff-all to see what kind of changes will be happening!"
	@echo "Use backup-all to create a dofile-backup folder and save your current configuration!"
	@echo "Use backup-restore to replace your current configuration with the files in ~/dotfile-backup/"

setup-all:
	@echo "WARNING! This will clober your current dotfiles!"
	@echo ""
	@while [ -z "$$CONTINUE" ]; do \
		read -r -p "Are you SURE this is a good idea??" CONTINUE; \
	done ;
	@if [ $$CONTINUE != "y" ] && [ $$CONTINUE != "Y" ]; then \
		echo "Exiting." ; exit 1 ; \
	fi

	@make install-all
	@make configure-all

install-all:
	@echo testing for dependencies...
	@echo please verify that the following programs are installed:
	@echo		'* bash'
	@echo		'* elinks'
	@echo		'* htop'
	@echo		'* vim'
	@echo		'* zsh'
	@echo		'* i3'
	@echo		'* urxvt'
	@echo		'* bin'
	@echo		'* tmux'
	@echo ''

configure-all: configure-shell configure-desktop
	@true

configure-shell: bash elinks htop motd vim zsh bin tmux
	@true

configure-desktop: i3 urxvt
	@true

backup-all:
	[ -d ~/dotfiles-backup ] || mkdir ~/dotfiles-backup/

	@make back-bash back-elinks back-htop back-i3 back-motd back-urxvt back-vim back-zsh back-bin back-backup
	@true

back-bash:
	cp ~/.bashrc ~/dotfiles-backup/bashrc
	@true

back-elinks:
	cp ~/.elinks/elinks.conf ~/dotfiles-backup/elinks.conf
	@true

back-htop:
	cp ~/.config/htop/htoprc ~/dotfiles-backup/htoprc
	@true

back-i3:
	@[ -d ~/dotfiles-backup/i3 ] || mkdir -p ~/dotfiles-backup/i3/
	cp ~/.i3/config ~/dotfiles-backup/i3/config
	cp ~/.i3/i3status.conf ~/dotfiles-backup/i3/i3status.conf
	@true

back-motd:
	cp ~/.motd ~/dotfiles-backup/motd
	@true

back-urxvt:
	cp ~/.Xresources ~/dotfiles-backup/Xresources
	@true

back-vim:
	cp -r ~/.vim ~/dotfiles-backup/vim
	cp ~/.vimrc ~/dotfiles-backup/vimrc
	@true

back-zsh:
	cp ~/.zlogin ~/dotfiles-backup/zlogin
	cp ~/.zshaliases ~/dotfiles-backup/zshaliases
	cp ~/.zshenv ~/dotfiles-backup/zshenv
	cp ~/.zshfunctions ~/dotfiles-backup/zshfunctions
	cp ~/.zshgrml ~/dotfiles-backup/zshgrml
	cp ~/.zshrc ~/dotfiles-backup/zshrc
	@true

back-bin:
	cp -r ~/bin ~/dotfiles-backup/bin
	@true

back-tmux:
	cp -r ~/.tmux ~/dotfiles-backup/tmux
	cp ~/.tmux.conf ~/dotfiles-backup/tmux.conf
	@true

backup-restore: brest-bash brest-elinks brest-htop brest-i3 brest-motd brest-urxvt brest-vim brest-zsh brest-bin brest-tmux

brest-bash:
	cp ~/dotfiles-backup/bashrc ~/.bashrc
	@true

brest-elinks:
	cp ~/dotfiles-backup/elinks.conf ~/.elinks/elinks.conf
	@true

brest-htop:
	cp ~/dotfiles-backup/htoprc ~/.config/htop/htoprc
	@true

brest-i3:
	cp ~/dotfiles-backup/i3/config ~/.i3/config
	cp ~/dotfiles-backup/i3/i3status.conf ~/.i3/i3status.conf
	@true

brest-motd:
	cp ~/dotfiles-backup/motd ~/.motd
	@true

brest-urxvt:
	cp ~/dotfiles/Xresources ~/.Xresources
	@true

brest-vim:
	rm -rf ~/.vim
	cp -r ~/dotfiles/vim ~/.vim
	cp ~/dotfiles/vimrc ~/.vimrc
	@true

brest-zsh:
	cp ~/dotfiles-backup/zlogin ~/.zlogin
	cp ~/dotfiles-backup/zshaliases ~/.zshaliases
	cp ~/dotfiles-backup/zshenv ~/.zshenv
	cp ~/dotfiles-backup/zshfunctions ~/.zshfunctions
	cp ~/dotfiles-backup/zshgrml ~/.zshgrml
	cp ~/dotfiles-backup/zshrc ~/.zshrc
	@true

brest-bin:
	cp -r ~/dotfiles-backup/bin ~/bin
	@true

brest-tmux:
	rm -rf ~/.tmux
	cp -r ~/dotfiles-backup/tmux ~/.tmux
	cp ~/dotfiles-backup/tmux.conf ~/.tmux.conf
	@true


diff-all: diff-bash diff-elinks diff-htop diff-i3 diff-motd diff-urxvt diff-vim diff-zsh diff-zsh
	@true

diff-bash:
	@echo "====================== bash ======================"
	-diff ~/.bashrc bash/bashrc
	@echo ""

diff-elinks:
	@echo "====================== elinks ======================"
	-diff ~/.elinks/elinks.conf elinks/elinks.conf
	@echo ""

diff-htop:
	@echo "====================== htop ======================"
	-diff ~/.config/htop/htoprc htop/htoprc
	@echo ""

diff-i3:
	@echo "====================== i3 ======================"
	-diff ~/.i3/config i3/config
	@echo ""
	-diff ~/.i3status.conf i3/i3status.conf
	@echo ""
	-diff ~/.i3/i3status.conf i3/i3status.conf
	@echo ""

diff-motd:
	@echo "====================== motd ======================"
	-diff ~/.motd motd/motd
	@echo ""

diff-urxvt:
	@echo "====================== urxvt ======================"
	-diff ~/.Xresources urxvt/Xresources
	@echo ""

diff-vim:
	@echo "====================== vim ======================"
	-diff ~/.vimrc vim/vimrc
	@echo ""

diff-zsh:
	@echo "====================== zsh ======================"
	-diff ~/.zlogin zsh/zlogin
	@echo ""
	-diff ~/.zshaliases zsh/zshaliases
	@echo ""
	-diff ~/.zshenv zsh/zshenv
	@echo ""
	-diff ~/.zshfunctions zsh/zshfunctions
	@echo ""
	-diff ~/.zshgrml zsh/zshgrml
	@echo ""
	-diff ~/.zshrc zsh/zshrc
	@echo ""

diff-bin:
	@echo "====================== bin ======================"
	-diff `ls -la ~/bin` `ls -la bin`
	@echo ""

diff-tmux:
	@echo "====================== tmux ======================"
	-diff ~/.tmux.conf tmux/tmux.conf
	@echo ""

bash:
	cp bash/bashrc ~/.bashrc

elinks:
	@[ -d ~/.elinks ] || mkdir ~/.elinks
	cp elinks/elinks.conf ~/.elinks/elinks.conf

htop:
	@[ -d ~/.config/htop ] || mkdir -p ~/.config/htop
	cp htop/htoprc ~/.config/htop/htoprc

i3:
	@[ -d ~/.i3 ] || mkdir ~/.i3
	cp i3/config ~/.i3/config
	cp i3/i3status.conf ~/.i3/i3status.conf

motd:
	cp motd/motd ~/.motd
	chmod a+x ~/.motd

urxvt:
	cp urxvt/Xresources ~/.Xresources

vim:
	@-[ -d ~/.vim ] && rm -rf ~/.vim
	cp -r vim/vim ~/.vim
	cp vim/vimrc ~/.vimrc
	vim +PluginInstall +qall

zsh:
	cp zsh/zlogin ~/.zlogin
	cp zsh/zshaliases ~/.zshaliases
	cp zsh/zshenv ~/.zshenv
	cp zsh/zshfunctions ~/.zshfunctions
	cp zsh/zshgrml ~/.zshgrml
	cp zsh/zshrc ~/.zshrc

bin:
	cp -r bin/ ~/bin

tmux:
	@-[ -d ~/.tmux ] && rm -rf ~/.tmux
	cp -r tmux/tmux ~/.tmux
	cp tmux/tmux.conf ~/.tmux.conf
	rm -rf ~/.tmux/plugins/tpm
	git clone https://github.com/tmux-plugins/tpm.git  ~/.tmux/plugins/tpm


.PHONY: brest-tmux diff-htop back-htop install-all back-motd setup-all diff-all brest-motd htop diff-bin back-bin diff-elinks back-elinks diff-i3 back-i3 brest-zsh makefile brest-urxvt urxvt back-tmux configure-all brest-vim help brest-bash diff-motd backup-all brest-htop motd configure-shell diff-tmux vim diff-zsh configure-desktop back-zsh diff-urxvt back-urxvt tmux bash zsh brest-bin backup-restore diff-vim back-vim i3 brest-elinks brest-i3 diff-bash back-bash elinks bin

