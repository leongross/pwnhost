FROM 		ubuntu:20.04
MAINTAINER 	"github.com/leongross"

ENV 	LC_CTYPE C.UTF-8
ENV 	DEBIAN_FRONTEND=noninteractive
ENV 	TZ=Europe/Moscow

ARG 	UNAME='pwny'

# inital system setup
RUN 	apt update && apt upgrade -y && \
	apt install apt-utils && \
	apt install -y man-db vim zsh git procps p7zip-full sudo \
	# build tools
	build-essential \
	# libraries
	libpcre3-dev libdb-dev libxt-dev libxaw7-dev libffi-dev libc6-dev-i386 \
	# python
	python3 python3-pip python3-dev python3-venv && \
	python3 -m pip install --upgrade pip && \
	rm -rf /var/lib/apt/lists/*


# Updating network cache
RUN	echo "nameserver 1.1.1.1" >> /etc/resolve.conf 

# user account setup
RUN 	useradd -mN -s /bin/zsh $UNAME && \
	mkdir /home/$UNAME/.config && \ 
	echo "pwnhost" > /etc/hostname && \
	mkdir /share && chown $UNAME /share
	#usermod -aG sudo $UNAME

RUN	echo "root:root" | chpasswd
RUN	echo "pwny:pwny" | chpasswd

# setup install script
RUN	printenv
COPY	./installer /installer.sh
RUN	/installer.sh

USER	$UNAME
WORKDIR	/home/$UNAME

# setup user interface
RUN	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# add home/user/.local/bin to path
RUN	export PATH="/home/user/.local/bin:/home/user/bin:$PATH"

WORKDIR		/home/$UNAME
EXPOSE 		22 80 443

