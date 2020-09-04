#!/bin/sh

UANME="user"

# user account setup
useradd -mN -s /bin/zsh $UNAME 
mkdir /home/$UNAME/.config 
echo "pwnbox" > /etc/hostname 
usermod -aG sudo $UNAME 

# setup user interface
su $UNAME && cd /home/$UNAME && 
# cloning dotfiles
git clone https://github.com/leongross/dotfiles.git 


# github project and tools cloning
mkdir repos && cd repos
wget -O ~/.gdbinit-gef.py -q http://gef.blah.cat/py && echo source ~/.gdbinit-gef.py >> ~/.gdbinit

