ARG BASE_IMAGE=eclipse-temurin:21-jre-jammy
FROM ${BASE_IMAGE}
LABEL org.opencontainers.image.authors="Maksymilian Słowiński mslowinski96@gmail.com"


ARG PORT=25565 SERVER_PATH=/mc-server USER=minecraft GROUP=minecraft
ENV SERVER_PACK_URL="" EULA=""

RUN apt-get update && apt-get upgrade -y && apt-get install -y curl unzip bash && rm -rf /var/lib/apt/lists/*



RUN groupadd -r ${GROUP} && \
    useradd -r -m -g ${GROUP} -d ${SERVER_PATH} -s /bin/false ${USER}

WORKDIR ${SERVER_PATH}

COPY CheckEula.sh ${SERVER_PATH}
RUN chown ${USER}:${GROUP} CheckEula.sh && \
    chmod u+x CheckEula.sh

COPY Start.sh ${SERVER_PATH}
RUN chown ${USER}:${GROUP} Start.sh && \
    chmod u+x Start.sh


USER ${USER}
EXPOSE ${PORT}

CMD [ "ls", "-al", "../" ]
ENTRYPOINT [ "./Start.sh" ]