DOCKER_NAMESPACE =	armbuild/
NAME =			scw-distrib-fedora
VERSION =		22
VERSION_ALIASES =	twenty-two latest
TITLE =			Fedora 22
DESCRIPTION =		Fedora 22
SOURCE_URL =		https://github.com/scaleway/image-fedora


## Image tools  (https://github.com/scaleway/image-tools)
all:    docker-rules.mk
docker-rules.mk:
	wget -qO - http://j.mp/scw-builder | bash
-include docker-rules.mk
## Below you can add custom makefile commands and overrides
