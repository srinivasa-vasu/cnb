ARG base_image
FROM ${base_image}

ARG cnb_uid
ARG cnb_gid
ARG stack_id

RUN groupadd cnb --gid ${cnb_gid} && \
  useradd --uid ${cnb_uid} --gid ${cnb_gid} -m -s /bin/bash cnb

ENV CNB_USER_ID=${cnb_uid}
ENV CNB_GROUP_ID=${cnb_gid}
ENV CNB_STACK_ID=${stack_id}

USER ${cnb_uid}:${cnb_gid}
LABEL io.buildpacks.stack.id=${stack_id}
LABEL io.buildpacks.stack.mixins="[\"build:git\", \"build:build-essential\"]"
