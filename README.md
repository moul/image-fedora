Official Fedora image on Online Labs
====================================

Scripts to build the official Fedora image on Online Labs

This image is built using [Image Tools](https://github.com/online-labs/image-tools) and depends on the [armbuild/fedora-qcow-minimal](https://registry.hub.docker.com/u/armbuild/fedora-qcow-minimal/) Docker image.

---

**This image is meant to be used on a C1 server.**

We use the Docker's building system and convert it at the end to a disk image that will boot on real servers without Docker. Note that the image is still runnable as a Docker container for debug or for inheritance.**

[More info](https://github.com/online-labs/image-tools#docker-based-builder)

---

Commands
--------

    # build the image in a rootfs directory
    $ make rootfs

    # push the image on s3
    $ make publish_on_s3.tar

    # write the image to /dev/nbd1
    $ make install_on_disk

Full list of commands available at: https://github.com/online-labs/image-tools/tree/master#commands

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
