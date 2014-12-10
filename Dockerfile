## -*- docker-image-name: "armbuild/ocs-distrib-fedora:20" -*-
FROM armbuild/fedora-qcow-minimal:20
MAINTAINER Online Labs <opensource@ocs.online.net>


# Environment
ENV OCS_BASE_IMAGE armbuild/ocs-fedora:20


# Install packages
# FIXME


# Patch rootfs
# FIXME
# RUN wget -qO - http://j.mp/ocs-scripts | FLAVORS=docker-based,systemd bash
# ADD ./patches/etc/ /etc/


# Configure locales
# FIXME


# Clean rootfs from image-builder
# FIXME
