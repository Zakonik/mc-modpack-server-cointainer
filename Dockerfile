ARG BASE_IMAGE=eclipse-temurin:21-jre-jammy
FROM ${BASE_IMAGE}
LABEL org.opencontainers.image.authors="Maksymilian Słowiński mslowinski96@gmail.com"


ARG PORT=25565 SERVER_PATH=/mc-server USER=minecraft GROUP=minecraft
ARG SCRIPTS_FOLDER=Scripts/
ENV SERVER_PACK_URL="" EULA=""

RUN apt-get update && apt-get install -y curl unzip bash && rm -rf /var/lib/apt/lists/*



RUN groupadd -r ${GROUP} && \
    useradd -r -m -g ${GROUP} -d ${SERVER_PATH} -s /bin/false ${USER}

WORKDIR ${SERVER_PATH}

COPY --chown=${USER}:${GROUP} --chmod=u+x ${SCRIPTS_FOLDER}* ${SERVER_PATH}/


USER ${USER}
EXPOSE ${PORT}

ENTRYPOINT [ "./ContainerStart.sh" ]