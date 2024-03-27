FROM ubuntu
ARG CONT_IMG_VER
ENV CONT_IMG_VER=v1.0.2
RUN echo $CONT_IMG_VER
RUN apt-get update && apt-get install -y curl
ENTRYPOINT ["/bin/sh","-c","--","while true; do sleep 30; done"]