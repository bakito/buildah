# stable/Dockerfile
#
# Build a Buildah container image from the latest
# stable version of Buildah on the Fedoras Updates System.
# https://bodhi.fedoraproject.org/updates/?search=buildah
# This image can be used to create a secured container
# that runs safely with privileges within the container.
#
FROM fedora:latest

# Don't include container-selinux and remove
# directories used by dnf that are just taking
# up space.
RUN yum -y install buildah fuse-overlayfs --exclude container-selinux; rm -rf /var/cache /var/log/dnf* /var/log/yum.*

# Adjust storage.conf to enable Fuse storage.
RUN sed -i -e 's|^#mount_program|mount_program|g' -e '/additionalimage.*/a "/var/lib/shared",' /etc/containers/storage.conf
