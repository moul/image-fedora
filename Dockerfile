## -*- docker-image-name: "armbuild/ocs-distrib-fedora:21" -*-
FROM armbuild/fedora-qcow-minimal:21
MAINTAINER Online Labs <opensource@ocs.online.net> (@online_en)


# Environment
ENV OCS_BASE_IMAGE armbuild/ocs-fedora:21


# Remove big packages
# kernel, drivers, firmwares
RUN yum erase -y kernel* *-drivers *-firmware
# graphics
RUN yum erase -y GConf2 gtk* gnome-* fedora-logos xkeyboard-config xorg-* gdk* qt* libX* *fonts*
# services
RUN yum erase -y nfs* libnfsidmap wpa_supplicant ModemManager usbutils samba-* cups* iso-codes poppler* words mozjs17
# rpmorphan | grep ^lib
RUN yum erase -y libfontenc libgusb libipa_hbac libmbim libqmi libreport-plugin-bugzilla libreport-plugin-reportuploader libxkbfile libmodman libmng
RUN rm -f /root/anaconda-ks.cfg

# Install packages
# FIXME
RUN yum install -y \
    NetworkManager \
    bc \
    dbus-glib-devel \
    mg \
    tmux \
    shunit2 \
    ntpdate \
    tar \
    wget \
    lbzip2


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
RUN wget https://github.com/online-labs/image-fedora/raw/master/packages/xnbd-client/RPMS/armv7hl/xnbd-client-0.3.0-1.fc20.armv7hl.rpm \
 && yum install -y ./xnbd-client-0.3.0-1.fc20.armv7hl.rpm \
 && rm -f xnbd-client-0.3.0-1.fc20.armv7hl.rpm


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
