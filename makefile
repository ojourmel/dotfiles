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

diff-all: diff-bash diff-elinks diff-htop diff-i3 diff-motd diff-urxvt diff-vim diff-zsh
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

bash:
	cp bash/bashrc ~/.bashrc

elinks:
	[ -d ~/.elinks ] || mkdir ~/.elinks
	cp elinks/elinks.conf ~/.elinks/elinks.conf

htop:
	[ -d ~/.config/htop ] || mkdir -p ~/.config/htop
	cp htop/htoprc ~/.config/htop/htoprc

i3:
	[ -d ~/.i3 ] || mkdir ~/.i3
	cp i3/config ~/.i3/config
	cp i3/i3status.conf ~/.i3/i3status.conf

motd:
	cp motd/motd ~/.motd
	chmod a+x ~/.motd

urxvt:
	cp urxvt/Xresources ~/.Xresources

vim:
	-[ -d ~/.vim ] && rm -rf ~/.vim
	cp -r vim/vim ~/.vim
	cp vimrc ~/.vimrc
	vim +PluginInstall +qal

zsh:
	cp zsh/zlogin ~/.zlogin
	cp zsh/zshaliases ~/.zshaliases
	cp zsh/zshenv ~/.zshenv
	cp zsh/zshfunctions ~/.zshfunctions
	cp zsh/zshgrml ~/.zshgrml
	cp zsh/zshrc ~/.zshrc

