## -*- docker-image-name: "armbuild/ocs-distrib-fedora:20" -*-
FROM armbuild/fedora-qcow-minimal:20
MAINTAINER Online Labs <opensource@ocs.online.net> (@online_en)


# Environment
ENV OCS_BASE_IMAGE armbuild/ocs-fedora:20


# Remove big packages
# kernel, drivers, firmwares
RUN yum erase -y kernel* *-drivers *-firmware
# graphics
RUN yum erase -y GConf2 gtk* gnome-* fedora-logos xkeyboard-config xorg-* gdk* qt* libX* *fonts*
# services
RUN yum erase -y nfs* libnfsidmap wpa_supplicant ModemManager usbutils samba-* cups* iso-codes poppler* words mozjs17
# rpmorphan | grep ^lib
RUN yum erase -y libfontenc libgusb libipa_hbac libmbim libqmi libreport-plugin-bugzilla libreport-plugin-reportuploader libxkbfile libmodman libmng


# Install packages
# FIXME
RUN yum install -y \
    NetworkManager \
    mg \
    tmux \
    ntpdate


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
RUN mkdir /tmp/build-xnbd \
    && cd /tmp/build-xnbd \
    && wget https://bitbucket.org/hirofuchi/xnbd/downloads/xnbd-0.3.0.tar.bz2 -O xnbd.tar.bz2 \
    && tar -xf xnbd.tar.bz2 \
    && cd xnbd-* \
    && yum install -y automake gcc gcc-c++ kernel-devel glib2-devel \
    && cd /tmp/build-xnbd/xnbd-* \
    && ./configure --prefix=/usr/local \
    && make -j4 \
    && make install \
    && yum remove -y automake gcc gcc-c++ kernel-devel glib2-devel \
    && yum -y autoremove \
    && yum clean all \
    && cd / \
    && rm -rf /tmp/build-xnbd /tmp/xnbd.tar.bz2


# Patch rootfs
RUN wget -qO - http://j.mp/ocs-scripts | bash


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
