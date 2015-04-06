DOCKER_NAMESPACE =	armbuild/
NAME =			scw-distrib-fedora
VERSION =		21
VERSION_ALIASES =	twenty-one latest latest
TITLE =			Fedora 21
DESCRIPTION =		Fedora 21
SOURCE_URL =		https://github.com/scaleway/image-fedora


## Image tools  (https://github.com/scaleway/image-tools)
all:    docker-rules.mk
docker-rules.mk:
	wget -qO - http://j.mp/scw-image-tools | bash
-include docker-rules.mk
## Below you can add custom makefile commands and overrides
