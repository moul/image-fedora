## -*- docker-image-name: "armbuild/ocs-distrib-fedora:20" -*-
FROM armbuild/fedora-qcow-minimal:20
MAINTAINER Online Labs <opensource@ocs.online.net>


# Environment
ENV OCS_BASE_IMAGE armbuild/ocs-fedora:20


# Install packages
# FIXME
RUN yum install -y tmux mg


# Patch rootfs
RUN wget -qO - http://j.mp/ocs-scripts | bash
ADD ./patches/etc/ /etc/


# Disable unappropriate services
RUN systemctl disable auditd.service \
 && systemctl disable var-lib-nfs-rpc_pipefs.mount


# Clean rootfs from image-builder
RUN yum erase -y \
        kernel kernel-lpae linux-firmware \
        mesa-dri-drivers gtk2 gtk3 gnome-icon-theme \
        fedora-logos alsa-firmware xkeyboard-config \
	gsettings-desktop-schemas xorg-x11-xkb-utils \
	wpa_supplicant gdk-pixbuf2 nfs-utils libnfsidmap
RUN package-cleanup --leaves | grep -v '^Unable to connect' | grep -v '^Loaded plugins:' | xargs yum erase -y
RUN yum clean all
    


# TEMPORARY DEBUG ACCESS
RUN echo root:toor | chpasswd
RUN umask 077; mkdir /root/.ssh; echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEApvPvDbWDY50Lsx4WyUInw407379iERte63OTTNae6+JgAeYsn52Z43Oeks/2qC0gxweq+sRY9ccqhfReie+r+mvl756T4G8lxX1ND8m6lZ9kM30Rvk0piZn3scF45spmLNzCNXza/Hagxy53P82ej2vq2ewXtjVdvW20G3cMHVLkcdgKJN+2s+UkSYlASW6enUj3no+bukT+6M8lJtlT0/0mZtnBRJtqCCvF0cm9xU0uxILrhIfdYAJ1XqaoqIQLFSDLVo5lILMzDNwV+CfAotRMWIKvWomCszhVQYHCQo2Z+b2Gs0TL4DRb23fRMdeaRufnVhh5ZMlNkb2ajaL6sw== m" >> /root/.ssh/authorized_keys
