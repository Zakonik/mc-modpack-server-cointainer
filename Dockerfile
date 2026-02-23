FROM alpine
LABEL org.opencontainers.image.authors="Maksymilian Słowiński mslowinski96@gmail.com"



ENV PORT=25565
ENV SERVER_PATH=/opt/mc-server



RUN apk upgrade && apk add openjdk21-jre-headless curl unzip