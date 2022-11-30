install-tools:
	apt install -y tmux zsh mosh git wget curl jq gh elinks
dev.setup:
	echo "setuping development environment"
	sudo apt install -y yarn
	pip3 install --upgrade pip
	pip3 install --user neovim
	rm -rf dev/opt/nvim
	mkdir -p dev/opt/nvim && cd dev/opt/nvim && wget -O /dev/stdout https://github.com/neovim/neovim/releases/download/v0.8.1/nvim-linux64.tar.gz | tar xz && mv nvim-linux64/* .
	#git clone --depth=1 https://github.com/savq/paq-nvim.gi
	curl https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > dev/opt/nvim/share/nvim/runtime/autoload/plug.vim
