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

### Additional Content
There are several options preset and ready for installtion. Each option inherits a different set of libraries and tools. These Options are passed via the `--env <LIST>` argument or an `--env-file <FILE>`.
Currently these options are available:
| Option | Packages | 
|---|---|
ARCH\_32 | adds 32-bit support 
PWN | ropper, pwntools
BIN | gef, binutils
WLST | rockyou.txt
WEB | netcat, curl, wget, ...
ALL | ARCH\_32, PWN, BIN, WLST, WEB

To install a package, set the corresponding environment variable to `1`. One example could be:
```bash
docker run -v$PWD/share:/share -cap-add=SYS_PTRACE --security-opt seccomp=unconfined -e PWN=1 WEB=1 -d --name:pwnhost -i pwnhost
```

## Usage
One example on how to run the container.
```bash
docker run --rm -v $PWD/share:/share --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -d --name pwnhost -i pwnhost
```
Note, that in your use case some options may not be nessecary. Consider to adjust it to your system setup.

Alternatively you can use the [run](./run) script provided in the root of the project directory.

Use `docker exec` to launch an interactive shell
```bash
docker exec -it pwnhost:latest zsh
```

### Credentials
The `Dockerfile` will automatically create the user `pwny` specified by the `ARG` variable `UNAME`. You can change it when building the image locally.

```c
pwny:pwny
root:root
```

## Packages
Because the purpouse of this image is to start right hacking without a big setup, some packages I considered to be useful will be preinstalled.
| Package | Source | Docs |
|---|---|---|
oh-my-zsh| https://github.com/ohmyzsh/ohmyzsh/ | https://github.com/ohmyzsh/ohmyzsh/wiki
git| https://github.com/git/git | https://git-scm.com/doc
pip3 | https://pip.pypa.io/en/stable/ | https://pip.pypa.io/en/stable/user\_guide/


