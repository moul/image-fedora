## -*- docker-image-name: "armbuild/scw-distrib-fedora:21" -*-
FROM armbuild/fedora-qcow-minimal:21
MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)


# Environment
ENV SCW_BASE_IMAGE armbuild/scw-fedora:21


# Patch rootfs for docker-based builds
RUN yum check-update; yum install -y tar curl \
 && curl -Lq http://j.mp/scw-skeleton | FLAVORS=common,docker-based,systemd bash -e \
 && /usr/local/sbin/builder-enter



# Remove big packages
# kernel, drivers, firmwares
RUN yum erase -y kernel* *-drivers *-firmware
# graphics
RUN yum erase -y GConf2 gtk* gnome-* fedora-logos xkeyboard-config xorg-* gdk* qt* libX* *fonts* plymouth*
# services
RUN yum erase -y nfs* libnfsidmap wpa_supplicant ModemManager usbutils samba-* cups* iso-codes poppler* words mozjs17
# rpmorphan | grep ^lib
RUN yum erase -y libfontenc libgusb libipa_hbac libmbim libqmi libreport-plugin-bugzilla libreport-plugin-reportuploader libxkbfile libmodman libmng
RUN rm -f /root/anaconda-ks.cfg


# Install packages
# FIXME
RUN yum check-update; \
    yum install -y \
      NetworkManager \
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
RUN package-cleanup --leaves | grep -v '^Unable to connect' | grep -v '^Loaded plugins:' | xargs yum erase -y \
 && yum -y autoremove \
 && yum clean all


# Disable unappropriate services
RUN systemctl disable auditd.service \
 && systemctl disable var-lib-nfs-rpc_pipefs.mount \
 && systemctl disable getty@tty1.service \
 && systemctl disable firewalld.service


# xnbd-client
RUN wget https://github.com/scaleway/image-fedora/raw/master/packages/xnbd-client/RPMS/armv7hl/xnbd-client-0.3.0-1.fc20.armv7hl.rpm \
 && yum install -y ./xnbd-client-0.3.0-1.fc20.armv7hl.rpm \
 && rm -f xnbd-client-0.3.0-1.fc20.armv7hl.rpm


# Enable appropriate services
RUN systemctl enable ntpdate.service \
 && systemctl enable NetworkManager-wait-online.service


# Add patches *after* systemd's soup, so we can overwrite
ADD ./patches/etc/ /etc/
ADD ./patches/usr/ /usr/


# Enable appropriate services
RUN systemctl enable oc-ssh-keys \
 && systemctl enable oc-add-extra-volumes \
 && systemctl enable oc-sync-kernel-modules


# Clean rootfs from image-builder
RUN /usr/local/sbin/builder-leave
