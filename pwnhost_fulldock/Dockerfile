FROM ubuntu:20.04

ENV LC_CTYPE C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
# fixing tzdata
ENV TZ=Europe/Moscow

ARG UNAME='user'

RUN	echo "root:root" | chpasswd

# inital system setup
RUN 	dpkg --add-architecture i386 && \
	apt update && apt upgrade -y && \
	apt install apt-utils && \
	apt install -y man-db vim zsh \
	# binary tools
	build-essential strace ltrace gdb gdb-multiarch gcc gcc-multilib g++ clang llvm make git \
	# web tools
	netcat curl wget net-tools libssl-dev openssh-server\ 
	# libraries
	libpcre3-dev libdb-dev libxt-dev libxaw7-dev libffi-dev libc6:i386 libncurses5:i386 libstdc++6:i386 \
	# python
	python python3 python3-pip python3-dev \
	# system management
	procps p7zip-full sudo 

# user account setup
RUN 	useradd -mN -s /bin/zsh $UNAME && \
	mkdir /home/$UNAME/.config && \ 
	echo "pwnhost" > /etc/hostname
	#usermod -aG sudo $UNAME

USER	$UNAME
WORKDIR	/home/$UNAME

# setup user interface
RUN	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
	# cloning dotfiles
	git clone https://github.com/leongross/dotfiles.git 

# pip installs
RUN 	pip3 install --pre unicorn && \ 
	pip3 install requests keystone-engine capstone ropper pwntools

# github project and tools cloning
RUN	mkdir repos && cd repos && \
	wget -O ~/.gdbinit-gef.py -q http://gef.blah.cat/py && \
	echo source ~/.gdbinit-gef.py >> ~/.gdbinit

# add $USER/.local/bin to PATH

WORKDIR	/home/$UNAME
EXPOSE 22 80 443
