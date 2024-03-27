FROM ubuntu
ARG CONT_IMG_VER
ENV CONT_IMG_VER=v1.0.1
RUN echo $CONT_IMG_VER
ENTRYPOINT ["/bin/sh","-c","--","while true; do sleep 30; done"]