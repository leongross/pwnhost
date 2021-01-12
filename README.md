# pwnhost - A quick and dirty CTF Container

# Table of Contents
1. [Installation](#installation)
  1. [Build from source](#from-source)
  2. [Pull from Dockerhub](#from-docker-hub)
2. [Usage](#usage)
  2. [Credentials](#creds)
3. [Packages](#packages)

## Installation
### From source
```bash
git clone https://github.com/leongross/pwnhost.git
cd pwnhost
docker build . -t pwnhost
```

### From Docker Hub
```bash
docker pull leongross/pwnhost
```


## Usage
Here one example on how to run the container.
```bash
docker run --rm -v $PWD/share:/share --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -d --name pwnhost -i pwnhost
```
Note, that in your use case some options may not be nessecary. Consider to adjust it to your system setup.

Alternatively you can use the [run](./run) script provided in the root of the project directory.

Use `docker exec` to launch an interactive shell
```bash
docker exec -it pwnhost:latest zsh
```
or connect to the virtual host via shh

```bash
ssh pwny@pwnhost
```

### Credentials
The `Dockerfile` will automatically create the user `pwny` specified by the `ARG` variable `UNAME`. You can change it when building the image locally.

```c
pwny:pwny
root:root
```

## Packages
Because the purpouse of this image is to start right hacking without a setup some packages I consider to be useful will be preinstalled.
| Package | Source | Docs |
---|---|---|
oh-my-zsh| https://github.com/ohmyzsh/ohmyzsh/ | https://github.com/ohmyzsh/ohmyzsh/wiki
git| https://github.com/git/git | https://git-scm.com/doc
qemu| https://github.com/qemu/qemu | https://www.qemu.org/docs/master/
llvm | https://releases.llvm.org/download.html#11.0.0 | https://llvm.org/docs/
pwntools | https://github.com/Gallopsled/pwntools | https://docs.pwntools.com/en/latest/
pip3 | https://pip.pypa.io/en/stable/ | https://pip.pypa.io/en/stable/user_guide/
gef | https://github.com/hugsy/gef | https://gef.readthedocs.io/en/master/


