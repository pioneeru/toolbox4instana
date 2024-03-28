# FROM ubuntu
# FROM ubi9/ubi-minimal:9.3-1612
FROM registry.access.redhat.com/ubi-minimal
ARG CONT_IMG_VER
ENV CONT_IMG_VER=v1.0.7
# ENV DEBIAN_FRONTEND noninteractive
# ENV DEBCONF_NOWARNINGS="yes"
RUN echo $CONT_IMG_VER
# RUN apt-get update && apt-get install -y curl
# RUN yum install -y curl
ENTRYPOINT ["/bin/sh","-c","--","while true; do sleep 30; done"]