FROM ubuntu:22.04

ARG RUNNER=local

ENV DEBIAN_FRONTEND=noninteractive

# 修正中文显示
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN if [ "${RUNNER}" != "github" ]; then \
        sed -i -E 's/(archive|security|ports).ubuntu.(org|com)/mirrors.aliyun.com/g' /etc/apt/sources.list; \
        sed -i -E 's/(archive|security|ports).ubuntu.(org|com)/mirrors.aliyun.com/g' /etc/apt/sources.list.d/ubuntu.sources; \
    fi \ 
    && apt-get update && apt-get upgrade -y  \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        locales \ 
        tzdata \
        dumb-init  \
    && locale-gen en_US.UTF-8  \
    && rm -rf /var/lib/apt/lists/*