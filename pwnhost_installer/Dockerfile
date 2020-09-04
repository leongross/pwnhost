FROM ubuntu:20.04

ENV LC_CTYPE C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
# fixing tzdata
ENV TZ=Europe/Moscow

ARG UNAME='user'

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

# pip installs
RUN 	su $UNAME && cd /home/$UNAME && \
	pip3 install --pre unicorn && \ 
	pip3 install requests keystone-engine capstone ropper pwntools

RUN	"$(curl -fsSL https://raw.githubusercontent.com/leongross/dockerfiles/master/pwnhost_installer/installer.sh)" | sh

WORKDIR	/home/$UNAME
EXPOSE 22 80 443
