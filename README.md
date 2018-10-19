Fedora image on Scaleway [![Build Status](https://travis-ci.org/scaleway/image-fedora.svg?branch=master)](https://travis-ci.org/scaleway/image-fedora)
====================================

Scripts to build the official Fedora image on Scaleway

This image is built using [Image Tools](https://github.com/scaleway/image-tools) and depends on the [armbuild/fedora-qcow-minimal](https://registry.hub.docker.com/u/armbuild/fedora-qcow-minimal/) Docker image.

<img src="http://upload.wikimedia.org/wikipedia/commons/4/44/Logo_Fedora_full.svg" width="400px" />

---

**This image is meant to be used on a C1 server.**

We use the Docker's building system and convert it at the end to a disk image that will boot on real servers without Docker. Note that the image is still runnable as a Docker container for debug or for inheritance.

[More info](https://github.com/scaleway/image-tools#docker-based-builder)

---

Install
-------

Build and write the image to /dev/nbd1 (see [documentation](https://www.scaleway.com/docs/create_an_image_with_docker))

$ make install

Full list of commands available at: [scaleway/image-tools](https://github.com/scaleway/image-tools/#commands)

---

Community discussions
---------------------

- [Official: Fedora image](https://community.cloud.online.net/t/official-fedora-image/545)
- [Please support CentOS (or at least Fedora)](https://community.cloud.online.net/t/need-feedback-please-support-centos-or-at-least-fedora/196)
- [New linux distributions (Debian, CoreOS, CentOS, Fedora, Arch Linux, ...)](https://community.cloud.online.net/t/official-new-linux-distributions-debian-coreos-centos-fedora-arch-linux/229)

Links
-----

- [Fedora project](https://fedoraproject.org)
- [ARM support on Fedora wiki](https://fedoraproject.org/wiki/Architectures/ARM)

---

A project by [![Scaleway](https://avatars1.githubusercontent.com/u/5185491?v=3&s=42)](https://www.scaleway.com/) [![GuardRails badge](https://badges.production.guardrails.io/moul/image-fedora.svg)](https://www.guardrails.io)
