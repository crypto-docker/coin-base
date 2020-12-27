FROM debian:bullseye-slim
LABEL maintainer="Mahsum UREBE <info@mahsumurebe.com>"
LABEL description="Coin Base Docker Image"

ENV COIN_ROOT_DIR="/data"
ENV COIN_RESOURCES="${COIN_ROOT_DIR}/resources"
ENV COIN_WALLETS="${COIN_ROOT_DIR}/wallets"
ENV COIN_LOGS="${COIN_ROOT_DIR}/logs"
ENV COIN_SCRIPTS="${COIN_ROOT_DIR}/scripts"

RUN apt-get update -y \
    && apt-get install curl gosu ca-certificates apt-transport-https -y \
    && apt-get clean

RUN groupadd -g 1000 coingroup \
    && useradd -u 1000 -g coingroup -m coinuser \
    && mkdir -p "${COIN_ROOT_DIR}" \
    && mkdir -p "${COIN_RESOURCES}" \
    && mkdir -p "${COIN_WALLETS}" \
    && mkdir -p "${COIN_LOGS}" \
    && mkdir -p "${COIN_SCRIPTS}" \
    && chown -R coinuser:coingroup "${COIN_ROOT_DIR}/"

WORKDIR "${COIN_ROOT_DIR}"

VOLUME [ "$COIN_ROOT_DIR" ]

CMD [ "bash" ]
