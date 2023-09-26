ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

install-tools:
	apt install -y tmux zsh mosh git wget curl jq elinks htop

install-googler:
	apt intstall googler

install-qr-webcam-scanner-cobang:
	add-apt-repository ppa:ng-hong-quan/ppa
	apt update
	apt install cobang

git-clone-usefull-tools:
	git clone https://github.com/arcanericky/ga-cmd # tool to retrive google authenticator keys by service(need SERVICE KEY - see below)
	cd ga-cmd && git submodule update --init --recursive
	git clone https://gist.github.com/1llusion1st/b9762b18537c9878554f218ad745c34f #tool to decode google authenticator exported URI
	apt install oathtool # google authenticator. Usage oathtool -b --totp '<SECRET>' -v


install-gh:
	snap install gh

dev.setup:
	echo "setuping development environment"
	sudo apt install -y yarn
	pip3 install --upgrade pip
	pip3 install --user neovim
	rm -rf dev/opt/nvim
	mkdir -p dev/opt/nvim && cd dev/opt/nvim && wget -O /dev/stdout https://github.com/neovim/neovim/releases/download/v0.8.1/nvim-linux64.tar.gz | tar xz && mv nvim-linux64/* .
	#git clone --depth=1 https://github.com/savq/paq-nvim.gi
	curl https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > dev/opt/nvim/share/nvim/runtime/autoload/plug.vim

tools-build:
	cd dev/tools/vpn
	go build -o main dev/tools/vpn/cmd/main.go


tool-vpn-up:
	sudo dev/tools/vpn/main dev/vpns

start-macos-lazy:
	echo ${ROOT_DIR}
	XDG_CONFIG_HOME=$(ROOT_DIR)/vim.macos.lazy XDG_DATA_HOME=$(ROOT_DIR)/vim.macos.lazy nvim

