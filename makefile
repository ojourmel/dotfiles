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



setup-all:
	@echo "WARNING! This will clober your current dotfiles!"
	@echo ""
	@while [ -z "$$CONTINUE" ]; do \
		read -r -p "Are you SURE this is a good idea??" CONTINUE; \
	done ; \
	if [ $$CONTINUE != "y" ] && [ $$CONTINUE != "Y" ]; then
		echo "Exiting." ; exit 1 ; \
	fi

	@make install-all
	@make configure-all

install-all:
	@echo "Not Set up yet"

configure-all: configure-shell configure-desktop

configure-shell: bash elinks htop motd vim zsh

configure-desktop: i3 urxvt

diff-all: diff-bash diff-elinks diff-htop diff-i3 diff-motd diff-urxvt diff-vim

diff-bash: bash
	diff ~/.bashrc bash/bashrc

diff-elinks: elinks
	diff ~/.elinks/elinks.conf elinks/elinks.conf

diff-htop: htop
	diff ~/.config/htop/htoprc htop/htoprc

diff-i3: i3
	diff ~/.i3/config i3/config
	diff ~/.i3status.conf i3/i3status.conf
	diff ~/.i3/i3status.conf i3/i3status.conf

diff-motd: motd
	diff ~/.motd motd/motd

diff-urxvt: urxvt
	diff ~/.Xresources urxvt/Xresources

diff-vim: vim
	diff ~/.vimrc vim/vimrc

diff-zsh: zsh
	diff ~/.zlogin zsh/zlogin
	diff ~/.zshaliases zsh/zshaliases
	diff ~/.zshenv zsh/zshenv
	diff ~/.zshfunctions zsh/zshfunctions
	diff ~/.zshgrml zsh/zshgrml
	diff ~/.zshrc zsh/zshrc

bash: bash
	cp bash/bashrc ~/.bashrc

elinks: elinks
	[ -d ~/.elinks ] || mkdir ~/.elinks
	cp elinks/elinks.conf ~/.elinks/elinks.conf

htop: htop
	[ -d ~/.config/htop ] || mkdir -p ~/.config/htop
	cp htop/htoprc ~/.config/htop/htoprc

i3: i3
	[ -d ~/.i3 ] || mkdir ~/.i3
	cp i3/config ~/.i3/config
	cp i3/i3status.conf ~/.i3/i3status.conf

motd: motd
	cp motd/motd ~/.motd
	chmod a+x ~/.motd

urxvt: urxvt
	cp urxvt/Xresources ~/.Xresources

vim: vim
	[ -d ~/.vim ] && rm -rf ~/.vim
	cp -r vim/vim ~/.vim
	cp vimrc ~/.vimrc
	vim +PluginInstall +qal

zsh: zsh
	cp zsh/zlogin ~/.zlogin
	cp zsh/zshaliases ~/.zshaliases
	cp zsh/zshenv ~/.zshenv
	cp zsh/zshfunctions ~/.zshfunctions
	cp zsh/zshgrml ~/.zshgrml
	cp zsh/zshrc ~/.zshrc

