ARG base_image
ARG cnb_uid
ARG cnb_gid
ARG base_os

FROM ${base_image} AS tiny-source

FROM ubuntu:${base_os} AS builder
COPY --from=tiny-source / /tiny/
RUN cp /bin/bash /tiny/bin/
#RUN cp -R /lib/x86_64-linux-gnu /tiny/lib/
#RUN cp /lib/x86_64-linux-gnu/libtinfo.so.6.2 /tiny/lib/x86_64-linux-gnu/
#RUN cp /lib/x86_64-linux-gnu/libtinfo.so.6 /tiny/lib/x86_64-linux-gnu/

RUN cp /bin/cat /tiny/bin/
RUN cp /bin/cat /tiny/usr/bin/
RUN cp /usr/bin/nproc /tiny/usr/bin/
RUN cp /usr/bin/tr /tiny/usr/bin/docker push humourmind/cnb-bionic-run:tiny
RUN cp /lib/x86_64-linux-gnu/libtinfo.so.5.9 /tiny/lib/x86_64-linux-gnu/
RUN cp /lib/x86_64-linux-gnu/libtinfo.so.5 /tiny/lib/x86_64-linux-gnu/
RUN cp /lib/x86_64-linux-gnu/libz.so.1 /tiny/lib/x86_64-linux-gnu/
RUN cp /lib/x86_64-linux-gnu/libz.so.1.2.11 /tiny/lib/x86_64-linux-gnu/
RUN cp /lib/x86_64-linux-gnu/libgcc_s.so.1 /tiny/lib/x86_64-linux-gnu/
RUN echo "cnb:x:${cnb_uid}:${cnb_gid}:cnb:/home/cnb:/bin/bash" >> /tiny/etc/passwd \
  && echo "cnb:x:${cnb_gid}" >> /tiny/etc/group \
  && mkdir -p /tiny/home/cnb

FROM ${base_image}
COPY --from=builder /tiny/ /
ARG stack_id
USER ${cnb_uid}:${cnb_gid}
LABEL io.buildpacks.stack.id="${stack_id}"
