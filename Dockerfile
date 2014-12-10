## -*- docker-image-name: "armbuild/ocs-distrib-fedora:20" -*-
FROM armbuild/fedora-qcow-minimal:20
MAINTAINER Online Labs <opensource@ocs.online.net>


# Environment
ENV OCS_BASE_IMAGE armbuild/ocs-fedora:20


# Install packages
# FIXME
# yum install -y

# Patch rootfs
# FIXME
# RUN wget -qO - http://j.mp/ocs-scripts | FLAVORS=docker-based,systemd bash
# ADD ./patches/etc/ /etc/
RUN echo /dev/nbd0 / ext4 defaults,noatime 0 0 > /etc/fstab
RUN printf "DEVICE=eth0\nBOOTPROTO=dhcp\nONBOOT=yes\n" > /etc/sysconfig/network-scripts/ifcfg-eth0


# Clean rootfs from image-builder
RUN rpm -qa | grep -i xorg | xargs yum -y remove \
 && yum erase -y yum install kernel kernel-lpae linux-firmware \
                   mesa-dri-drivers gtk2 gtk3 gnome-icon-theme \
		   fedora-logos alsa-firmware xkeyboard-config \
 && rpm clean all
    


# TEMPORARY DEBUG ACCESS
RUN echo root:toor | chpasswd
RUN umask 077; mkdir /root/.ssh; echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEApvPvDbWDY50Lsx4WyUInw407379iERte63OTTNae6+JgAeYsn52Z43Oeks/2qC0gxweq+sRY9ccqhfReie+r+mvl756T4G8lxX1ND8m6lZ9kM30Rvk0piZn3scF45spmLNzCNXza/Hagxy53P82ej2vq2ewXtjVdvW20G3cMHVLkcdgKJN+2s+UkSYlASW6enUj3no+bukT+6M8lJtlT0/0mZtnBRJtqCCvF0cm9xU0uxILrhIfdYAJ1XqaoqIQLFSDLVo5lILMzDNwV+CfAotRMWIKvWomCszhVQYHCQo2Z+b2Gs0TL4DRb23fRMdeaRufnVhh5ZMlNkb2ajaL6sw== m" >> /root/.ssh/authorized_keys
