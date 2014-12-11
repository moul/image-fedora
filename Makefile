DOCKER_NAMESPACE =	armbuild/
NAME =			ocs-distrib-fedora
VERSION =		20
VERSION_ALIASES =	heisenbug latest
TITLE =			Fedora 20
DESCRIPTION =		Fedora 20
SOURCE_URL =		https://github.com/online-labs/image-fedora


## Image tools  (https://github.com/online-labs/image-tools)
all:	docker-rules.mk
docker-rules.mk:
	wget -qO - http://j.mp/image-tools | bash
-include docker-rules.mk
## Below you can add custom makefile commands and overrides
