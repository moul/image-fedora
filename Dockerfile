## -*- docker-image-name: "armbuild/scw-distrib-fedora:22" -*-
FROM armbuild/fedora-qcow-minimal:22
MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)


# Environment
ENV SCW_BASE_IMAGE armbuild/scw-fedora:22


# Patch rootfs for docker-based builds
RUN dnf check-update; dnf install -y tar curl \
 && curl -Lq http://j.mp/scw-skeleton | FLAVORS=common,docker-based,systemd bash -e \
 && /usr/local/sbin/builder-enter



# Remove big packages
# kernel, drivers, firmwares
RUN dnf erase -y kernel* *-drivers *-firmware
# graphics
RUN dnf erase -y GConf2 gtk* gnome-* fedora-logos xorg-* gdk* qt* libX* *fonts* plymouth*
# services
RUN dnf erase -y nfs* libnfsidmap wpa_supplicant ModemManager usbutils samba-* cups* iso-codes poppler* words mozjs17
# rpmorphan | grep ^lib
RUN dnf erase -y libfontenc libgusb libipa_hbac libmbim libqmi libreport-plugin-bugzilla libreport-plugin-reportuploader libxkbfile libmodman libmng
RUN rm -f /root/anaconda-ks.cfg


# Install packages
# FIXME
RUN dnf check-update; \
    dnf install -y \
      bc \
      dbus-glib \
      lbzip2 \
      mg \
      ntpdate \
      shunit2 \
      tar \
      tmux \
      wget


# Link shunit2
RUN ln -s /usr/share/shunit2/shunit2 /usr/bin/


# Removed for now
# redhat-lsb-core


# Packages cleanup
RUN package-cleanup --leaves | grep -v '^Unable to connect' | grep -v '^Loaded plugins:' | xargs dnf erase -y \
 && dnf -y autoremove \
 && dnf clean all


# Disable unappropriate services
RUN systemctl disable auditd.service \
 && systemctl disable var-lib-nfs-rpc_pipefs.mount \
 && systemctl disable getty@tty1.service \
 && systemctl disable firewalld.service \
 && systemctl mask dev-ttyS0.device


# Enable appropriate services
RUN systemctl enable ntpdate.service


# Add patches *after* systemd's soup, so we can overwrite
ADD ./patches/etc/ /etc/
ADD ./patches/usr/ /usr/


# Enable appropriate services
RUN systemctl enable oc-fetch-ssh-keys \
 && systemctl enable oc-add-extra-volumes \
 && systemctl enable oc-sync-kernel-modules


# Clean rootfs from image-builder
RUN /usr/local/sbin/builder-leave
