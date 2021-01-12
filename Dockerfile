FROM 		ubuntu:20.04
MAINTAINER 	"github.com/leongross"

ENV 	LC_CTYPE C.UTF-8
ENV 	DEBIAN_FRONTEND=noninteractive
ENV 	TZ=Europe/Moscow

ARG 	UNAME='pwny'
RUN	echo "root:root" | chpasswd
RUN	echo "pwny:pwny" | chpasswd

# inital system setup
RUN 	dpkg --add-architecture i386 && \
	apt update && apt upgrade -y && \
	apt install apt-utils && \
	apt install -y man-db vim zsh git \
	# binary tools
	build-essential strace ltrace gdb gdb-multiarch gcc gcc-multilib g++ clang llvm make qemu \
	# web tools
	netcat curl wget net-tools libssl-dev openssh-server iputils-ping tcpdump dnsutils\ 
	# libraries
	libpcre3-dev libdb-dev libxt-dev libxaw7-dev libffi-dev libc6:i386 libncurses5:i386 libstdc++6:i386 \
	# python
	python3 python3-pip python3-dev python3-venv \
	# system management
	procps p7zip-full sudo 

# Updating network cache
RUN	echo "nameserver 1.1.1.1" >> /etc/resolve.conf 

# user account setup
RUN 	useradd -mN -s /bin/zsh $UNAME && \
	mkdir /home/$UNAME/.config && \ 
	echo "pwnhost" > /etc/hostname && \
	mkdir /share && chown $UNAME /share
	#usermod -aG sudo $UNAME

USER	$UNAME
WORKDIR	/home/$UNAME

# setup user interface
RUN	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# pip installs
RUN	pip3 install --pre unicorn && \ 
	pip3 install requests keystone-engine capstone ropper pwntools

# github project and tools cloning
RUN	wget -O ~/.gdbinit-gef.py -q http://gef.blah.cat/py && \
	echo source ~/.gdbinit-gef.py >> ~/.gdbinit

# add home/user/.local/bin to path
RUN	export PATH="/home/user/.local/bin:/home/user/bin:$PATH"
RUN	service sshd start

WORKDIR		/home/$UNAME
EXPOSE 		22 80 443
