DOCKER_NAMESPACE =	armbuild/
NAME =			ocs-distrib-fedora
VERSION =		21
VERSION_ALIASES =	twenty-one latest
TITLE =			Fedora 21
DESCRIPTION =		Fedora 21
SOURCE_URL =		https://github.com/online-labs/image-fedora


## Image tools  (https://github.com/online-labs/image-tools)
all:	docker-rules.mk
docker-rules.mk:
	wget -qO - http://j.mp/image-tools | bash
-include docker-rules.mk
## Below you can add custom makefile commands and overrides
